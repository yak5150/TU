clc
clear all
klocal=[ 1 0 -1 0;0 0 0 0;-1 0 1 0;0 0 0 0];
%Constants (E, A and L values)
theta_A= atand(120/100); %degrees
L_A= sqrt((120^2)+(100^2)); %inches
A = (pi()/4)*(2)^2; %in^2
E=30e6; %psi for steel
theta_B=0;
L_B=100; %inches
theta_C=90;
L_C=120;%inches
theta_D=0;
L_D=100; %inches
theta_E=90+atand(120/100);
L_E=sqrt((120^2)+(100^2));
theta_F=0;
L_F=200;
theta_G=atand(120/100);
L_G=sqrt((120^2)+(100^2)); %inches
%transform to global coordinates
[T_A, K_A] = kglobal(theta_A,L_A,A,E);
[T_B, K_B] = kglobal(theta_B,L_B,A,E);
[T_C, K_C] = kglobal(theta_C,L_C,A,E);
[T_D, K_D]= kglobal(theta_D,L_D,A,E);
[T_E, K_E] = kglobal(theta_E,L_E,A,E);
[T_F, K_F]= kglobal(theta_F,L_F,A,E);
[T_G, K_G] = kglobal(theta_G,L_G,A,E);
%Create the global matrix
K = [K_A(1,1)+K_B(1,1) K_A(1,2)+K_B(1,2) K_A(1,3) K_A(1,4) K_B(1,3) K_B(1,4) 0 0 0 0;
K_A(2,1)+K_B(2,1) K_A(2,2)+K_B(2,2) K_A(2,3) K_A(2,4) K_B(2,3) K_B(2,4) 0 0 0 0;
K_A(3,1) K_A(3,2) K_A(3,3)+K_C(1,1)+K_E(1,1)+K_F(1,1) K_A(3,4)+K_C(1,2)+K_E(1,2)+K_F(1,2) K_C(1,3) K_C(1,4) K_F(1,3) K_F(1,4) K_E(1,3) K_E(1,4);
K_A(4,1) K_A(4,2) K_A(4,3)+K_C(2,1)+K_E(2,1)+K_F(2,1) K_A(4,4)+K_C(2,2)+K_E(2,2)+K_F(2,2) K_C(2,3) K_C(2,4) K_F(2,3) K_F(2,4) K_E(2,3) K_E(2,4);
K_B(3,1) K_B(3,2) K_C(3,1) K_C(3,2) K_B(3,3)+K_C(3,3)+K_D(1,1) K_B(3,4)+K_C(3,4)+K_D(1,2) 0 0 K_D(1,3) K_D(1,4);
K_B(4,1) K_B(4,2) K_C(4,1) K_C(4,2) K_B(4,3)+K_C(4,3)+K_D(2,1) K_B(4,4)+K_C(4,4)+K_D(2,2) 0 0 K_D(2,3) K_D(2,4);
0 0 K_F(3,1) K_F(3,2) 0 0 K_F(3,3)+K_G(1,1) K_F(3,4)+K_G(1,2) K_G(1,3) K_G(1,4);
0 0 K_F(4,1) K_F(4,2) 0 0 K_F(4,3)+K_G(2,1) K_F(4,4)+K_G(2,2) K_G(2,3) K_G(2,4);
0 0 K_E(3,1) K_E(3,2) K_D(3,1) K_D(3,2) K_G(3,1) K_G(3,2) K_E(3,3)+K_G(3,3)+K_D(3,3) K_E(3,4)+K_G(3,4)+K_D(3,4);
0 0 K_E(4,1) K_E(4,2) K_D(4,1) K_D(4,2) K_G(4,1) K_G(4,2) K_E(4,3)+K_G(4,3)+K_D(4,3) K_E(4,4)+K_G(4,4)+K_D(4,4);];
%matrix should sum up to zero if it was done correctly
k_sum = sum(K)
%Recuded system of equations based on boundary conditions
%we're ignoring any unknown variables, just keeping rows for x2 and y2 and y3
k_con=K([3:9],[3:9]);
%column vector of our known forces
F = [130000; -160000; -0; 0; -200000; 0; 0];
%SOlve for unknown displacements
X= k_con\F
%Construct full displacment vector in global cords
XX = [0;0;X(1);X(2);X(3);X(4);X(5);X(6);X(7);0] % this is all of the global displacement
%Calculate reaction forces
F_react=K*XX %solving for reaction forces
%Find local displacments for each element
%local x_local=transfor*X_gloabal
XAlocal = T_A*[XX(1:4)];
XBlocal = T_B*[XX(1:2); XX(4:5)];
XClocal = T_C*[XX(3:6)];
XDlocal = T_D*[XX(4:5); XX(9:10)];
XElocal = T_E*[XX(3:4); XX(9:10)];
XFlocal = T_F*[XX(3:4); XX(7:8)];
XGlocal = T_G*[XX(7:10)];
%Calculate axial force
F_axial_A=((E*A)/L_A)*klocal*XAlocal
F_axial_B=(E*A/L_B)*klocal*XBlocal
F_axial_C=(E*A*L_C)*klocal*XClocal
F_axial_D=(E*A*L_D)*klocal*XDlocal
F_axial_E=(E*A*L_E)*klocal*XElocal
F_axial_F=(E*A*L_F)*klocal*XFlocal
F_axial_G=(E*A*L_G)*klocal*XGlocal
%Calculate stress
StressA = F_axial_A/A
StressB = F_axial_B/A
StressC = F_axial_C/A
StressD = F_axial_D/A
StressE = F_axial_E/A

StressF = F_axial_F/A
StressG = F_axial_G/A
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