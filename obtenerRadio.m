function radio = obtenerRadio(x,d1,d2)
    fd1 = matlabFunction(d1); 
    fd2 = matlabFunction(d2);
    valorD1 = feval(fd1,x);
    valorD2 = feval(fd2,x);
    radioCurvatura = ((1 + (valorD1).^2).^(3/2))./ (valorD2);
    radio =  abs(radioCurvatura);
end