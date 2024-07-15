% Title:   Lagrange interpolation and estimating crop production
% Type:    Problem file
% Authors: Scott A. Strong w/ GPT-4o support 
% Date:    7/14/24
% Data:    Crop production data from 2013-2017 in Konya province, Turkey
% Subject: Lagrange Interpolation for estimating crop production
% Summary: This script uses Lagrange interpolation to estimate the production of
%          wheat, maize, and barley based on historical sown area data.
%          The motivation for this comes from replicating the work of Celik
%           in the paper titled, "Lagrange interpolation polynomial and an application in
%           agriculture," published in International Journal of Latest Engineering and Management Research 
%           in 2018.


% Load data from CSV file
data = readtable('crop_data.csv');

% Extract columns into separate variables
years = data.Year;
wheat_sown = data.Wheat_Sown;
wheat_production = data.Wheat_Production;
maize_sown = data.Maize_Sown;
maize_production = data.Maize_Production;
barley_sown = data.Barley_Sown;
barley_production = data.Barley_Production;



% Generate a range of sown areas for plotting the interpolation polynomial
sown_area_range_wheat = linspace(min(wheat_sown), max(wheat_sown), 1000);
sown_area_range_maize = linspace(min(maize_sown), max(maize_sown), 1000);
sown_area_range_barley = linspace(min(barley_sown), max(barley_sown), 1000);

% Calculate interpolated production values for plotting
interp_wheat = arrayfun(@(x) lagrangeInterpolation(x, wheat_sown, wheat_production), sown_area_range_wheat);
interp_maize = arrayfun(@(x) lagrangeInterpolation(x, maize_sown, maize_production), sown_area_range_maize);
interp_barley = arrayfun(@(x) lagrangeInterpolation(x, barley_sown, barley_production), sown_area_range_barley);

% Estimate wheat production
wheat_sown_est = [2100000, 2300000];


% Estimate maize production
maize_sown_est = [450000, 550000];


% Estimate barley production
barley_sown_est = [2500000, 2600000];


% Plot the original data points, interpolated points, and interpolation polynomial
figure;
subplot(3,1,1);
plot(wheat_sown, wheat_production, 'o', 'DisplayName', 'Original Data');
hold on;
plot(wheat_sown_est, arrayfun(@(x) lagrangeInterpolation(x, wheat_sown, wheat_production), wheat_sown_est), '*', 'DisplayName', 'Interpolated Data');
plot(sown_area_range_wheat, interp_wheat, 'r-', 'DisplayName', 'Interpolation Polynomial');
title('Wheat Production');
xlabel('Sown Area (hectares)');
ylabel('Production (tons)');
legend;

subplot(3,1,2);
plot(maize_sown, maize_production, 'o', 'DisplayName', 'Original Data');
hold on;
plot(maize_sown_est, arrayfun(@(x) lagrangeInterpolation(x, maize_sown, maize_production), maize_sown_est), '*', 'DisplayName', 'Interpolated Data');
plot(sown_area_range_maize, interp_maize, 'r-', 'DisplayName', 'Interpolation Polynomial');
title('Maize Production');
xlabel('Sown Area (hectares)');
ylabel('Production (tons)');
legend;

subplot(3,1,3);
plot(barley_sown, barley_production, 'o', 'DisplayName', 'Original Data');
hold on;
plot(barley_sown_est, arrayfun(@(x) lagrangeInterpolation(x, barley_sown, barley_production), barley_sown_est), '*', 'DisplayName', 'Interpolated Data');
plot(sown_area_range_barley, interp_barley, 'r-', 'DisplayName', 'Interpolation Polynomial');
title('Barley Production');
xlabel('Sown Area (hectares)');
ylabel('Production (tons)');
legend;

% Define the Lagrange interpolation function
function production = lagrangeInterpolation(sown_area, sown_areas, productions)
    n = length(sown_areas);
    production = 0;


end