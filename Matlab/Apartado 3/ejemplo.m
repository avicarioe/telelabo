close all
clear

Hf = tf(1,[1 1])*tf(1,[1 0.5])*tf(1,[1 0.25]);
nyquist(Hf);

Hs = Hf/(1+Hf);
figure
step(Hs)

% Punto origen
modHw = @(w) abs(freqresp(Hf,w))-1;
w0 = fsolve(modHw, 0.8);

A = freqresp(Hf,w0);
rA = abs(A);
phaA = pi+angle(A);

% Punto destino
rB = 1;
phaB = 50*pi/180;

% Cálculo de parámetros
alpha = 0.25;
rC = rB/rA;
phaC = phaB - phaA;

KP = rC*cos(phaC);
tauI = (1/(2*w0*alpha))*(tan(phaC)+sqrt(4*alpha+tan(phaC)^2));
tauD = alpha*tauI;

% Representación del lazo cerrado
%Hc = KP*(1 + tf([tauD 0],1) + tf(1, [tauI 0]));
%Hfb = (Hc*Hf)/(1+(Hc*Hf));
num = KP*[tauD 1 1/tauI];
den = [1 7/4 7/8+tauD*KP 1/8+KP KP/tauI];
Hfb = tf(num, den);
figure
step(Hfb);

% Lazo abierto modificado
figure
nyquist(Hfb);
