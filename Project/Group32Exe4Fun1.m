%% ========= Project - Question 4 ===========
%
% Theodoros Papafotiou & Efthymia Amarantidou
% AEM: 9708 & 9762
% ===========================================

function Group32Exe4Fun1(countryA)

    B = 1000;
    alpha = 0.05;

    weeks = strings(8, 2);
    for i = 1:length(weeks)
       weeks(i, 1) = ['2020-W', int2str(i+41)];
       weeks(i, 2) = ['2021-W', int2str(i+41)];
    end
    
    [ECDC_num, ~, ECDC_raw] = xlsread('ECDC-7Days-Testing.xlsx');
        
    num_of_neighbours = 4;
    
    countries = Group32Exe4Fun2(countryA, num_of_neighbours);
    fprintf('The neighbouring countries are:\n');
    disp(countries);
    
    % Bootstrap check for the null hypothesis that the mean positivity rate
    % for a period of 2 months is the same for 2020 and 2021.
    for i = 1:num_of_neighbours + 1
        
        country = countries(i);
        % Positivity rate values for the given period for each country.
        data_months = Group32Exe4Fun3(weeks, country, ECDC_raw, ECDC_num);

        F2020 = data_months(:, 1);
        F2021 = data_months(:, 2);
        A = mean(F2020);
        D = mean(F2021);
        stat = A - D;
        Fxy = [F2020' F2021'];

        mean_samples = zeros(B,1);
        n = length(F2020);
        for j = 1:B
            randV = unidrnd(2*n, 2*n, 1);
            samplesX = Fxy(randV(1:n));
            samplesY = Fxy(randV(n+1:2*n));
            mean_samples(j) = mean(samplesX) - mean(samplesY);
        end

        mean_samples = [mean_samples; stat];
        mean_sorted = sort(mean_samples);

        r = mean(find(mean_sorted == stat));

        %% Check if inside the confidence interval
        if (r < (B + 1)*alpha/2) || (r > (B + 1)*(1 - alpha/2))
            fprintf('[%s] The null hypothesis is rejected.\n', country{1});
        else
            fprintf('[%s] The null hypothesis is accepted.\n', country{1});
        end
    end

end

