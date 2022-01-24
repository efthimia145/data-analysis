% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [5] Ex. 8


clear;
close all;
clc;

%% IImport data
physical_txt = importdata('physical.txt');
physical_data = physical_txt.data;

parameters = 11;
W = physical_data(:, 1);

figure()
hold on

for i = 2:parameters
    
    plot(W, physical_data(:, i), 'o')
    
end
hold off
grid on
title("Weight alongside all other params")
legend

RSquareOrd = zeros(parameters - 1, 2);
RSquareAdj = zeros(parameters - 1, 2);

for i = 2:parameters
    
    mdl = fitlm(physical_data(:, i), W);
    
    RSquareOrd(i-1, 1) = mdl.Rsquared.Ordinary;
    RSquareAdj(i-1, 1) = mdl.Rsquared.Adjusted;    
    RSquareOrd(i-1, 2) = i;
    RSquareAdj(i-1, 2) = i;
    
end

[~,idx] = sort(RSquareOrd(:,1)); 
ROrdSorted = RSquareOrd(idx,:);   

[~,idx] = sort(RSquareAdj(:,1));
RAdjSorted = RSquareAdj(idx,:);  

fprintf("Best fit for param No. %d\n", ROrdSorted(parameters - 1, 2));