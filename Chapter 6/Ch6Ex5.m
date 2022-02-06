% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [6] Ex. 5

clear;
close all;
clc;

%% Generate data matrix

n = 1000;
p = 5;

mu = [1 8 15 5 32];

X = zeros(n,p);
for i=1:5
    X(:,i) = exprnd(mu(i), n, 1);
end

beta = [0 2 0 -3 0]';

muEpsilon = 0;
sigmaEpsilon = 5;

epsilon = normrnd(muEpsilon, sigmaEpsilon, n, 1);

y = X*beta + epsilon;

%% Question (a)

% OLS

% bOLS = lscov(X, y);

[U, S, V] = svd(X);
S = S(1:p,1:p);
U = U(1:n,1:p);

bOLS = V*inv(S)*(U')*y;
yOLS = X*bOLS;

% PCR 

% Calculation of Principal Components 
[PCALoadings,PCAScores,PCAVar] = pca(X,'Economy',false);

PCAVar = PCAVar/sum(PCAVar);

% k selection based on the per variance explained criterio
figure();
plot(1:p,cumsum(100*PCAVar),'-bo');
xlabel('Number of PCA components');
ylabel('Percent Variance Explained in Y');
grid on;

k = 4;
% Regression model estimation
betaPCR = regress(y-mean(y), PCAScores(:,1:k));
betaPCR = PCALoadings(:,1:k)*betaPCR;
% Transformation 
betaPCR = [mean(y) - mean(X)*betaPCR; betaPCR];
yfitPCR = [ones(n,1) X]*betaPCR;

% PLS
[~,~,~,~,~, PLSPctVar] = plsregress(X,y,p);

plot(1:p, cumsum(100*PLSPctVar(2,:)),'-bo');
xlabel('Number of PLS components');
ylabel('Percent Variance Explained in Y');
grid on;

k = 4;

[~,~,~,~,betaPLS] = plsregress(X,y,k);
yfitPLS = [ones(n,1) X]*betaPLS;

% RR
k = 100;
bRR = ridge(y, X ,k);
yfitRR = X*bRR;

% LASSO 
bLASSO = lasso(X, y);
bLASSO = bLASSO(:,1);
yfitLASSO = X*bLASSO;
%% Question (b)

% OLS
figure();
plot(y, yOLS, '*');
xlabel('Observed Response');
ylabel('Fitted Response');
title('Observed and Estimated values of y [OLS]');
grid on;

figure();
OLSError = y - yOLS;
OLSError = OLSError / std(OLSError);
plot(OLSError, '.');
xlabel('y');
ylabel('Error');
title('Standar regression error [OLS]');
grid on;

% PCR
figure();
scatter(y,yfitPCR,'r*');
xlabel('Observed Response');
ylabel('Fitted Response');
title('Observed and Estimated values of y [PCR]');
legend(['PCR with ' num2str(k) ' Components'],  'location','NW');
grid on;

figure();
PCRError = y-yfitPCR;
PCRError = PCRError/std(PCRError);
plot(PCRError, '.');
xlabel('y');
ylabel('Error');
title('Standar regression error [PCR]');
grid on;

% PLS
figure();
scatter(y,yfitPLS,'r*');
xlabel('Observed Response');
ylabel('Fitted Response');
title('Observed and Estimated values of y [PLS]');
legend(['PLS with ' num2str(k) ' Components'],  'location','NW');
grid on;

figure();
PLSError = y-yfitPLS;
PLSError = PLSError/std(PLSError);
plot(PLSError, '.');
xlabel('y');
ylabel('Error');
title('Standar regression error [PLS]');
grid on;

% RR
figure();
scatter(y, yfitRR, 'r*');
xlabel('Observed Response');
ylabel('Fitted Response');
title('Observed and Estimated values of y [RR]');
grid on;

figure();
RRError = y-yfitRR;
RRError = RRError/std(RRError);
plot(RRError, '.');
xlabel('y');
ylabel('Error');
title('Standar regression error [RR]');
grid on;
grid on;

% LASSO
figure();
scatter(y, yfitLASSO, 'r*');
xlabel('Observed Response');
ylabel('Fitted Response');
title('Observed and Estimated values of y [LASSO]');
grid on;

figure();
LASSOError = y-yfitLASSO;
LASSOError = LASSOError/std(LASSOError);
plot(LASSOError, '.');
xlabel('y');
ylabel('Error');
title('Standar regression error [LASSO]');
grid on;
grid on;