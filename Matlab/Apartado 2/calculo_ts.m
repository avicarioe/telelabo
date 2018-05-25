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
zetas=0.5;
betas=15;

%C�digo
beta2=linspace(0,120,50);
ts=[];
for j=1:length(zetas)
    zeta=zetas(j);
    beta=betas(j);
    omegan=p./(beta2*zeta);
    Q=beta^2-2*beta+1/(zeta^2);
    r1=(zeta*omegan*(beta*(1/(zeta^2)-4)+2/(zeta^2)))./Q;
    r2=(omegan.^2*(1/(zeta^2)-2*beta))./Q;
    r3=(beta.^3*zeta*omegan)./Q;
    tsz=zeros(1,50);
    for i=2:50
        num1=[r1(i) r2(i)];
        den1= [1 2*zeta*omegan(i) omegan(i)^2];
        Hf1=tf(num1,den1);
        num2= r3(i);
        den2= [1 beta*zeta*omegan(i)];
        Hf2=tf(num2, den2);
        Hf=Hf1+Hf2;
        [y,t]=step(Hf);
%         last=0;
%         for j=1:length(t)
%             if abs(y(j)-1)<tol
%                 if last==0
%                     last=j;
%                 end
%             else
%                 last=0;
%             end
%         end
        dis = abs(y-1);
        pos = find(dis>tol);
        tsz(i) = t(pos(end));
    end
    ts=[ts; tsz];
end
plot(beta2, ts')
hold on
refline([0, ts_max])
hold off