% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [3] Ex. 3

clear;
close all;
clc;

num_of_samples = 1000;
sample_size = [5, 100];
mu = 15; 

confidence_interval = 0.95;

for i=1:2
    sum = 0;
    r = exprnd(mu, num_of_samples, sample_size(i));

    [h,p,ci,stats] = ttest(r, mu, 'Alpha', 1-confidence_interval);
    
    for j=1:sample_size(i)
       sum = sum + h(j);
    end
    
    propability = sum / sample_size(i);
    
    fprintf("Propability = %.3f\n", propability)   
end







