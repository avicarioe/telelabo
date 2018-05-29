function Hf = hf_from_pid (KP, tauI, tauD, K, p)
    num=K*KP*tauD*[1 1/tauD 1/(tauD*tauI)];
    den=[1 (p+K*KP*tauD) (K*KP) (K*KP/tauI)];
    Hf=tf(num,den);
end