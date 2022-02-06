% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [4] Ex. 1

clear;
close all;
clc;


h1 = 100;
h2 = [60 54 58 60 56];

e0 = 0.76;

%% Question (a)
e = sqrt(h2/h1);

mean_e = mean(e);
se = std(e);

se_mean = se / sqrt(length(h2));

fprintf("Uncertainty for each throw = %.4f\n", se);
fprintf("Uncertainty for the mean of throws = %.4f\n", se_mean);

alpha = 0.05;

t_value = tinv(1-alpha/2, length(h2)-1);

throw_uncertainty_limit = t_value*se;
mean_uncertainty_limit = t_value*se_mean;
    
fprintf("Uncertainty limit for each throw (alpha = %.2f) = %.4f +- %.4f\n", ...
                     alpha, se_mean, throw_uncertainty_limit)
fprintf("Uncertainty limit for the mean of throws (alpha = %.2f) = %.4f +- %.4f\n", ...
                     alpha, se_mean, mean_uncertainty_limit)

%% Question (b)

M = 1000;
n = 5;

mu = 58;
sigma = 2;

samples = zeros(M, n);

samples = normrnd(mu, sigma, [M n]);

mean_h2 = mean(samples, 2);
std_h2 = std(samples, 0, 2);
e2 = sqrt(mean_h2/h1);

nbins = 15;

figure();
nbins = 15;
histogram(mean_h2, nbins);
xline(mu, 'r', 'LineWidth', 10);
xlabel("Mean")
title("Histogram of mean values");
grid on;

figure();
nbins = 15;
histogram(std_h2, nbins);
xline(sigma, 'r', 'LineWidth', 10);
xlabel("Standard Deviation")
title("Histogram of std values");
grid on;

figure();
histogram(e2, nbins);
xline(e0, 'r', 'LineWidth', 10);
xlabel("Coefficient of recovery")
title("Histogram of e values");
grid on;

%% Question (c)

h1C = [80 100 90 120 95];
h2C = [48 60 50 75 56];

eC = sqrt(h2./h1);

uncertainty_h1C = std(h1C) / sqrt(length(h1C));
uncertainty_h2C = std(h2C) / sqrt(length(h2C));

uncertainty_eC = std(eC) / sqrt(length(eC));

fprintf("Uncertainty for height h1 = %.4f\n", uncertainty_h1C);
fprintf("Uncertainty for height h2 = %.4f\n", uncertainty_h2C);
fprintf("Uncertainty for COR e = %.4f\n", uncertainty_eC);

alpha = 0.05;

mean_eC = mean(eC, 2);
t_value = tinv(1-alpha/2, length(eC)-1);

throw_uncertainty_limit_C = t_value*eC;
mean_uncertainty_limit_C = t_value*mean_eC;
    
fprintf("Uncertainty limit for each throw (alpha = %.2f) = %.4f +- %.4f\n", ...
                     alpha, mean_eC, throw_uncertainty_limit_C)
fprintf("Uncertainty limit for the mean of throws (alpha = %.2f) = %.4f +- %.4f\n", ...
                     alpha, mean_eC, mean_uncertainty_limit_C)