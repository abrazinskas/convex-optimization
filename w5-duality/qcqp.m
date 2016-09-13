P= [1 0; 0 1];
q_1 = [-2;-2];
q_2 = [-2;2];

cvx_begin
variable x(2)
minimize (x'*P*x)
subject to
    x'*P*x + x'*q_1 + 1 <= 0
    x'*P*x + x'*q_2 + 1 <= 0
cvx_end