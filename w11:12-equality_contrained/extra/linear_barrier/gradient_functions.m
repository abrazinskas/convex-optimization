%% Gradients and functions
grad = @(x) c;
hessian = @(x) zeros(n, n);
f = @(x) c'*x;


%% Barrier function \phi that approximates the contraint x>=0
phi = @(x) -sum(log(x));
d_phi = @(x) -1./x;
d2_phi = @(x) diag(1./ (x.^2));