%% ========= Project - Question 4 ===========
%
% Theodoros Papafotiou & Efthymia Amarantidou
% AEM: 9708 & 9762
% ===========================================

% Find a specific number of neighbouring countries of countryA. 
function [countries] = Group32Exe4Fun2(countryA, num_of_neighbours)

    [~, EUcountries] = xlsread('EuropeanCountries.xlsx');
    
    index = find(ismember(EUcountries(2:end, 2), countryA));
    
    margin = floor(num_of_neighbours/2);
    countries = EUcountries(index-margin+1:index+margin+1, 2);
    
    if mod(num_of_neighbours, 2) == 1
        countries = [countries; EUcountries(index+margin+2, 2)];
    end

end

