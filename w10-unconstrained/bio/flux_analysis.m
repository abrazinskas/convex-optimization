clear all;
run fba_data.m;
eps = 0.1;



% loosen the boundaries of maximum dual variable
% in order to get the highest profit gain
% vmax(5)= vmax(5) + eps;

% if you want to find what rate the model is most sensitive to
% set them all to the same value
% vmax =10*ones(n,1);

% some experiments with perturbation
cvx_begin quiet
variable v(n) 
dual variable l;
maximize(v(n)); % the cell growth rate
subject to
    S*v == 0;
    v>=0;
    l: v<=vmax;
cvx_end

G_min = 0.2*cvx_optval;
% searching for essential genes
for i=1:n
   vknock = vmax;
   vknock(i) = 0; % knocking the gene
   cvx_begin quiet
       variable v(n)
       subject to
            S*v == 0;
            v >= 0;
            v(n) >= G_min;
            v <= vknock;
   cvx_end
   if (strcmp(cvx_status, 'Infeasible'))
       disp(['gene ', num2str(i), ' is essential']);   
   end
end


% searching for lethal genes

% cartesian product of all possibilities
% we know that 1 and 9 are essential genes
[X,Y] = meshgrid(2:8,2:8);
knocks = [X(:) Y(:)];

for i=1:length(knocks)
   k1 = knocks(i,1);
   k2 = knocks(i,2);
   vknock = vmax;
   % knocking the gene
   vknock(k1) = 0; 
   vknock(k2) = 0; 
   
   cvx_begin quiet
       variable v(n)
       subject to
            S*v == 0;
            v >= 0;
            v(n) >= G_min;
            v <= vknock;
   cvx_end
   if (strcmp(cvx_status, 'Infeasible'))
       disp(['genes ', num2str(k1),' and ', num2str(k2), ' are lethals']);   
   end
end

