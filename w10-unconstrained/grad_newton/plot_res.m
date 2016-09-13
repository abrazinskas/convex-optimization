function [] = plot_res(f_vals,p_star, titl)
plot(f_vals - p_star);
title(titl);
xlabel('iter');
ylabel('f - p^{*}');