cvx_begin quiet
variable x(1)
dual variable lambda;
minimize (x^2 + 1)
    subject to
    lambda: (x-2)*(x-4) <=0
cvx_end
disp(['optimal value: ',num2str(x^2 + 1)]);

obj = @(x) x.^2 + 1;
opt = obj(x);
constr = @(x)(x_space-2).*(x_space-4);

x_space = linspace(-5,5,100);
x_feas = (constr(x)<=0);
x_feas = x_space(x_feas);
plot(x_space,obj(x_space),'blue');
hold on
plot(x_space, constr(x_space));
plot(x_feas, obj(x_feas),'red');
legend('f_o','f_1');
plot(x,opt,'o');

lagr = [2];
% colors = ['blue','pink','yellow']
L = @(x,l) (x.^2 + 1)+ l*(x-2).*(x-4);
x_opt = @(l) 3*l/(1+l);
for i=1:length(lagr)
    lag = lagr(i);
    plot(x_space,L(x_space,lag)); 
    L(x_opt(lag),lag)
end