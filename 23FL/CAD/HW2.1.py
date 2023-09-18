import numpy as np
import math

# constants:
u = 30
v = 15
theta = 30 # degrees
theta_rad = math.radians(theta) # radians

cords_local = np.array([[u], [v]])
transform = np.array([[math.cos(theta_rad), -math.sin(theta_rad)],
                     [math.sin(theta_rad), math.cos(theta_rad)]])

cords_global = np.dot(transform, cords_local)

print(f"Global coordinates are ({cords_global[0, 0]:.1f}, {cords_global[1, 0]:.1f}).")