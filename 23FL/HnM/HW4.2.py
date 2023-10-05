import math as m
import numpy as np

L, W, T1, T2 = 2, 1, 50, 150

def eq4_19(n, x, y):
    f = ((-1)**(n+1)+1)/n*m.sin(n*m.pi*x/L)*m.sinh(n*m.pi*y/L)/m.sinh(n*m.pi*W/L)
    return f

nn = np.array([1, 3, 5, 7, 9])
yy  = np.array([0.25, 0.5, 0.75])
results = []

for y in yy:
    theta = 2/m.pi*np.sum([eq4_19(n, 1, y) for n in nn])
    T = theta*(T2-T1)+T1
    results.append((y, T))

for y, T in results:
    print(f"For y = {y:.2f}, T = {T:.4f} deg C")