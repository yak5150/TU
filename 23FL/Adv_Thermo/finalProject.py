# import pyromat as pm 
# R134A = pm.get('mp.C2H2F4')

# problem given parameters
tempFzr = -18
tempRef = 4
tempInf = 25
compE = 0.8
tempDelta = 10
Qfzr = 20 
Qref = 40

# state 1
# exit evaporator 2 "freezer" into compressor 1
print(f"temp1 = {tempFzr - tempDelta}")
h1 = 230.38 # table A10 at -28degC
s1 = 0.9411 # table A10 at -28degC
p1 = 0.9305 # table A10 at -28degC

# state 2
# exit compressor 1 into heat exchanger
s2_s = s1 # isentropic compression
h2_s = 