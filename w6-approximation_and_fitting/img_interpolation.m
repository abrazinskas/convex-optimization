clear all;
run tv_img_interp.m

% preparing mask matrices
U_ver = ones(m,n);
U_ver(1,:) = zeros(n,1);
U_hor = ones(m,n);
U_hor(:,1) = zeros(1,m);


% producing reconstructed images using l2 and total variance methods
cvx_begin
 variable Ul2(m,n)
 Ul2(Known) == Uorig(Known); % Fix known pixel values.
 U_hor_der = Ul2 - circshift(Ul2,[0,1]) .* U_hor; % horizontal derivative 
 U_ver_der = Ul2 - circshift(Ul2,[1,0]) .* U_ver; % vertical derivative 
 minimize (norm([U_hor_der(:);(U_ver_der(:))],2)); % l2 measure
cvx_end

cvx_begin
 variable Utv(m,n)
 Utv(Known) == Uorig(Known); % Fix known pixel values.
 U_hor_der = Utv - circshift(Utv,[0,1]) .* U_hor; % horizontal derivative 
 U_ver_der = Utv - circshift(Utv,[1,0]) .* U_ver; % vertical derivative 
 minimize (norm([U_hor_der(:);(U_ver_der(:))],1)); % total variance measure
cvx_end
 
% Graph everything.
 figure(1); cla;
 colormap gray;
 
 subplot(221);
 imagesc(Uorig)
 title('Original image');
 axis image;
 
 subplot(222);
 imagesc(Known.*Uorig + 256-150*Known);
 title('Obscured image');
 axis image;
 
 subplot(223);
 imagesc(Ul2);
 title('l_2 reconstructed image');
 axis image;
 
 subplot(224);
 imagesc(Utv);
 title('Total variation reconstructed image');
 axis image;
