% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [5] Ex. 5

clear;
close all;
clc;

lightair_data = importdata('lightair.dat');
lightair_data = sortrows(lightair_data);

x = lightair_data(:,1);
y = lightair_data(:,2);

M = 1000;
n = 100;

b1 = zeros(1, M);
b0 = zeros(1, M);

for i = 1:M
   randomIndex = unidrnd(100, 100, 1);
   lightair_randomed = lightair_data(randomIndex, :);

   x = lightair_randomed(:, 1);
   y = lightair_randomed(:, 2);

   b1(i) = (sum((x - mean(x)).*(y - mean(y))))/(sum((x - mean(x)).^2));
   b0(i) = (sum(y) - b1(i)*sum(x))/n;
end

alpha = 0.05;

b1 = sort(b1);
b0 = sort(b0);

cib0 = [b0(25) b0(95)];
cib1 = [b1(25) b1(95)];

fprintf("[b0] CI = [%.4f, %.    4f]\n", cib0(1), cib0(2));
fprintf("[b1] CI = [%.4f, %.4f]", cib1(1), cib1(2));