import numpy as np
np.random.seed(30)
ifm = np.random.randint(256, size=(12,12,16), dtype=np.uint8)
wgt = np.random.randint(256, size=(3,3,16,16), dtype=np.uint8)

ifm_filename = "random_ifm.dat"
ifm_fileobj = open(ifm_filename, mode='wb')
ifm.tofile(ifm_fileobj)
ifm_fileobj.close

wgt_filename = "random_wgt.dat"
wgt_fileobj = open(wgt_filename, mode='wb')
wgt.tofile(wgt_fileobj)
wgt_fileobj.close