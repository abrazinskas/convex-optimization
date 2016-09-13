clear all;
run quad_metric_data_norng.m;
X = X';
Y = Y';
d = d';

cvx_begin quiet
variable P(n,n) symmetric
d_hat = [];
for i = 1:N
    d_hat = [d_hat; ((X(i,:) - Y(i,:))*P*(X(i,:) - Y(i,:))')];
end
minimize ((1/N) * sum(d.^2 - 2*d .* d_hat.^(1/2)  + d_hat ));
subject to
    P == semidefinite(n)
    d_hat > 0;
cvx_end

plot(d,'*');
hold on;
plot(d_hat.^(1/2) ,'+');

% run on a test data
X_test = X_test';
Y_test = Y_test';
d_hat = [];
d_test = d_test';

for i = 1:N_test
     d_hat = [d_hat; (X_test(i,:) - Y_test(i,:))*P*(X_test(i,:) - Y_test(i,:))'];
end

RMSE = (1/N_test) * sum(d_test.^2 - 2*d_test .* d_hat.^(1/2)  + d_hat );