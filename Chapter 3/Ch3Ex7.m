% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [3] Ex. 7

clear;
close all;
clc;

%% Init values

M = 100; % Number of samples
n = 10;  % Sample size
nboot = 1000; % Number of Bootstrap samples

X = randn(M, n);

%% ==== Question (a) ==== 

mu = mean(X, 2);
confidence = 0.95;

h = zeros(M);
p = zeros(M);
ci = zeros(M, 2);
boot_ci = zeros(M, 2);

for i=1:M
    [h(i),p(i),ci(i,:)] = ttest(X(i,:), mu(i), 'Alpha', 1-confidence);
    
end

for i=1:M
    boot_ci(i,:) = bootci(nboot, @mean, X(i,:));
end

%% Mean CI Lower Limit
nbins = 10;
figure('Name', 'Initial CI Histogram', 'NumberTitle', 'off');
hold on;
h1 = histogram(ci(:,1), nbins);
h2 = histogram(boot_ci(:,1), nbins);
legend('Mean X', 'Bootstrap Mean')
title('Mean CI Lower Limit Histogram');
grid on;
hold off;

figure('Name', 'CI Histogram', 'NumberTitle', 'off');
hold on;
plot(h1.BinEdges(1:length(h1.BinEdges)-1), h1.Values, '.-k');
plot(h2.BinEdges(1:length(h2.BinEdges)-1), h2.Values, '.-m');
legend('Mean X', 'Bootstrap Mean')
title('Mean CI Lower Limit Histogram');
grid on;

%% Mean CI Upper Limit

nbins = 10;
figure('Name', 'Initial CI Histogram', 'NumberTitle', 'off');
hold on;
h1 = histogram(ci(:,2), nbins);
h2 = histogram(boot_ci(:,2), nbins);
legend('Mean X', 'Bootstrap Mean')
title('Mean CI Upper Limit Histogram');
grid on;
hold off;

figure('Name', 'CI Histogram', 'NumberTitle', 'off');
hold on;
plot(h1.BinEdges(1:length(h1.BinEdges)-1), h1.Values, '.-k');
plot(h2.BinEdges(1:length(h2.BinEdges)-1), h2.Values, '.-m');
legend('Mean X', 'Bootstrap Mean')
title('Mean CI Upper Limit Histogram');
grid on;

%% ==== Question (b) ==== 

Y = X.^2;
mu = mean(Y, 2);

for i=1:M
    [h(i),p(i),ci(i,:)] = ttest(Y(i,:), mu(i), 'Alpha', 1-confidence);
    
end

for i=1:M
    boot_ci(i,:) = bootci(nboot, @mean, Y(i,:));
end

%% Mean CI Lower Limit
nbins = 10;
figure('Name', 'Initial CI Histogram', 'NumberTitle', 'off');
hold on;
h1 = histogram(ci(:,1), nbins);
h2 = histogram(boot_ci(:,1), nbins);
legend('Mean Y', 'Bootstrap Mean')
title('Mean CI Lower Limit Histogram');
grid on;
hold off;

figure('Name', 'CI Histogram', 'NumberTitle', 'off');
hold on;
plot(h1.BinEdges(1:length(h1.BinEdges)-1), h1.Values, '.-k');
plot(h2.BinEdges(1:length(h2.BinEdges)-1), h2.Values, '.-m');
legend('Mean Y', 'Bootstrap Mean')
title('Mean CI Lower Limit Histogram');
grid on;

%% Mean CI Upper Limit

nbins = 10;
figure('Name', 'Initial CI Histogram', 'NumberTitle', 'off');
hold on;
h1 = histogram(ci(:,2), nbins);
h2 = histogram(boot_ci(:,2), nbins);
legend('Mean Y', 'Bootstrap Mean')
title('Mean CI Upper Limit Histogram');
grid on;
hold off;

figure('Name', 'CI Histogram', 'NumberTitle', 'off');
hold on;
plot(h1.BinEdges(1:length(h1.BinEdges)-1), h1.Values, '.-k');
plot(h2.BinEdges(1:length(h2.BinEdges)-1), h2.Values, '.-m');
legend('Mean Y', 'Bootstrap Mean')
title('Mean CI Upper Limit Histogram');
grid on;