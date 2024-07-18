% Title:   Lagrange interpolation and estimating crop production
% Type:    Solution file
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


%%%% STEP 1: At the bottom of this code is a function that will calculate
%%%% the Lagrange interpolating polynomial. It is currently blank and you
%%%% should fill it in with your LIP code. 

% Load table 1 from paper from CSV file
% We will use this table to form our interpolations
data = readtable('crop_data.csv');

% Extract columns into separate variables
years = data.Year; % Note, this will not be needed. 
wheat_sown = data.Wheat_Sown;
wheat_production = data.Wheat_Production;
maize_sown = data.Maize_Sown;
maize_production = data.Maize_Production;
barley_sown = data.Barley_Sown;
barley_production = data.Barley_Production;
rye_sown = data.Rye_Sown;
rye_production = data.Rye_Production;
oats_sown = data.Oats_Sown;
oats_production = data.Oats_Production;



% Generate a range of sown areas for plotting the interpolation polynomial
sown_area_range_wheat = linspace(min(wheat_sown), max(wheat_sown), 1000);
sown_area_range_maize = linspace(min(maize_sown), max(maize_sown), 1000);
sown_area_range_barley = linspace(min(barley_sown), max(barley_sown), 1000);
sown_area_range_rye = linspace(min(rye_sown), max(rye_sown), 1000);
sown_area_range_oats = linspace(min(oats_sown), max(oats_sown), 1000);

% Calculate interpolated production values for plotting
% STEP 2: In this location complete the command snipits and call 
interp_wheat = ;
interp_maize = ;
interp_barley = ;
interp_rye = ;
interp_oats = ;

% Load the paper's estimates from their interpolations from CSV file
paper_product_interpolations = readtable('crop_data_interpolated.csv');

paper_wheat_sown = paper_product_interpolations.wheat_sown;
paper_wheat_production_interpolation = paper_product_interpolations.wheat_produced_est;
paper_maize_sown = paper_product_interpolations.maize_sown;
paper_maize_production_interpolation = paper_product_interpolations.maize_produced_est;
paper_barley_sown = paper_product_interpolations.barley_sown;
paper_barley_production_interpolation = paper_product_interpolations.barley_produced_est;
paper_rye_sown = paper_product_interpolations.rye_sown;
paper_rye_production_interpolation = paper_product_interpolations.rye_produced_est;
paper_oats_sown = paper_product_interpolations.oats_sown;
paper_oats_production_interpolation = paper_product_interpolations.oats_produced_est;

% STEP 3: Using the sown data which the paper estimates the production
% using their interpolations, complete the following code snipits to use
% our interpolations to define estimates. 

us_wheat_production_interpolation = ;
us_maize_production_interpolation =  ;
us_barley_production_interpolation = ;
us_rye_production_interpolation = ;
us_oats_production_interpolation = ;

% Define the Lagrange interpolation polynomials as functions
% COMMENT THESE LINES OUT TO TAKE OUT PAPER INTERPOLATING POLYNOMIALS
% YOU WILL GET ERRORS, BUT THE REST WILL BE RENDERED
wheat_poly = @(x) 3.2194e-17*x.^4 - 2.8938e-10*x.^3 + 0.00097012*x.^2 - 1436.9576*x + 793926608.77;
maize_poly = @(x) -1.0005e-15*x.^4 + 1.903e-09*x.^3 - 0.0013241*x.^2 + 401.8973*x - 44546355.4122;
barley_poly = @(x) 3.718e-14*x.^4 - 3.683e-07*x.^3 + 1.3656*x.^2 - 2247058.379*x + 1384545405346.58;
rye_poly = @(x) 3.14158e-13*x.^4 - 8.2442e-08*x.^3 + 0.00798*x.^2 - 336.812*x + 5224527.211;
oats_poly = @(x) -7.438e-12*x.^4 + 1.641e-06*x.^3 - 0.13404*x.^2 + 4809.7877*x - 64111377.455;

