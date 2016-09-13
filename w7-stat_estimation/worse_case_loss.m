clear all;

% initially known parameters 
mu1 = 8;
mu2 = 20;
sigma1 = 6;
sigma2 = 17.5;
ro = -0.25; 
rmin= -30;
rmax = 70;

% discretized number of values that random variables can take
n = 100; 
r = linspace(rmin,rmax,n)';

% define marginal probability functions
prob = @(mu,sigma,r) (exp(- (r - mu).^2 /(2*sigma^2))) / sum(exp(- (r - mu).^2 /(2*sigma^2)));

% marginals 
p1 = prob(mu1,sigma1,r);
p2 = prob(mu2,sigma2,r);

% form mask of region where R1 + R2 <= 0
r1p = r*ones(1,n); r2p = ones(n,1)*r';
loss_mask = (r1p + r2p <= 0)';

cvx_begin quiet
    variable P(n,n); 
    %p(R1 + R2 <=0 )%
%     maximize (sum(sum(P.*idx)));
maximize (sum(sum((P(loss_mask)))))
subject to 
    % check positivity of pdf
    P >= 0;
    % check marginals
    sum(P,2) == p1;
    sum(P',2) == p2;
    % check that it sums to one
    sum(sum(P)) == 1;
    (sum(sum(P.*(r*r'))) - mu1*mu2) == ro * sigma1*sigma2;  
cvx_end

% plotting 
P = full(P);
figure
subplot(211)
mesh(r1p,r2p,P');
xlabel('r1');
ylabel('r2');
zlabel('density');
title('mesh');

subplot(212)
contour(r1p,r2p,P');
title('contour');


