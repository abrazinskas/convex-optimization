% question 2
% cvx_begin
%     variable x1;
%     variable x2;
%     minimize (x1^2+9*x2^2);
%     subject to
%         2*x1 + x2 >= 1;
%         x1 + 3*x2 >= 1;
%         x1 >= 0; 
%         x2 >= 0;
% cvx_end

% question 3
rng(0,'v5uniform');
n=100;
m=300;
A=rand(m,n);
b=A*ones(n,1)/2;
c=-rand(n,1);


cvx_begin
    variable x(n)
    minimize (c'*x)
    subject to 
        A*x <= b
        x>=0
        x<=1
cvx_end
lower_bound = cvx_optval


t_vec = linspace(0,1,n);
obj = zeros(n,1);
max_viol = zeros(n,1);
for i = 1:n
    t = t_vec(i);
    x_prime = (x >= t);
    f_val = c'*x_prime;
    max_viol(i) = max(A*x_prime - b);
    obj(i) = f_val;
    end
figure
subplot(2,1,1);
plot(t_vec,obj);
title('objective values');
xlabel('t');
ylabel('objective');

subplot(2,1,2);
plot(t_vec,max_viol);
title('maximum violation');
xlabel('t')
ylabel('maximum violation')


upper_bound = min(obj(find(max_viol<=0)));

upper_bound - lower_bound 



