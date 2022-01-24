% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [6] Ex. 6

clear;
close all;
clc;

physical_txt = importdata('physical.txt');
physical = physical_txt.data;

[n,p] = size(physical);
p = p - 1;

X = physical(:,2:p+1);
y = physical(:,1);

%% PCR 
[PCALoadings,PCAScores,PCAVar] = pca(X,'Economy',false);

PCAVar = PCAVar/sum(PCAVar);
figure();
plot(1:p,cumsum(100*PCAVar),'-bo');
xlabel('Number of PCA components');
ylabel('Percent Variance Explained in Y');
grid on;

k = 4;
betaPCR = regress(y-mean(y), PCAScores(:,1:k));
betaPCR = PCALoadings(:,1:k)*betaPCR;
betaPCR = [mean(y) - mean(X)*betaPCR; betaPCR];
yfitPCR = [ones(n,1) X]*betaPCR;

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


%% PLS
[~,~,~,~,~, PLSPctVar] = plsregress(X,y,p);

plot(1:p, cumsum(100*PLSPctVar(2,:)),'-bo');
xlabel('Number of PLS components');
ylabel('Percent Variance Explained in Y');
grid on;

k = 4;

[~,~,~,~,betaPLS] = plsregress(X,y,k);
yfitPLS = [ones(n,1) X]*betaPLS;

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

%% RR
k = 100;
bRR = ridge(y, X ,k);
yfitRR = X*bRR;

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

%% LASSO 
bLASSO = lasso(X, y);
bLASSO = bLASSO(:,1);
yfitLASSO = X*bLASSO;

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

%% Stepwise
stepwise(X, y);