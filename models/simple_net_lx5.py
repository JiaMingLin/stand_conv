import numpy as np
import fpga_nn
import time
from fpga_nn import config
import pickle

class SimpleNet(fpga_nn.Module):

	def __init__(self, layers, img_height, img_width, img_channel, params_path = None):
		super(SimpleNet, self).__init__(img_height, img_width, img_channel)
		self.layers = layers

		# initialize weight for each layer
		self.init_weight(params_path)

		# copy weight data to hardware buffer 
		self.load_parameters()

def make_layers(img_channel, img_height, img_width):

	layers = []
	# Conv(output channel, input channel, input height, input width, kerSize, stride)
	layers += [fpga_nn.Conv2DPool(32, img_channel, img_height, img_width, ker = 3, poolWin = 2)]

	layers += [fpga_nn.Conv2DPool(64, 32, int(img_height/2), int(img_width/2), ker = 3, poolWin = 2)]

	layers += [fpga_nn.Conv2DPool(64, 64, int(img_height/4), int(img_width/4), ker = 3, poolWin = 2)]

	layers += [fpga_nn.Conv2DPool(64, 64, int(img_height/8), int(img_width/8), ker = 3, poolWin = 2)]
	
	# layers += [fpga_nn.Conv2DPool(64, 64, int(img_height/16), int(img_width/16), ker = 3, poolWin = 2)]
	
	# layers += [fpga_nn.Flatten(int(img_height/32), int(img_width/32), 64)]
	# layers += [fpga_nn.Linear(32,int(img_height/32) * int(img_width/32) * 64)]
	# layers += [fpga_nn.Linear(10,32, quantize = False)]

	return layers

def simple_net():

	img_channel=3; img_height=32; img_width=32
	layers = make_layers(img_channel, img_height, img_width)
	params_path = "parameters/lx5/model.pickle"
	model = SimpleNet(layers,img_channel, img_height, img_width, params_path = params_path)

	return model

if __name__ == "__main__":

	import pickle
	import conv_operation as co
	fm = pickle.load(open("parameters/lx5/feature_map.pickle",'rb'))

	m = simple_net()
	x = np.transpose(fm['conv1_input'][0,:,:,:], (1,2,0)).astype(np.uint8)
	output = m(x)

	# print(output)
	out_channel = m.layers[-1].out_channel; outRow = 2; outCol = 2

# 	# convert to row major
	hw_result = co.convertOFMOutput(\
		output, output.shape[0], m.WORD_LENGTH, out_channel, outRow, outCol, Ti = 16)
	# hw_result = np.expand_dims(output, axis = 2)

	golden_ofm = fm['conv5_input'][0,:,:,:].astype(np.uint8)
# # 	golden_ofm = co.sw_pooling(golden_ofm, 2)
	
	print("error = ",np.sum(golden_ofm - hw_result))
