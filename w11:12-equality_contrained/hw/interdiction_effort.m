clear all;
run interdict_alloc_data.m;

cvx_begin
    variables x(m) z(n)
    minimize(z(n))
    z(1) == 0
    A'*z >= -diag(a)*x;
    x >= 0
    x <= x_max
    sum(x) <= B
cvx_end

disp(['P_max is: ', num2str(exp(z(n)))])