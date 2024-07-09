function [root, iter, errors] = secant(f, x0, x1, tol, expected_root, MaxIterations, animate)
% input: 
% f - function handle
% x0 - initial guess
% x1 - second initial guess
% tol - tolerance for stopping condition
% expected_root - known root (for error calculation)
% MaxIterations - maximum number of iterations allowed
% animate - boolean flag to control animation

n = 1;
errors = [];

if animate
    [secantHandle, predictedRootHandle] = initializePlot(f, x0, f(x0));
end

while abs(x1 - x0) >= tol && n < MaxIterations
    if animate
        animateIteration(f, x0, x1, secantHandle, predictedRootHandle);
        pause(1); % pause to visualize each iteration and delay before updating
    end

    % Move to the next iteration
    secantLine = (f(x1) - f(x0)) / (x1 - x0);
    xNew = x1 - f(x1) / secantLine;
    x0 = x1;
    x1 = xNew;
    root = xNew;
    n = n + 1;

    % Calculate the error based on function value approaching zero
    abs_percent_error = abs((root - expected_root) / expected_root) * 100;
    errors = [errors, abs_percent_error ];
end

if animate
    % Mark the converged root with green asterisks
    if abs(x1 - x0) < tol
        plot(x1, f(x1), 'g*', 'MarkerSize', 10);
    end
    hold off;

    % Plot the errors
    figure;
    plot(1:length(errors), errors, 'b-o');
    title('Absolute % Error of Secant per-Iteration');
    xlabel('Iteration');
    ylabel('Error');
    grid on;
end

iter = n;
end

function [secantHandle, predictedRootHandle] = initializePlot(f, x0, f_x0)
    figure;
    hold on;
    fplot(f, [x0-5, x0+5]);
    plot(x0, f_x0, 'ro'); % initial guess
    title('Secant Method Iterations');
    xlabel('x');
    ylabel('f(x)');

    secantHandle = plot(nan, nan, 'g--'); % Initialize the secant line handle
    predictedRootHandle = plot(nan, nan, 'go'); % Initialize the predicted root handle
end

function animateIteration(f, x0, x1, secantHandle, predictedRootHandle)
    % Calculate and plot the secant line
    X = linspace(x0, x1, 100); % range for secant line
    secant = (f(x1) - f(x0)) / (x1 - x0) * (X - x0) + f(x0);
    set(secantHandle, 'XData', X, 'YData', secant); % Update the secant line

    % Update current iteration point to red
    plot(x0, 0, 'ro'); % Make the previous predicted root red

    % Update predicted root
    set(predictedRootHandle, 'XData', x1, 'YData', 0); % Update the predicted root
    set(predictedRootHandle, 'MarkerEdgeColor', 'g'); % Set the new predicted root to green
end