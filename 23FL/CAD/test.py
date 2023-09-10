import numpy as np

# Define the coefficient matrix A
A = np.array([[2, 1],
              [1, 3]])

# Define the right-hand side vector b
b = np.array([4, 7])

# Solve the system of equations
x = np.linalg.solve(A, b)

# Print the solution
print("Solution:")
print(x)