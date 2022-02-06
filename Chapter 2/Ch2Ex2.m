% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [2] Ex. 2

clear;
close all;
clc;

num_of_iterations = 1000;

lambda = 1;
bins = 60;

X = rand(num_of_iterations, 1);
Y = -(1/lambda)*log(1-X);

H = histogram(Y, bins);

exponential = lambda * exp(-lambda * H.BinEdges);
exponential = exponential/sum(exponential);

figure();
hold on
plot(H.BinEdges(1:length(H.BinEdges)-1), H.Values/num_of_iterations, '-c*', 'LineWidth',2);
plot(H.BinEdges, exponential, 'b');
xlabel("x");
ylabel("F(x)");
title(['Simulation of the exponential distribution']);
legend('Simulated','Analytical')
grid on
hold off