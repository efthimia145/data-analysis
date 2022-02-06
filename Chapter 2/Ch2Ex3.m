% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [2] Ex. 3

clear;
close all;
clc;

num_of_iterations = 10000;

% The mean matrix
mu = [0 0];

% The values of the major semidiameter
sigma_major = [1 1];

% Correlation must be greater than 0 in order to get correlated values.
correlation_r = 0.5;

% The value of the minor semidiameter indexes
sigma_minor = correlation_r * sqrt(sigma_major(1)*sigma_major(2));

% Covariances matrix
Sigma = [sigma_major(1) sigma_minor; sigma_minor sigma_major(2)];

X = mvnrnd(mu, Sigma, num_of_iterations);

var_X = var(X(:,1));
var_Y = var(X(:,2));

cov_X_Y = correlation_r*sqrt(var_X*var_Y);
var_X_Y = var(X(:,1)+X(:,2)) + 2*cov_X_Y;


fprintf("Var[X] = %f\t", var_X);
fprintf("Var[Y] = %f\n", var_Y);
fprintf("Var[X + Y] = Var[X] + Var[Y] + 2*Cov(X+Y) = %f\n", var_X_Y);
fprintf("Var[X] + Var[Y] = %f\n", var_X + var_Y);
fprintf("It is proven that Var[X + Y] != Var[X] + Var[Y]");




