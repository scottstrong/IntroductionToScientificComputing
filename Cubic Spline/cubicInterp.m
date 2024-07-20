function s = cubicInterp(x,y,z)

x = x(:); y = y(:); z = z(:);

n = length(x)-1;

h = zeros(n,1);
A = zeros(n+1,n+1);
RHS = zeros(n+1,1);
b = zeros(n,1);
d = zeros(n,1);

for i = 1:n
    h(i) = x(i+1)-x(i);
end

A(1,1) = 1;
A(n+1,n+1) = 1;
for i = 2:n
    A(i,i) = 2*(h(i-1)+h(i));
    A(i,i+1) = h(i);
    A(i,i-1) = h(i-1);
    RHS(i) = 3*(y(i+1)-y(i))/h(i)-3*(y(i)-y(i-1))/h(i-1);
end
RHS
c = A\RHS;

for i = 1:n
    d(i) = (c(i+1)-c(i))/(3*h(i));
    b(i) = (y(i+1)-y(i))/h(i) - (2*c(i)+c(i+1))*h(i)/3;
end

for k = 1:length(z)
    i = discretize(z(k),x);
    s(k) = y(i) + b(i)*(z(k)-x(i)) + c(i)*(z(k) - x(i))^2 + d(i)*(z(k) - x(i))^3;
end

end