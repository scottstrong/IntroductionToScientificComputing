% Convergence Rate Analysis Driver File
%%%%%%%%%
% Author: Scott A. Strong w/ GPT4o assistance
% Date: 7/8/24
%
% Summary: This driver file analyzes the convergence rate of various root-finding methods.
%%%%%%%%%

% Define the function and its derivative
% Trial 1
f = @(x) exp(-x) - x;
fPrime = @(x) -exp(-x) - 1;
% Trial 2: Cycles Newton at x=0
% f = @(x) x.^3-2*x+2;
% fPrime = @(x) 3*x.^2-2;
% Trial 3: OG
% f = @(x) -x.^3+2*x.^2-2;
% fPrime = @(x) -3*x.^2+2*2*x;
% Trial 4
f = @(x) (x - 1).^3 - 2 * (x - 1) + 1;
fPrime = @(x) 3 * (x - 1).^2 - 2;


plotCheck=1;


% Initial interval and parameters
% Trial 1
% a = -10;  % Poor interval for bisection method
% b = 10;
% Trial 2
 a=-10;
 b=0;

if plotCheck == 1
 x = linspace(a,b,100);
 plot(x,f(x))
 hold on
 plot(x,fPrime(x))
 plot(x,x-x)
 hold off
end

tol = 1e-240; % Set a very tight tolerance to increase iterations
MaxIterations = 500; % Increase the maximum number of iterations

% Expected root for error calculation
% Trial 1
% expected_root = 0.567143290409784; % Known root of the function exp(-x) - x
% Trial 2
% Time the fzero method
tic;
expected_root = fzero(f, [a, b]);
time_fzero = toc;
fprintf('fzero found the root at x = %.6f in %.6f seconds\n', expected_root, time_fzero);



% Bisection Method
[root_bisection, iterations_bisection, errors_bisection] = bisection(a, b, f, tol, expected_root, MaxIterations, false);

% Newton Method
x0 = 10;  % Poor initial guess for Newton's method
x0=-10; % Trial 2 guess

[root_newton, iterations_newton, errors_newton] = newton(f, fPrime, x0, tol, expected_root, MaxIterations, false);

% Secant Method
x1 = -10; % Poor initial guess for Secant method
x1=-5; % Trial 2 guess
[root_secant, iterations_secant, errors_secant] = secant(f, x0, x1, tol, expected_root, MaxIterations, false);

% Muller Method
x2 = 20;  % Poor initial guess for Muller method
x2 =-1;  % Trial 2 guess
[root_muller, iterations_muller, errors_muller] = muller(f, x0, x1, x2, tol, expected_root, MaxIterations, false);

% Ensure lengths match for plotting
iterations_bisection = length(errors_bisection);
iterations_newton = length(errors_newton);
iterations_secant = length(errors_secant);
iterations_muller = length(errors_muller);

% Small epsilon to avoid log(0) issues
epsilon = 1e-12;

% Calculate alpha for each method using the helper function
alpha_bisection = calculate_alpha(errors_bisection, epsilon);
alpha_newton = calculate_alpha(errors_newton, epsilon);
alpha_secant = calculate_alpha(errors_secant, epsilon);
alpha_muller = calculate_alpha(errors_muller, epsilon);

% Calculate mean and median alpha values
mean_alpha_bisection = mean(alpha_bisection);
median_alpha_bisection = median(alpha_bisection);

mean_alpha_newton = mean(alpha_newton);
median_alpha_newton = median(alpha_newton);

mean_alpha_secant = mean(alpha_secant);
median_alpha_secant = median(alpha_secant);

mean_alpha_muller = mean(alpha_muller);
median_alpha_muller = median(alpha_muller);

% Plot errors vs. iterations for each method
figure;
subplot(4, 1, 1);
semilogy(1:iterations_bisection, abs(errors_bisection), '-o');
title('Bisection Method');
xlabel('Iteration');
ylabel('Absolute Percent Error');
grid on;

subplot(4, 1, 2);
semilogy(1:iterations_newton, abs(errors_newton), '-o');
title('Newton Method');
xlabel('Iteration');
ylabel('Absolute Percent Error');
grid on;

subplot(4, 1, 3);
semilogy(1:iterations_secant, abs(errors_secant), '-o');
title('Secant Method');
xlabel('Iteration');
ylabel('Absolute Percent Error');
grid on;

