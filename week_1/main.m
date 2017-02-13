%settings
numRuns = 3

% Minimum is at (1,1) (=0)
rosenbrock2d=@(x, y) 100 .* (x.^2 - y) .^2 + (1 - x).^2;

%  Minimum is at (0, 0)
% Used 20 instead of 10 as the constant to make the global minimum equal to
% 0 and simplify the calculations. We saw some formulation where the first
% term is 10d, with d being the dimensionality
rastrigin2d = @(x, y) 20 + x.^2 - 10 .* cos(2 .* pi .* x) + y.^2 - 10 .* cos(2 .* pi .* y);

[maxFitness, bestParticle, particles] = runPso(rosenbrock2d);
%[maxFitness, bestParticle, particles] = runPso(rastrigin2d);

fitness = zeros(numRuns,1);
positions = zeros(numRuns,2);

for i=1:numRuns;
    [maxFitness, bestParticle, particles] = runPso(rosenbrock2d);
    fitness(i,1) = maxFitness;
    positions(i,1) = bestParticle(1);
    positions(i,2) = bestParticle(2);
end

figure
plot(positions, '*');


