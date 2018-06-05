clear
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
amorts=[0.6 0.7 0.8 0.9];
beta2=0.5;
len=500;

%Código
beta=linspace(0,50,len);
Mp=[];
for amort=amorts
    Mpz=zeros(1,len);
    for i=1:len
        Hf = hf_from_beta(beta(i), beta2, amort, p, K);
        Mpz(i)=getMp(Hf);
    end
    Mp=[Mp; Mpz];
end
plot(beta, Mp')
hold on
hline(Mp_max, 0, 50);
hline(Mp_min, 0, 50);
title('Sobreelongación máxima de y(t) de un D|PID')
legend('\zeta=0.6','\zeta=0.7','\zeta=0.8','\zeta=0.9', 'Location', 'northeast')
xlabel('\beta')
ylabel('M_p')
hold off