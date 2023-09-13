import numpy as np

L = 0.4
W = 0.4
A = L*W
x = 0.012
h_i = 1
h_o = 1
delta_T = 90
no_wndws = 130
pwr_cost = 1E-3 # W/$hr
no_hrs = 8


K_ag = 0.014
K_pc = 0.21
K_Ls = 1.4
K_values = np.array([K_ag, K_pc, K_Ls])

results = []

for K in K_values:
    q = -K * A * delta_T / x
    C_tot = no_wndws * -q * pwr_cost * no_hrs

    results.append(C_tot)

for i, cost in enumerate(results):
    print(f"Total cost for K={K_values[i]} is ${cost:.2f}")