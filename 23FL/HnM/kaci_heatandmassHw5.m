%heatandmassh5
%Kaci Walter
%%Q11
h=55;
Lc=0.5*10^-3;
k=0.34;
T=220;
T8=300;
T1=20;
Bi=(h*Lc)/k;
rho=700;
cp=2400;
alpha=k/(rho*cp);
t=((Lc^2)*log((T-T8)/(T1-T8)))/(-Bi*alpha);
v=3/t;
%% Q38
h=250;
Lc=0.1/2;
k=48;
T=200;
T8=800;
T1=550;
Bi=(h*Lc)/k;
rho=7830;
cp=550;
alpha=k/(rho*cp);
%interpolation of zeta and C1 from table 5.1
x=0.2604;
x1=0.25;
x2=0.3;
y2=0.5218;
y1=0.4801;
zeta=((x-x1)/(x2-x1))*(y2-y1)+y1;
c1=1.0382;
c2=1.0450;
C1=((x-x1)/(x2-x1))*(c2-c1)+c1;
Fo=(log(((T1-T8)/(T-T8))/C1))/zeta^2;
t=(Fo*Lc^2)/alpha;
%% Q48
h=1000;
k=50;
c=500;
T8=750;
T=550;
zeta=1.0184;
To=T8+((T-T8)/(0.7568))
%% Q56
k=1.4;
rhob=1300;
cpb=1465;
rhog=2500;
cpg=750;
h=30;
t=200;
alphag=k/(rhog*cpg);
alphab=k/(rhob*cpb);
d=0.045;
Bi=(h*(d/6))/k;
Fo=(alphag*t)/((d/2)^2);
c1=1.1441;
zeta=1.1656;
T1=40;
T8=10;
T=c1*exp(-zeta*Fo)*(T1-T8)+T8

