% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [2] Ex. 4

clear;
close all;
clc;

num_of_iterations = 1000;
J = ones(num_of_iterations, 1);

% Consider Y = 1/X
X = zeros(1, num_of_iterations);
Y = zeros(1, num_of_iterations);

mean_X = zeros(1, num_of_iterations);
mean_Y = zeros(1, num_of_iterations);

minimum_number = 1;
maximum_number = 2;

% minimum_number = -1;
% maximum_number = 1;

% minimum_number = 0;
% maximum_number = 1;


for i = 1:num_of_iterations
    J = ones(i, 1);
    
    X = (maximum_number - minimum_number)*rand(i, 1) + minimum_number;
    Y = J./X;
    
    mean_X(i) = ones/mean(X);
    mean_Y(i) = mean(Y);
end

x = 1:num_of_iterations;
plot(x,mean_X(x), 'g', x, mean_Y(x), 'b');
grid on
hold on
xlabel('Number of iterations');
ylabel('Mean');
title(['Check the condition E[1/X] = 1/E[X]']);

