% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [5] Ex. 3

clear;
close all;
clc;

temperature = importdata('temperature_Thessaloniki.dat');
raining = importdata('raining_Thessaloniki.dat');

[n, m]=size(temperature);
alpha = 0.05;

r_temp = zeros(2,2,m);
for i=1:1:m
    r_temp(:,:,i) = corrcoef(temperature(:,i), raining(:,i));
end
r(:) = r_temp(1,2,:);

t_student = r .* (sqrt((n-2)./(1-r.^2)));
p_student = tcdf(t_student,n-2);

p_in = 0;
for i=1:1:m
    if (p_student(1,i) < 0.975) && (p_student(1,i) > 0.025)
        p_in = p_in + 1;
    end
end
fprintf('Percentage of rho in CI = %1.2f\n', (p_in/m)*100);

%% Randomization

for i=2:1:m
    temperature_random = randperm(n);
    temperature(:,i) = temperature(temperature_random,1);
end

r_temp = zeros(2,2,m);
for i=1:1:m
    r_temp(:,:,i) = corrcoef(temperature(:,i),raining(:,i));
end
r(:) = r_temp(1,2,:);

t_student = r .* (sqrt((n-2)./(1-r.^2)));

t_student_sorted = sort(t_student);
upper = t_student_sorted(1, ceil(m*(1-alpha/2)));
lower = t_student_sorted(1, ceil(m*alpha/2));

if (t_student(1,1) < upper) && (t_student(1,1) > lower)
    fprintf('Approved\n');
else
    fprintf('Rejected\n');
end