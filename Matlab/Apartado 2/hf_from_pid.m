function Hf = hf_from_pid (KP, tauI, tauD1, tauD2, K, p)
    tauD=tauD1+tauD2;
    num=K*KP*tauD*[1 1/tauD 1/(tauD*tauI)];
    den=[1 (p+K*KP*tauD1) (K*KP) (K*KP/tauI)];
    Hf=tf(num,den);
end