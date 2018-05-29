num = 1;
den = [1 3/2 3/8+1/2 1/8];
Hf = tf(num, den);
nyquist(Hf);

Hs = Hf/(1+Hf);
figure
step(Hs)

% Punto origen
Hw = @(w) 1/((j*w+1)*(j*w+0.5)*(j*w+1/4));
modHw = @(w) abs(Hw(w))-1;
w0 = fsolve(modHw, 0.8);

A = Hw(w0);
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
tauI = 1/(2*w0*alpha)*(tan(phaC)+sqrt(4*alpha+tan(phaC)^2));
tauD = alpha*tauI;

% Representación del lazo cerrado
Hc = KP*(1 + tf([tauD 0],1) + tf(1, [tauI 0]));
Hfb = Hc*Hf/(1+Hc*Hf);
figure
step(Hfb);
figure
nyquist(Hf);