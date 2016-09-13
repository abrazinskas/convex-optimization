function [lambda, x] =  dual_solver(A,P,q,b)
    cvx_begin quiet
        variable x(2);
        dual variable lambda;
        minimize( x'*P*x + q'*x)
        subject to
        lambda : A*x <= b;
    cvx_end
end