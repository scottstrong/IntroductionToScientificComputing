function [root, iter, errors] = muller(f, x0, x1, x2, tol, expected_root, MaxIterations, animate)
    n = 1;
    errors = [];

    if animate
        [mullerHandle, predictedRootHandle] = initializePlot(f, x2, f(x2));
    end

    while abs(x2 - x1) >= tol && n < MaxIterations
        if animate
            animateIteration(f, x0, x1, x2, mullerHandle, predictedRootHandle);
            pause(1); % pause to visualize each iteration and delay before updating
        end

        % Move to the next iteration
        h1 = x1 - x0;
        h2 = x2 - x1;
        delta1 = (f(x1) - f(x0)) / h1;
        delta2 = (f(x2) - f(x1)) / h2;
        d = (delta2 - delta1) / (h2 + h1);
        b = delta2 + h2 * d;
        
        % Calculate the argument and D, taking care of complex values
        argument = b^2 - 4 * f(x2) * d;
        if argument < 0
            fprintf('Warning: negative argument for sqrt. Iteration: %d\n', n);
        end
        D = sqrt(abs(argument)); % Use the magnitude of the argument

        if abs(b - D) < abs(b + D)
            E = b + D;
        else
            E = b - D;
        end

        h = -2 * f(x2) / E;
        xNew = x2 + h;

        % Debug output for current state
        % fprintf('Iteration %d:\n', n);
        % fprintf('x0 = %.6f, x1 = %.6f, x2 = %.6f, xNew = %.6f\n', x0, x1, x2, xNew);
        % fprintf('h1 = %.6f, h2 = %.6f, delta1 = %.6f, delta2 = %.6f, d = %.6f, b = %.6f, D = %.6f, E = %.6f, h = %.6f\n', h1, h2, delta1, delta2, d, b, D, E, h);

        x0 = x1;
        x1 = x2;
        x2 = xNew;
        
        % Take the real part if the imaginary part is below tolerance
        if abs(imag(xNew)) < tol
            xNew = real(xNew);
        end
        
        root = xNew;
        n = n + 1;

        % Calculate the error based on function value approaching zero
        errors = [errors; abs((root-expected_root)/expected_root)];
    end

    if animate
        % Mark the converged root with green asterisks
        if abs(x2 - x1) < tol
            plot(x2, f(x2), 'g*', 'MarkerSize', 10);
        end
        hold off;

        % Plot the errors
        figure;
        plot(1:length(errors), errors, 'b-o');
        title('Muller''s Absolute % Error per Iteration');
        xlabel('Iteration');
        ylabel('Error');
        grid on;
    end

    iter = n;
end

function [mullerHandle, predictedRootHandle] = initializePlot(f, x0, f_x0)
    figure;
    hold on;
    fplot(f, [x0-5, x0+5]);
    plot(x0, f_x0, 'ro'); % initial guess
    title('Muller''s Method');
    xlabel('x');
    ylabel('f(x)');

    mullerHandle = plot(nan, nan, 'g--'); % Initialize the line handle
    predictedRootHandle = plot(nan, nan, 'go'); % Initialize the predicted root handle
end

function animateIteration(f, x0, x1, x2, mullerHandle, predictedRootHandle)
    % Calculate and plot the quadratic polynomial
    X = linspace(min([x0, x1, x2]) - 1, max([x0, x1, x2]) + 1, 100);
    h1 = x1 - x0;
    h2 = x2 - x1;
    delta1 = (f(x1) - f(x0)) / h1;
    delta2 = (f(x2) - f(x1)) / h2;
    d = (delta2 - delta1) / (h2 + h1);
    b = delta2 + h2 * d;
    a = d;
    c = f(x2);
    quadratic = a * (X - x2).^2 + b * (X - x2) + c;
    set(mullerHandle, 'XData', X, 'YData', quadratic); % Update the quadratic polynomial

    % Update current iteration point to red
    plot(x2, 0, 'ro'); % Make the previous predicted root red

    % Update predicted root
    set(predictedRootHandle, 'XData', x2, 'YData', 0); % Update the predicted root
    set(predictedRootHandle, 'MarkerEdgeColor', 'g'); % Set the new predicted root to green
end