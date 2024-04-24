import numpy as np

L1 = 1
L2 = 1
NX = 512
NY = 512
#HORIZON = 3.015
HORIZON = 1.42
q = 2
Dn = 2**8-1
FINALTIME = 100
DELTAT = 0.001
LAMBDA = 0.25

GXMASK = np.array([[1,1,1],[0,0,0],[1,1,1]])
GYMASK = np.array([[1,0,1],[1,0,1],[1,0,1]])
#.flatten().astype(int)
