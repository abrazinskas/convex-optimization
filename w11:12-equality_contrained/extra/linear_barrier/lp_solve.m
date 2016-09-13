function [x, history] = lp_solve(A, b, c)
    [m,n] = size(A);
    x0 = A\b;
    t0 = 2 -min(x0);
    z0 = x0 + t0*ones(n,1) - ones(n,1);
    b1 = b - A*ones(n,1);
    A1 = [A,-A*ones(n,1)];
    c1 = [zeros(n,1);1];
    run gradient_functions.m; 
    %% Gradients and functions (here we modify our functions a bit)
    f = @(x) c1'*x;
    grad = @(x) c1;
    hessian = @(x) zeros(n+1, n+1);  
    
    % phase I 
    [z_star, history] = logbarrier([z0;t0], A1, b1, f, grad, hessian, phi, d_phi, d2_phi);
    x_feas = z_star(1:n) + (1 - z_star(n+1));
    t = z_star(n+1);
    
    if (t >=1)
        fprintf('the problem is infeasible, value of t is: %d \n', t-1);
        x = [];
        history = [];
    else
        % phase II
         run gradient_functions.m;  % redifine functions
         [x, history] = logbarrier(x_feas, A, b, f, grad, hessian, phi, d_phi, d2_phi);
    end
end

