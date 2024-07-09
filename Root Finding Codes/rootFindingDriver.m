%%%%%%%%%
% Author: Scott A. Strong w/ GPT4o assistance
% Date: 7/8/24
%
% Summary: This driver file tests various root-finding methods (bisection, 
% Newton, secant, and Muller) on a given function and compares their performance 
% in terms of finding roots and execution time.
%%%%%%%%%

f = @(x) -x.^3+2*x.^2-2;
fPrime = @(x) -3*x.^2+2*2*x;

% f = @(x) x.^2-1;
% fPrime = @(x) 2*x;

%% Cycles Newton at x=0
% f = @(x) x.^3-2*x+2;
% fPrime = @(x) 3*x.^2-2;

% a=-1.77;
% b=-1.76;

a=-5;
b=5;

plotCheck=0;
if plotCheck == 1
 x = linspace(a,b,100);
 plot(x,f(x))
 hold on
 plot(x,fPrime(x))
 plot(x,x-x)
 hold off
end

tol = 1e-6;

MaxIterations=100;

expected_root=0;
x0=-5;
x1=-2;
x2 =-1; 

% Time the fzero method
tic;
expected_root = fzero(f, [a, b]);
time_fzero = toc;
fprintf('fzero found the root at x = %.6f in %.6f seconds\n', expected_root, time_fzero);

tic;
[root, iterations, errors] = bisection(a, b, f, tol, expected_root,false);
time_bisection = toc;
fprintf('Bisection method found the root at x = %.6f after %d iterations in %.6f seconds\n', root, iterations, time_bisection);

tic
[rootNewton, iterationsNewton, errorsNewton] = newton(f, fPrime,x0, tol, expected_root,MaxIterations,false);
time_Newton = toc;
fprintf('Newton method found the root at x = %.6f after %d iterations in %.6f seconds\n', expected_root, iterationsNewton, time_Newton);

tic
[rootSecant, iterationsSecant, errorsSecant] = secant(f, x0,x1, tol, expected_root,MaxIterations,false);
time_Secant = toc;
fprintf('Secant method found the root at x = %.6f after %d iterations in %.6f seconds\n', rootSecant, iterationsSecant, time_Secant);

tic
[rootMuller, iterationsMuller, errorsMuller] = muller(f, x0, x1, x2, tol, expected_root, MaxIterations, true);
time_Muller = toc;
fprintf('Muller method found the root at x = %.6f after %d iterations in %.6f seconds\n', expected_root, iterationsMuller, time_Muller);