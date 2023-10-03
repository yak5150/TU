clc
clear
format long

% Givens
T_c_i = (18+20)/2 % C 
T_h_i = (60+70)/2 % C 
T_inf = 25; % C 

TcK = T_c_i+273.15; 
ThK = T_h_i +273.15;
T_inf_K = T_inf + 273.15;

D_i_in = 1*0.0254; % m
D_i_out = 1.125*0.0254; % m

D_o_in = 1.5*0.0254; % m
D_o_out = 1.625*0.0254; % m
% 
% m_c = linspace(0.2,0.05,16); %L/s
% m_h = linspace(0.2,0.05,16); %L/s

m_c = 1
m_h = 0.25

L = linspace(0,1,100); % m

rho = 1000; %kg/m^3, density of water

k_cu = 398; % W/m · K


thermo_prop = [273.15, 0.00611, 1.000, 206.3, 2502, 4.217, 1.854, 1750,...
    8.02, 569, 18.2, 12.99, 0.815, 75.5, 68.05, 273.15; 275 0.00697,...
    1.000, 181.7, 2497, 4.211, 1.855, 1652, 8.09, 574, 18.3, 12.22, 0.817,...
    75.3, 32.74, 275; 280, 0.00990, 1.000, 130.4, 2485, 4.198, 1.858,...
    1422, 8.29, 582, 18.6, 10.26, 0.825, 74.8, 46.04, 280; 285, 0.01387,...
    1.000, 99.4, 2473, 4.189, 1.861, 1225, 8.49, 590, 18.9, 8.81, 0.833,...
    74.3, 114.1, 285; 290, 0.01917, 1.001, 69.7, 2461, 4.184, 1.864, 1080,...
    8.69, 598, 19.3, 7.56, 0.841, 73.7, 174.0, 290; 295, 0.02617, 1.002,...
    51.94, 2449, 4.181, 1.868, 959, 8.89, 606, 19.5, 6.62, 0.849, 72.7,...
    227.5, 295; 300, 0.03531, 1.003, 39.13, 2438, 4.179, 1.872, 855, 9.09,...
    613, 19.6, 5.83, 0.857, 71.7, 276.1, 300; 305, 0.04712, 1.005, 29.74,...
    2426, 4.178, 1.877, 769, 9.29, 620, 20.1, 5.20, 0.865, 70.9, 320.6,...
    305; 310, 0.06221, 1.007, 22.93, 2414, 4.178, 1.882, 695, 9.49, 628,...
    20.4, 4.62, 0.873, 70.0, 361.9, 310; 315, 0.08132, 1.009, 17.82, 2402,...
    4.179, 1.888, 631, 9.69, 634, 20.7, 4.16, 0.883, 69.2, 400.4, 315; 320,...
    0.1053, 1.011, 13.98, 2390, 4.180, 1.895, 577, 9.89, 640, 21.0, 3.77,...
    0.894, 68.3, 436.7, 320; 325, 0.1351, 1.013, 11.06, 2378, 4.182,...
    1.903, 528, 10.09, 645, 21.3, 3.42, 0.901, 67.5, 471.2, 325; 330,...
    0.1719, 1.016, 8.82, 2366, 4.184, 1.911, 489, 10.29, 650, 21.7, 3.15,...
    0.908, 66.6, 504.0, 330; 335, 0.2167, 1.018, 7.09, 2354, 4.186, 1.920,...
    453, 10.49, 656, 22.0, 2.88, 0.916, 65.8, 535.5, 335; 340, 0.2713,...
    1.021, 5.74, 2342, 4.188, 1.930, 420, 10.69, 660, 22.3, 2.66, 0.925,...
    64.9, 566.0, 340; 345, 0.3372, 1.024, 4.683, 2329, 4.191, 1.941,...
    389, 10.89, 664, 22.6, 2.45, 0.933, 64.1, 595.4, 345];

