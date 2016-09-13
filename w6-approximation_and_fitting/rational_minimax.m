% QUASICONVEX examples

k = 201;
t = linspace(-3,3,k)';
T = [t t t];
y = exp(t);
pow = 0:2; 
for i =1:k
    T(i,:) = T(i,:).^pow;
end

% upper and lower bounds
u = exp(3);
l = 0;
th = 0.0001;

while (u-l) > th
     gamma = (l+u)/2;
     cvx_begin quiet
     variables a(3) b(2)
     subject to 
        T*a - y.*(T*[1;b]) <= gamma*(T*[1;b])
        T*a - y.*(T*[1;b])>= - gamma*(T*[1;b])
%         T*[1;b] > 0
     cvx_end
     if strcmp(cvx_status,'Solved') 
         u = gamma;
     else
         l = gamma;
     end
end
 
obj = norm((T*a)./(T*[1;b])-y,inf)
y_fit = (T*a)./(T*[1;b]);

 
%  cvx_begin
%  variables a(3) b(2) t
%      minimize t
%  subject to 
%      T*a - y.*(T*[1;b]) <= t.* (T*[1;b])
%      T*[1;b] > 0

%  cvx_end

figure(1);
plot(t,y,'b', t,y_fit,'r+');
xlabel('t');
ylabel('y');





