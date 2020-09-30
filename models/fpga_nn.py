import configparser
import numpy as np
import conv_operation as co
import time

from math import floor, ceil
from pynq import Xlnk
from pynq import Overlay

config = configparser.ConfigParser()   
configFilePath = './config.cfg'
config.read(configFilePath)

class Module(object):
	hardware_instance = None

	# singlton for Hardware Instance
	class HardwareInit:
		def __init__(self):
			self.init_config()
			print("Initialize Hardware...: load bitstream")
			self.xlnk = Xlnk()
			self.xlnk.xlnk_reset()

			self.core0 = Overlay(self.bitstream_path).DoCompute_0
			# self.core1 = Overlay(self.bitstream_path).DoCompute_1

			# allocate buffer for input image
			self.input_buff = self.xlnk.cma_array(\
				shape=(self.buffer_depth, self.WORD_LENGTH), \
				dtype=np.uint8)
			
			print("Initialize Hardware...: done")
		
		def init_config(self):
			print("Initialize configuration...")
			self.board = config["FPGAConfig"]["name"]
			self.bitstream_path = config["FPGAConfig"]["bitstream_path"]
			self.precision = int(config["PEConfig"]["precision"])
			self.data_width = int(config["PEConfig"]["data_width"])
			self.Ti = int(config["PEConfig"]["Ti"])
			self.To = int(config["PEConfig"]["To"])
			self.Tr = int(config["PEConfig"]["Tr"])
			self.Tc = int(config["PEConfig"]["Tc"])

			self.img_height = int(config["DataConfig"]["image_height"])
			self.img_width = int(config["DataConfig"]["image_width"])
			self.img_channel = int(config["DataConfig"]["image_channel"])
			
			self.WORD_LENGTH = int(ceil(self.data_width/self.precision))
			self.buffer_depth = int(ceil((self.img_channel*self.img_height*self.img_width)/self.WORD_LENGTH))
			print("Initialize configuration...: done") 

	
	def __init__(self):

		if Module.hardware_instance is None:
			Module.hardware_instance = Module.HardwareInit()

		self.core0 = Module.hardware_instance.core0
		# self.core1 = Module.hardware_instance.core1
		self.xlnk = Module.hardware_instance.xlnk
		self.input_buff = Module.hardware_instance.input_buff
		self.WORD_LENGTH = Module.hardware_instance.WORD_LENGTH

		self.Tr = Module.hardware_instance.Tr
		self.Tc = Module.hardware_instance.Tc
		self.Ti = Module.hardware_instance.Ti
		self.To = Module.hardware_instance.To

		self.layers = None

	def __call__(self, raw_image):
		self._convert_raw_image_to_buffer(raw_image)
		print("executing layers...")

		hw_begin = time.perf_counter()
		fm = self.layers[0](self.input_buff)
		print("layer {} size = {}, time = {}(ms)"\
			.format(0, self.layers[0].weight_shape, (time.perf_counter() - hw_begin)*1000))

		cnt = 1
		for l in self.layers[1:]:
			hw_begin = time.perf_counter()
			fm = l(fm)
			print("layer {} size = {}, time = {}(ms)"\
			.format(cnt, l.weight_shape, (time.perf_counter() - hw_begin)*1000))
			cnt+=1

		return fm

	def mem_alloc(self, out_channel, in_channel, in_height, in_width, ker):
		print("memory allocation...")
		# ifm_depth = int(ceil((in_channel*in_height*in_width)/self.WORD_LENGTH))
		if (out_channel % self.To != 0):
			out_channel += self.To - (out_channel % self.To)

		fm_depth = int(ceil((out_channel*in_height*in_width)/self.WORD_LENGTH))
		wgt_depth = int(ceil((in_channel*out_channel*ker*ker)/self.WORD_LENGTH))

		# ifm_buff = self.xlnk.cma_array(shape=(ifm_depth, self.WORD_LENGTH), dtype=np.uint8)
		fm_buff = self.xlnk.cma_array(shape=(fm_depth, self.WORD_LENGTH), dtype=np.uint8)
		wgt_buff = self.xlnk.cma_array(shape=(wgt_depth, self.WORD_LENGTH), dtype=np.uint8)
		print("memory allocation...: done")
		
		return fm_buff, wgt_buff

	def setting(self, ofm_buff, ifm_buff, wgt_buff,\
	 out_channel, in_channel, in_height, in_width, ker=3, s=1, poolWin=1):

		self.core0.write(0x10, ifm_buff.physical_address)
		self.core0.write(0x18, ofm_buff.physical_address)
		self.core0.write(0x20, wgt_buff.physical_address)
		self.core0.write(0x28, int(in_height))
		self.core0.write(0x30, int(in_width))
		self.core0.write(0x38, int(in_channel))
		self.core0.write(0x40, int(out_channel))
		self.core0.write(0x48, self.Tr)
		self.core0.write(0x50, self.Tc)
		self.core0.write(0x58, ker)
		self.core0.write(0x60, s)
		self.core0.write(0x68, poolWin)

	def execute(self):
		self.core0.write(0x00, 1)
		isready = self.core0.read(0x00)

		while( isready == 1 ):
			isready = self.core0.read(0x00)
		
	def load_parameters(self):
		if self.layers is None:
			raise("Network layers are not initialized")

		for l in self.layers:
			if l.type is not "conv":
				continue

			if l.weight_data.shape != l.weight_shape:
				raise("Input weight shape is " + l.weight_data.shape \
					+ ", not match with setting " + l.weight_shape)

			self._convert_weight_to_buffer(l)

		return 0

	def _convert_raw_image_to_buffer(self, raw_image):

		imgH = raw_image.shape[0]
		imgW = raw_image.shape[1]
		img_channel = raw_image.shape[2]
		
		if img_channel < self.Ti:
			zero_padding = np.zeros((imgH, imgW, self.Ti-img_channel), dtype = np.uint8)
			raw_image = np.concatenate((raw_image, zero_padding), axis = 2)


		np.copyto(self.input_buff, raw_image.reshape(-1,raw_image.shape[2]))

	"""
	Convert pytorch WGT to Xlnk input
	Input:
    	1. wgt: pytorch tensor(out channel, in channel, ker_height, ker_width)
	Output:
    	1. wgt_cma: Xlnk cma(Depth, WORD_LENGTH), 
        	Depth = (out_channel/To) * (in_channel/Ti) * To * ker_height * ker_width * (Ti/WORD_LENGTH) * WORD_LENGTH
	"""
	def _convert_weight_to_buffer(self, layer):
		wgt = layer.weight_data
		out_channel = layer.out_channel
		in_channel = layer.in_channel
		kerH = layer.ker
		kerW = layer.ker

		if in_channel < self.Ti:
			zero_padding = np.zeros((out_channel,self.Ti - in_channel,kerH,kerW), dtype=np.uint8)
			wgt = np.concatenate((wgt,zero_padding), axis = 1)

		# if (out_channel % self.To != 0):
		# 	zero_padding = np.zeros((self.To - (out_channel % self.To),in_channel,kerH,kerW), dtype=np.uint8)
		# 	wgt = np.concatenate((wgt,zero_padding), axis = 0)

		print("shape of wgt: ", wgt.shape)
		wgt_tmp = np.transpose(\
						wgt.reshape((int(ceil(out_channel/self.To)), self.To, int(ceil(in_channel/self.Ti)), self.Ti, kerH, kerW)), \
						(0,2,1,4,5,3))\
					.reshape((int(ceil(out_channel/self.To)), int(ceil(in_channel/self.Ti)), self.To, kerH, kerW,int(self.Ti/self.WORD_LENGTH),self.WORD_LENGTH))\
					.reshape(-1,self.WORD_LENGTH)

		np.copyto(layer.wgt_buff, wgt_tmp)


