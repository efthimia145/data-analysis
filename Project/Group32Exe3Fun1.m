%% ========= Project - Question 3 ===========
%
% Theodoros Papafotiou & Efthymia Amarantidou
% AEM: 9708 & 9762
% ===========================================

function Group32Exe3Fun1(countryA)

    B = 1000;
    
    % Find the week of the latest peak of the positivity rate for country
    % A.
    [year, week] = Group32Exe3Fun4(countryA);
    fprintf(['The week of the latest peak on the positivity rate of '...
                countryA ' is ' num2str(year) '-W' num2str(week) '\n\n'])

    num_of_weeks = 12;
    mean_rates = zeros(num_of_weeks, 2); % Weekly mean positivity rate for EU and Greece
    diffs = zeros(num_of_weeks, 1);
    
    for i = (week-num_of_weeks + 1):week
        week_str = [int2str(year), '-W', int2str(i)];
        mean_rates(i-(week-num_of_weeks), 1) = Group32Exe3Fun2(week_str);
        
        index = i-(week-num_of_weeks);
        [diffs(index), mean_rates(index, 2)] = ...
                Group32Exe3Fun3(week_str, mean_rates(index, 1), B);
    end
    
    figure()
    hold on
    x = (week-num_of_weeks + 1):week;
    plot(x, mean_rates(:, 1), '-*r');
    plot(x, mean_rates(:, 2), '-ob');
    plot(x, diffs, '-xm');
    hold off
    legend('Weekly Rate Greece', 'Weekly Rate Europe', 'Diff [EU - GR]');
    xlabel(['Weeks - ', int2str(year)]);
    ylabel('Rate');
    title('Mean Positivity Rate')
    grid on

end

