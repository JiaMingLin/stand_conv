import numpy as np
import fpga_nn

from fpga_nn import config

class SimpleNet(fpga_nn.Module):

	def __init__(self, layers,img_height, img_width, img_channel, params_path = None):
		super(SimpleNet, self).__init__(img_height, img_width, img_channel)
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

	in_height = 256
	in_width = 256
	in_channel = 3

	layers = []
	# Conv(output channel, input channel, input height, input width, kerSize, stride)
	layers += [fpga_nn.Conv2D(64, in_channel, in_height, in_width, ker = 3, s = 1)]
	layers += [fpga_nn.Conv2DPool(128, 64, in_height, in_width, ker = 3, poolWin = 2)]

	layers += [fpga_nn.Conv2D(128, 128, int(in_height/2), int(in_width/2), ker = 3, s = 1)]
	layers += [fpga_nn.Conv2DPool(256, 128, int(in_height/2), int(in_width/2), ker = 3, poolWin = 2)]

	layers += [fpga_nn.Conv2D(256, 256, int(in_height/4), int(in_width/4), ker = 3, s = 1)]
	layers += [fpga_nn.Conv2D(256, 256, int(in_height/4), int(in_width/4), ker = 3, s = 1)]
	layers += [fpga_nn.Conv2DPool(512, 256, int(in_height/4), int(in_width/4), ker = 3, poolWin = 2)]

	layers += [fpga_nn.Conv2D(512, 512, int(in_height/8), int(in_width/8), ker = 3, s = 1)]
	layers += [fpga_nn.Conv2D(512, 512, int(in_height/8), int(in_width/8), ker = 3, s = 1)]
	layers += [fpga_nn.Conv2DPool(512, 512, int(in_height/8), int(in_width/8), ker = 3, poolWin = 2)]

	layers += [fpga_nn.Conv2D(512, 512, int(in_height/16), int(in_width/16), ker = 3, s = 1)]
	layers += [fpga_nn.Conv2D(512, 512, int(in_height/16), int(in_width/16), ker = 3, s = 1)]
	layers += [fpga_nn.Conv2DPool(512, 512, int(in_height/16), int(in_width/16), ker = 3, poolWin = 2)]

	# conv output size = (8,8,512)
	# layers += [fpga_nn.Flatten(int(in_height/32), int(in_width/32), 512)]
	# layers += [fpga_nn.Linear(4096,int(in_height/32)*int(in_width/32)*512)]
	# layers += [fpga_nn.Linear(101,4096)]

	return layers

def simple_net():

	layers = make_layers()
	params_path = "params.path"
	model = SimpleNet(layers,256, 256, 3, params_path = params_path)

	return model


if __name__ == "__main__":

	m = simple_net()

	# hardware convolution
	in_height = 256
	in_width = 256
	in_channel = 3

	outRow = 1; outCol = 1
	x = np.random.randint(256, size=(in_height,in_width,in_channel), dtype=np.uint8)

	output = m(x)
	
	import timeit

	m.verbose = False
	timeit.timeit('m(x)', setup="from __main__ import m, x")
	

	out_channel = m.layers[-1].out_channel

	# convert to row major
	# hw_result = co.convertOFMOutput(\
	# 	output, output.shape[0], m.WORD_LENGTH, out_channel, outRow, outCol, Ti = 16)