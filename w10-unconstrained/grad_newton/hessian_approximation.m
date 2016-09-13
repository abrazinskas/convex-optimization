n = 1000;
m = 1000;
randn('state',5);
A=randn(m,n);
iter = 1000;
alpha = 0.01;
beta = 0.5;

grad = @(x) A'*(1./(1-A*x)) + 1./(1-x) - 1./(1+x);
hessian = @(x) A'*diag(1./(A*x-1).^2)*A  + diag(1./(1-x).^2 + 1./(1+x).^2);
f = @(x) - sum(log(1 - A*x)) - sum(log(1-x)) - sum(log(1+x));



% newton's method
disp('running pure netwons method');
tic
x = zeros(n,1);
[x, f_vals, newtons_it] = newton(x, A, iter, alpha, beta, f, grad, hessian);
toc

figure
subplot(311)
p_star = f(x);% assuming that the last solution is the most optimal
plot_res(f_vals, p_star, 'pure newtons');


% reusing hessian newton's
disp('running reusing hessian matrix netwons method');
tic 
x = zeros(n,1);
[x, f_vals, newtons_it] = mod_newton(x, A, iter, alpha, beta, f, grad, hessian, 1, 4);
toc

subplot(312)
p_star = f(x);% assuming that the last solution is the most optimal
plot_res(f_vals, p_star, 'R newtons');

% reusing hessian newton's
disp('running diagonal hessian matrix netwons method');
tic 
x = zeros(n,1);
[x, f_vals, newtons_it] = mod_newton(x, A, iter, alpha, beta, f, grad, hessian, 2);
toc

subplot(313)
p_star = f(x);% assuming that the last solution is the most optimal
plot_res(f_vals, p_star, 'D newtons');
