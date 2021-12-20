% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [5] Ex. 2

clear;
close all;
clc;

L = 1000;
n = 20; % 200
alpha = 0.05;

rho0 = 0;
mu = [0 0];
sigma = [1 rho0; rho0 1];

R = zeros(n, 2, L);
R(:,:,1) = mvnrnd(mu, sigma, n);

for i=2:1:L
    x_random = randperm(n);
    R(:,1,i) = R(x_random,1,1);
    R(:,2,i) = R(:,2,1);
end

r_temp = zeros(2,2,L);
for i=1:1:L
    r_temp(:,:,i) = corrcoef(R(:,1,i),R(:,2,i));
end
r(:) = r_temp(1,2,:);

t_student = r .* (sqrt((n-2)./(1-r.^2)));

t_student_sorted = sort(t_student);
upper = t_student_sorted(1, ceil(L*(1-alpha/2)));
lower = t_student_sorted(1, ceil(L*alpha/2));

if (t_student(1,1) < upper) && (t_student(1,1) > lower)
    fprintf('Approved\n');
else
    fprintf('Rejected\n');
end