% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [3] Ex. 6

clear;
close all;
clc;

%% ==== Question (a) ==== 

n = 10; % Sample size
nboot = 1000;

X = randn(n,1);

bootstat = bootstrp(nboot,@mean, X);

figure('Name', 'Bootstrap Histogram', 'NumberTitle', 'off');
histogram(bootstat);
xline(mean(X),'--r','Average');

legend('X ~ N (0,1)', 'Average Value')
title('Bootstrap Histogram [n = 10, bootn = 1000]');
hold on
grid on

%% ==== Question (b) ==== 

boot_error_est = std(bootstat);
standard_error_est = std(X)/sqrt(n);

fprintf("Bootstrap standard error estimation = %.4f\n", boot_error_est)
fprintf("Parametric standard error estimation = %.4f\n", standard_error_est)

%% ==== Question (c) ==== 

Y = exp(X);

bootstat = bootstrp(nboot,@mean, Y);

figure('Name', 'Bootstrap Histogram', 'NumberTitle', 'off');
histogram(bootstat);
xline(mean(Y),'--r','Average');

legend('Y = exp(X), X ~ N (0,1)', 'Average Value')
title('Bootstrap Histogram [n = 10, bootn = 1000]');
hold on
grid on

% Standard error estimation

boot_error_est = std(bootstat);
standard_error_est = std(Y)/sqrt(n);

fprintf("Bootstrap standard error estimation = %.4f\n", boot_error_est)
fprintf("Parametric standard error estimation = %.4f\n", standard_error_est)