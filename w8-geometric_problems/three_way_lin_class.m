clear all;
run sep3way_data.m;

cvx_begin
variables a1(2) a2(2) a3(2) b1 b2 b3
% maximize (sum(X*a1 + Y*a2 + Z*a3 ) - M*b1 - N*b2 - P*b3)

subject to
% 1.
X'*a1 - b1 > max(X'*a2 - b2, X'*a3 - b3)
% 2. 
Y'*a2 - b2 > max(Y'*a3 - b3, Y'*a1 - b1)
% 3.
Z'*a3 - b3 > max(Z'*a1 - b1, Z'*a2 - b2)

% 4.
% to avoid undounded optimizations
norm(a1,2) <= 1
norm(a2,2) <= 1
norm(a3,2) <= 1

cvx_end


% now let's plot the three-way separation induced by
% a1,a2,a3,b1,b2,b3
% find maximally confusing point
% a1=[1;1];a2=[1;-5];a3=[-1;-1];b1=0;b2=0;b3=0;
p = [(a1-a2)';(a1-a3)']\[(b1-b2);(b1-b3)];
% 
% % plot 
 t = [-7:0.01:7];
 u1 = a1-a2; u2 = a2-a3; u3 = a3-a1;
 v1 = b1-b2; v2 = b2-b3; v3 = b3-b1;
 line1 = (-t*u1(1)+v1)/u1(2); idx1 = find(u2'*[t;line1]-v2>0);
 line2 = (-t*u2(1)+v2)/u2(2); idx2 = find(u3'*[t;line2]-v3>0);
 line3 = (-t*u3(1)+v3)/u3(2); idx3 = find(u1'*[t;line3]-v1>0);
% 
 plot(X(1,:),X(2,:),'*',Y(1,:),Y(2,:),'ro',Z(1,:),Z(2,:),'g+',...
      t(idx1),line1(idx1),'k',t(idx2),line2(idx2),'k',t(idx3),line3(idx3),'k');
 axis([-7 7 -7 7]);
