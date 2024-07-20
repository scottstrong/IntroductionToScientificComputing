% Load data
data = readtable('experience_salary_data.csv');
X = data.YearsExperience;
y = data.Salary;

% Create the design matrix for the least squares problem
n = length(X);
sum_X = sum(X);
sum_X2 = sum(X.^2);
sum_y = sum(y);
sum_Xy = sum(X .* y);

% Form the normal equations matrix A and vector b
A = [n, sum_X; sum_X, sum_X2];
b = [sum_y; sum_Xy];

% Solve the normal equations for b and m
theta = A \ b;
b = theta(1);
m = theta(2);
y_pred = X * m + b;

% Calculating R^2
SS_tot = sum((y - mean(y)).^2);
SS_res = sum((y - y_pred).^2);
R2 = 1 - (SS_res / SS_tot);

% Plotting the data and the LS solution
figure;
scatter(X, y, 'blue', 'filled');
hold on;
plot(X, y_pred, 'red');
title('Salary vs Years of Experience');
xlabel('Years of Experience');
ylabel('Salary');
legend('Actual data', 'LS solution', 'Location', 'Best');
grid on;
text(min(X)+1, max(y)-10000, sprintf('R^2 = %.4f', R2), 'FontSize', 12, 'BackgroundColor', 'white');

% Output R^2 value
R2