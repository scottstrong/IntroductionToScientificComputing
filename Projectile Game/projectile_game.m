function projectile_game()
    % Initialize the game
    h0 = input('Enter the initial height of the projectile (h0): ');
    target_x = randi([10, 100]); % Random target between 10 and 100 units
    fprintf('Target is at x = %d units.\n', target_x);
    
    % Initialize the error margin
    error_margin = 0.5; % Allowable margin to hit the target
    
    % Initialize history
    history = [];
    
    % Setup figure for animation
    figure;
    hold on;
    xlabel('Distance (units)');
    ylabel('Height (units)');
    title('Projectile Motion Game');
    plot(target_x, 0, 'rx', 'MarkerSize', 10, 'LineWidth', 2); % Plot the target
    axis([0, 1.2 * target_x, 0, 1.2 * h0 + 1]);
    grid on;
    
    % Game loop
    while true
        % Get user input for v0 and theta
        v0 = input('Enter the initial velocity (v0): ');
        theta_deg = input('Enter the launch angle (theta) in degrees: ');
        theta = deg2rad(theta_deg); % Convert angle to radians
        
        % Calculate the distance using the projectile function
        [dist, x_vals, y_vals] = projectile(v0, theta, h0);
        
        % Store the attempt in history
        history = [history; v0, theta_deg, dist];
        
        % Display history
        fprintf('Previous choices and results:\n');
        for i = 1:size(history, 1)
            fprintf('Attempt %d: v0 = %.2f, theta = %.2f degrees, distance = %.2f units\n', ...
                    i, history(i, 1), history(i, 2), history(i, 3));
        end
        
        % Animate the projectile motion
        animate_projectile(x_vals, y_vals);
        
        % Check if the distance is within the target range
        if abs(dist - target_x) <= error_margin
            fprintf('Congratulations! You hit the target at x = %.2f units.\n', dist);
            break;
        else
            fprintf('You missed! The projectile landed at x = %.2f units.\n', dist);
            if dist < target_x
                fprintf('Try increasing your velocity or angle.\n');
            else
                fprintf('Try decreasing your velocity or angle.\n');
            end
        end
    end
end

function [dist, x_vals, y_vals] = projectile(v0, theta, h0)
    % Find the distance a projectile travels using standard kinematics (no drag)
    % input v0 = initial velocity in magnitude
    % input theta = angle of launch
    % input h0 = initial height of launch
    % output dist = horizontal distance of projectile (assuming flat ground)
    % output x_vals = x positions for animation
    % output y_vals = y positions for animation

    % Use quadForm subfunction to find the times the projectile hits the ground
    % Physics: the quadratic equation is always y(t) = -9.81/2*t^2 + v0*sin(theta)*t + h0
    [t1, t2] = quadForm(-9.81/2, v0*sin(theta), h0);
    tstar = max([t1, t2]); % Find the positive root

    % Calculate the horizontal distance
    dist = v0*cos(theta)*tstar;

    % Generate values for animation
    t_vals = linspace(0, tstar, 100);
    x_vals = v0*cos(theta)*t_vals;
    y_vals = -9.81/2*t_vals.^2 + v0*sin(theta)*t_vals + h0;
end

function [t1, t2] = quadForm(a, b, c)
    % Solve the quadratic equation a*t^2 + b*t + c = 0
    discriminant = b^2 - 4*a*c;
    t1 = (-b + sqrt(discriminant)) / (2*a);
    t2 = (-b - sqrt(discriminant)) / (2*a);
end

function animate_projectile(x_vals, y_vals)
    % Animate the projectile motion
    proj = plot(x_vals(1), y_vals(1), 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b');
    for k = 1:length(x_vals)
        set(proj, 'XData', x_vals(k), 'YData', y_vals(k));
        pause(0.02); % Adjust the pause duration to control the speed of the animation
    end
end