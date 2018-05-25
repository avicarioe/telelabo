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
zetas=[0.35 0.4 0.45 0.4 0.35];
betas=[12.5 15 18 16 13.5];
len=100;

%Código
beta2=linspace(0,30,len);
ts=[];
for j=1:length(zetas)
    zeta=zetas(j);
    beta=betas(j);
    omegan=p./(beta2*zeta);
    Q=beta^2-2*beta+1/(zeta^2);
    r1=(zeta*omegan*(beta*(1/(zeta^2)-4)+2/(zeta^2)))./Q;
    r2=(omegan.^2*(1/(zeta^2)-2*beta))./Q;
    r3=(beta.^3*zeta*omegan)./Q;
    tsz=zeros(1,len);
    for i=2:len
        num1=[r1(i) r2(i)];
        den1= [1 2*zeta*omegan(i) omegan(i)^2];
        Hf1=tf(num1,den1);
        num2= r3(i);
        den2= [1 beta*zeta*omegan(i)];
        Hf2=tf(num2, den2);
        Hf=Hf1+Hf2;
        [y,t]=step(Hf);
        dis = abs(y-1);
        pos = find(dis>tol);
        tsz(i) = t(pos(end));
    end
    ts=[ts; tsz];
end
plot(beta2, ts')
hold on
refline([0, ts_max]),
title('Tiempo de estabilización de la respuesta al escalón')
legend('\zeta=0.35, \beta=12.5','\zeta=0.40, \beta=15','\zeta=0.45, \beta=18','\zeta=0.40, \beta=16','\zeta=0.35, \beta=13.5', 'Location', 'northeast')
xlabel('\beta_2')
ylabel('t_s')
hold off