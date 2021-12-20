% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [2] Ex. 1

total_flips = 32000;
ratio = zeros(1, total_flips);

for i = 1:total_flips
    ratio(i) = coin_flip(i);
end

x = 1:total_flips;
y = ratio(x);
plot(x, y);

title(["Propability definition proof"]);
xlabel("Number of flips");
ylabel("Tail ratio");
grid on

function [ratio] = coin_flip(num_of_flips)
    num_of_tails = 0;
    for i = 1:num_of_flips
        x = rand;
        if x <= 0.5
            num_of_tails = num_of_tails + 1;
        end
    end
    ratio = num_of_tails / num_of_flips;
end