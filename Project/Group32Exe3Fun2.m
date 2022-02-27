%% ========= Project - Question 3 ===========
%
% Theodoros Papafotiou & Efthymia Amarantidou
% AEM: 9708 & 9762
% ===========================================

% Calculate the mean weekly rate for a specific week in EU countries.
function [mean_positive_rate] = Group32Exe3Fun2(week)

    [ECDC_num, ~, ECDC_raw] = xlsread('ECDC-7Days-Testing.xlsx');
    [~, EUcountries] = xlsread('EuropeanCountries.xlsx');
    level = 'national';
    
    countEntries = 0;
    entries = zeros(length(EUcountries)-1, 1);
    for i = 2:height(ECDC_raw)
        dataWeek = ECDC_raw(i, 3);
        dataLevel = ECDC_raw(i, 4);
        dataCountry = ECDC_raw(i, 1);
        
        if strcmp(dataWeek{1}, week) && strcmp(dataLevel{1}, level)

            if any(strcmp(EUcountries(2:end, 2), dataCountry{1}))
                value = ECDC_num(i-1, 5);
                if ~isnan(value)
                    countEntries = countEntries + 1;  
                    entries(countEntries) = ECDC_num(i-1, 5);
                end
            end
        end
    end
    mean_positive_rate = sum(entries) / countEntries;
end

