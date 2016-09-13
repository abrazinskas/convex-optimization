function [x_star, nu_star, lambda_hist] = lp_acent(A,b,c, x_0)
% solves problem
% minimize c?*x - sum(log(x))
% subject to A*x = b
% using Newton?s method, given strictly feasible starting p
% input (A, b, c, x_0)
% returns primal and dual optimal points
% lambda_hist is a vector showing lambda^2/2 for each newton
step
% returns [], [] if MAXITERS reached, or x_0 not feasible
% algorithm parameters
ALPHA = 0.01;
BETA = 0.5;
EPSILON = 1e-6;
MAXITERS = 100;
if (min(x_0) <= 0) || (norm(A*x_0 - b) > 1e-3) % x0 not feasible
fprintf('FAILED');
nu_star = []; x_star = []; lambda_hist=[];
return;
end
m = length(b);
n = length(x_0);
x = x_0; lambda_hist = [];
for iter = 1:MAXITERS
H = diag(x.^(-2));
g = c - x.^(-1);
% lines below compute newton step via whole KKT system
% M = [ H A?; A zeros(m,m)];
% d = M\[-g; zeros(m,1)];
% dx = d(1:n);
% w = d(n+1:end);
% newton step by elimination method
w = (A*diag(x.^2)*A')\(-A*diag(x.^2)*g);
dx = -diag(x.^2)*(A'*w + g);
lambdasqr = -g'*dx; % dx?*H*dx;
lambda_hist = [lambda_hist lambdasqr/2];
if lambdasqr/2 <= EPSILON break; end
% backtracking line search
% first bring the point inside the domain
t = 1; while min(x+t*dx) <= 0 t = BETA*t; end
% now do backtracking line search

while c'*(t*dx)-sum(log(x+t*dx))+sum(log(x))-ALPHA*t*g'*dx> 0
t = BETA*t;
end
x = x + t*dx;
end
if iter == MAXITERS % MAXITERS reached
fprintf('ERROR: MAXITERS reached.\n');
x_star = []; nu_star = [];
else
x_star = x;
nu_star = w;
end