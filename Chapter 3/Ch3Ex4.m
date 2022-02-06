% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [3] Ex. 4

clear;
close all;
clc;

obs_values = [41 46 47 47 48 50 50 50 50 50 50 50 ...
            48 50 50 50 50 50 50 50 52 52 53 55 ...
            50 50 50 50 52 52 53 53 53 53 53 57 ...
            52 52 53 53 53 53 53 53 54 54 55 68];
        
sampling_mean = mean(obs_values);

sampling_variance = std(obs_values)^2;

confidence = 0.95;

%% ==== Question (a) & (b) ==== 
s0 = 5;
[h,p,ci,stats] = vartest(obs_values, s0, 'Alpha', 1-confidence);

fprintf("The variance's confidence interval for confidence %.2f is [%.2f, %.2f]\n", confidence, ci(1), ci(2))
fprintf("[Ho: sigma = %d] p-value = %.3f\n", s0, p);
%% ==== Question (c) & (d) ==== 

mu0 = 52;
[h,p,ci,stats] = ttest(obs_values, mu0, 'Alpha', 1-confidence);

fprintf("\nThe mean's confidence interval for confidence %.2f is [%.2f, %.2f]\n", confidence, ci(1), ci(2))
fprintf("[Ho: mu = %d] p-value = %.3f\n", mu0, p);
%% ==== Question (e) ==== 

[h,p] = chi2gof(obs_values, 'Alpha', 1-confidence);
fprintf("\np-value = %f\n", p)