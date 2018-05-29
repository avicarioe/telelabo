function Hf = hf_from_beta (beta, beta2, amort, p, K)
    omegan=p/(beta2*amort);
    Q=beta^2-2.*beta+1/(amort^2);
    r1=(amort*omegan*(beta*(1/(amort^2)-4)+2/(amort^2)))/Q;
    r2=(omegan^2*(1/(amort^2)-2*beta))/Q;
    r3=(beta.^3*amort*omegan)/Q;
    num1=[r1 r2];
    den1= [1 2*amort*omegan omegan^2];
    Hf1=tf(num1,den1);
    num2= r3;
    den2= [1 beta*amort*omegan];
    Hf2=tf(num2, den2);
    Hf=Hf1+Hf2;
end