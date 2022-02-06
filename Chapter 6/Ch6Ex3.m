% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [6] Ex. 3

clear;
close all;
clc;

physical_txt = importdata('physical.txt');
physical = physical_txt.data;

[n,p] = size(physical);

y = physical - repmat(sum(physical)/n, n, 1);
covY = cov(y);
[eigenVectors, eigenValues] = eig(covY);

eigenValues = diag(eigenValues);
eigenValues = eigenValues(p:-1:1);
eigenVectors = eigenVectors(:,p:-1:1);

%% Question (a)

% [Method 1] Scree Plot
figure();
hold on

plot(1:p,eigenValues,'-o')
plot(xlim, mean(eigenValues) * [1, 1]);

title('Scree Plot')
xlabel('Index')
ylabel('Eigenvalue')
title('Scree plot')
grid on

% [Method 2] Explained variance percentage

td = 100*cumsum(eigenValues)/sum(eigenValues);
figure();

plot(1:p,td,'o-k');
xlabel('Index');
ylabel('Variance Percentage');
title('Explained Variance percentage');
grid on;

% [Method 3] Variance size
eigenvaluesAvg = mean(eigenValues);
thresholdPercentage = 0.7;
threshold = thresholdPercentage * eigenvaluesAvg;
index = find(eigenValues > threshold);
fprintf('Dimension d using size of the variance: %d \n',length(index));
%% Question (b)

d = 2;

a = eigenVectors(:, 1:d);
z = physical * a;

figure();
plot(z(:,1),z(:,2),'*')

xlabel('PC 1')
ylabel('PC 2')
title('PCA [d = 2]')
grid on

d = 3;
a = eigenVectors(:, 1:d);
z = physical * a;

figure();
plot3(z(:,1), z(:,2), z(:, 3),'*')

xlabel('PC 1')
ylabel('PC 2')
zlabel('PC 3')
title('PCA [d = 3]')
grid on