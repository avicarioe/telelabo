%Valores deseados
Mp_max=0.12;
Mp_min=0.05;
ts_max=0.3;
tol=0.05;
tr_max=0.15;

%Datos
K=2652.28;
p=64.986;

%Valores dados
zetas=[0.2 0.4 0.6 0.8];
beta2=3.5;

%Código
beta=0:50;
Mp=[];
for zeta=zetas
    omegan=p/(beta2*zeta);
    Q=beta.^2-2.*beta+1/(zeta^2);
    r1=(zeta*omegan*(beta*(1/(zeta^2)-4)+2/(zeta^2)))./Q;
    r2=(omegan^2*(1/(zeta^2)-2*beta))./Q;
    r3=(beta.^3*zeta*omegan)./Q;
    Mpz=zeros(1,50);
    for i=1:51
        num1=[r1(i) r2(i)];
        den1= [1 2*zeta*omegan omegan^2];
        Hf1=tf(num1,den1);
        num2= r3(i);
        den2= [1 beta(i)*zeta*omegan];
        Hf2=tf(num2, den2);
        Hf=Hf1+Hf2;
        [y,t]=step(Hf);
        Mpz(i)=max(y)-1;
    end
    Mp=[Mp; Mpz];
end
plot(beta, Mp')
hold on
plot