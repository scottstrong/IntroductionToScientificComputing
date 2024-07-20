% Parameters
N = 10;  % Number of terms in Fourier series for initial approximation
M = 100; % Number of terms in Fourier series for detailed approximation
num_samples = 1000;  % Number of samples per cycle
T = 2*pi;  % Period of the sawtooth wave
cycles = 3;  % Number of cycles

% Time vector for three cycles
t = linspace(0, cycles*T, cycles*num_samples);

% Sawtooth wave approximation using 10 terms in Fourier series
sawtooth_approx_10 = zeros(size(t));
for n = 1:N
    sawtooth_approx_10 = sawtooth_approx_10 + (2*(-1)^n / n) * sin(n*t);
end

% Normalize the sawtooth wave to have a maximum displacement of 1
sawtooth_approx_10 = sawtooth_approx_10 / max(abs(sawtooth_approx_10));

% Sawtooth wave approximation using 100 terms in Fourier series
sawtooth_approx_100 = zeros(size(t));
for n = 1:M
    sawtooth_approx_100 = sawtooth_approx_100 + (2*(-1)^n / n) * sin(n*t);
end

% Normalize the sawtooth wave to have a maximum displacement of 1
sawtooth_approx_100 = sawtooth_approx_100 / max(abs(sawtooth_approx_100));

% Randomly sample points from the 10-term approximation
sample_indices = randperm(length(t), length(t));
sampled_t = t(sample_indices);
sampled_sawtooth = sawtooth_approx_10(sample_indices);

% Add noise to the data
max_displacement = max(abs(sawtooth_approx_10));
noise_level = 0.10 * max_displacement;
noisy_t = sampled_t + noise_level * randn(size(sampled_t));
noisy_sawtooth = sampled_sawtooth + noise_level * randn(size(sampled_sawtooth));

% Prepare data for CSV
noisy_data = [noisy_t', noisy_sawtooth'];
unnoised_data = [sampled_t', sampled_sawtooth'];

% Save data to CSV files
noisy_csv_filename = 'noisy_sawtooth_data.csv';
unnoised_csv_filename = 'unnoised_sawtooth_data.csv';
writematrix(noisy_data, noisy_csv_filename);
writematrix(unnoised_data, unnoised_csv_filename);

% Fourier Series Approximation for Noisy Data
% Construct the design matrix A
A_noisy = zeros(length(noisy_t), 2*N);
for k = 1:N
    A_noisy(:, k) = cos(k*noisy_t);
    A_noisy(:, N+k) = sin(k*noisy_t);
end

% Solve the linear system A_noisy * c = noisy_sawtooth
c_noisy = A_noisy \ noisy_sawtooth';

% Extract the Fourier coefficients
a_noisy = c_noisy(1:N);
b_noisy = c_noisy(N+1:end);

% Reconstruct the Fourier series approximation from noisy data
f_noisy_approx = zeros(size(t));
for k = 1:N
    f_noisy_approx = f_noisy_approx + a_noisy(k) * cos(k*t) + b_noisy(k) * sin(k*t);
end



% Plot the results
figure;

% First subplot: Comparison of 10-term and 100-term Fourier approximations
subplot(3,1,1);
plot(t, sawtooth_approx_10, 'b', 'LineWidth', 1.5);
hold on;
plot(t, sawtooth_approx_100, 'g', 'LineWidth', 1.5);
title('Fourier Approximation of Sawtooth Wave: 10 terms vs 100 terms');
xlabel('Time');
ylabel('Amplitude');
legend('10 terms', '100 terms');
grid on;

% Second subplot: Least Squares Approximation from Noisy Data
subplot(3,1,2);
plot(t, sawtooth_approx_10, 'b', 'LineWidth', 1.5);
hold on;
plot(t, f_noisy_approx, 'g', 'LineWidth', 1.5);
scatter(noisy_t, noisy_sawtooth, 10, 'r', 'filled');
title('Least Squares Approximation from Noisy Data');
xlabel('Time');
ylabel('Amplitude');
legend('Original Fourier Approximation', 'Least Squares Approximation', 'Noisy Samples');
grid on;

% Third subplot: Comparison of 10-term Fourier Approximation and LS Approximation
subplot(3,1,3);
plot(t, sawtooth_approx_10, 'b', 'LineWidth', 1.5);
hold on;
plot(t, f_noisy_approx, 'g', 'LineWidth', 1.5);
title('Comparison of 10-term Approximation and LS Solution');
xlabel('Time');
ylabel('Amplitude');
legend('10-term Fourier Approximation', 'Least Squares Approximation');
grid on;

% Display message
disp(['Noisy data has been saved to ' noisy_csv_filename]);
disp(['Unnoised data has been saved to ' unnoised_csv_filename]);