
m = 30;
n = 100;

A = randn(m,n) + i*randn(m,n);
b = randn(m,1) + i*randn(m,1);

% a)
cvx_begin 
    variable x_1(n) complex
    minimize (norm(x_1,2))
    subject to
        A*x_1 == b
cvx_end

% b)
cvx_begin
    variable x_2(n) complex
    minimize (norm(x_2,inf))
    subject to 
        A*x_2 == b
cvx_end

figure
scatter(real(x_1),imag(x_1),'blue');
hold on 
scatter(real(x_2),imag(x_2),'filled');
title('norms')


