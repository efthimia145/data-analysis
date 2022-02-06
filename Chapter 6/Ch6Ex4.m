% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [6] Ex. 4

clear;
close all;
clc;

A2 = [unifrnd(-1, 1), unifrnd(-1, 1); unifrnd(-1, 1), unifrnd(-1, 1)]; 
A3 = [unifrnd(-1, 1), unifrnd(-1, 1), unifrnd(-1, 1); unifrnd(-1, 1), unifrnd(-1, 1), unifrnd(-1, 1)];

n = 10000;
prewhiten_value = 1;

p = 2;

% Sound data 
chirpData = load('chirp.mat');
s1 = chirpData.y;

gongData = load('gong.mat');
s2 = gongData.y;

% Covariances matrix
S = [s1(1:n), s2(1:n)];

figure();
plot(S(:, 1));

% Plotting the signals 
xlabel('t');
ylabel('s1(t)');
title('Source signal 1');
grid on;

figure();
plot(S(:, 2));
xlabel('t');
ylabel('s2(t)');
title('Source signal 2');
grid on;

%% Question (a)

if p == 2

    x2 = S * A2;

    figure();
    hold on;
    plot(x2(:, 1));
    
    xlabel('t');
    ylabel('x1(t)');
    title('Mixed signal 1 [p = 2]');
    grid on;

    figure();
    hold on;
    plot(x2(:, 2));
    
    xlabel('t');
    ylabel('x2(t)');
    title('Mixed signal 2 [p = 2]');
    grid on;

    y2 = x2 - mean(x2);
    
    if prewhiten_value
        y2 = prewhiten(y2);
    end

    mdl = rica(y2, p);
    z2 = transform(mdl, y2);

    figure();
    plot(z2(:, 1));
    hold on;
    plot(y2(:, 1));
    
    xlabel('t');
    ylabel('s1(t) reconstr.');
    title('ICA reconstructed s1 VS source [p = 2]');
    hold off;
    legend('ICA reconstructed', 'Source');
    grid on;

    figure();
    plot(z2(:, 2));
    hold on;
    plot(y2(:, 2));
    
    xlabel('t');
    ylabel('s2(t) reconstr.');
    title('ICA reconstructed s2 VS source [p = 2]');
    hold off;
    legend('ICA reconstructed', 'Source');
    grid on;
    
end

%% Question (b)

if p == 3

    x3 = S * A3;

    figure();
    hold on;
    plot(x3(:, 1));
    
    xlabel('t');
    ylabel('x1(t)');
    title('Mixed signal 1 [p = 3]');
    grid on;

    figure();
    hold on;
    plot(x3(:, 2));
    
    xlabel('t');
    ylabel('x2(t)');
    title('Mixed signal 2 [p = 3]');
    grid on;

    figure();
    hold on;
    plot(x3(:, 3));
    
    xlabel('t');
    ylabel('x3(t)');
    title('Mixed signal 3 [p = 3]');
    grid on;

    y3 = x3 - mean(x3);

    mdl = rica(y3, p);
    z3 = transform(mdl, y3);

    figure();
    plot(z3(:, 1));
    hold on;
    plot(y3(:, 1));
    
    xlabel('t');
    ylabel('s1(t) reconstr.');
    title('ICA reconstructed s1 VS source [p = 3]');
    hold off;
    legend('ICA reconstructed', 'Source');
    grid on;

    figure();
    plot(z3(:, 2));
    hold on;
    plot(y3(:, 2));
    
    xlabel('t');
    ylabel('s2(t) reconstr.');
    title('ICA reconstructed s2 VS source [p = 3]');
    hold off;
    legend('ICA reconstructed', 'Source');
    grid on;

    figure();
    plot(z3(:, 3));
    hold on;
    
    plot(y3(:, 3));
    xlabel('t');
    ylabel('s3(t) reconstr.');
    title('ICA reconstructed s3 VS source [p = 3]');
    hold off;
    legend('ICA reconstructed', 'Source');
    grid on;
    
end