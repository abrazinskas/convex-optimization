cvx_begin
    variables x,y
    minimize (exp(-x))
    subject to
        (x^2)/4 <= 0
        y>0
cvx_end