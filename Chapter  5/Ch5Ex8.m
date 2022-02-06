% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [5] Ex. 8


clear;
close all;
clc;

%% Import data
physical_txt = importdata('physical.txt');
physical_data = physical_txt.data;

parameters = width(physical_data);
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

%% Step wise regression

X = physical_data(:, 2:end);
Y = physical_data(:, 1);

[b,~,~,model,stats] = stepwisefit(X,Y);
b0 = stats.intercept;
b = [b0; b(model)];     

Ypred = [ones(length(X),1) X(:,model)]*b;
errors = Y - Ypred;
rmse = stats.rmse;

n = height(physical_data);
se = rmse/(n-2);

Rsq = @(ypred,y) 1-sum((ypred-y).^2)/sum((y-mean(y)).^2);
adjRsq = @(ypred,y,n,k) ( 1 - (n-1)/(n-1-k)*sum((ypred-y).^2)/sum((y-mean(y)).^2) );

ROrd = 1 - stats.SSresid/stats.SStotal;
RAdj = adjRsq(Ypred,Y,length(Y),length(b));