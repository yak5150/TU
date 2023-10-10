clear
clc

% Constants
L_A = sqrt(100^2 + 120^2);
L_B = 100;
L_C = 120;
L_D = 100;
L_E = sqrt(100^2 + 120^2);
L_F = 200;
L_G = sqrt(100^2 + 120^2);
theta_A = atand(120/100);
theta_B = 0;
theta_C = 90;
theta_D = 0;
theta_E = 90 + atand(100/120);
theta_F = 0;
theta_G = atand(120/100);

diam = 2; % inch
CsA = pi * diam^2 / 4; % Cross sectional area
Elas = 30e6; %psi

F_2x = 130e3;
F_2y = -160e3;
F_4x = -200e3;

K_local = [ 1 0 -1 0; 0 0 0 0; -1 0 1 0; 0 0 0 0];

% Calc k in global cords for each memeber
[T_A, A] = kglobal(theta_A, L_A, CsA, Elas);
[T_B, B] = kglobal(theta_B, L_B, CsA, Elas);
[T_C, C] = kglobal(theta_C, L_C, CsA, Elas);
[T_D, D] = kglobal(theta_D, L_D, CsA, Elas);
[T_E, E] = kglobal(theta_E, L_E, CsA, Elas);
[T_F, F] = kglobal(theta_F, L_F, CsA, Elas);
[T_G, G] = kglobal(theta_G, L_G, CsA, Elas);

%Assemble the Global K matrix
K_global = [A(1,1)+B(1,1), A(1,2)+B(1,2), A(1,3), A(1,4), B(1,3), B(1,4), 0, 0, 0, 0;
            A(2,1)+B(2,1), A(2,2)+B(2,2), A(2,3), A(2,4), B(2,3), B(2,4), 0, 0, 0, 0;
            A(3,1), A(3,2), A(3,3)+C(1,1)+E(1,1)+F(1,1), A(3,4)+C(1,2)+E(1,2)+F(1,2), C(1,3), C(1,4), F(1,3), F(1,4), E(1,3), E(1,4);
            A(4,1), A(4,2), A(4,3)+C(2,1)+E(2,1)+F(2,1), A(4,4)+C(2,2)+E(2,2)+F(2,2), C(2,3), C(2,4), F(2,3), F(2,4), E(2,3), E(2,4);
            B(3,1), B(3,2), C(3,1), C(3,2), B(3,3)+C(3,3)+D(1,1), B(3,4)+C(3,4)+D(1,2), 0, 0, D(1,3), D(1,4);
            B(4,1), B(4,2), C(4,1), C(4,2), B(4,3)+C(4,3)+D(2,1), B(4,4)+C(4,4)+D(2,2), 0, 0, D(2,3), D(2,4);
            0, 0, F(3,1), F(3,2), 0, 0, F(3,3)+G(1,1), F(3,4)+G(1,2), G(1,3), G(1,4);
            0, 0, F(4,1), F(4,2), 0, 0, F(4,3)+G(2,1), F(4,4)+G(2,2), G(2,3), G(2,4);
            0, 0, E(3,1), E(3,2), D(3,1), D(3,2), G(3,1), G(3,2), D(3,3)+E(3,3)+G(3,3),D(3,4)+E(3,4)+G(3,4);
            0, 0, E(4,1), E(4,2), D(4,1), D(4,2), G(4,1), G(4,2), D(4,3)+E(4,3)+G(4,3),D(4,4)+E(4,4)+G(4,4);
            ];

K_check = sum(K_global)

%Recuded system of equations based on boundary conditions
F_bndry = [F_2x;F_2y;0;0;F_4x;0;0;];
K_bndry = [K_global([3:9],[3:9])];

%Solve for unknown displacments
xySolve_1 = K_bndry\F_bndry; 

%Construct full displacment vector in global cords
xySolve_2 = [0;0;xySolve_1(1);xySolve_1(2);xySolve_1(3);xySolve_1(4);xySolve_1(5);xySolve_1(6);xySolve_1(7);0;]

%Calculate reaction forces
F_react = K_global * xySolve_2

%Find local displacments for each element
%local x_local=transfor*X_gloabal
X_local_A = T_A*[xySolve_2(1:4)];
X_local_B = T_B*[xySolve_2(1:2);xySolve_2(4:5);];
X_local_C = T_C*[xySolve_2(3:6)];
X_local_D = T_D*[xySolve_2(4:5);xySolve_2(9:10)];
X_local_E = T_E*[xySolve_2(3:4);xySolve_2(9:10)];
X_local_F = T_F*[xySolve_2(3:4);xySolve_2(7:8)];
X_local_G = T_G*[xySolve_2(7:10)];

%Calculate axial force
F_axial_A = (Elas*CsA/L_A)*K_local*X_local_A;
F_axial_B = (Elas*CsA/L_B)*K_local*X_local_B;
F_axial_C = (Elas*CsA/L_C)*K_local*X_local_C;
F_axial_D = (Elas*CsA/L_D)*K_local*X_local_D;
F_axial_E = (Elas*CsA/L_E)*K_local*X_local_E;
F_axial_F = (Elas*CsA/L_F)*K_local*X_local_F;
F_axial_G = (Elas*CsA/L_G)*K_local*X_local_G;

%Calculate stress
stress_A = F_axial_A/CsA
stress_B = F_axial_B/CsA
stress_C = F_axial_C/CsA
stress_D = F_axial_D/CsA
stress_E = F_axial_E/CsA
stress_F = F_axial_F/CsA
stress_G = F_axial_G/CsA