% Linear Interpolation Values
T_c_low = 0; T_c_up = 0; mu_c_low = 0; mu_c_up = 0; k_c_low = 0;...
    k_c_up = 0; Pr_c_low = 0; Pr_c_up = 0; C_c_up = 0; C_c_low = 0;
mu_h_low = 0; mu_h_up = 0; k_h_low = 0; k_h_up = 0; Pr_h_low = 0;...
    Pr_h_up = 0; C_h_up = 0; C_h_low = 0;
k_cu_low = 0; k_cu_up = 0;

for i = 1:16
    % Cold Values
    if abs(TcK-thermo_prop(i,1)) <= 5
        % x = value, y = temperature
        if (TcK-thermo_prop(i,1)) > 0 
            % lower values
            T_c_low = thermo_prop(i,1);
            mu_c_low = thermo_prop(i,8);
            k_c_low = thermo_prop(i,10);
            Pr_c_low = thermo_prop(i,12);
            C_c_low = thermo_prop(i,6);
        else
            % upper values
            T_c_up = thermo_prop(i,1);
            mu_c_up = thermo_prop(i,8);
            k_c_up = thermo_prop(i,10);
            Pr_c_up = thermo_prop(i,12);
            C_c_up = thermo_prop(i,6);

        end
    end
     % Hot Values
    if abs(ThK-thermo_prop(i,1)) <= 5
        % x = value, y = temperature
        if (ThK-thermo_prop(i,1)) > 0 
            % lower values
            T_h_low = thermo_prop(i,1);
            mu_h_low = thermo_prop(i,8);
            k_h_low = thermo_prop(i,10);
            Pr_h_low = thermo_prop(i,12);
            C_h_low = thermo_prop(i,6);
        else
            % upper values
            T_h_up = thermo_prop(i,1);
            mu_h_up = thermo_prop(i,8);
            k_h_up = thermo_prop(i,10);
            Pr_h_up = thermo_prop(i,12);
            C_h_up = thermo_prop(i,6);

        end
    end
end

% Cold Interpolations
mu_c = ((((TcK-T_c_up)*(mu_c_low-mu_c_up))/(T_c_low-T_c_up))+mu_c_up)*10^-6; % N · s/m2
k_c = ((((TcK-T_c_up)*(k_c_low-k_c_up))/(T_c_low-T_c_up))+k_c_up)*10^-3; % W/m · K
Pr_c = (((TcK-T_c_up)*(Pr_c_low-Pr_c_up))/(T_c_low-T_c_up))+Pr_c_up;
C_c = ((((TcK-T_c_up)*(C_c_low-C_c_up))/(T_c_low-T_c_up))+C_c_up)*1000; % kJ/kg · K

% Hot Interpolations
mu_h = ((((ThK-T_h_up)*(mu_h_low-mu_h_up))/(T_h_low-T_h_up))+mu_h_up)*10^-6; % N · s/m2
k_h = ((((ThK-T_h_up)*(k_h_low-k_h_up))/(T_h_low-T_h_up))+k_h_up)*10^-3; % W/m · K
Pr_h = (((ThK-T_h_up)*(Pr_h_low-Pr_h_up))/(T_h_low-T_h_up))+Pr_h_up;
C_h = ((((ThK-T_h_up)*(C_h_low-C_h_up))/(T_h_low-T_h_up))+C_h_up)*1000; % kJ/kg · K

% Calculated Constants

ReD_h = (m_h*4)/((pi*D_i_in)*mu_h);
ReD_c = (m_c *4)/(pi*(D_o_in-D_i_out)*mu_c); 


NuD_c = 0.023*(ReD_c^0.8)*(Pr_c^0.4); % cold water is getting heated 
NuD_h = 0.023*(ReD_h^0.8)*(Pr_h^0.3); % hot water is getting cooled

h_c = (k_c*NuD_c)/D_o_in;
h_h = (k_h*NuD_h)/D_i_in;

