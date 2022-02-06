% Exercise 3.4
clear;
close all;
% Data from dropout voltage in an electric circuit.
% Estimation and hypothesis testing on mean, variance and hypothesis
% testing for goodness of fit to normal distribution.
% datdir = 'c:\MyFiles\Teach\DataAnalysis\Data\';
% dattxt = 'DropoutVoltage';
clear;
close all;
sigma0 = 5;
varalpha = 0.05;
mu0 = 52;
mualpha = 0.05;
tittxt = 'dropout voltage';

%eval(['load ',datdir,dattxt,'.dat'])
% eval(['xV = ',dattxt,';'])
xV = [41 46 47 47 48 50 50 50 50 50 50 50 48 50 50 50 50 50 50 50 52 52 53 55 50 50 50 50 52 52 53 53 53 53 53 57 52 52 53 53 53 53 53 53 54 54 55 68];
n = length(xV);
nbin = round(sqrt(n));
figure(1)
clf
histfit(xV,nbin)
xlabel('x')
ylabel('counts')
title(sprintf('%s: n=%d ',tittxt,n))
figure(2)
clf
boxplot(xV)
title(sprintf('%s: n=%d ',tittxt,n))

% (a) and (b)
[h,pvar,civarV]=vartest(xV,sigma0^2,varalpha);
fprintf('---- 3.4 (a) ----- \n');
fprintf('CI for var(X)=[%2.3f,%2.3f] \n',civarV(1),civarV(2));
fprintf('CI for sigma(X)=[%2.3f,%2.3f] \n',sqrt(civarV(1)),sqrt(civarV(2)));
fprintf('---- 3.4 (b) ----- \n');
fprintf('p-value (for H:sigma=%2.2f) = %1.5f \n',sigma0,pvar);
% (c) and (d)
[hmu,pmu,cimuV]=ttest(xV,mu0,mualpha);
fprintf('---- 3.4 (c) ----- \n');
fprintf('CI for mu(X)=[%2.3f,%2.3f] \n',cimuV(1),cimuV(2));
fprintf('---- 3.4 (d) ----- \n');
fprintf('p-value (for H:mu=%2.2f) = %1.5f \n',mu0,pmu);
% (e)
% [h,pgof,gofstats]=chi2gof(xV,'nbins',nbin)
[hchi,pgof,gofstats]=chi2gof(xV);
fprintf('---- 3.4 (e) ----- \n');
fprintf('p-value (for H:normal fit) = %1.5f \n',pgof);
fprintf('\t observed \t expected frequencies \n');
Kc = length(gofstats.O);
for i=1:Kc
    fprintf('\t %3.3f \t %3.3f \n',gofstats.O(i),gofstats.E(i));
end