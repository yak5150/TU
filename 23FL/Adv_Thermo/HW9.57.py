import math
import numpy as np

W_net = 10e6
hh = np.array([300.19, 411.22, 300.19, 446.50, 1173.84, 1575.57, 1085.31, 1575.57, 1173.84, 446.5])

W_T = (hh[5] - hh[6]) + (hh[7] - hh[8])
W_C = (hh[1] - hh[0]) + (hh[3] - hh[2])
q_in = (hh[5] - hh[4]) + (hh[7] - hh[6])

m_dot = W_net * q_in / (W_T - W_C)

print(hh)
print('m_dot = ', m_dot)