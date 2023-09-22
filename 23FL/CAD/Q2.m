clear
clc

% ***Constants***
L_A = 9;
L_B = sqrt(9^2 + 14^2);
L_C = 14;
theta_A = 90;
theta_B = atand(14/9);
theta_C = 0;

CsA = 0.049; % Cross sectional area
E = 30e6;

F_2x = 50;
F_2y = -35;
F_3y = 0;

K_local = [ 1 0 -1 0; 0 0 0 0; -1 0 1 0; 0 0 0 0];

% Calc k in global cords for each memeber
[T_A, A] = kglobal(theta_A, L_A, CsA, E);
[T_B, B] = kglobal(theta_B, L_B, CsA, E);
[T_C, C] = kglobal(theta_C, L_C, CsA, E);

% ***Assemble the Global K matrix***
K_global = [A(1,1)+C(1,1), A(1,2)+C(1,2), A(1,3), A(1,4), C(1,3), C(1,4);
            A(2,1)+C(2,1), A(2,2)+C(2,2), A(2,3), A(2,4), C(2,3), C(2,4);
            A(3,1), A(3,2), A(3,3)+B(1,1), A(3,4)+B(1,2), B(1,3), B(1,4);
            A(4,1), A(4,2), A(4,3)+B(2,1), A(4,4)+B(2,2), B(2,3), B(2,4);
            C(3,1), C(3,2), B(3,1), B(3,2), B(3,3)+C(3,3), B(3,4)+C(3,4);
            C(4,1), C(4,2), B(4,1), B(4,2), B(4,3)+C(4,3), B(4,4)+C(4,4);];

K_check = sum(K_global)

% ***Recuded system of equations based on boundary conditions***
F_bndry = [F_2x; F_2y; F_3y;];
K_bndry = K_global(3:5, 3:5);

%Solve for unknown displacments
xySolve_1 = K_bndry\F_bndry; 

% ***Construct full displacment vector in global cords***
xySolve_2 = [0; 0; xySolve_1(1); xySolve_1(2); xySolve_1(3); 0;]

%Calculate reaction forces
F_react = K_global * xySolve_2

% ***Find local displacments for each element***
%local x_local=transfor*X_gloabal
X_local_A = T_A*[xySolve_2(1:4)];
X_local_B = T_B*[xySolve_2(3:6)];
X_local_C = T_C*[xySolve_2(1:2);xySolve_2(5:6)];

%Calculate axial force
F_axial_A = (E*CsA/L_A)*K_local*X_local_A;
F_axial_B = (E*CsA/L_B)*K_local*X_local_B;
F_axial_C = (E*CsA/L_C)*K_local*X_local_C;

%Calculate stress
stress_A = F_axial_A/CsA
stress_B = F_axial_B/CsA
stress_C = F_axial_C/CsA