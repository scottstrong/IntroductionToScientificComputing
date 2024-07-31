function [t, y] = vectorRK4(f, range, iv, h)
    % Define the time vector from range(1) to range(2) with step size h
    t = range(1):h:range(2);
    N = length(t); % Number of time steps

    % Initialize the solution matrix y with N rows and length(iv) columns
    y = zeros(N, length(iv));
    y(1, :) = iv; % Set the initial condition

    for i = 1:N-1
        % Compute the four slopes k1, k2, k3, and k4 for the RK4 method
        
        % k1 is the slope at the beginning of the interval
        k1 = h * f(t(i), y(i, :));
        
        % k2 is the slope at the midpoint, using k1 for the intermediate value
        k2 = h * f(t(i) + h/2, y(i, :) + k1/2);
        
        % k3 is another slope at the midpoint, using k2 for the intermediate value
        k3 = h * f(t(i) + h/2, y(i, :) + k2/2);
        
        % k4 is the slope at the end of the interval, using k3 for the intermediate value
        k4 = h * f(t(i) + h, y(i, :) + k3);
        
        % Update the solution for the next time step using the weighted average of the slopes
        y(i+1, :) = y(i, :) + (1/6) * (k1 + 2*k2 + 2*k3 + k4);
    end
end