randn('state',0);
n = 4000;  t = (0:n-1)';
exact = 0.5*sin((2*pi/n)*t).*sin(0.01*t);
corrupt = exact + 0.05*randn(size(exact));

x = t*1e9;
figure(1)
subplot(311)
plot(t,exact,'-');
axis([0 n -0.6 0.6])
title('original signal');
ylabel('ya');

subplot(312)
plot(t,corrupt,'-');
axis([0 n -0.6 0.6])
title('corrupted signal');
ylabel('ya');


% reconstruction
lambda = 50; % the coefficient of smoothness
  cvx_begin quiet
    variable x(n)
    minimize(norm(x-corrupt,2)+lambda*norm(x(2:n)-x(1:n-1),2))
  cvx_end
  
  
subplot(313)
plot(t,x,'-');
axis([0 n -0.6 0.6])
title('reconstructed signal');
ylabel('ya');
