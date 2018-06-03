clear
%Datos
K=2652.28/23.04;
p=64.986;
Tm=0.005;

%Valores dados
amort=0.7;
beta=15;
beta2=3.5;

%Cálculo de variables
KP=(p^2*(2*beta+(1/amort^2)))/(beta2^2*K)
tauD1=(beta2*(beta-beta2+2))/(p*(2*beta+(1/amort^2)));
tauD2=p/(K*KP);
tauI=(beta2*amort^2*(2*beta+(1/amort^2)))/(beta*p);

tauD=tauD1+tauD2;

KI=KP*Tm/tauI
KD1=KP*tauD1/Tm
KD2=KP*tauD2/Tm

%Función transferencia con r's
Hf = hf_from_beta(beta, beta2, amort, p, K);
step(Hf);

%Función de transferencia principal
Hf = hf_from_pid (KP, tauI, tauD1, tauD2, K, p);
figure
step(Hf);
