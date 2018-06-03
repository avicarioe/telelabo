clear
close all
% Datos del motor
K = 22233201.58;
p1 = 64.986;
p2 = 8382.70;

% Representación del lazo abierto
num = K;
den = [1 p1+p2 p1*p2 0];
Hf = tf(num, den);
bode(Hf);
figure
nyquist(Hf)

% Lazo cerrado sin PID
Hs = Hf/(1+Hf);
figure
step(Hs)

% Punto origen
modHw = @(w) abs(freqresp(Hf,w))-1;
w0 = fsolve(modHw, 20);

A = freqresp(Hf,w0);
rA = abs(A);
phaA = 2*pi+angle(A);

% Punto destino
rB = 1;
phaB = pi+50*pi/180;

% Cálculo de parámetros
alpha = 0.25;
rC = rB/rA;
phaC = phaB - phaA;
KP = rC*cos(phaC);
tauI = 1/(2*w0*alpha)*(tan(phaC)+sqrt(4*alpha+tan(phaC)^2));
tauD = alpha*tauI;

% Representación del lazo cerrado
%Hfb = hf_from_pid (KP, tauI, tauD, 2652.28, 64.986);
Hc = KP*(1 + tf([tauD 0],1) + tf(1, [tauI 0]));
Hfb = Hc*Hf/(1+Hc*Hf);
figure
step(Hfb);

% Lazo abierto modificado
figure
nyquist(Hf*Hc);
