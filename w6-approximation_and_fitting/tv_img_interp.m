% tv_img_interp.m
% Total variation image interpolation.
% EE364a
% Defines m, n, Uorig, Known.

% Load original image.
Uorig = double(imread('tv_img_interp.png'));

[m, n] = size(Uorig);

% Create 50% mask of known pixels.
rand('state', 1029);
Known = rand(m,n) > 0.5;

%%%%% Put your solution code here

% Calculate and define Ul2 and Utv.

% Placeholder:
% Ul2 = ones(m, n);
% Utv = ones(m, n);

%%%%%


