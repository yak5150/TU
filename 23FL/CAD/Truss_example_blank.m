clear
clc
%Constants
klocal=[ 1 0 -1 0;0 0 0 0;-1 0 1 0;0 0 0 0];
%calc k in global cords for each memeber
%Assemble the Global K matrix
%Recuded system of equations based on boundary conditions
%Solve for unknown displacments
%Construct full displacment vector in global cords
%Calculate reaction forces
%Find local displacments for each element
%local x_local=transfor*X_gloabal
%Calculate axial force
%Calculate stress
%local to global transformation function
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