subplot(4, 1, 4);
semilogy(1:iterations_muller, abs(errors_muller), '-o');
title('Muller Method');
xlabel('Iteration');
ylabel('Absolute Percent Error');
grid on;

% Plot alpha values and mean alpha values for each method
figure;
subplot(4, 1, 1);
plot(3:length(alpha_bisection) + 2, alpha_bisection, '-o');
hold on;
yline(mean_alpha_bisection, 'r--', 'LineWidth', 2, 'Label', ['Mean = ', num2str(mean_alpha_bisection)]);
yline(median_alpha_bisection, 'g--', 'LineWidth', 2, 'Label', ['Median = ', num2str(median_alpha_bisection)]);
title('Alpha Values - Bisection Method');
xlabel('Iteration');
ylabel('Alpha');
legend('Alpha Values', 'Mean Alpha', 'Median Alpha');
grid on;

subplot(4, 1, 2);
plot(3:length(alpha_newton) + 2, alpha_newton, '-o');
hold on;
yline(mean_alpha_newton, 'r--', 'LineWidth', 2, 'Label', ['Mean = ', num2str(mean_alpha_newton)]);
yline(median_alpha_newton, 'g--', 'LineWidth', 2, 'Label', ['Median = ', num2str(median_alpha_newton)]);
title('Alpha Values - Newton Method');
xlabel('Iteration');
ylabel('Alpha');
legend('Alpha Values', 'Mean Alpha', 'Median Alpha');
grid on;

subplot(4, 1, 3);
plot(3:length(alpha_secant) + 2, alpha_secant, '-o');
hold on;
yline(mean_alpha_secant, 'r--', 'LineWidth', 2, 'Label', ['Mean = ', num2str(mean_alpha_secant)]);
yline(median_alpha_secant, 'g--', 'LineWidth', 2, 'Label', ['Median = ', num2str(median_alpha_secant)]);
title('Alpha Values - Secant Method');
xlabel('Iteration');
ylabel('Alpha');
legend('Alpha Values', 'Mean Alpha', 'Median Alpha');
grid on;

subplot(4, 1, 4);
plot(3:length(alpha_muller) + 2, alpha_muller, '-o');
hold on;
yline(mean_alpha_muller, 'r--', 'LineWidth', 2, 'Label', ['Mean = ', num2str(mean_alpha_muller)]);
yline(median_alpha_muller, 'g--', 'LineWidth', 2, 'Label', ['Median = ', num2str(median_alpha_muller)]);
title('Alpha Values - Muller Method');
xlabel('Iteration');
ylabel('Alpha');
legend('Alpha Values', 'Mean Alpha', 'Median Alpha');
grid on;

% Display final results for each method
fprintf('Bisection method found the root at x = %.6f after %d iterations\n', root_bisection, iterations_bisection);
fprintf('Newton method found the root at x = %.6f after %d iterations\n', root_newton, iterations_newton);
fprintf('Secant method found the root at x = %.6f after %d iterations\n', root_secant, iterations_secant);
fprintf('Muller method found the root at x = %.6f after %d iterations\n', root_muller, iterations_muller);

% Display mean and median alpha values for each method
fprintf('Bisection method: Mean Alpha = %.4f, Median Alpha = %.4f\n', mean_alpha_bisection, median_alpha_bisection);
fprintf('Newton method: Mean Alpha = %.4f, Median Alpha = %.4f\n', mean_alpha_newton, median_alpha_newton);
fprintf('Secant method: Mean Alpha = %.4f, Median Alpha = %.4f\n', mean_alpha_secant, median_alpha_secant);
fprintf('Muller method: Mean Alpha = %.4f, Median Alpha = %.4f\n', mean_alpha_muller, median_alpha_muller);

% Function to calculate alpha values
function alpha_values = calculate_alpha(errors, epsilon)
    errors = errors(errors > epsilon); % Filter out errors that are too small
    alpha_values = zeros(1, length(errors) - 2);
    for n = 2:length(errors) - 1
        alpha_values(n-1) = log(abs(errors(n+1) / errors(n))) / log(abs(errors(n) / errors(n-1)));
    end
    alpha_values = alpha_values(isfinite(alpha_values)); % Filter out non-finite values
end