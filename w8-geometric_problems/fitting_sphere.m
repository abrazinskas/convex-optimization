clear all;
run sphere_fit_data.m
U= U';

[n,m] = size(U);
 
% dummy vectors 
o1 = ones(1,2);
o2 = ones(size(U,1),1);
 
cvx_begin
     variables x(3);
     A = [ -2*U ones(n,1)]; 
     b = sum(U.^2,2);
     minimize (norm(A*x + b,2))
 cvx_end
 
 x_c = x(1:2);
 r = sqrt( (norm(x_c,2))^2 - x(3));

plot(U(:,1),U(:,2),'*');
hold on
circle2(x_c(1),x_c(2),r);