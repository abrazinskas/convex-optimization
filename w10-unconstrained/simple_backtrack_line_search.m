
function simple_backtrack_line_search
clear all;
range_x = [-10:10];

ALPHA = 0.05;
BETA = 0.7;

x = 2; % starting point
iter = 10;


figure(1)
plot(range_x, f(range_x));
hold on;
% plot(x,f(x),'o');
t=1; 
% x_delta = -der_f(x);
% plot(x + t*x_delta ,f(x) + t*der_f(x)*x_delta,'o');
% plot(range_x,line(x,t,der_f(x)));

 for i = 1:iter
     x_delta = - der_f(x);
     t = 1;
     while ( f(x+ t*x_delta) > f(x) - ALPHA * t * x_delta^2)
         plot(x,f(x),'o')
         plot(x + t*x_delta ,f(x) + t*der_f(x)*x_delta,'o');
         plot(range_x,line(x,t,-x_delta));
         t = BETA * t;
         plot(x + t*x_delta ,f(x) + t*der_f(x)*x_delta,'o');
         
     end
     x = x + t*x_delta;
 end

'optimal solution is: '
x

    function y = f(x)
        y = x.^2;
    end

    function der = der_f(x)
        der = 2*x;
    end

    function l = line(cur_x,t,slope)
        l = f(cur_x) + t*slope * (range_x-cur_x); 
    end

end