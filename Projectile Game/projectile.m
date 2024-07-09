function dist = projectile(v0, theta, h0)
% Find the distance a projectile travels using standard kinematics (no drag)
% input v0 = initial velocity in magnitude
% input theta = angle of launch
% input h0 = initial height of launch
% output dist = horizontal distance of projectile (assuming flat ground)
    
% Use quadForm subfunction to find the times the projectile hits the ground
% Physics: the quadratic equation is always y(t) = -9.81/2*t^2 + v0*sin(theta)*t + h0
[t1,t2] = quadForm(-9.81/2,v0*sin(theta),h0);

% Now use the built-in "max" command to find the positive root
tstar = max(t1,t2);

% Now find the horizontal distance of the projectile when it hits the ground
% Physics: the equation is always x(t) = v0*cos(theta)*t + x0
dist = v0*cos(theta)*tstar;

end

% Include the subfunction quadForm
function [r1,r2] = quadForm(a,b,c)
% Compute the roots of the quadratic equation a*x^2 + b*x + c
% Inputs: a,b,c: coefficients of quadtratic as described above
% Outuputs: r1, r2: x-values where ax^2+bx+c = 0, r1>r2

d = (b^2-4*a*c);
r1 = (-b+sqrt(d))/(2*a);
r2 = (-b-sqrt(d))/(2*a);

end