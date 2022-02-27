%% ========= Project - Question 3 ===========
%
% Theodoros Papafotiou & Efthymia Amarantidou
% AEM: 9708 & 9762
% ===========================================

% Calculate the daily positivity rate for a specific week in Greece, 
function [diff, weekly_rate] = Group32Exe3Fun3(week, mean_rate_EU, B)

    [~, ~, EODY_raw] = xlsread('FullEodyData.xlsx');
    
    A = string(EODY_raw(2:height(EODY_raw), 51));
    indices_week = count(A, week);
    num_of_days = sum(indices_week);
    
    positivity_rate = 0;
    daily_rate = zeros(num_of_days, 1);
    first_day = find(indices_week == 1, 1);
    for day = first_day:first_day+num_of_days
        dataPCR = EODY_raw(day, 45);
        dataPCR_last = EODY_raw(day-1, 45);
        dataRapid = EODY_raw(day, 46);
        dataRapid_last = EODY_raw(day-1, 46);
        dataCases = EODY_raw(day, 2);

        if isnan(dataPCR{1})
            dataPCR{1} = 0;
        end
        if isnan(dataPCR_last{1})
            dataPCR_last{1} = 0;
        end
        if isnan(dataRapid{1})
            dataRapid{1} = 0;
        end
        if isnan(dataRapid_last{1})
            dataRapid_last{1} = 0;
        end
        daily_rate(day - first_day + 1) = 100*(dataCases{1}) / ...
                            (dataPCR{1} - dataPCR_last{1} ...
                            + dataRapid{1} - dataRapid_last{1});
        positivity_rate = positivity_rate + daily_rate(day - first_day + 1);
    end
    weekly_rate = positivity_rate / num_of_days;
    
    bootstraped_week = bootstrp(B, @mean, daily_rate);
    ci = bootci(B, @mean, bootstraped_week);
    if mean_rate_EU < ci(1) || mean_rate_EU > ci(2)
        fprintf(['[== ', week, ' ==]\n'])
        fprintf('The weekly positivity rate of Greece is statistically different than EU.\n');
        diff = mean_rate_EU - weekly_rate;
    else
        fprintf(['[== ', week, ' ==]\n'])
        fprintf('The weekly positivity rate of Greece is not statistically different than EU.\n');
        diff = mean_rate_EU - weekly_rate;
    end
end

