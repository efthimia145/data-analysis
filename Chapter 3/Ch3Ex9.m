% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [3] Ex. 9
clear;
close all;
clc;

%% Init variables & Create samples

M = 100; % Num of Samples
n = 10;  % Sample size of X 
m = 12;  % Sample size of Y 
squared = 0; % Set to 1 for Question (b)
typical = 1; % Set to O for Question (c) 

X = randn(M, n);
Y = randn(M, m);

if squared
    X = X.^2;
    Y = Y.^2;
end

if ~typical
    mu = 0.2;
    sigma = 1;
    Y = normrnd(mu,sigma, [M, m]);
end

%% ==== Question (a.i) ==== 

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
end

%% ==== Question (a.ii) ==== 

B = 1000; % Num of Bootstrap Samples
bootstrap_ci = zeros(M, 2);

bootstat_X = bootstrp(B,@mean, X');
bootstat_Y = bootstrp(B,@mean, Y');

lower_limit = floor((B+1)*alpha/2);
upper_limit = ceil((1-alpha/2)*(B+1));

bootstat_difference = sort(bootstat_X - bootstat_Y);

for i=1:M
    bootstrap_ci(i, 1) = bootstat_difference(lower_limit, i);
    bootstrap_ci(i, 2) = bootstat_difference(upper_limit, i);    
end