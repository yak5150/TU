%code for Heat and Mass HW
clc 
clear
x=1; 
y=0.75;
W=1;
L=2;
T1=50;
T2=150;

f=@(n) 2./n.*sin(n.*pi.*x./L).*(sinh(n.*pi.*y./L)./sinh(n.*pi.*W./L));

tt= [1,3,5,7,9];

ans=f(tt);
theta=2/pi*sum(ans)

T=theta*(T2-T1)+T1
%%%%%%%%%%%%%%%%%%%%%%%%
%Question 13
w=2;
d1=0.3;
d2=0.2;
k=0.5;
t2=95;
t1=5;
s=(2*pi)/(acosh((4*(w^2)-d1^2-d2^2)/(2*d1*d2)))
q=s*k*(t2-t1)
%%%%%%%%%%%%%%
%question 28
l3=2;
w3=1;
d3=0.25;
k3=150;
h1=50;
h2=4;
tt2=25;
tt1=300;
As=4*w3*l3;
s3=(2*pi*l3)/(log(1.08*w3/d3))
Rcond=1/(s3*k3);
Rconv1=1/(pi*h1*d3*l3);
Rconv2=1/(h2*As);
q3=(tt1-tt2)/(Rcond+Rconv1+Rconv2)
Tcyl=tt1-q3*Rconv1
Tsqr=q3*Rconv2+tt2
%%
%Question 46
clc
clear
t1=430;
t3=394;
t8=600;
t9=600;
t6=492;
ti=300;
h=50;
x=0.01;
t2=(0.5*t1+0.5*t3+t6+((h*x)/1)*ti)/(2+((h*x)/1))
t4=(t3+(h*x)*ti)/(1+h*x)
qcv=h*(x/2)*(t1-ti)+h*x*(t2-ti)+h*x*(t3-ti)+h*(x/2)*(t4-ti)