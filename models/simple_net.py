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
				l.weight_data = np.random.randint(256,size=l.weight_shape, dtype=np.uint8)

def make_layers():

	in_height = int(config["DataConfig"]["image_height"])
	in_width = int(config["DataConfig"]["image_width"])
	in_channel = 3

	layers = []
	# Conv(output channel, input channel, input height, input width, kerSize, stride)
	layers += [fpga_nn.Conv2D(16, in_channel, in_height, in_width, ker = 3, s = 1)]
	layers += [fpga_nn.Conv2DPool(32, 16, in_height, in_width, ker = 3, poolWin = 2)]
	layers += [fpga_nn.Conv2DPool(64, 32, int(in_height/2), int(in_width/2), ker = 3, poolWin = 2)]
	layers += [fpga_nn.Flatten(int(in_height/4), int(in_width/4), 64)]
	layers += [fpga_nn.Linear(4096,4096)]
	layers += [fpga_nn.Linear(1024,4096)]
	layers += [fpga_nn.Linear(101,1024)]

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

	outRow = 1; outCol = 1
	x = np.random.randint(256, size=(in_height,in_width,in_channel), dtype=np.uint8)
	output = m(x)

	out_channel = m.layers[-1].out_channel

	# convert to row major
	# hw_result = co.convertOFMOutput(\
	# 	output, output.shape[0], m.WORD_LENGTH, out_channel, outRow, outCol, Ti = 16)
	hw_result = np.expand_dims(output, axis = 2)

	# software convolution
	print("To compute software convulution")
	wgt_0 = m.layers[0].weight_data
	wgt_1 = m.layers[1].weight_data
	wgt_2 = m.layers[2].weight_data
	wgt_4 = m.layers[4].weight_data
	wgt_5 = m.layers[5].weight_data
	wgt_6 = m.layers[6].weight_data

	sw_ifm_0 = np.expand_dims(np.transpose(x, (2,0,1)), axis = 0)
	sw_ofm_0 = co.scipy_conv(sw_ifm_0, wgt_0, 1) # input and output are row major

	sw_ifm_1 = np.expand_dims(sw_ofm_0, axis = 0)
	sw_ofm_1 = co.scipy_conv(sw_ifm_1, wgt_1, 1)
	sw_ofm_1 = co.sw_pooling(sw_ofm_1, 2)

	sw_ifm_2 = np.expand_dims(sw_ofm_1, axis = 0)
	sw_ofm_2 = co.scipy_conv(sw_ifm_2, wgt_2, 1)
	sw_ofm_2 = co.sw_pooling(sw_ofm_2, 2)

	flatten_ifm = co.sw_flatten(sw_ofm_2)
	linear_ofm_0 = co.sw_linear(flatten_ifm, wgt_4)
	linear_ofm_1 = co.sw_linear(linear_ofm_0, wgt_5)
	sw_result = co.sw_linear(linear_ofm_1, wgt_6)
	sw_result = np.expand_dims(sw_result, axis = 2)
	
	print(sw_result.shape, hw_result.shape)
	err = co.compareResult(sw_result, hw_result, out_channel, outRow, outCol)
	print("errors = ", err)
