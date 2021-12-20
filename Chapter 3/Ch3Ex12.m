% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [3] Ex. 12
clear;
close all;
clc;

%% Init variables & Create samples

M = 100; % Num of Samples
n = 10;  % Sample size of X 
m = 12;  % Sample size of Y 

mu = 0;
sigmaX = 1;
sigmaY = 1.5;

X = normrnd(mu,sigmaX, [M, n]);
Y = normrnd(mu,sigmaY, [M, m]);

mu0 = 0;

rejections = zeros(1, 2);
%% Parametric Method

for i=1:M
    
    [h,~] = ttest2(X(i,:),Y(i,:),'Vartype','unequal');
    
    rejections(1) = rejections(1) + h;    
end

rejections(1) = rejections(1) / M;

%% Bootstrap Method

% Sample transformation
sampleXY = [X Y];

meanX = mean(X, 2);
meanY = mean(Y, 2);
Z = mean(sampleXY, 2);

Xbar = zeros(M, n);
Ybar = zeros(M, m);

for i=1:M
    Xbar(i,:) = X(i, :) - meanX(i) + Z(i);
    Ybar(i,:) = Y(i, :) - meanY(i) + Z(i);
end

B = 1000;
alpha = 0.05;
common_sample = [Xbar Ybar];
mean_difference = zeros(M, B+1);

lower_limit = floor((B+1)*alpha/2);
upper_limit = ceil((B+1)*(1-(alpha/2)));

for i=1:M
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

%% Print the results 

fprintf("Rejection percentage using parametric method = %.2f\n", rejections(1));
fprintf("Rejection percentage using bootstrap method = %.2f\n", rejections(2));

    