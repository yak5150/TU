clear
clc

% Constants
theta_A = atand(9/12);
length_A = sqrt(9^2 + 12^2);
theta_B = atand(9/0);
length_B = 9;
theta_C = 0;
length_C = 12;
F_2x = 60;
F_2y = -30;
F_3x = 0;

diam = 0.25;
csa = pi * diam^2 / 4; % Cross sectional area
E = 30e6;

K_local = [ 1 0 -1 0; 0 0 0 0; -1 0 1 0; 0 0 0 0];

% Calc k in global cords for each memeber
[T_A, K_A] = kglobal(theta_A, length_A, csa, E);
[T_B, K_B] = kglobal(theta_B, length_B, csa, E);
[T_C, K_C] = kglobal(theta_C, length_C, csa, E);

%Assemble the Global K matrix
K_global = [K_A(1,1) + K_C(1,1), K_A(1,2) + K_C(1,2), K_A(1,3), K_A(1,4), K_C(1,3), K_C(1,4);
            K_A(2,1) + K_C(2,1), K_A(2,2) + K_C(2,2), K_A(2,3), K_A(2,4), K_C(2,3), K_C(2,4);
            K_A(3,1), K_A(3,2), K_A(3,3) + K_B(1,1), K_A(3,4) + K_B(1,2), K_B(1,3), K_B(1,4);
            K_A(4,1), K_A(4,2), K_A(4,3) + K_B(2,1), K_A(4,4) + K_B(2,2), K_B(2,3), K_B(2,4);
            K_C(3,1), K_C(3,2), K_B(3,1), K_B(3,2), K_B(3,3) + K_C(3,3), K_B(3,4) + K_C(3,4);
            K_C(4,1), K_C(4,2), K_B(4,1), K_B(4,2), K_B(4,3) + K_C(4,3), K_B(4,4) + K_C(4,4);];

%Recuded system of equations based on boundary conditions
F_bndry = [F_2x;F_2y;F_3x];
K_bndry = K_global(3:5,3:5);

%Solve for unknown displacments
xySolve_1 = K_bndry\F_bndry; 

%Construct full displacment vector in global cords
xySolve_2 = [0;0;xySolve_1(1);xySolve_1(2);xySolve_1(3);0;]

%Calculate reaction forces
F_react = K_global * xySolve_2

%Find local displacments for each element
%local x_local=transfor*X_gloabal
X_local_A = T_A*[xySolve_2(1:4)];
X_local_B = T_B*[xySolve_2(3:6)];
X_local_C = T_C*[xySolve_2(1:2);xySolve_2(5:6)];

%Calculate axial force
F_axial_A = (E*csa/length_A)*K_local*X_local_A
F_axial_B = (E*csa/length_B)*K_local*X_local_B
F_axial_C = (E*csa/length_C)*K_local*X_local_C

%Calculate stress
stress_A = F_axial_A/csa
stress_B = F_axial_B/csa
stress_C = F_axial_C/csa
