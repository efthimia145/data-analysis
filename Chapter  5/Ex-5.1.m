% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [5] Ex. 1

clear;
close all;
clc;

M = 1000; 
n = 20; % 200
alpha = 0.05;
nbins = 20;

rho0 = 0; % 0.5

mu = [0 0];
sigma = [1 rho0; rho0 1];

R = zeros(n, 2, M);
for i=1:1:M
    R(:,:,i) = mvnrnd(mu, sigma, n);
end

r_temp = zeros(2,2,M);
for i=1:1:M
    r_temp(:,:,i) = corrcoef(R(:,1,i),R(:,2,i));
end
r(:) = r_temp(1,2,:);

%% Question (a)
r_fisher(:) = atanh(r);

r_ci_fisher(1,1:M) = r_fisher(1,1:M) - 1.96*sqrt(1/(n-3));
r_ci_fisher(2,1:M) = r_fisher(1,1:M) + 1.96*sqrt(1/(n-3));

r_ci = tanh(r_ci_fisher);

figure();
histogram(r_ci(1,:), nbins);
title({
        '[Fisher Transform] Lower limit of the CI for'
        ['M = ', int2str(M), ' n = ', int2str(n), ' and alpha = ', num2str(alpha)]
        });
grid on;
    
figure();
histogram(r_ci(2,:), nbins);
title({
        '[Fisher Transform] Upper limit of the CI for'
        ['M = ', int2str(M), ' n = ', int2str(n), ' and alpha = ', num2str(alpha)]
        });
grid on;

r_in = 0;
for i=1:1:M
    if (r_ci(1,i) < rho0) && (r_ci(2,i) > rho0)
        r_in = r_in + 1;
    end
end
fprintf('[Fisher Transform] Percentace of rho in CI = %1.2f\n', (r_in/M)*100);


%% Question (b)
t_student = r .* (sqrt((n-2)./(1-r.^2)));
r_student = tcdf(t_student, n-2);

r_in = 0;
for i=1:1:M
    if (r_student(1,i) < 1-alpha/2) && (r_student(1,i) > alpha/2)
        r_in = r_in + 1;
    end
end
fprintf('[Student] Percentace of rho in CI = %1.2f\n', (r_in/M)*100);
