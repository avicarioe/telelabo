function Mp = getMp (Hf)
    [y,t]=step(Hf);
    Mp = max(y)-1;
end