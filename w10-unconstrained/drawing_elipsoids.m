P1 = [2 0; 0 8];
P2 = [8 0; 0 2];



% P1
x2 = @(x1) sqrt(1/8 - (x1.^2)/4);
x1 = linspace(-sqrt(0.5),sqrt(0.5),1000);

figure

subplot(211)
plot([x1 x1], [-x2(x1) x2(x1)],'*');
xlabel('x');
ylabel('y');

