n = 100;
m = 10;

%% Generating data %%
randn('seed',0);
A=randn(m-1,n);
A = [A;ones(1,n)];

while rank(A)~=m
   A=randn(m-1,n); 
   A = [A;ones(1,n)];
end

x = randn(n,1);
x = sign(x) .* x;
b = A*x;
c = randn(n,1);
%% Gradients and functions
% run gradient_functions.m 
% need to derivative 

% newton's method
[x_opt, nu, lambdas] = newton_KKT_and_BE(x, A, b, f, grad, hessian);
%[x_opt, nu, lambdas] = lp_acent(A, b, c, x);
% some final checks


disp 'Final checks: '; 

norm(A*x_opt-b)
all(x>=0)
iters = 1:length(lambdas);
% subplot(212);
ax = gca;
plot(iters, lambdas);
title('Newtons method');
xlabel('iter');
ylabel('$\frac{\lambda^2}{2} $','Interpreter','latex');
set(gca,'yscale','log');