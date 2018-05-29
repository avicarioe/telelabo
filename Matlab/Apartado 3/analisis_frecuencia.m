num=22233201.58;
den=[1 8382.70+64.986 8382.70*64.986 0];


% ang=0:0.01:2*pi; 
% xp=cos(ang);
% yp=sin(ang);


bode(num,den);
figure
nyquist(num,den);
hold on
%plot(xp,yp);
hold off
%figure
%rlocus(num,den);