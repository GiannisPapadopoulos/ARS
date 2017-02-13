syms x;
syms y;
rosenbrock=@(x, y) 100 .* (x.^2 - y) .^2 + (1 - x).^2;
rosenfx = @(x,y) 2*x - 400*x*(- x^2 + y) - 2;
rosenfy = @(x,y) - 200*x^2 + 200*y;

rastrigin = @(x, y) 20 + x.^2 - 10 .* cos(2 .* pi .* x) + y.^2 - 10 .* cos(2 .* pi .* y);
rastriginfx = @(x,y) 2*x + 20*pi*sin(2*pi*x);
rastriginfy = @(x,y) 2*y + 20*pi*sin(2*pi*y);

%runGradientDescent(rosenbrock, rosenfx, rosenfy, 0.00001);
runGradientDescent(rastrigin, rastriginfx, rastriginfy, 0.00001);