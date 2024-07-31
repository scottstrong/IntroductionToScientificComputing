% Define the parameters
m = 1; % mass
k = 1; % spring constant

% Time span for the simulation
tspan = [0, 20];

% Define the ODE function for undriven oscillator (f(t) = 0)
odefun = @(t, Y, gamma) [Y(2); -k/m * Y(1) - gamma/m * Y(2)];

% Initial conditions
Y0 = [1; 0]; % initial displacement and initial velocity

% Different damping coefficients
gammas = [0, 0.1, 2, 3]; % undamped, underdamped, critically damped, overdamped

figure;
hold on;

% Solve and plot for different damping coefficients
for i = 1:length(gammas)
    gamma = gammas(i);
    [t, Y] = ode45(@(t, Y) odefun(t, Y, gamma), tspan, Y0);
    plot(Y(:, 1), Y(:, 2), 'DisplayName', ['\gamma = ', num2str(gamma)]);
end

title('Phase Plane Plot for Different Damping Coefficients');
xlabel('Displacement y');
ylabel('Velocity y''');
legend;
hold off;