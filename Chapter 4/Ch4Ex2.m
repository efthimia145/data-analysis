% Amarantidou Efthymia 
% AEM: 9762
% Data Analysis | Chapter [4] Ex. 2

clear;
close all;
clc;

height_std = 5; 
width_std = 5;

%% Question (a)

height = 500;
width = 300;

area_std = sqrt(((height_std*width)^2) + ((width_std*height)^2));

heights = 1:1000;
widths = zeros(1, length(heights));

for i=1:length(heights)
    widths(i) = sqrt(((area_std^2) - ((width_std*heights(i))^2))/(height_std^2));
end

fprintf("The uncertainty on the calculation of the area with width = %d and height = %d is %.4f",...
                                            width, height, area_std);

figure();
scatter(widths,heights);
xlabel('height (m)')
ylabel('width (m)')
title("Widths and Heights for constant area uncertainty = " + area_std);
grid on;

%% Question (b)

step = 10;
n = 1000;
[x, y] = meshgrid(1:step:n, 1:step:n);
z = sqrt(((height_std*y)^2) + ((width_std*x)^2));

surf(x,y,z);
xlabel("height (m)");
ylabel("width (m)");
zlabel("Uncertainty (m)");
title("Uncertainty(height, width)");