import numpy as np


# 1D in X axis
# Givens
F1 = 60
F2 = 0
F3 = 0
F4 = -F1
K1 = 50
K2 = 60
K3 = 55

# Matrix Assy
forces = np.array([[F1], 
    [F2], 
    [F3], 
    [F4]
])

stiffness = np.array([[K1, -K1, 0, 0], 
    [-K1, K1 + K2, -K2, 0],
    [0, -K2, K2 + K3, -K3], 
    [0, 0, -K3, K3]
])

# Boundary Constraints
stiffness[:, 3] = 0

print (forces)
print (stiffness)

displacements = np.linalg.solve(stiffness, forces)

print(displacements)
#print("Displacements: " + str(displacements))