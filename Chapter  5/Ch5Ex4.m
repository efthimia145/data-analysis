% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [5] Ex. 4

clear;
close all;
clc;

n = 100; % Sample size

lightair_data = importdata('lightair.dat');
lightair_data = sortrows(lightair_data);

x = lightair_data(:,1);
y = lightair_data(:,2);

muX = mean(x);
muY = mean(y);

sumX = sum(x.^2);
sumY = sum(y.^2);

%% Question (a)
figure();
hold on;
scatter(x, y);
xlabel("Air Density (kg/m^{3})");
ylabel( "Light Speed");
title("Correlation Scatter Plot");
grid on;

commonSum = sum(x.*y);

r = (commonSum - n*muX*muY)/sqrt((sumX - n*(muX^2))*(sumY - n*(muY^2)));

dim = [.2 .01 .3 .3];
str = 'r = ' + string(r);
annotation('textbox',dim, 'String',str,'FitBoxToText','on');

%% Question (b)
Sxy = sum((x - muX).*(y - muY))/ (n-1);
sx = (sumX - n*muX^2)/(n-1);
sy = (sumY- n*muY^2)/(n-1);

b1 = Sxy/sx;

b0 = muY - b1*muX;

ybar = b0 + b1*x;

plot(x, ybar);
legend('Scatter Plot', 'Estimated linear model');

alpha = 0.05;

t = tinv(1-alpha/2, n-2);

se = sqrt((n-1)/(n-2) * sy - b1^2 * sx^2);
Sxx = sx * (n-1);

sb1 = se / sqrt(Sxx);
sb0 = se*sqrt((1/n)+((muX^2)/Sxx));

CIb1 = [b1-t*sb1 b1+t*sb1];
CIb0 = [b0-t*sb0 b0+t*sb0];

fprintf("The confidence interval for b1 = b1 +- %.3f = [%.3f, %.3f]\n", t*sb1, CIb1(1), CIb1(2));
fprintf("The confidence interval for b0 = b0 +- %.3f = [%.3f, %.3f]\n", t*sb0, CIb0(1), CIb0(1));

%% Question (c)

muYbar = mean(ybar);
sybar = se * sqrt(1/n) + (((x-muX).^2)/Sxx);

ciMuYLow = (b0 + b1*x) - t*se*sqrt((1/n) + ((x-muX).^2)/Sxx);
ciMuYUp = (b0 + b1*x) + t*se*sqrt((1/n) + ((x-muX).^2)/Sxx);

ciMuY = [ciMuYLow ciMuYUp];

plot(x, ciMuYLow);
plot(x, ciMuYUp);

ciYLow = (b0 + b1*x) - t*se*sqrt(1 + (1/n) + ((x-muX).^2)/Sxx);
ciYUp = (b0 + b1*x) + t*se*sqrt(1 + (1/n) + ((x-muX).^2)/Sxx);
ciY = [ciYLow ciYUp];

plot(x, ciYLow);
plot(x, ciYUp);
legend('Scatter Plot', 'Estimated linear model', 'Light Speed Mean CI Lower Limit', 'Light Speed Mean CI Upper Limit', ...
                                                                                  'Light Speed CI Lower Limit', 'Light Speed CI Upper Limit');

x1 = 1.29; % Air density value

sybar1 = se * sqrt((1/n) + ((x1-muX).^2)/Sxx);
ciMuY1 = [muYbar - t*sybar1 muYbar + t*sybar1];
ciY1 = [muYbar - t.*sqrt(se^2 + sybar1^2) muYbar + t.*sqrt(se^2 + sybar1^2)];

hold off;
fprintf("\n====For the given value of air density = %.2f====\nCI for Light Speed Mean = [%.2f, %.2f]\nCI for Light Speed Value = [%.2f, %.2f]\n", ...
                                                                                                    x1, ciMuY1(1), ciMuY1(2), ciY1(1), ciY1(2));
                                                                                                
%% Question (d)

c = 299792.458;
d0 = 1.29;

yReal = c*(1 - 0.00029*(x/d0)) - 299000;

b0Real = c - 299000;
b1Real =  -c*0.00029/d0;

figure();
xline(b0Real, '-', 'b0 Real');
xline(CIb0, '-.r', 'b0 Limits');
title("b0 Parameter")
grid on;

figure();
xline(b1Real, '-', 'b1 Real');
xline(CIb1, '-.r', 'b1 Limits');
title('b1 Parameter');
grid on;

ybarReal = b0Real + b1Real*x;

muYReal = mean(yReal);

figure();
plot(x, ybar);
hold on;
plot(x, ybarReal);
plot(x, ciMuY(:, 1));
plot(x, ciMuY(:,2));

xlabel("Air Density (kg/m^{3})");
ylabel( "Light Speed");
title("Real Data");
legend('Estimation', 'Real data', 'Light Speed Mean CI Lower Limit', 'Light Speed Mean CI Upper Limit');
grid on;
hold off;

fprintf("\n[==== Real Light Speed Data ====]\nb0 = %.3f\nb1 = %.3f", b0Real, b1Real);

fprintf("\nMean = %.3f\n", muYReal);

