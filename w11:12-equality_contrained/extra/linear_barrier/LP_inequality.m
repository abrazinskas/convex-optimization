% We solve a simple LP problem using logbarrier method
% the problem is : min c'x
%                  s.t. Ax ==b 
%                       x >=0
clear all;
%% General parameters

n = 500;
m = 100;

%% Generating data %%
randn('seed', 0);
A = [randn(m-1,n);ones(1,n)];
x = rand(n,1) + 0.1;
b = A*x;
c = randn(n,1);

%% Gradients and functions
run gradient_functions.m;

% run logbarrier method
[x_sol, history] = logbarrier(x, A, b, f, grad, hessian, phi, d_phi, d2_phi);
[xx, yy] = stairs(cumsum(history(1,:)),history(2,:));
semilogy(xx,yy);
 

% for comparison use cvx
% solve LP using cvx for comparison
cvx_begin quiet
    variable x(n)
    minimize(c'*x)
    subject to
        A*x == b
        x >= 0
cvx_end

fprintf('\n\nOptimal value found by barrier method: %d \n', c'*x_sol);
fprintf('Optimal value found by CVX: %d \n', cvx_optval);

