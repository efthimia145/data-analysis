%% ========= Project - Question 3 ===========
%
% Theodoros Papafotiou & Efthymia Amarantidou
% AEM: 9708 & 9762
% ===========================================

% Calculates the week that the latest peak on the positivity rate of a
% country happens. 

function [year, week] = Group32Exe3Fun4(country)

    level = 'national';
    [ECDC_num, ~, ECDC_raw] = xlsread('ECDC-7Days-Testing.xlsx');
    weeksPerYear = 52;
    
    indices = zeros(weeksPerYear*2, 1);
    countWeeks = 0;
    
    for i = 2:height(ECDC_raw)
        dataCountry = ECDC_raw(i, 1);
        dataLevel = ECDC_raw(i, 4);
        
        if strcmp(dataCountry{1}, country) && strcmp(dataLevel{1}, level)
            countWeeks = countWeeks + 1;
            indices(countWeeks) = i;
        end
    end
    
    indices = indices(indices > 0);
    indices = int64(indices - 1);
    
    positive_rate_array = ECDC_num(indices, 5);
    [peaks, locations] = findpeaks(positive_rate_array);
    
    last_peak = peaks(end);
    week_of_last_peak = string(ECDC_raw(indices(locations(end)) + 1, 3));

    week_chared = char(week_of_last_peak);
    year = str2double(week_chared(1:4));
    week = str2double(week_chared(7:8));
end

