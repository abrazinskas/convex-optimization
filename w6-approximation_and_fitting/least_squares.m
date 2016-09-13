n = 2;
m = 7;
A = [1 2; 1 3; 1 3; 1 4; 1 4; 1 1; 1 8];
b = [2;2;3;3;4;60;8]; % with outliers
%b = [2;2;3;3;4;1;8]; % without outliers

% least squares solution
cvx_begin
    variable x_1(n);
    minimize( norm(A*x_1-b));
cvx_end

% huber least squares
cvx_begin 
    variable x_2(n);
    minimize (sum(huber(A*x_2-b)));
cvx_end


% plots
rng default;  % For reproducibility
figure;

scatter(A(:,2),b,'mo');
hold on 

% plotting least squares
plot(A(:,2),A*x_1);

% plotting huber least squares
plot(A(:,2),A*x_2);
legend('data points','LS fit','Huber LS fit');
hold off