% reuses a previously computed hessian matrix, computes a new hessian every
% N iterations
% mode = 1: hessian reuse, 2: diagonal hessian
function [x, f_vals,i] = mod_newton(x, A, iter,alpha,beta,f,grad,hessian, mode, N)
    if nargin <=9 && mode == 2
        N= 1;
    else
        N = N-1; % because we start from 0 and not 1
    end
    
    eta = 0.0001;
    f_vals = [f(x)];
    for i=0:iter
        t = 1;
        gr = grad(x);
        
        % re-evaluate hessian every N iterations
        if (mod(i,N)==0)
            H = hessian(x);
        end
        if(mode == 2)
            H = diag(diag(H));
        end

        delta_x = - H\gr;

        % termination condition 
        if(norm(gr'*delta_x)<= 2*eta) % norm is not affected by the sign
            break;
        end
        
        % making sure that we start in the domain of the function
        while t > 0 && (any(A*(x + t*delta_x)>1) || any(abs(x + t*delta_x)>1))
            t = beta*t;
        end

        % backtracking linesearch
        while t > 0 && (f(x + t*delta_x) > f(x) + alpha*t*gr'*delta_x)
            t = beta*t;
        end
        % the actual optimization
        x = x + t * delta_x;

        % saving f values
        f_vals = [f_vals; f(x)];
end