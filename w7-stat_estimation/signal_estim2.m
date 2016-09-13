run ml_estim_incr_signal_data_norng.m;


% with monotonocity constraints and non-negativity
cvx_begin quiet
variable x(N) 
    yhat = conv(h,x);
    yhat = yhat(1:end-3);
    minimize (norm((y - yhat),2))
    subject to 
        x(1) >= 0;
        x(2:N) >= x(1:N-1);
cvx_end

figure
subplot(211);
plot(x,'r')
hold on
plot(xtrue,'b');
ylabel('xval');
legend('x','xtrue')
title('xml');
hold off;

% without monotonocity constraints and non-negativity
cvx_begin quiet
variable x(N) 
    yhat = conv(h,x);
    yhat = yhat(1:end-3);
    minimize (norm((y - yhat),2))
cvx_end

subplot(212);
plot(x,'r')
hold on
plot(xtrue,'b');
ylabel('xval');
legend('x','xtrue')
title('xml free');
hold off;