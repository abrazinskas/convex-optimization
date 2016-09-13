% Newton optimization method based on block elimination or KKT matrix depending on the last passed parameter%
% parameters: 
%  x : starting feasible vector
%  A : matrix involved in Ax = b constraint
%  b : 
%  grad : gradient of the objective function
%  H : hessian of the objective
%  KKT : boolean flag 
function [x, nu, lambdas] = newton(x, A, b, f, grad, hessian, KKT)
    %% hyper-parameters for backtrack line search%%
    alpha = 0.01;
    beta = 0.5;
    iter = 2000;
    eta = 10^-6;
        
    lambdas = [];
    [m,n] = size(A);
    for i=0:iter
        t = 1;
        gr = grad(x);
        H = hessian(x);
        H_inv = inv(H);
        
        if nargin() == 6
            % Block elimination
            % Compute delta_x and lambda via KKT block elimination
            % 1-2. compute Schur's complement and b_hat
             S = - A*H_inv*A';
             b_hat = A*H_inv*gr;
             % 3. solve for nu (dual variable)
             nu = linsolve(S,b_hat);
             % 4. solve for delta_x (Newton step)
             delta_x = linsolve(H, -(gr + A'*nu));
        elseif nargin() == 7 && KKT
             % KKT matrix solution
             KKT = [H A'; A zeros(m,m)];
             b_tilda = [-gr; zeros(m,1)];
             X = linsolve(KKT,b_tilda);
             delta_x = X(1:n);
             nu = X((n+1):n+m);
        end

        lambda_sq_norm = -gr'*delta_x;
        lambdas = [lambdas; lambda_sq_norm/2];
        
        % termination condition 
        if(lambda_sq_norm<= 2*eta) % norm is not affected by the sign
            break;
        end

        % making sure that we start in the domain of the function
        while t > eta && (any((x + t*delta_x)< 0)|| norm(A*delta_x)>eta)
            t = beta*t;
        end

        % backtracking linesearch
        while t > 0 && (f(x + t*delta_x) > f(x) + alpha*t*gr'*delta_x)
            t = beta*t;
        end
        
        % the actual optimization
        x = x + t * delta_x;
    end
    if i == iter
        fprintf ('could not find a solution in %d iterations \n' ,iter)
        x = [];
        nu = [];
        lambdas =[];
    end
end