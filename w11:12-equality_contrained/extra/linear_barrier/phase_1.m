% We solve a simple LP problem using logbarrier method + phase I 
% the problem is : min c'x
%                  s.t. Ax ==b 
%                       x >=0
clear all;

%% General parameters
n = 500;
m = 100;

%% Hyperparameters
t = 1;
mu = 10;

%% Generating data %%
randn('seed', 0);
A = [randn(m-1,n);ones(1,n)];
x = rand(n,1) + 0.1;
c = randn(n,1);
b = A*x;

[x_star, history] = lp_solve(A, b, c);
% compare to cvx
cvx_begin quiet
    variables x(n)
    minimize (c'*x)
    subject to
        A*x == b
        x >= 0
cvx_end


fprintf('\n\n Optimal value found by barrier method: %d \n', c'*x_star);
fprintf('Optimal value found by CVX: %d \n', cvx_optval);


% try to solve infeasible problem
b = randn(m,1);
c = randn(n,1);
[x_star, history] = lp_solve(A, b, c);