% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [3] Ex. 8

clear;
close all;
clc;

%% Init values

M = 100; % Number of samples
n = 10;  % Sample size
nboot = 1000; % Number of Bootstrap samples

X = randn(M, n);

%% ==== Question (a) ==== 

variance = var(X,0,2);
confidence = 0.95;

h = zeros(M);
p = zeros(M);
ci = zeros(M, 2);
boot_ci = zeros(M, 2);

for i=1:M
    [h(i),p(i),ci(i,:)] = vartest(X(i,:), variance(i), 'Alpha', 1-confidence);
end

ci = sqrt(ci);

for i=1:M
    boot_ci(i,:) = bootci(nboot, @std, X(i,:));
end

%% Standard Deviation CI Lower Limit
nbins = 10;
figure('Name', 'Initial CI Histogram', 'NumberTitle', 'off');
hold on;
h1 = histogram(ci(:,1), nbins);
h2 = histogram(boot_ci(:,1), nbins);
legend('Standard Deviation X', 'Bootstrap Standard Deviation')
title('Standard Deviation CI Lower Limit Histogram');
grid on;
hold off;

figure('Name', 'CI Histogram', 'NumberTitle', 'off');
hold on;
plot(h1.BinEdges(1:length(h1.BinEdges)-1), h1.Values, '.-k');
plot(h2.BinEdges(1:length(h2.BinEdges)-1), h2.Values, '.-m');
legend('Standard Deviation X', 'Bootstrap Standard Deviation')
title('Standard Deviation CI Lower Limit Histogram');
grid on;

%% Standard Deviation CI Upper Limit

nbins = 10;
figure('Name', 'Initial CI Histogram', 'NumberTitle', 'off');
hold on;
h1 = histogram(ci(:,2), nbins);
h2 = histogram(boot_ci(:,2), nbins);
legend('Standard Deviation X', 'Bootstrap Standard Deviation')
title('Standard Deviation CI Upper Limit Histogram');
grid on;
hold off;

figure('Name', 'CI Histogram', 'NumberTitle', 'off');
hold on;
plot(h1.BinEdges(1:length(h1.BinEdges)-1), h1.Values, '.-k');
plot(h2.BinEdges(1:length(h2.BinEdges)-1), h2.Values, '.-m');
legend('Standard Deviation X', 'Bootstrap Standard Deviation')
title('Standard Deviation CI Upper Limit Histogram');
grid on;

%% ==== Question (b) ==== 

Y = X.^2;
variance = var(Y, 0, 2);

for i=1:M
    [h(i),p(i),ci(i,:)] = vartest(Y(i,:), variance(i), 'Alpha', 1-confidence);
    
end

ci = sqrt(ci);

for i=1:M
    boot_ci(i,:) = bootci(nboot, @std, Y(i,:));
end

%% Standard Deviation CI Lower Limit
nbins = 10;
figure('Name', 'Initial CI Histogram', 'NumberTitle', 'off');
hold on;
h1 = histogram(ci(:,1), nbins);
h2 = histogram(boot_ci(:,1), nbins);
legend('Standard Deviation Y', 'Bootstrap Standard Deviation')
title('Standard Deviation CI Lower Limit Histogram');
grid on;
hold off;

figure('Name', 'CI Histogram', 'NumberTitle', 'off');
hold on;
plot(h1.BinEdges(1:length(h1.BinEdges)-1), h1.Values, '.-k');
plot(h2.BinEdges(1:length(h2.BinEdges)-1), h2.Values, '.-m');
legend('Standard Deviation Y', 'Bootstrap Standard Deviation')
title('Standard Deviation CI Lower Limit Histogram');
grid on;

%% Standard Deviation CI Upper Limit

nbins = 10;
figure('Name', 'Initial CI Histogram', 'NumberTitle', 'off');
hold on;
h1 = histogram(ci(:,2), nbins);
h2 = histogram(boot_ci(:,2), nbins);
legend('Standard Deviation Y', 'Bootstrap Standard Deviation')
title('Standard Deviation CI Upper Limit Histogram');
grid on;
hold off;

figure('Name', 'CI Histogram', 'NumberTitle', 'off');
hold on;
plot(h1.BinEdges(1:length(h1.BinEdges)-1), h1.Values, '.-k');
plot(h2.BinEdges(1:length(h2.BinEdges)-1), h2.Values, '.-m');
legend('Standard Deviation Y', 'Bootstrap Standard Deviation')
title('Standard Deviation CI Upper Limit Histogram');
grid on;

