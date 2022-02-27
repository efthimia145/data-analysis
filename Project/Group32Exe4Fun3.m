%% ========= Project - Question 4 ===========
%
% Theodoros Papafotiou & Efthymia Amarantidou
% AEM: 9708 & 9762
% ===========================================

% Find the positivity rate for specific weeks in a specific country.
function [data] = Group32Exe4Fun3(weeks, country, ECDC_raw, ECDC_num)

    level = 'national';
    
    countWeeks = 1;
    data = zeros(height(weeks), 2); % First column: 2020, Second column: 2021
    
    for i = 2:height(ECDC_raw)
        dataCountry = ECDC_raw(i, 1);
        dataLevel = ECDC_raw(i, 4);
        dataWeek = ECDC_raw(i, 3);
        
        dataWeekChar = char(dataWeek{1});
        year = str2double(dataWeekChar(1:4));
        
        if strcmp(dataCountry{1}, country) && strcmp(dataLevel{1}, level)
            
            if countWeeks == height(weeks) + 1
                countWeeks = 1;
            end
            
            if int64(year) == 2020 && strcmp(dataWeek{1}, weeks(countWeeks, 1))
                data(countWeeks, 1) = ECDC_num(i - 1, 5);
                countWeeks = countWeeks + 1;
            elseif int64(year) == 2021 && strcmp(dataWeek{1}, weeks(countWeeks, 2))
                data(countWeeks, 2) = ECDC_num(i - 1, 5);
                countWeeks = countWeeks + 1;
            end
        end
    end
end

