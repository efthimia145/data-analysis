% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [3] Ex. 10

clear;
close all;
clc;

%% Init variables & Create samples

M = 100;
n = 10;
alpha = 0.05;
squared = 0; % Set to 1 for Question (b)

X = randn(M, n);
mu0 = [0 0.5];

if squared
    X = X.^2;
    mu0 = [1 2];
end

p_value = zeros(2, size(mu0, 2));

%% ==== Question (a.i) ==== 

counter_h = zeros(1, length(mu0));

for i=1:M
    [h1,~] = ttest(X(i,:), mu0(1), 'Alpha', alpha);
    [h2,~] = ttest(X(i,:), mu0(2), 'Alpha', alpha);
    
    counter_h(1) = counter_h(1) + h1;
    counter_h(2) = counter_h(2) + h2;
end

p_value(1, :) = counter_h / M;

%% ==== Question (a.ii) ==== 

%Rearrange the samples

muX = mean(X, 2);
Xbar = zeros(M, n);


for null_hypothesis=1:length(mu0)
    for sample=1:M
        Xbar(sample,:) = X(sample, :) - muX(sample) + mu0(null_hypothesis);
    end
    % Create Bootstrap samples from xbar

    B = 15000;

    bootstat_Xbar = bootstrp(B,@mean, Xbar');

    bootstat_Xbar = [bootstat_Xbar; muX'];

    bootstat_Xbar_sorted = sort(bootstat_Xbar);

    rnk = zeros(B+1, M);

    lower_limit = floor((B+1)*alpha/2);
    upper_limit = ceil((B+1)*(1-(alpha/2)));

    counter_h = 0;

    for i=1:M
        [~, rnk(:,i)] = ismember(bootstat_Xbar(:,i), bootstat_Xbar_sorted(:,i));

        if rnk(B+1, i) < lower_limit || rnk(B+1, i) > upper_limit
            counter_h = counter_h + 1;
        end
    end

    p_value(2, null_hypothesis) = counter_h / M;
end

%% Print the results 

for i=1:size(mu0, 2)
    fprintf("\n=== Null Hypothesis [Ho] =  %.2f === \n", mu0(i))
    fprintf("[Parametric] p_value = %.2f\n", p_value(1, i))
    fprintf("[Bootstrap] p_value = %.2f\n", p_value(2, i))
end


