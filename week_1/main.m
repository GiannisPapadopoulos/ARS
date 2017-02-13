% Minimum is at (1,1) (=0)
rosenbrock2d=@(x) 100 .* (x(1).^2 - x(2)) .^2 + (1 - x(1)).^2;
rosenbrock2d=@(x, y) 100 .* (x.^2 - y) .^2 + (1 - x).^2;
[maxFitness, bestParticle, particles] = runPso(rosenbrock2d);

