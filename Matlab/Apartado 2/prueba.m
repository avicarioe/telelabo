clear
%Datos
K=2652.28/23.04;
p=64.986;
KP=15.5;
tauD1=0.0364;
tauI=0.0578;

tauD2=p/(K*KP);
tauD=tauD1+tauD2;

num=[K*KP*tauD K*KP K*KP/tauI];
den=[1 p+K*KP*tauD1 K*KP K*KP/tauI];
Hf=tf(num,den);
step(Hf)

%%
num=[p+K*KP*tauD1 K*KP K*KP/tauI];
den=[1 p+K*KP*tauD1 K*KP K*KP/tauI];
Hf=tf(num,den);
figure
step(Hf)