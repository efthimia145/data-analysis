% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [4] Ex. 3

clear;
close all;
clc;

mean_V = 77.78;
std_V = 0.71;

mean_I = 1.21;
std_I = 0.071;

mean_f = 0.283;
std_f = 0.017;

%% Question (a)

std_P = sqrt(((mean_I*cos(mean_f)*std_V)^2) + ((mean_V*cos(mean_f)*std_I)^2)+((mean_V*mean_I*(-sin(mean_f))*std_f)^2));

fprintf("The uncertainty of the power = %.3f\n", std_P);

%% Question (b)

M = 1000;

mu = [mean_V mean_I mean_f];
sigma = [std_V^2 0 0; 0 std_I^2 0; 0 0 std_f^2];
    
samples = mvnrnd(mu, sigma, M);

P = samples(:,1).*samples(:,2).*cos(samples(:,3));

sampling_std_P = std(P);

figure();
xline(std_P, 'r', "LineWidth", 5);
xline(sampling_std_P, 'b', "LineWidth", 5);
xlabel('Power');
title("Calculations of power deviation");
grid on;

%% Question (c)

rhof = 0.5;

std_P2 = sqrt(std_V^2*(mean_I*cos(mean_f))^2 + std_I^2*(mean_V*cos(mean_f))^2 ...
                + std_f^2*(mean_V*mean_I*(-sin(mean_f)))^2 + ...
                + 2*(mean_I*cos(mean_f))*(mean_V*mean_I*(-sin(mean_f)))...
                    *rhof*std_V*std_f);
                
mu = [mean_V, mean_I, mean_f];
corvf = rhof * std_V * std_f;
sigma = [std_V^2 0 corvf; 0 std_I^2 0; corvf 0 std_f^2];

samples2 = mvnrnd(mu, sigma, M);

P2 = samples2(:,1).*samples2(:,2).*cos(samples2(:,3));

sampling_std_P2 = std(P2);

figure();
xline(std_P, 'r', "LineWidth", 5);
xline(sampling_std_P2, 'b', "LineWidth", 5);
xlabel('Power');
title("Calculations of power deviation");
grid on;
