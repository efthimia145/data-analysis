% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [6] Ex. 1

clear;
close all;
clc;

%%
n = 1000;  % Sample size

mu = [0 0];
sigma = [1 0; 0 4];

rng('default');
X = mvnrnd(mu,sigma,n);

W = [0.2 0.8; 0.4 0.5; 0.7 0.3];

figure();
plot(X(:,1),X(:,2), '*');
xlabel('x1');
ylabel('x2');
grid on;
title('Observed points in 2D');

%% Tranformation from R^2 to R^3

transformedX = X*W';

x = transformedX(:,1);
y = transformedX(:,2);
z = transformedX(:,3);

figure();
plot3(x,y,z, '*');
xlabel('y1');
ylabel('y3');
zlabel('y2');
grid on;
title('Observed points in 3D');

%% Question (a)
% Covariances matrix

Xc = transformedX - mean(transformedX);

S = 1/(n-1)*(Xc')*Xc;

% Eigenvectors & Eigenvalues of S

[Seigenvectors, Seigenvalues] = eig(S);

Seigenvalues = sort(diag(Seigenvalues), 'descend');

%% Question (b)

figure();
index = 1:length(Seigenvalues);
plot(index, Seigenvalues(index), 'o-');
xlabel('Index');
ylabel('Eigevalue');
title('Scree plot');
grid on;

Y = (Seigenvectors * Xc')';

figure();
plot3(Y(:,1), Y(:,2), Y(:,3), '*'); 
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');
title('Principal Component Scores [3D]');
grid on;

%% Question (c)

Y2 = (Seigenvectors(:,1:2)' * Xc')';

figure();
hold on;
plot(X(:,1), X(:,2), '*');
plot(Y2(:,1), Y2(:,2), '*k');
xlabel('PC1');
ylabel('PC2');
legend();
title('Principal Component Scores [2D]');
hold off;
grid on;