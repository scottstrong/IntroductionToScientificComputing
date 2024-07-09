function [root, iter, errors] = bisection(a, b, f, tol, expected_root, plotFlag)
    % Check if the signs of the function at the endpoints are different
    if f(a) * f(b) >= 0
        error('The function must have different signs at the endpoints a and b.')
    end

    % Initialize variables
    iter = 0;
    errors = []; % Array to store the errors at each iteration

    % Set up the figure for animation if plotFlag is true
    if plotFlag
        figure;
        fplot(f, [a, b]);
        hold on;
        plot([a b], [0 0], 'k--'); % x-axis
        xlim([a b]);
        yUpper = max(f(a),f(b));
        yLower = min(f(a),f(b));
        ylim([yLower, yUpper]);
        title('Bisection Method');
        xlabel('x');
        ylabel('f(x)');
        grid on;
    end

    % Start the bisection loop
    while (b - a) > tol
        % Compute the midpoint
        p = (a + b) / 2;
        fp = f(p);
        
        % Calculate the absolute percent error
        abs_percent_error = abs((p - expected_root) / expected_root) * 100;
        errors = [errors, abs_percent_error]; % Append the error to the array

        % Display iteration information
        % fprintf('Iteration %d: a = %.6f, b = %.6f, p = %.6f, f(p) = %.6f, Error = %.6f%%\n', iter, a, b, p, fp, abs_percent_error);

        % Plot the current interval and midpoint if plotFlag is true
        if plotFlag
            plot([a b], [f(a) f(b)], 'ro-'); % Endpoints
            plot(p, fp, 'bo'); % Midpoint
            pause(0.5); % Pause for animation effect
        end

        % Check if the midpoint is a root
        if fp == 0
            a = p;
            b = p;
            break
        elseif f(a) * fp < 0
            b = p;
        else
            a = p;
        end

        % Increment the iteration count
        iter = iter + 1;
    end

    % The root is the midpoint of the final interval
    root = (a + b) / 2;

    % Highlight the final root on the plot if plotFlag is true
    if plotFlag
        plot(root, f(root), 'g*', 'MarkerSize', 10);
        hold off;
    end

    % Plot errors if plotFlag is true
    if plotFlag
        plotErrors(errors);
    end
end

function plotErrors(errors)
    figure;
    semilogy(errors, 'o-');
    xlabel('Iteration');
    ylabel('Error');
    title('Convergence of Bisection Method');
end