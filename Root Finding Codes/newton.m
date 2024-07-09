function [root, iter, errors] = newton(f, fPrime, x0, tol, expected_root, MaxIterations, animate)
% input: 
% f - function handle
% fPrime - derivative of the function handle
% x0 - initial guess
% tol - tolerance for stopping condition
% expected_root - known root (for error calculation)
% MaxIterations - maximum number of iterations allowed
% animate - boolean flag to control animation

xOld = x0;
xNew = xOld - f(xOld)/fPrime(xOld);
n = 1;
errors = [];

if animate
    [tangentHandle, predictedRootHandle] = initializePlot(f, x0, f(xOld));
end

while abs(xNew - xOld) >= tol && n < MaxIterations
    if animate
        animateIteration(f, fPrime, xOld, xNew, tangentHandle, predictedRootHandle);
        pause(1); % pause to visualize each iteration and delay before updating
    end

    % Move to the next iteration
    xOld = xNew;
    n = n + 1;
    xNew = xOld - f(xOld)/fPrime(xOld);
    root = xNew;

    % Calculate the error based on function value approaching zero
    abs_percent_error = abs((root - expected_root) / expected_root) * 100;
    errors = [errors, abs_percent_error];
end

if animate
    % Mark the converged root with green asterisks
    if abs(xNew - xOld) < tol
        plot(xNew, f(xNew), 'g*', 'MarkerSize', 10);
    end
    hold off;

    % Plot the errors
    figure;
    plot(1:length(errors), errors, 'b-o');
    title('Absolute % Error of Newton per-Iteration');
    xlabel('Iteration');
    ylabel('Error');
    grid on;
end

iter = n;
end

function [tangentHandle, predictedRootHandle] = initializePlot(f, x0, f_x0)
    figure;
    hold on;
    fplot(f, [x0-5, x0+5]);
    plot(x0, f_x0, 'ro'); % initial guess
    title('Newton''s Method Iterations');
    xlabel('x');
    ylabel('f(x)');

    tangentHandle = plot(nan, nan, 'g--'); % Initialize the tangent line handle
    predictedRootHandle = plot(nan, nan, 'go'); % Initialize the predicted root handle
end

function animateIteration(f, fPrime, xOld, xNew, tangentHandle, predictedRootHandle)
    % Calculate and plot the tangent line
    X = linspace(xOld-1, xOld+1, 100); % range for tangent line
    tangent = f(xOld) + fPrime(xOld) * (X - xOld);
    set(tangentHandle, 'XData', X, 'YData', tangent); % Update the tangent line

    % Update current iteration point to red
    plot(xOld, 0, 'ro'); % Make the previous predicted root red

    % Update predicted root
    set(predictedRootHandle, 'XData', xNew, 'YData', 0); % Update the predicted root
    set(predictedRootHandle, 'MarkerEdgeColor', 'g'); % Set the new predicted root to green
end