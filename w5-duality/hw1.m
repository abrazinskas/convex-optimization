% objective 
P = [1 -1/2; -1/2 2];
q = [-1;0]; 

% constraints 
u1 = -2;
u2 = -3;
a1 = [1;2];
a2 = [1;-4];
a3 = [-1;-1];
A = [a1';a2';a3']; % constraints matrix
b = [ u1; u2; 5];

[lambda,x] = dual_solver(A,P,q,b);

%% checking KKT conditions
% constraints 
lagr_grad = @(x,lambda) 2*P*x + q + A'*lambda;
disp(all(A*x <= b ));
disp(all(lambda >=0));
disp(lambda'*(A*x-b)<=eps); % can be a veryyyy small number, so can't say == 0
disp(all(lagr_grad(x,lambda)<=10^-6));
delta = [-0.1,0,0.1];
for i = 1:3
    for j = 1:3
        d1 = delta(i);
        d2 = delta(j);
        u = [d1;d2;0];
        pred = x'*P*x + q'*x -  lambda'*u;
        [lambda_per,x_per] = dual_solver(A,P,q,b+u);
        actual = x_per'*P*x_per + q'*x_per;
        disp(['for d1 ',num2str(d1),' d2 ',num2str(d2), ' pred: ', num2str(pred),' actual: ', num2str(actual), ' diff: ', num2str(actual-pred)]);
    end
end

