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
amort=[0.35 0.4 0.45 0.4 0.35];
beta=[12.5 15 18 16 13.5];
len=50;

%Código
beta2=linspace(0,30,len);
ts=[];
for j=1:length(amort)
    tsz=zeros(1,len);
    for i=2:len
        Hf = hf_from_beta(beta(j), beta2(i), amort(j), p, K);
        tsz(i) = getTs(Hf, tol);
    end
    ts=[ts; tsz];
end
plot(beta2, ts')
hold on
hline(ts_max, 0, 30);
title('Tiempo de estabilización de la respuesta al escalón')
legend('\zeta=0.35, \beta=12.5','\zeta=0.40, \beta=15','\zeta=0.45, \beta=18','\zeta=0.40, \beta=16','\zeta=0.35, \beta=13.5', 'Location', 'northeast')
xlabel('\beta_2')
ylabel('t_s')
hold off