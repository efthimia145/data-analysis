% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [3] Ex. 11
clear;
close all;
clc;

%% Init variables & Create samples

M = 100; % Num of Samples
n = 10;  % Sample size of X 
m = 12;  % Sample size of Y 

X = randn(M, n);
Y = randn(M, m);

mu0 = 0;
rejections = zeros(1, 3);

%% ==== Parametric Method ==== 

alpha = 0.05;

mean_X = mean(X, 2);
mean_Y = mean(Y, 2);
std_X = std(X, 0, 2);
std_Y = std(Y, 0, 2);

var_pooled = zeros(M, 1);
ci_pooled = zeros(M, 2);
t_value = tinv(1-(alpha/2), n+m-2);


for i=1:M
    var_pooled(i) = ((n-1)*(std_X(i)^2) + (m-1)*(std_Y(i)^2))/(n+m-2);
    ci_pooled(i, 1) = ((mean_X(i)- mean_Y(i)) - t_value*sqrt(var_pooled(i)*sqrt((1/n)+(1/m))));
    ci_pooled(i, 2) = ((mean_X(i)- mean_Y(i)) + t_value*sqrt(var_pooled(i)*sqrt((1/n)+(1/m))));

    if mu0 < ci_pooled(i, 1) || mu0 > ci_pooled(i, 2)
        rejections(1) = rejections(1) + 1;
    end
end

rejections(1) = rejections(1) / M;
%% ==== Bootstrap Method ==== 

B = 1000;
common_sample = [X Y];
mean_difference = zeros(M, B+1);

lower_limit = floor((B+1)*alpha/2);
upper_limit = ceil((B+1)*(1-(alpha/2)));

for i=1:M
    samples = zeros(B, length(common_sample));

    for sample=1:B
        randomized_samples = common_sample(unidrnd(n+m,n+m,1));
        updatedX = randomized_samples(1:n);
        updatedY = randomized_samples(n+1:length(randomized_samples));
        mean_difference(i,sample) = mean(updatedX) - mean(updatedY);
    end
    
    mean_value = mean(X(i,:)) - mean(Y(i,:));
    mean_difference(i,B+1) = mean_value;
    
    sorted_diff = sort(mean_difference(i,:));
    
    mean_rank = find(sorted_diff == mean_value);

    if mean_rank < lower_limit || mean_rank > upper_limit
        rejections(2) = rejections(2) + 1;
    end
end

rejections(2) = rejections(2) / M;


%% ==== Rendom Permutation Method ==== 
mean_difference = zeros(M, B+1);

for i=1:M
    for sample=1:B
        randomized_samples = common_sample(randperm(length(common_sample(1,:))));
        updatedX = randomized_samples(1:n);
        updatedY = randomized_samples(n+1:length(randomized_samples));
        mean_difference(i,sample) = mean(updatedX) - mean(updatedY);
    end
    
    mean_value = mean(X(i,:)) - mean(Y(i,:));
    mean_difference(i,B+1) = mean_value;
    
    sorted_diff = sort(mean_difference(i,:));
    
    mean_rank = find(sorted_diff == mean_value);

    if mean_rank < lower_limit || mean_rank > upper_limit
        rejections(3) = rejections(3) + 1;
    end
end

rejections(3) = rejections(3) / M;

%% Print results
fprintf("Rejection percentage using parametric method = %.2f\n", rejections(1));
fprintf("Rejection percentage using bootstrap method = %.2f\n", rejections(2));
fprintf("Rejection percentage using permutation method = %.2f\n", rejections(3));
