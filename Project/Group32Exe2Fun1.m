%% ========= Project - Question 2 ===========
%
% Theodoros Papafotiou & Efthymia Amarantidou
% AEM: 9708 & 9762
% ===========================================

function Group32Exe2Fun1(positivityRate2020, positivityRate2021, countries)
    
    B = 1000;               % Bootstrap
    alpha = 0.05;           % For the confidence interval
    
    n1 = length(positivityRate2020);
    n2 = length(positivityRate2021);
    n_diff = n1 - n2;
    idx = find(ismember(countries(:, 1), countries(:, 2)));
    
    %% Make the lists of the same length, so that there are equal data for 2020 and 2021
    
    if n_diff > 0
        % Remove from 2020 list
        positivityRate2020 = positivityRate2020(idx);
    elseif n_diff < 0
        % Remove from 2021 list
        positivityRate2021 = positivityRate2021(idx);
    end
    
    sorted2020 = sort(positivityRate2020);
    sorted2021 = sort(positivityRate2021);
    n = min(n1, n2);

    Fx = sorted2020 ./ n;
    Fy = sorted2021 ./ n;
    
    maxFxFy = max(Fx - Fy);
    
    Fxy = [Fx Fy];
    
    % Creare bootstrap samples
    max_samples = zeros(B,1);
    for j = 1:B
        randV = unidrnd(2*n, 2*n, 1);
        samplesX = Fxy(randV(1:n));
        samplesY = Fxy(randV(n+1:2*n));
        max_samples(j) = max(samplesX - samplesY);
    end
    stat = maxFxFy;
    max_samples = [max_samples; stat];
    max_sorted = sort(max_samples);
    
    r = mean(find(max_sorted == stat));
    
    %% Check if inside the confidence interval.
    if (r < (B + 1)*alpha/2) || (r > (B + 1)*(1 - alpha/2))
        disp('The null hypothesis that the distributions match is rejected.');
    else
        disp('The null hypothesis that the distributions match is accepted.');
    end

end