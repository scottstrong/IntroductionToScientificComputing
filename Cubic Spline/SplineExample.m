% Load the CSV data
data = readtable('nonlinear_pendulum_data_damping2.csv');

% Define the number of samples for each iteration
sample_sizes = [10, 50, 100, 300];
num_data_points = height(data);

% Create a figure for displacement and velocity plots
figure;

for iter = 1:length(sample_sizes)
    num_samples = sample_sizes(iter);

    % Ensure the sample size does not exceed the number of available data points
    if num_samples > num_data_points
        num_samples = num_data_points;
    end

    % Randomly sample the data
    sampled_indices = randperm(num_data_points, num_samples);
    sampled_data = data(sampled_indices, :);

    % Sort the sampled data by time
    sampled_data = sortrows(sampled_data, 'Time');

    % Extract the sampled time and displacement
    time_sampled = sampled_data.Time;
    displacement_sampled = sampled_data.Displacement;

    % Generate the cubic spline interpolation
    time_interp = linspace(min(time_sampled), max(time_sampled), 1000);
    displacement_spline = cubicInterp(time_sampled, displacement_sampled, time_interp);

    % Calculate the derivative of the cubic spline interpolation (velocity)
    velocity_spline = diff(displacement_spline) ./ diff(time_interp);
    time_velocity = time_interp(1:end-1); % Time points corresponding to the velocity

    % Piecewise symbolic differentiation of the cubic spline
    spline_coeffs = spline(time_sampled, displacement_sampled);
    velocity_symbolic_values = zeros(size(time_velocity));

    for i = 1:length(spline_coeffs.breaks)-1
        % Define the current interval
        t_interval = time_velocity >= spline_coeffs.breaks(i) & time_velocity < spline_coeffs.breaks(i+1);
        
        % Extract the coefficients for the current interval
        a = spline_coeffs.coefs(i, 1);
        b = spline_coeffs.coefs(i, 2);
        c = spline_coeffs.coefs(i, 3);
        d = spline_coeffs.coefs(i, 4);
        
        % Symbolically differentiate the polynomial for the current interval
        syms t
        poly = a*(t - spline_coeffs.breaks(i)).^3 + ...
               b*(t - spline_coeffs.breaks(i)).^2 + ...
               c*(t - spline_coeffs.breaks(i)) + ...
               d;
           
        poly_derivative = diff(poly, t);
        poly_derivative_func = matlabFunction(poly_derivative);
        
        % Evaluate the derivative at the time points in the current interval
        velocity_symbolic_values(t_interval) = poly_derivative_func(time_velocity(t_interval));
    end

    % Plot the original, sampled, and interpolated displacement
    subplot(4, 2, 2*iter-1);
    plot(data.Time, data.Displacement, 'k-', 'DisplayName', 'Original Displacement');
    hold on;
    plot(time_sampled, displacement_sampled, 'bo', 'DisplayName', 'Sampled Displacement');
    plot(time_interp, displacement_spline, 'r-', 'DisplayName', 'Interpolated Displacement');
    legend;
    xlabel('Time');
    ylabel('Displacement');
    title(['Displacement: Original vs Interpolated (Sample size ', num2str(num_samples), ')']);
    hold off;

    % Plot the original and interpolated velocity with symbolic differentiation
    subplot(4, 2, 2*iter);
    plot(data.Time, data.Velocity, 'k-', 'DisplayName', 'Original Velocity');
    hold on;
    plot(time_velocity, velocity_spline, 'r-', 'DisplayName', 'Interpolated Velocity');
    plot(time_velocity, velocity_symbolic_values, 'g--', 'DisplayName', 'Symbolic Differentiated Velocity');
    legend;
    xlabel('Time');
    ylabel('Velocity');
    title(['Velocity: Original vs Interpolated (Sample size ', num2str(num_samples), ')']);
    hold off;
end