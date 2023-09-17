clear 
clc
%Constants (E, A and L values)
theta_A= atand(6/8); %in
L_A= sqrt(6^2+8^2); %inch
A = 0.049; %in^2
E=30e6;

theta_B= atand(-6/4);
L_B= sqrt(4^2+6^2);


klocal=[ 1 0 -1 0;0 0 0 0;-1 0 1 0;0 0 0 0];

%calc k in global cords for each memeber 
[T_A, K_A] = kglobal(theta_A,L_A,A,E)
[T_B, K_B] = kglobal(theta_B,L_B,A,E)

%Assemble the Global K matrix
K = [K_A(1,1), K_A(1,2), K_A(1,3), K_A(1,4), 0, 0;
    K_A(2,1), K_A(2,2), K_A(2,3), K_A(2,4), 0, 0;
    K_A(3,1), K_A(3,2), K_A(3,3)+K_B(1,1), K_A(3,4)+K_B(1,2), K_B(1,3), K_B(1,4);
    K_A(4,1), K_A(4,2), K_A(4,3)+K_B(2,1), K_A(4,4)+K_B(2,2), K_B(2,3), K_B(2,4);
    0, 0, K_B(3,1), K_B(3,2), K_B(3,3), K_B(3,4);
    0, 0, K_B(4,1), K_B(4,2), K_B(4,3), K_B(4,4)];
    %matrix should sum up to zero if it was done correctly

%Recuded system of equations based on boundary conditions 
    %we're ignoring any unknown variables, just keeping rows for x2 and y2 
k_con=K([3:4],[3:4])
%column vector of our known forces
F = [50;0];

%SOlve for unknown displacments
X= k_con\F;
x2=k_con^-1*F;
x3 = linsolve(k_con,F);

%Construct full displacment vector in global cords
XX = [0;0;X(1);X(2);0;0]
%Calculate reaction forces 
F_react=K.*XX %what

%Fina local displacments for each element 
%local x_local=transfor*X_gloabal

XAlocal = T_A*[XX(1:4)]
XBlocal = T_B*[XX(3:6)]

%Calculate axial force 
F_axial_A=((E*A)/L_A)*klocal*XAlocal
F_axial_B=(E*A/L_B)*klocal*XBlocal
%Calculate stress
StressA = F_axial_A/A
StressB = F_axial_B/A

%local to global transformation function 
    %put a function at 
function [l kglb1] = kglobal(theta, h, A, E)

l=[cosd(theta) sind(theta) 0 0;
    -sind(theta) cosd(theta) 0 0;
    0 0 cosd(theta) sind(theta);
    0 0 -sind(theta) cosd(theta)];

klocal1 = [ 1 0 -1 0; 
            0 0 0 0; 
            -1 0 1 0; 
            0 0 0 0];
linv=inv(l);
kglb1=(E*A/h)*(linv*klocal1*l);

end

