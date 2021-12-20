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

%% ==== Question (a) ==== 
[h,p,ci,stats] = vartest(obs_values, sampling_variance, 'Alpha', 1-confidence);

fprintf("The variance's confidence interval for confidence %.2f is [%.2f, %.2f]\n", confidence, ci(1), ci(2))

%% ==== Question (b) ==== 

standard_deviation = sqrt(sampling_variance);

fprintf("The standard deviation is: %f\n", standard_deviation)

%% ==== Question (c) ==== 

[h,p,ci,stats] = ttest(obs_values, sampling_mean, 'Alpha', 1-confidence);

fprintf("The mean's confidence interval for confidence %.2f is [%.2f, %.2f]\n", confidence, ci(1), ci(2))

%% ==== Question (e) ==== 

[h,p] = chi2gof(obs_values, 'Alpha', 1-confidence);
fprintf("p-value = %f\n", p)