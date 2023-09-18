clear
clc

% ***Constants***
L_A = ;
L_B = ;
L_C = ;
L_D = ;
L_E = ;
theta_A = atand();
theta_B = atand();
theta_C = atand();
theta_D = atand();
theta_E = atand();

diam = ;
CsA = pi * diam^2 / 4; % Cross sectional area
E = ;

F_2x = ;
F_2y = ;

K_local = [ 1 0 -1 0; 0 0 0 0; -1 0 1 0; 0 0 0 0];

% Calc k in global cords for each memeber
[T_A, A] = kglobal(theta_A, L_A, CsA, E);
[T_B, B] = kglobal(theta_B, L_B, CsA, E);
[T_C, C] = kglobal(theta_C, L_C, CsA, E);
[T_D, D] = kglobal(theta_D, L_D, CsA, E);
[T_E, E] = kglobal(theta_E, L_E, CsA, E);

% ***Assemble the Global K matrix***
K_global = [, , , , , , , ;
            , , , , , , , ;
            , , , , , , , ;
            , , , , , , , ;
            , , , , , , , ;
            , , , , , , , ;
            , , , , , , , ;
            , , , , , , , ;];

K_check = sum(K_global)

% ***Recuded system of equations based on boundary conditions***
F_bndry = [];
K_bndry = K_global();

%Solve for unknown displacments
xySolve_1 = K_bndry\F_bndry; 

% ***Construct full displacment vector in global cords***
xySolve_2 = []

%Calculate reaction forces
F_react = K_global * xySolve_2

% ***Find local displacments for each element***
%local x_local=transfor*X_gloabal
X_local_A = T_A*[xySolve_2()];
X_local_B = T_B*[xySolve_2()];
X_local_C = T_C*[xySolve_2()];
X_local_D = T_D*[xySolve_2()];
X_local_E = T_E*[xySolve_2()];

%Calculate axial force
F_axial_A = (E*CsA/L_A)*K_local*X_local_A;
F_axial_B = (E*CsA/L_B)*K_local*X_local_B;
F_axial_C = (E*CsA/L_C)*K_local*X_local_C;
F_axial_D = (E*CsA/L_D)*K_local*X_local_D;
F_axial_E = (E*CsA/L_E)*K_local*X_local_E;

%Calculate stress
stress_A = F_axial_A/CsA
stress_B = F_axial_B/CsA
stress_C = F_axial_C/CsA
stress_D = F_axial_D/CsA
stress_E = F_axial_E/CsA