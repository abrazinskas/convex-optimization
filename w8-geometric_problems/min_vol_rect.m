clear all;
run max_vol_box_norng.m;


cvx_begin quiet
    variables l(n) u(n)
    % the length of rectange sides
    maximize (geo_mean(u - l))
    subject to 
        l <= u;
        max(A,0)*u - max(-A,0)*l <= b;
cvx_end


% A = [0 1; 0 -1;1 0; -1 0;-1 1];
% m = 5;
% n = 2;
% b = [1 1 1 1 0]';
% 
% cvx_begin
%     variables l(n) u(n) x(n)
%     % the length of rectange sides
%     maximize (geo_mean(u - l))
%     subject to 
%         A*x <= b;
%         x >= l;
%         x <= u;
%         l <= u;
%         A*u <= b;
%         A*l <= b;
% cvx_end
% 
% plot(A(:,1),A(:,2),'o');
% hold on;
% rectangle('Position',[l' (u-l)']);

 