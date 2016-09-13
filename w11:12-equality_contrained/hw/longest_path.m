c = [ 10; 30; 2; 5;6];
A = [ -1 -1 0 0 0; 1 0 -1 0 0; 0 1 1 -1 -1; 0 0 0 1 1];

n = 4;
m = 5;
p = zeros(n,1); % placeholder for maximums

% searching the maximumum path
for i=2:n
    for j=1:(i-1)
            p(i)= max([p(i);-(A(j,:).*A(i,:))'.*(c + p(j))]);
    end
end

disp(['result is: ', int2str(p(n)) ]);
