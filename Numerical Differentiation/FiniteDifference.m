% Define the function and its derivative
f = @(x) exp(x);
f_prime = @(x) exp(x);

% Point at which to evaluate the derivative
x0 = 1.0;

% Exact value of the derivative at x0
exact_derivative = f_prime(x0);

% Initialize the array for h values
h = logspace(0, -16, 100);

% Initialize arrays for the forward, backward, and central difference errors
forward_error = zeros(size(h));
backward_error = zeros(size(h));
central_error = zeros(size(h));

% Calculate the errors for each h
for i = 1:length(h)
    h_i = h(i);
    
    % Forward difference approximation
    forward_diff = (f(x0 + h_i) - f(x0)) / h_i;
    forward_error(i) = abs((forward_diff - exact_derivative) / exact_derivative) * 100;

    % Backward difference approximation
    backward_diff = (f(x0) - f(x0 - h_i)) / h_i;
    backward_error(i) = abs((backward_diff - exact_derivative) / exact_derivative) * 100;
    
    % Central difference approximation
    central_diff = (f(x0 + h_i) - f(x0 - h_i)) / (2 * h_i);
    central_error(i) = abs((central_diff - exact_derivative) / exact_derivative) * 100;
end

% Log-log plot of the absolute percent errors
figure;
loglog(h, forward_error, 'r', 'DisplayName', 'Forward Difference');
%xticklabels([1:10]) %an example 
set ( gca, 'xdir', 'reverse' )
hold on;
loglog(h, central_error, 'b', 'DisplayName', 'Central Difference');
loglog(h, backward_error, 'g', 'DisplayName', 'Backward Difference');
xlabel('h');
ylabel('Absolute Percent Error (%)');
title('Absolute Percent Error in Finite Difference Approximations (Log-Log Plot)');
legend;

% Highlight the point where errors start increasing in log-log plot
[~, min_forward_idx] = min(forward_error);
[~, min_central_idx] = min(central_error);
[~, min_backward_idx] = min(backward_error);

loglog(h(min_forward_idx), forward_error(min_forward_idx), 'ro', 'MarkerFaceColor', 'r');
loglog(h(min_central_idx), central_error(min_central_idx), 'bo', 'MarkerFaceColor', 'b');
loglog(h(min_backward_idx), backward_error(min_backward_idx), 'go', 'MarkerFaceColor', 'g');

text(h(min_forward_idx), forward_error(min_forward_idx)*2, 'Forward min error', 'HorizontalAlignment', 'left');
text(h(min_central_idx), central_error(min_central_idx)*2, 'Central min error', 'HorizontalAlignment', 'left');
text(h(min_backward_idx), backward_error(min_backward_idx)*2, 'Backward min error', 'HorizontalAlignment', 'left');

hold off;