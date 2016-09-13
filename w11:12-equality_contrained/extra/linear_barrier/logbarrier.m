% logbarrier method as bescided on p569 [Convex Optimization, Stephan Boyed]
function [x, history] = logbarrier(x, A, b, f, grad, hessian, phi, d_phi, d2_phi)
    
    %% hyper-parameters
    eps = 10^-3; % tolerance 
    t = 1;
    mu = 20;
    
    [m, n] = size(A);
    history =[];
    while (n/t > eps)
        % redefine given functions
        new_f = @(x) t*f(x) + phi(x); 
        new_hessian = @(x) t*hessian(x) + d2_phi(x);
        new_grad = @(x) t* grad(x) + d_phi(x);
        %% centering step (using Newton's optimization)
        [x, nu, lambdas] = newton_KKT_and_BE(x, A, b, new_f, new_grad, new_hessian);
        t = t*mu;
        % storing history
        history = [history; length(lambdas) n/t]; 
    end
    history = history';
end