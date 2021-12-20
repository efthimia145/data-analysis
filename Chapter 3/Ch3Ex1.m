% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [3] Ex. 1

clear;
close all;
clc;

num_of_samples = [1e3; 2*1e3; 1.5*1e4];
sample_size = [1e3; 2*1e2; 3*1e3];

lambda = [5; 10; 20];

for i=1:3
    r = poissrnd(lambda(i), num_of_samples(i), sample_size(i));

    sampling_mean_variables = mean(r,2);

    figure('Name', 'Sampling Mean histogram', 'NumberTitle', 'off')
    histogram(sampling_mean_variables)
    
    grid on
    
    fprintf("\nLambda = %d\n", lambda(i))
    fprintf("Samples = %d\n", num_of_samples(i))
    fprintf("Sample Size = %d\n", sample_size(i))
    fprintf("Mean = %f\n", mean(sampling_mean_variables))
end