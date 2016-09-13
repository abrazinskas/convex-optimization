clear all;
run ad_disp_data.m
o = ones(n,1);
cvx_begin quiet
    variable N(n,T)
    s = max(0,q - diag( Acontr'*N*Tcontr));
    rev = trace(R*N');
    maximize(rev - s'*p) 
    subject to
        N >= 0;
        N'*o - I == 0; % just like Ax - b == 0        
cvx_end

disp(['net profit: ', num2str(cvx_optval)]);
disp(['total revenue: ',num2str(rev)]) 
disp(['total penalty payment: ',num2str(s'*p)]);


% creating the maximum revenue impression matrix
N_max_rev = zeros(n,T);
for t = 1:T
    [val idx] = max(R(:,t));
    N_max_rev(idx,t) = I(t);
end

% check constraints
assert( all(N_max_rev(:) >= 0))
assert(all(N_max_rev'*o - I == 0)) 
s = max(0,q - diag( Acontr'*N_max_rev*Tcontr));
rev = trace(R*N_max_rev');
disp(['largest revenue net profit: ', num2str(rev - s'*p)]);
disp(['total revenue: ',num2str(rev)]) 
disp(['total penalty payment: ',num2str(s'*p)]);