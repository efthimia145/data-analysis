% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [3] Ex. 5

clear;
close all;
clc;

%% Init values

eruption_data = importdata('eruption.dat');

confidence = 0.95;

h = zeros(1,3);
p = zeros(1,3);
ci = zeros(3,2);

%% ==== Question (a) ==== 

sigma_test = [10 1 10];
variance = var(eruption_data, 1);

for i=1:3
    [h(i),p(i),ci(i,:)] = vartest(eruption_data(:,i), sigma_test(i)^2, 'Alpha', 1-confidence);
end

ci = sqrt(ci);

fprintf("STANDARD DEVIATION ANALYSIS\n")
fprintf("\n[Old Faithful Eruption Waiting Time]\n")
fprintf("\n1989: Sigma CI = [%.2f, %.2f]\n", ci(1,1), ci(1,2))
fprintf("\t  p-value = %.3f [Test Sigma = %d]\n", p(1), sigma_test(1))

fprintf("\n2006: Sigma CI = [%.2f, %.2f]\n", ci(3,1),  ci(3,2))
fprintf("\t  p-value = %.3f [Test Sigma = %d]\n", p(3), sigma_test(3))

fprintf("\n__________________________________\n")
fprintf("\n[Old Faithful Eruption Duration]\n")
fprintf("\n1989: Sigma CI = [%.2f, %.2f]\n",  ci(2,1),  ci(2,2))
fprintf("\t  p-value = %.3f [Test Sigma = %d]\n", p(2), sigma_test(2))

%% ==== Question (b) ==== 

mean_test = [75 2.5 75];
mu = mean(eruption_data);

for i=1:3
    [h(i),p(i),ci(i,:)] = ttest(eruption_data(:,i), mu(i), 'Alpha', 1-confidence);
end

fprintf("\n=========================================\n")
fprintf("\nMEAN ANALYSIS\n")
fprintf("\n[Old Faithful Eruption Waiting Time]\n")
fprintf("\n1989: Mean CI = [%.2f, %.2f]\n", ci(1,1), ci(1,2))
fprintf("\t  p-value = %.3f [Mean = %d]\n", p(1), mean_test(1))

fprintf("\n2006: Mean CI = [%.2f, %.2f]\n", ci(3,1),  ci(3,2))
fprintf("\t  p-value = %.3f [Mean = %d]\n", p(3), mean_test(3))

fprintf("\n__________________________________\n")
fprintf("\n[Old Faithful Eruption Duration]\n")
fprintf("\n1989: Mean CI = [%.2f, %.2f]\n",  ci(2,1),  ci(2,2))
fprintf("\t  p-value = %.3f [Mean = %d]\n", p(2), mean_test(2))

%% ==== Question (c) ==== 

for i=1:3
    [h(i),p(i)] = chi2gof(eruption_data(:,i), 'Alpha', 1-confidence);;
end

fprintf("\n=========================================\n")
fprintf("\nNORMAL FIT ANALYSIS\n")
fprintf("\n[Old Faithful Eruption Waiting Time]\n")
fprintf("\n1989: p-value = %.3f [Normal Fit]\n", p(1))
fprintf("2006: p-value = %.3f [Normal Fit]\n", p(3))

fprintf("\n__________________________________\n")
fprintf("\n[Old Faithful Eruption Duration]\n")
fprintf("\n2006: p-value = %.3f [Normal Fit]\n", p(2))

%% ==== Claim Proof ==== 

duration_threshold = 2.1;
mu = [65 91];
sigma = 10;

data1 = eruption_data(eruption_data(:,2) < duration_threshold, 1);
data2 = eruption_data(eruption_data(:,2) > duration_threshold, 1);


[h,p,ci] = vartest(data1, sigma^2, 'Alpha', 1-confidence);
ci = sqrt(ci);

fprintf("\n=========================================\n")
fprintf("\n[Old Faithful Eruption Waiting Time]\n")
fprintf("\n[--------Duration < 2.1min--------]\np-value = %.3f\nCI = [%.3f, %.3f]\n", p, ci(1), ci(2))

[h,p,ci] = vartest(data2, sigma^2, 'Alpha', 1-confidence);
ci = sqrt(ci);

fprintf("\n__________________________________\n")
fprintf("\n[--------Duration > 2.1min--------]\np-value = %.3f\nCI = [%.3f, %.3f]\n", p, ci(1), ci(2))

[h,p,ci] = ttest(data1, mu(1), 'Alpha', 1-confidence);

fprintf("\n=========================================\n")
fprintf("\n[Old Faithful Eruption Waiting Time]\n")
fprintf("\n[--------Duration < 2.1min--------]\np-value = %.3f\nCI = [%.3f, %.3f]\n", p, ci(1), ci(2))

[h,p,ci] = ttest(data2, mu(2), 'Alpha', 1-confidence);

fprintf("\n__________________________________\n")
fprintf("\n[--------Duration > 2.1min--------]\np-value = %.3f\nCI = [%.3f, %.3f]\n", p, ci(1), ci(2))