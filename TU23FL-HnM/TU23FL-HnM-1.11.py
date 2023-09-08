D_pan = 0.220
thk_pan = 0.008
k_Al = 240
k_Cu = 390
T_s = 110
q_conv = 600

# Convection --> Fourier's law
# Rearrange to solve for T_bot
T_bot_Al = (-4*thk_pan*q_conv/k_Al/3.14/D_pan**2)+T_s
T_bot_Cu = (-4*thk_pan*q_conv/k_Cu/3.14/D_pan**2)+T_s
print('Aluminum pans bottom temp is ' + f"{T_bot_Al:.2f}" + ' deg C')
print('Copper pans bottom temp is ' + f"{T_bot_Cu:.2f}" + ' deg C')