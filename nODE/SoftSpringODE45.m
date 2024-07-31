% Parameters
m = 1;
k1 = -1;
b = 0.2;
k3 = 1;

% Time span for the simulation
tspan = [0, 100];

% Initial conditions
Y0 = [1; 0]; % y(0) = 0, y'(0) = 1

% Define the ODE function for the damped, driven soft spring
odefun_soft_spring = @(t, Y) [Y(2); -k1/m * Y(1) - k3/m * Y(1)^3 - b/m * Y(2) - 3 * sin(1.1* t)];

% Solve using ode45
[t, Y] = ode45(odefun_soft_spring, tspan, Y0);

% Plot displacement vs. time
figure;
subplot(2, 1, 1);
plot(t, Y(:, 1));
title('Displacement of Damped and Driven Soft Spring');
xlabel('Time');
ylabel('Displacement y');

% Plot phase plane (displacement vs. velocity)
subplot(2, 1, 2);
plot(Y(:, 1), Y(:, 2));
title('Phase Plane Plot of Damped and Driven Soft Spring');
xlabel('Displacement y');
ylabel('Velocity y''');