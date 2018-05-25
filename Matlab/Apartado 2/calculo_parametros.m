clear
%Datos
K=2652.28/23.04;
p=64.986;
Tm=0.002;

%Valores dados
zeta=0.5;
beta=10;
beta2=5;

%Cálculo de variables
KP=(p^2*(2*beta+(1/zeta^2)))/(beta2^2*K)
tauD1=(beta2*(beta-beta2+2))/(p*(2*beta+(1/zeta^2)));
tauD2=p/(K*KP);
tauI=(beta2*zeta^2*(2*beta+(1/zeta^2)))/(beta*p);

tauD=tauD1+tauD2;
 
KI=KP*Tm/tauI
KD1=KP*tauD1/Tm
KD2=KP*tauD2/Tm

% KP=1.89;
% tauD1=1/KP;
% tauD2=0.56/KP;
% tauI=KP/0.05;
% 
% 
% KI=(beta*p^3)/(beta2^3*zeta^2*K)
% KD=(p*(beta-beta2+2))/(beta2*K)

%%
%Función transferencia con r's
omegan=p/(beta2*zeta);
Q=beta^2-2*beta+1/(zeta^2);
r1=(zeta*omegan*(beta*(1/(zeta^2)-4)+(2/(zeta^2))))/Q;
r2=(omegan^2*((1/(zeta^2))-2*beta))/Q;
r3=(beta^3*zeta*omegan)/Q;
num1=[r1 r2];
den1= [1 (2*zeta*omegan) omegan^2];
%Hf1=tf(num1,den1);
num2= r3;
den2= [1 beta*zeta*omegan];
%Hf2=tf(num2, den2);
%Hf=Hf1+Hf2;
[num,den]=parallel(num1,den1,num2,den2);
Hf=tf(num,den);
step(Hf);

%Función de transferencia principal
num=K*KP*tauD*[1 1/tauD 1/(tauD*tauI)];
den=[1 (p+K*KP*tauD1) (K*KP) (K*KP/tauI)];
Hf1=tf(num,den);
figure
step(Hf1);

%Función de transferencia alternativa
num=[p+K*KP*tauD1 K*KP K*KP/tauI]; %esta mal
Hf2=tf(num,den);
figure
step(Hf2);

