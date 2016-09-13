clear all;
run rank_aggr_data.m;

P = zeros(m,n);
% creating incident matrix
for k = 1:m
    ri = preferences(k,1);
    rj = preferences(k,2);
    P(k,ri)= -1;
    P(k,rj) = 1;
end


% plain penalty function 
cvx_begin quiet
    variable r_p(n)
    minimize (sum(max(P*r_p+1,0)));
cvx_end

% quadratic penalty function
cvx_begin quiet
    variable r_s(n)
    minimize (sum_square_pos(P*r_s+1));
cvx_end

% computing positive violations
v_p = max(P*r_p+1,0);
v_s = (max(P*r_s+1,0)).^2;

v_pos_p = sum(v_p>0.001);
v_pos_s = sum(v_s>0.001);
disp(['squared has ', num2str(v_pos_s - v_pos_p), ' more violations ']);

ss = max(abs([P*r_p+1;P*r_s+1]));
tt = -ceil(ss):0.05:ceil(ss);  % sets center for each bin

range_max=2.0;  rr=-range_max:1e-2:range_max;
figure(1), clf
subplot(211);
h_p = histogram(v_p,tt);
title('Plain penalty');
axis([-range_max range_max 0 40]);

subplot(212)
h_s = histogram(v_s,tt);
title('Quadratic penalty');
axis([-range_max range_max 0 40]);

