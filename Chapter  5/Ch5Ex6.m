% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [5] Ex. 6


clear;
close all;
clc;

X = [2 3 8 16 32 48 64 80];
Y = [98.2 91.7 81.3 64.0 36.4 32.6 17.1 11.3];

n = length(X);


%% Question (a)

figure();
hold on;
scatter(X, Y);
xlabel("Air Density (kg/m^{3})");
ylabel( "Light Speed");
title("Correlation Scatter Plot");
grid on;


%% Function

% Power
power = @(b,x)( b(1)*x.^(b(2)) );

% Logarithmic
logarithmic = @(b,x)( b(1)+b(2)*log(x));

% Inverse
inverse = @(b,x)( b(1) + b(2)./x);

% Exponential
exponential = @(b,x)( b(1)*exp(b(2)*x) );

functions = {power ; logarithmic; inverse; exponential};
functionNames = ["Power" ; "Logarithmic"; "Inverse"; "exponential"];
mse = zeros(length(functions),1);

%% Question (a) & (b)

for i = 1:length(functions)

    % Calculate non linear regression model
    beta0 = [10 ; -0.1];
    model = fitnlm(X,Y,functions{i},beta0);
    mse(i) = model.MSE;
    
    beta = table2array(model.Coefficients);
    beta = beta(:,1);
    pred = functions{i}(beta,X);
    
    % Plot data and regression
    figure(i)
    scatter(X,Y)
    hold on;
    grid on;
    plot(X,pred)
    title(strcat(functionNames(i)," regression"));
    
    % Question (b)
    x0 = 25;
    prediction = functions{i}(beta,x0);
    hold on;
    plot(x0,prediction,'x','MarkerEdgeColor','k','MarkerSize',5);

    
    % Diagnostic plot of standardised error
    ei_standard = (Y - pred)/sqrt(mse(i));
    figure(i*10)
    scatter(Y,ei_standard);
    hold on;
    grid on;
    plot(Y,repmat(2,1,length(Y)));
    hold on;
    plot(Y,repmat(0,1,length(Y)));
    hold on;
    plot(Y,repmat(-2,1,length(Y)));
    title(strcat(functionNames(i)," regression standardised error"));
end
