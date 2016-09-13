function [x, f_vals,i] = newton(x, A, iter,alpha,beta,f,grad,hessian)
    eta = 0.0001;
    f_vals = [f(x)];
    for i=0:iter
        t = 1;
        gr = grad(x);
        H = hessian(x);
        
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