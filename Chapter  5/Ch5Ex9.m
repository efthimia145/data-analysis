% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [5] Ex. 9


clear;
close all;
clc;

%% Import data 
hospital_txt = importdata('hospital.txt');
hospital_data = hospital_txt.data;

parameters = 4;
H = hospital_data(:, 1);

threshold = 0.9;

for i = 2:parameters
    
    for j = 2:parameters
        
        if i ~= j
            mdl = fitlm(hospital_data(:, i), hospital_data(:, j));
            
            if mdl.Rsquared.Ordinary > threshold || mdl.Rsquared.Adjusted > threshold
                fprintf("Multicollinearity between %d and %d parameters\n", i, j);
            end
            
        end
        
    end
    
end

%% Fit Linear Model

RSquareOrd = zeros(parameters - 1, 2);
RSquareAdj = zeros(parameters - 1, 2);

for i = 2:parameters
    
    mdl = fitlm(hospital_data(:, i), H);
    
    RSquareOrd(i-1, 1) = mdl.Rsquared.Ordinary;
    RSquareAdj(i-1, 1) = mdl.Rsquared.Adjusted;
    RSquareOrd(i-1, 2) = i;
    RSquareAdj(i-1, 2) = i;
    
end

[~,idx] = sort(RSquareOrd(:,1)); 
ROrdSorted = RSquareOrd(idx,:);  

[~,idx] = sort(RSquareAdj(:,1)); 
RAdjSorted = RSquareAdj(idx,:);  

fprintf("\nBest fit for param No. %d\n", ROrdSorted(parameters - 1, 2));
