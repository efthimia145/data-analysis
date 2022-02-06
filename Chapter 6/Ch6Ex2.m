% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [6] Ex. 2

clear;
close all;
clc;

yeastData = importdata('yeast.dat');

[n, p] = size(yeastData);

y = yeastData - mean(yeastData);

covY = cov(y);

[eigenVectors, eigenValues] = eig(covY);

eigenValues = sort(diag(eigenValues), 'descend');
eigenVectors = eigenVectors(:,p:-1:1);

%% Question (a)

% [Method 1] Scree plot
figure();
hold on
plot(1:p,eigenValues,'-o')
yline(mean(eigenValues), 'r');

title('Scree Plot')
xlabel('Index')
ylabel('Eigenvalue')
title('Scree plot')
grid on

% [Method 2] Explained variance percentage


%% Question (b)

d = 2;

a = eigenVectors(:, 1:d);
z = yeastData * a;

figure();

plot(z(:,1),z(:,2),'*');

xlabel('PC 1');
ylabel('PC 2');
title(['PCA [d = ' num2str(d) ']']);
grid on

d = 3;
a = eigenVectors(:, 1:d);
z = yeastData * a;

figure();

plot3(z(:,1), z(:,2), z(:, 3),'*');

xlabel('PC 1');
ylabel('PC 2');
zlabel('PC 3');
title(['PCA [d = ' num2str(d) ']']);
grid on