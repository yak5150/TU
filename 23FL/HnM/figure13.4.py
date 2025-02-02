from math import sqrt, log, tan

X = float(input("X value = "))
Y = float(input("Y value = "))

def view_factor(X, Y):
    F_ij = (2 / 3.14 / X / Y) * (sqrt(log((1 + X**2) * (1 + Y**2) / (1 + X**2 + Y**2)))) + \
    X * sqrt(1 + Y**2) * (tan(X / sqrt(1 + Y**2)))**-1 + \
    Y * sqrt(1 + X**2) * (tan(Y / sqrt(1 + X**2)))**-1 - X * (tan(X)**(-1) - Y * (tan(Y))**(-1))
    return F_ij

result = view_factor(X,Y)
print(result)