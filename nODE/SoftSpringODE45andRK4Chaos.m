% Parameters
m = 1;
k1 = -1;
b = 0.2;
k3 = 5; % Increase the nonlinearity
A = 8; % Increase the driving force amplitude
omega = .76; % Adjust the driving frequency to induce chaos

% Time span for the simulation
tspan = [0, 100];

% Initial conditions
Y0_1 = [1; 0]; % y(0) = 1, y'(0) = 0
Y0_2 = [1.01; 0]; % Slightly different initial condition y(0) = 1.01, y'(0) = 0

% Define the ODE function for the damped, driven soft spring
% First function is for ODE45 (expects column data) 
% Second function is for vectorRK4 (expects row data) 
odefun_soft_spring = @(t, Y) [Y(2); -k1/m * Y(1) - k3/m * Y(1)^3 - b/m * Y(2) + A * sin(omega * t)];
% odefun_soft_spring = @(t, Y) [Y(2), -k1/m * Y(1) - k3/m * Y(1)^3 - b/m * Y(2) + A * sin(omega * t)];

% Solve using ode45 for the first initial condition
[t1, Y1] = ode45(odefun_soft_spring, tspan, Y0_1);
% [t1, Y1] = vectorRK4(odefun_soft_spring, tspan, Y0_1,0.001);

% Solve using ode45 for the second initial condition
[t2, Y2] = ode45(odefun_soft_spring, tspan, Y0_2);
% [t2, Y2] = vectorRK4(odefun_soft_spring, tspan, Y0_2,0.001);
% Plot displacement vs. time for both initial conditions
figure;

% Plot displacement vs. time
subplot(2, 1, 1);
plot(t1, Y1(:, 1), 'b-', 'DisplayName', 'y(0) = 1');
hold on;
plot(t2, Y2(:, 1), 'r--', 'DisplayName', 'y(0) = 1.01');
title('Displacement vs. Time');
xlabel('Time');
ylabel('Displacement y');
legend;
hold off;

% Plot phase plane (displacement vs. velocity)
subplot(2, 1, 2);
plot(Y1(:, 1), Y1(:, 2), 'b-', 'DisplayName', 'y(0) = 1');
hold on;
plot(Y2(:, 1), Y2(:, 2), 'r--', 'DisplayName', 'y(0) = 1.01');
title('Phase Plane Plot');
xlabel('Displacement y');
ylabel('Velocity y''');
legend;
hold off;

% Adjust layout
sgtitle('Comparing Different Initial Conditions with Chaotic Behavior');