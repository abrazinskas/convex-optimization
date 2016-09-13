
function grad_and_newton
% set(gca, 'YTickLabel', num2str(get(gca, 'YTick'), '%.7f'))

n = 100;
m = 200;
randn('state',1);
A = randn(m,n);
ITER = 7;



x = zeros(n,1); % initial x
ALPHA = 0.01;
BETA = 0.5;
TOLERANCE = 10^-6;

gradient_optimization(x);
%newton_optimization(x);



% optimizing the function

   % x : initial point   
   function x = gradient_optimization(x)
       f_val = [];
       iter_nr = [];
       step_len = [];
       
       for i = 1:ITER
        % compute the step direction
        delta_x = - f_der(x);
        
        if(norm(-delta_x,2)<TOLERANCE)
            break;
        end

        t = 1;   
        % enforced condition that x must be in the domain
        while (any(A*(x+t*delta_x)>1) | any(abs(x)>1) & t > 0)
            t = BETA*t;
        end

        % compute t value (step-size)
        while (f(x + t*delta_x) > f(x) - ALPHA*t*delta_x'*delta_x & t > 0 )
            t = BETA*t;
        end

        % the actual parameters adjustment
        x = x + t * delta_x;

        if (mod(i,1)==0)
            step_len = [step_len t];
            f_val = [f_val f(x)];
            iter_nr = [iter_nr i];
        end
       end
    'best result is:'
    f(x)
    ' in # steps:'
    i
    % plot the result
    my_plot(iter_nr,f_val,step_len,x) 
   end



    function x = newton_optimization(x)
       f_val = [];
       iter_nr = [];
       step_len = [];
       
       for i = 1:ITER
           
        % compute the step direction
        f_d = f_der(x);
        f_2_d = f_sec_der(x);
        delta_x = - inv(f_2_d)*f_d;
        lambda = -1*f_d'*delta_x/2;
        
        if(lambda<=TOLERANCE)
            break;
        end
        
        t = 1;  
        % enforced condition that x must be in the domain
        while (any(A*(x+t*delta_x)>1) | any(abs(x)>1) & t > 0)
            t = BETA*t;
        end

        % compute t value (step-size)
        while (f(x + t*delta_x) > f(x) - ALPHA*t*delta_x'*delta_x & t > 0 )
            t = BETA*t;
        end

        % the actual parameters adjustment
        x = x + t * delta_x;
        
        if (mod(i,1)==0)
            step_len = [step_len t];
            f_val = [f_val f(x)];
            iter_nr = [iter_nr i];
        end
       end
       my_plot(iter_nr,f_val,step_len,x);
       'best result is:'
       f(x)
       ' in # steps:'
       i
       x;
    end


    function [] = my_plot (iter_nr,f_val,step_len,x)
        figure(1)
        subplot(211);
        plot(iter_nr,real(f_val) - f(x));
        ylabel('f(x^k) - p*');
        xlabel('iter');
        subplot(212);
        plot(iter_nr,step_len,'o');
        ylabel('t');
        xlabel('iter');
        title('gradient descent'); 
    end



    function res = f (x)
        res = - sum(log(1 - A*x)) - sum(log(1 - x)) - sum(log(1 + x));
    end


    function der = f_der (x)
        der = A'* (1./(1-A*x)) + 1./(1-x) - 1./(1+x);
    end

    function der = f_sec_der(x)
        d = 1./(1-A*x);
        der = A'*diag(d.^2)*A + diag(1./(1-x).^2) + diag(1./(1+x).^2);
    end



end
