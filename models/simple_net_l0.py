import numpy as np
import fpga_nn
import time
from fpga_nn import config
import pickle

class SimpleNet(fpga_nn.Module):

	def __init__(self, layers, img_height, img_width, img_channel, params_path = None):
		super(SimpleNet, self).__init__(img_height, img_width, img_channel)
		self.layers = layers
		self.params_path = params_path

		# initialize weight for each layer
		self._init_weight()

		# copy weight data to hardware buffer 
		self.load_parameters();

	# (out_channel, in_channel, ker, ker)
	# TODO: load from parameter file
	def _init_weight(self, params_path = None):
		for l in self.layers:
			if l.type == "conv" or l.type == "linear":
				# (out_channel, in_channel, ker, ker)
				l.weight_data = np.load("parameters/wgt_0.npy").astype(np.uint8)

def make_layers(img_channel, img_height, img_width):

	multiplier = 0.002746367361396551
	zp_x = 7; zp_w = 128; zp_x_next = 7
	layers = []
	# Conv(output channel, input channel, input height, input width, kerSize, stride)
	layers += [fpga_nn.Conv2D(32, img_channel, img_height, img_width, \
				multiplier, zp_x, zp_w, zp_x_next, ker = 3)]
	# layers += [fpga_nn.Conv2DPool(32, 16, in_height, in_width, ker = 3, poolWin = 2)]
	# layers += [fpga_nn.Conv2DPool(64, 32, int(in_height/2), int(in_width/2), ker = 3, poolWin = 2)]
	# layers += [fpga_nn.Flatten(int(in_height/4), int(in_width/4), 64)]
	# layers += [fpga_nn.Linear(4096,4096)]
	# layers += [fpga_nn.Linear(1024,4096)]
	# layers += [fpga_nn.Linear(101,1024)]

	return layers

def simple_net():

	img_channel=3; img_height=32; img_width=32
	layers = make_layers(img_channel, img_height, img_width)
	params_path = "params.path"
	model = SimpleNet(layers,img_channel, img_height, img_width, params_path = params_path)

	return model


if __name__ == "__main__":

	import conv_operation as co
	m = simple_net()

	outRow = 32; outCol = 32
	x = np.transpose(np.load("parameters/ifm_0.npy")[0,:,:,:], (1,2,0)).astype(np.uint8)
	output = m(x)

	out_channel = m.layers[-1].out_channel
	
	# convert to row major
	hw_result = co.convertOFMOutput(\
		output, output.shape[0], m.WORD_LENGTH, out_channel, outRow, outCol, Ti = 16)
	# hw_result = np.expand_dims(output, axis = 2)

	golden_ofm = np.load("parameters/ofm_0.npy")[0,:,:,:].astype(np.uint8)
# 	golden_ofm = co.sw_pooling(golden_ofm, 2)
	
	print("error = ",np.sum(golden_ofm - hw_result))