% Plot the original data points, interpolated points, and interpolation polynomial
figure;
subplot(3,2,1);
plot(wheat_sown, wheat_production, 'o', 'DisplayName', 'Original Data');
hold on;
plot(paper_wheat_sown, paper_wheat_production_interpolation, '*', 'DisplayName', 'Interpolated (Paper)');
plot(paper_wheat_sown, us_wheat_production_interpolation, 'x', 'DisplayName', 'Interpolated (US)');
plot(sown_area_range_wheat, interp_wheat, 'r-', 'DisplayName', 'Interpolation Polynomial');
fplot(wheat_poly, [min(sown_area_range_wheat), max(sown_area_range_wheat)], 'b--', 'DisplayName', 'Paper Polynomial');
title('Wheat Production');
xlabel('Sown Area (hectares)');
ylabel('Production (tons)');
legend('Location', 'southeast')

subplot(3,2,2);
plot(maize_sown, maize_production, 'o', 'DisplayName', 'Original Data');
hold on;
plot(paper_maize_sown, paper_maize_production_interpolation, '*', 'DisplayName', 'Interpolated (Paper)');
plot(paper_maize_sown, us_maize_production_interpolation, 'x', 'DisplayName', 'Interpolated (US)');
plot(sown_area_range_maize, interp_maize, 'r-', 'DisplayName', 'Interpolation Polynomial');
fplot(maize_poly, [min(sown_area_range_maize), max(sown_area_range_maize)], 'b--', 'DisplayName', 'Paper Polynomial');
title('Maize Production');
xlabel('Sown Area (hectares)');
ylabel('Production (tons)');
legend('Location', 'northwest')

subplot(3,2,3);
plot(barley_sown, barley_production, 'o', 'DisplayName', 'Original Data');
hold on;
plot(paper_barley_sown, paper_barley_production_interpolation, '*', 'DisplayName', 'Interpolated (Paper)');
plot(paper_barley_sown, us_barley_production_interpolation, 'x', 'DisplayName', 'Interpolated (US)');
plot(sown_area_range_barley, interp_barley, 'r-', 'DisplayName', 'Interpolation Polynomial');
fplot(barley_poly, [min(sown_area_range_barley), max(sown_area_range_barley)], 'b--', 'DisplayName', 'Paper Polynomial');
title('Barley Production');
xlabel('Sown Area (hectares)');
ylabel('Production (tons)');
legend('Location', 'southwest')

subplot(3,2,4);
plot(rye_sown, rye_production, 'o', 'DisplayName', 'Original Data');
hold on;
plot(paper_rye_sown, paper_rye_production_interpolation, '*', 'DisplayName', 'Interpolated (Paper)');
plot(paper_rye_sown, us_rye_production_interpolation, 'x', 'DisplayName', 'Interpolated (US)');
plot(sown_area_range_rye, interp_rye, 'r-', 'DisplayName', 'Interpolation Polynomial');
fplot(rye_poly, [min(sown_area_range_rye), max(sown_area_range_rye)], 'b--', 'DisplayName', 'Paper Polynomial');
title('Rye Production');
xlabel('Sown Area (hectares)');
ylabel('Production (tons)');
legend('Location', 'northwest')

subplot(3,2,5);
plot(oats_sown, oats_production, 'o', 'DisplayName', 'Original Data');
hold on;
plot(paper_oats_sown, paper_oats_production_interpolation, '*', 'DisplayName', 'Interpolated (Paper)');
plot(paper_oats_sown, us_oats_production_interpolation, 'x', 'DisplayName', 'Interpolated (US)');
plot(sown_area_range_oats, interp_oats, 'r-', 'DisplayName', 'Interpolation Polynomial');
fplot(oats_poly, [min(sown_area_range_oats), max(sown_area_range_oats)], 'b--', 'DisplayName', 'Paper Polynomial');
title('Oats Production');
xlabel('Sown Area (hectares)');
ylabel('Production (tons)');
legend('Location', 'northwest')

% Define the Lagrange interpolation function
% STEP 1: Complete this LIP code. You should be able to use your code
% directly. 
function p = lagrangeInterpolation(x, y, z)
    
% Fill this in

end