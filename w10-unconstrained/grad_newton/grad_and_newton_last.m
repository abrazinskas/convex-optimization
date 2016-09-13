n = 100;
m = 200;
randn('state',1);
A=randn(m,n);
iter = 1000;
alpha = 0.01;
beta = 0.5;

grad = @(x) A'*(1./(1-A*x)) + 1./(1-x) - 1./(1+x);
hessian = @(x) A'*diag(1./(A*x-1).^2)*A  + diag(1./(1-x).^2 + 1./(1+x).^2);
f = @(x) - sum(log(1 - A*x)) - sum(log(1-x)) - sum(log(1+x));

x = zeros(n,1);
% gradient method
[x, f_vals,grad_it] = grad_descent(x, A, iter, alpha,beta,f,grad);

figure
% some final checks
disp 'Final checks:'; 
all(A*x<=1)
any(abs(x)<=1)
p_star = f(x); % assuming that the last solution is the most optimal
subplot(211);
plot(f_vals - p_star);
title('Gradient descent');
xlabel('iter');
ylabel('f - p^{*}');


x = zeros(n,1);
% newton's method
[x, f_vals, newtons_it] = newton(x, A, iter, alpha, beta, f, grad, hessian);

% some final checks
disp 'Final checks:'; 
all(A*x<=1)
any(abs(x)<=1)
p_star = f(x); % assuming that the last solution is the most optimal
subplot(212);
plot(f_vals - p_star);
title('Newtons method');
xlabel('iter');
ylabel('f(x) - p^{*}');
