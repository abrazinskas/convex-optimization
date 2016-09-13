function [x, f_vals,i] = grad_descent(x, A, iter,alpha,beta,f,grad)
    eta = 0.0001;
    f_vals = [];
    for i=0:iter
        t = 1;
        gr = grad(x);
        
        % termination condition 
        if(norm(gr)<=eta)
            break;
        end

        delta_x = - gr;
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

end