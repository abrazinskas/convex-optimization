% in this problem we have a dataset of teams that compate against each
% other. The task is to find a vector of their abilities (a).
clear all;
run team_data.m;
A = sparse(1:m,train(:,1),train(:,3),m,n) + ...
       sparse(1:m,train(:,2),-train(:,3),m,n);
C = sum(train(:,3)==1);

% training
cvx_begin quiet
variable a(n)
% maximize (sum(sigma*log_normcdf(a(train(:,2)) - a(train(:,1)))));
maximize (sum(log_normcdf(A*a/sigma)))
subject to
    a >= 0;
    a <= 1;
cvx_end

% testing
y = sign(a(test(:,1)) - a(test(:,2)));
correct = sum( y == test(:,3))
accuracy = correct / m