class Conv2D(Module):
	def __init__(self, out_channel, in_channel, in_height, in_width, ker=3, s=1):

		super(Conv2D, self).__init__()

		self.type = "conv"
		self.out_channel = out_channel
		self.in_channel = in_channel
		self.in_height = in_height
		self.in_width = in_width
		self.out_height = in_height
		self.out_width = in_width
		self.ker = ker
		self.s = s
		self.weight_shape = (out_channel, in_channel, ker, ker)
		self.weight_data = None

		self.ofm_buff, self.wgt_buff = \
		self.mem_alloc(max(out_channel, self.To)\
			, max(in_channel, self.Ti), self.out_height, self.out_width, ker)

	def __call__(self, ifm_buff):
		print("executing conv2d")
		self.ifm_buff = ifm_buff
		self.setting(self.ofm_buff,\
					 self.ifm_buff,\
					 self.wgt_buff,\
					 self.out_channel,\
					 self.in_channel,\
					 self.in_height,\
					 self.in_width,\
					 self.ker,\
					 self.s)
		self.execute()
		return self.ofm_buff

class Conv2DPool(Module):
	def __init__(self, out_channel, in_channel, in_height, in_width, ker=3, s=1, poolWin = 2):
		super(Conv2DPool, self).__init__()
		
		self.type = "conv"
		self.out_channel = out_channel
		self.in_channel = in_channel
		self.in_height = in_height
		self.in_width = in_width
		self.out_height = int(ceil(in_height/poolWin))
		self.out_width = int(ceil(in_width/poolWin))
		self.ker = ker
		self.s = s
		self.poolWin = poolWin
		self.weight_shape = (out_channel, in_channel, ker, ker)
		self.weight_data = None

		self.ofm_buff, self.wgt_buff = \
		self.mem_alloc(max(out_channel, self.To)\
			, max(in_channel, self.Ti), self.out_height, self.out_width, ker)
	
	def __call__(self, ifm_buff):
		print("executing conv2dPool")
		self.ifm_buff = ifm_buff
		self.setting(self.ofm_buff,\
					 self.ifm_buff,\
					 self.wgt_buff,\
					 self.out_channel,\
					 self.in_channel,\
					 self.in_height,\
					 self.in_width,\
					 poolWin = self.poolWin)
		self.execute()
		return self.ofm_buff

