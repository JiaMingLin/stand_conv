import numpy as np
import fpga_nn
import time
from fpga_nn import config

class SimpleNet(fpga_nn.Module):

	def __init__(self, layers, params_path = None):
		super(SimpleNet, self).__init__()
		self.layers = layers
		self.params_path = params_path

		# initialize weight for each layer
		self._init_weight()

		# copy weight data to hardware buffer 
		self.load_parameters();

	# TODO: load from parameter file
	def _init_weight(self, params_path = None):
		for l in self.layers:
			if l.type == "conv" or l.type == "linear":
				l.weight_data = np.load("quantize_conv_weight.npy").astype(np.uint8)

def make_layers():

	in_height = int(config["DataConfig"]["image_height"])
	in_width = int(config["DataConfig"]["image_width"])
	in_channel = 3

	multiplier = 0.002746367361396551
	zp_x = 7; zp_w = 128; zp_x_next = 7
	layers = []
	# Conv(output channel, input channel, input height, input width, kerSize, stride)
	layers += [fpga_nn.Conv2DPool(32, in_channel, in_height, in_width, \
				multiplier, zp_x, zp_w, zp_x_next, ker = 3, poolWin = 2)]
	# layers += [fpga_nn.Conv2DPool(32, 16, in_height, in_width, ker = 3, poolWin = 2)]
	# layers += [fpga_nn.Conv2DPool(64, 32, int(in_height/2), int(in_width/2), ker = 3, poolWin = 2)]
	# layers += [fpga_nn.Flatten(int(in_height/4), int(in_width/4), 64)]
	# layers += [fpga_nn.Linear(4096,4096)]
	# layers += [fpga_nn.Linear(1024,4096)]
	# layers += [fpga_nn.Linear(101,1024)]

	return layers

def simple_net():

	layers = make_layers()
	params_path = "params.path"
	model = SimpleNet(layers, params_path = params_path)

	return model


if __name__ == "__main__":

	import conv_operation as co
	m = simple_net()

	# hardware convolution
	in_height = int(config["DataConfig"]["image_height"])
	in_width = int(config["DataConfig"]["image_width"])
	in_channel = 3

	outRow = 16; outCol = 16
	# x = np.random.randint(256, size=(in_height,in_width,in_channel), dtype=np.uint8)
	x = np.transpose(np.load("input_featuremap.npy")[0,:,:,:], (1,2,0)).astype(np.uint8)
	output = m(x)

	out_channel = m.layers[-1].out_channel

	# convert to row major
	hw_result = co.convertOFMOutput(\
		output, output.shape[0], m.WORD_LENGTH, out_channel, outRow, outCol, Ti = 16)
	# hw_result = np.expand_dims(output, axis = 2)

	golden_ofm = np.load("output_featuremap.npy")[0,:,:,:]
	golden_ofm = co.sw_pooling(golden_ofm, 2)
	
	print("error = ",np.sum(golden_ofm - hw_result))
