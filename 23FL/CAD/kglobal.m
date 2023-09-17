function [l, kglb1] = kglobal(theta, L, A, E)

l = [cosd(theta) sind(theta) 0 0;
    -sind(theta) cosd(theta) 0 0;
    0 0 cosd(theta) sind(theta);
    0 0 -sind(theta) cosd(theta)];

klocal1 = [ 1 0 -1 0; 
            0 0 0 0; 
            -1 0 1 0; 
            0 0 0 0];
linv = inv(l);
kglb1 = (E * A / L) * (linv * klocal1 * l);

end
