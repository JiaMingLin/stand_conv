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

	# (out_channel, in_channel, ker, ker)
	# TODO: load from parameter file
	def _init_weight(self, params_path = None):
		for l in self.layers:
			if l.type == "conv" or l.type == "linear":
				# (out_channel, in_channel, ker, ker)
				# l.weight_data = np.load("quantize_conv_weight.npy").astype(np.uint8)
				l.weight_data = np.ones(l.weight_shape, dtype=np.uint8)
				(out_channel, in_channel, kerH, kerW) = l.weight_shape
				for o in range(out_channel):
					for i in range(in_channel):
						for ky in range(kerH):
							for kx in range(kerW):
								l.weight_data[o][i][ky][kx] = o*in_channel*kerH*kerW + i*kerH*kerW + ky*kerW + kx
				l.weight_data = np.random.randint(256,size=l.weight_shape, dtype=np.uint8)

def make_layers():

	in_height = int(config["DataConfig"]["image_height"])
	in_width = int(config["DataConfig"]["image_width"])
	in_channel = int(config["DataConfig"]["image_channel"])

	multiplier = 0.002746367361396551
	zp_x = 7; zp_w = 128; zp_x_next = 7
	layers = []
	# Conv(output channel, input channel, input height, input width, kerSize, stride)
	layers += [fpga_nn.Conv2DPool(64, in_channel, in_height, in_width, \
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
	in_channel = int(config["DataConfig"]["image_channel"])

	outRow = 8; outCol = 8
	x = np.ones((in_height,in_width,in_channel), dtype=np.uint8)
	for h in range(in_height):
		for w in range(in_width):
			for i in range(in_channel):
				x[h][w][i] = h*in_width*in_channel + w*in_channel + i

	x = np.random.randint(256, size=(in_height,in_width,in_channel), dtype=np.uint8)
	# x = np.transpose(np.load("input_featuremap.npy")[0,:,:,:], (1,2,0)).astype(np.uint8)
	output = m(x)

	out_channel = m.layers[-1].out_channel

	# convert to row major
	hw_result = co.convertOFMOutput(\
		output, output.shape[0], m.WORD_LENGTH, out_channel, outRow, outCol, Ti = 16)

	wgt_0 = m.layers[0].weight_data
	sw_ifm_0 = np.expand_dims(np.transpose(x, (2,0,1)), axis = 0)

	scipy_result = co.scipy_conv(sw_ifm_0, wgt_0, stride=1)
	scipy_result = co.sw_pooling(scipy_result, 2)

	print(scipy_result.shape, hw_result.shape)
	print("error = ",np.sum(scipy_result - hw_result))