class Linear(Module):
	def __init__(self, out_channel, in_channel):
		super(Linear, self).__init__()

		self.type = "linear"
		self.out_channel = out_channel
		self.in_channel = in_channel
		self.in_height = 1
		self.in_width = 1
		self.out_height = 1
		self.out_width = 1
		self.ker = 1
		self.weight_shape = (out_channel, in_channel, 1, 1)
		self.weight_data = None

		# self.ofm_buff, self.wgt_buff = \
		# self.mem_alloc(max(out_channel, self.To)\
		# 	, max(in_channel, self.Ti), self.out_height, self.out_width, self.ker)

	def __call__(self, feature):
		print("executing Fully Connected Layer")
		# feature: (1, in_channel * in_height * in_width)
		# wgt: (out_channel, in_channel * in_height * in_width)
		return co.sw_linear(feature, self.weight_data)

class Flatten(Module):
	def __init__(self, in_height, in_width, in_channel):
		super(Flatten, self).__init__()
		
		self.type = "flatten"
		self.in_height = in_height
		self.in_width = in_width
		self.in_channel = in_channel
		self.weight_shape = (in_height, in_width, in_channel)
		# self.tile_depth = int(in_height*in_width)

	def __call__(self, feature_buff):
		print("executing Flatten")
		# convert to row major feature map(channel, height, width)
		return co.convertOFMOutput(\
				feature_buff, feature_buff.shape[0], self.WORD_LENGTH\
				, self.in_channel, self.in_height, self.in_width, Ti = self.Ti)\
			.reshape((self.in_channel * self.in_height * self.in_width, -1))

		# buffer_depth = hw_buffer.shape[0]

		# # TODO: padding zero
		# num_tile = int(ceil(buffer_depth/self.tile_depth))
		# return np.transpose(\
		# 	hw_buffer.reshape((num_tile,self.tile_depth,self.WORD_LENGTH)),(0,2,1))\
		# .reshape((buffer_depth,self.WORD_LENGTH))
		

class ReLU(Module):
	def __init__():
		pass