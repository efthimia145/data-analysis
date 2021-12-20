% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [2] Ex. 5

clear;
close all;
clc;

mu = 4; 
variance = 0.01;
sigma = sqrt(variance);
x = 3.9;

propability = normcdf(x,mu,sigma);
fprintf('The propability of a girder to be shorter than %0.1f is %f.', x, propability)

desired_propability = 0.01;

variable_value = norminv(desired_propability, mu, sigma);

fprintf('\nIn order for the propability of destruction to be less than %0.3f the destruction limit must be: %f', desired_propability,variable_value)