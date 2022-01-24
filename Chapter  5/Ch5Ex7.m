% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [5] Ex. 7


clear;
close all;
clc;

thermostat_data = importdata('thermostat.dat');

KtoC = 273.15;

R = thermostat_data(:, 1);
T = thermostat_data(:, 2) + KtoC;

X = log(R);
Y = 1 ./ T;

X = sort(X);
Y = sort(Y);

%% Question (a)

testNumber = 4;

pFit = zeros(testNumber, testNumber+1);
pVal = zeros(testNumber, length(X));
YDiff = zeros(testNumber, length(Y));

for i = 1:testNumber
    
    pFit(i, 1:(i+1)) = polyfit(X, Y, i);
    pVal(i, :) = polyval(pFit(i, 1:(i+1)), X);
    YDiff(i, :) = pVal(i, :)' - Y;
    
end

%% Question (b)
syms b0 b1 b3
eqns = [b0*length(X) + b1*sum(X) + b3*sum(X.^3) == sum(Y), ...
        b0*sum(X) + b1*sum(X.^2) + b3*sum(X.^4) == sum(X.*Y), ...
        b0*sum(X.^2) + b1*sum(X.^3) + b3*sum(X.^5) == sum((X.^2).*Y)];

so = solve(eqns, [b0, b1, b3]);

Y_SH = double(so.b0) + double(so.b1) * X + double(so.b3) * (X.^3);



% Plot polynomial
f1 = figure(1);

plot(X, Y, 'ok')
hold on
for i = 1:testNumber
    
    plot(X, pVal(i, :));
    
end

plot(X, Y_SH, 'g+');
legend('Data', 'n = 1', 'n = 2', 'n = 3', 'n = 4', 'S.H.')
hold off
grid on
title('Different Polynomial Fits for data')
xlabel('1/T');
ylabel('Y == Polynomial');

% Plot polynomial difference
f2 = figure(2);
hold on
plot(X, Y - Y, 'ok')

for i = 1:testNumber
    
    plot(X, YDiff(i, :))
    
end

Y_SH_diff = Y_SH - Y;
plot(X, Y_SH_diff, 'g+');
hold off
grid on
title('Difference');
xlabel('1/T');
ylabel("Y' - Y");
legend('Data', 'n = 1', 'n = 2', 'n = 3', 'n = 4')