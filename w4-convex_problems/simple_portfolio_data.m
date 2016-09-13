%% simple_portfolio_data
n=20;
rng(5,'v5uniform');
pbar = ones(n,1)*.03+[rand(n-1,1); 0]*.12;
rng(5,'v5normal');
S = randn(n,n);
S = S'*S;
S = S/max(abs(diag(S)))*.2;
S(:,n) = zeros(n,1);
S(n,:) = zeros(n,1)';
x_unif = ones(n,1)/n;


% a scalar version  

% cvx_begin
% variable x(n)
% minimize (x'*S*x)
% subject to
%     pbar'*x == pbar'*x_unif; % same expected return as in the case of uniform portfolio
%     sum(x) == 1
%     %x>=0
%     sum(max(-x,zeros(n,1))) <= 0.5 % limit on total short position
% cvx_end
% 
% % risk (standard devitation)
% risk_unif = sqrt(x_unif'*S*x_unif);
% risk = sqrt(x'*S*x);

% a vectorized version

m = 10;
mus = linspace(0,1,m);
risk = zeros(m,1);
for i = 1:m
    mu = mus(i);
    cvx_begin quiet
        variable x(n)
        minimize (-pbar'*x +  mu* x'*S*x )
        subject to
            pbar'*x == pbar'*x_unif; % same expected return as in the case of uniform portfolio
            sum(x) == 1
            %x>=0
            sum(max(-x,zeros(n,1))) <= 0.5 % limit on total short position
    cvx_end
    risk(i)= x'*S*x;
end

figure
plot(mus,risk);
title('mu vs risk');
ylabel('risk');
xlabel('mu');