A_o = pi*D_o_out*L;
% A_c = pi*D_c_i*L;
% A_h = pi*D_h_i*L;
% 
% R_c_conv = 1./(h_c*A_c);
% R_i_cond = log(D_c_o/D_c_i)./(2*pi*L*k_cu);
% R_h_conv = 1./(h_h*A_h);
% R_o_cond = log(D_h_o/D_h_i)./(2*pi*L*k_cu);
% R_air_conv = 1./(h_air.*A_o);

% U = ((R_c_conv+R_i_cond+R_h_conv+R_o_cond+R_air_conv)).^-1
Ut = 1./((1/h_h)+(log(D_i_out/D_i_in)./(2*pi*L*k_cu))+(1./h_c)+...
    (log(D_o_out/D_o_in)./(2*pi*L*k_cu)));

if C_c < C_h
        C_min = C_c;
        C_max = C_h;
else
        C_min = C_h;
        C_max = C_c;
end

C_r = C_min/C_max;

NTU = (Ut.*A_o)/C_min;

q_max = C_min*(T_h_i-T_c_i);

% Parallel Flow 
eps_p = (1-exp(-NTU*(1+C_r)))/(1+C_r);
q_p = eps_p*q_max;
T_c_o_p = (q_p/(m_c*C_min))+T_c_i;
T_h_o_p = (-q_p/(m_h*C_max))+T_h_i;

% Counter Flow
eps_c = (1-exp(-NTU*(1-C_r)))./(1-(C_r*exp(-NTU*(1-C_r))));
q_c = eps_c*q_max;
T_c_o_c = (q_c/(m_c*C_min))+T_c_i;
T_h_o_c = (-q_c/(m_h*C_max))+T_h_i;

% printing
disp(['Length: ',num2str(L),' m'])
fprintf('\n')
disp(['U: ',num2str(Ut(length(Ut)))])
%fprintf('\n')
%disp(['Initial Hot Temperature: ',num2str(T_h_i)])
%disp(['Initial Cold Temperature: ',num2str(T_c_i)])

fprintf('\n Parallel Flow \n')
disp(['Heat Transfer Rate: ',num2str(q_p(100))])
disp(['Final Hot Temperature: ',num2str(T_h_o_p(100))])
disp(['Final Cold Temperature: ',num2str(T_c_o_p(100))])

fprintf('\n Counter Flow \n')
disp(['Heat Transfer Rate: ',num2str(q_c(100))])
disp(['Final Hot Temperature: ',num2str(T_h_o_c(100))])
disp(['Final Cold Temperature: ',num2str(T_c_o_c(100))])

%-------Plot 1-------------------------------------------------------------
figure(1)
hold on
plot(L,T_h_o_c,'r-','linewidth',2)
plot(L,T_c_o_c,'b-','linewidth',2);
ylabel('Temperature (^{\circ}C)');
xlabel('Length (m)');
ax = gca;
ax.YColor = 'k';
ax.FontSize = 15;
lgd = legend('Hot Fluid Outlet Temperature',...
'Cold Fluid Outlet Temperature','location','southoutside');
lgd.NumColumns = 3;
lgd.FontSize = 10;
title('Temperature Outlets Comparison');
grid on
hold off

%-------Plot 2-------------------------------------------------------------
figure(2)
hold on
plot(L,T_h_o_c,'r-','linewidth',2)
plot(L,T_c_o_c,'b-','linewidth',2);
plot(L,T_h_o_p,'k--','linewidth',2)
plot(L,T_c_o_p,'g--','linewidth',2);
ylabel('Temperature (^{\circ}C)');
xlabel('Length (m)');
ax = gca;
ax.YColor = 'k';
ax.FontSize = 15;
lgd = legend('Hot Fluid Outlet Temperature Cross Flow',...
'Cold Fluid Outlet Temperature Cross Flow',...
'Hot Fluid Outlet Temperature Parallel Flow',...
'Cold Fluid Outlet Temperature Parallel Flow',...
'location','southoutside');
lgd.NumColumns = 3;
lgd.FontSize = 10;
title('Heat Exchanger Flow Temperature Outlets Comparison');
grid on
hold off