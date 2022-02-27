%% ========= Project - Question 1 ===========
%
% Theodoros Papafotiou & Efthymia Amarantidou
% AEM: 9708 & 9762
% ===========================================

function [positivityRate2020, positivityRate2021, countries] = Group32Exe1Fun1(countryA, plot_results)

    [ECDC_num, ~, ECDC_raw] = xlsread('ECDC-7Days-Testing.xlsx');
    [~, EUcountries] = xlsread('EuropeanCountries.xlsx');

    weekSel = ['2020-W45'; '2021-W45'];
    level = 'national';
    indexInit1 = 0;  % The index in which data for the selected weeks for country A start for 2020. 
    indexInit2 = 0;  % The index in which data for the selected weeks for country A start for 2021. 

    % Define the indexes that data for country A start for each year and
    % then find the week that positivity rate is maximum. 
    for i = 2:height(ECDC_raw)
        dataWeek = ECDC_raw(i, 3);
        dataLevel = ECDC_raw(i, 4);
        dataCountry = ECDC_raw(i, 1);
        if strcmp(dataWeek{1}, weekSel(1, :)) && strcmp(dataLevel{1}, level) ...
                && strcmp(dataCountry{1}, countryA)

            indexInit1 = i;

        elseif strcmp(dataWeek{1}, weekSel(2, :)) && strcmp(dataLevel{1}, level) ...
                && strcmp(dataCountry{1}, countryA)

            indexInit2 = i;
            break
        end
    end

    [~, IndexMax1] = max(ECDC_num(indexInit1-1:indexInit1+4, 5));
    [~, IndexMax2] = max(ECDC_num(indexInit2-1:indexInit2+4, 5));

    numWeek1 = 44 + IndexMax1;
    numWeek2 = 44 + IndexMax2;
    countCountries = [0, 0];
    weekFind = ['2020-W', int2str(numWeek1); '2021-W', int2str(numWeek2)];

    fprintf(['The weeks on which positivity rate is maximum in ' countryA ' are:\n2020: W' ...
                                                    int2str(numWeek1) '\n2021: W' int2str(numWeek2) '\n']);
    level = 'national';

    % Find the data for the weeks defined above for each of the 25 European
    % countries.
    indices2021 = zeros(25, 1);
    indices2020 = zeros(25, 1);
    countries = strings(25, 2);

    for i = 2:height(ECDC_raw)
        dataWeek = ECDC_raw(i, 3);
        dataLevel = ECDC_raw(i, 4);
        dataCountry = ECDC_raw(i, 1);
        if strcmp(dataWeek{1}, weekFind(1, :)) && strcmp(dataLevel{1}, level)

            if any(strcmp(EUcountries(2:end, 2), dataCountry{1}))
                countCountries(1) = countCountries(1) + 1;  
                indices2020(countCountries(1)) = i;
                countries(countCountries(1), 1) = dataCountry{1};
            end

        elseif strcmp(dataWeek{1}, weekFind(2, :)) && strcmp(dataLevel{1}, level)

            if any(strcmp(EUcountries(2:end, 2), dataCountry{1}))
                countCountries(2) = countCountries(2) + 1;  
                indices2021(countCountries(2)) = i;
                countries(countCountries(2), 2) = dataCountry{1};
            end
        end

    end

    indices2020 = int64(indices2020 - 1);
    indices2021 = int64(indices2021 - 1);
    positivityRate2020 = zeros(length(find(indices2020 > 0)), 1);
    positivityRate2021 = zeros(length(find(indices2021 > 0)), 1);
    for i = 1:25
        if indices2020(i) > 0
            positivityRate2020(i) = ECDC_num(indices2020(i), 5);
        end

        if indices2021(i) > 0
            positivityRate2021(i) = ECDC_num(indices2021(i), 5);
        end
    end
    
    sorted2020 = sort(positivityRate2020);
    sorted2021 = sort(positivityRate2021);
    
    if plot_results
        
        nbins = 8;
    
        figure()
        histfit(positivityRate2020, nbins, 'normal');
        xlabel('Positivity Rate');
        ylabel('Number of countries');
        title(['Distribution fit - 2020 || Week ', int2str(numWeek1)]);
        grid on

        figure()
        histfit(positivityRate2021, nbins, 'normal');
        xlabel('Positivity Rate');
        ylabel('Number of countries');
        title(['Distribution fit - 2021 || Week ', int2str(numWeek2)]);
        grid on

    end
    %% Comments
    %   From the histograms above we can deduce that the both distributions can 
    %   be fit by the normal distribution, regardless the small size of the 
    %   samples (25 countries).
    %%
    if plot_results
        figure();
        hold on
        plot(sorted2021, '--*r');
        plot(sorted2020, '--*b');
        hold off
        xlabel('Number of countries');
        ylabel('Positivity Rate');
        title('Positivity Rate Distribution');
        legend(['2021 - Week ', int2str(numWeek2)],['2020 - Week ', int2str(numWeek1)]);
        grid on
    end
    
end