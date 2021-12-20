% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [2] Ex. 5

clear;
close all;
clc;

n = 100;
N = 10000;

X = rand(n, N);

Y = median(X);

H = histogram(Y, 100);

histfit(Y, 100);

title('Proof of Central Limit Theorem');
grid on