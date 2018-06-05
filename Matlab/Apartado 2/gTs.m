function ts = gTs (Hf, tol)
    [y,t]=step(Hf);
    dis = abs(y-1);
    pos = find(dis>tol);
    ts = t(pos(end));
end