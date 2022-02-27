%% ========= Project - Question 2 ===========
%
% Theodoros Papafotiou & Efthymia Amarantidou
% AEM: 9708 & 9762
% ===========================================

clear;
close all;
clc;

%% Run 2nd Question
countryA = 'Iceland';
plot_results = false;

[EUpositivityRate2020, EUpositivityRate2021, countries] = Group32Exe1Fun1(countryA, plot_results);

Group32Exe2Fun1(EUpositivityRate2020, EUpositivityRate2021, countries);