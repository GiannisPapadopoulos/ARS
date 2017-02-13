%settings
numRuns = 1000;

% Minimum is at (1,1) (=0)
rosenbrock2d=@(x, y) 100 .* (x.^2 - y) .^2 + (1 - x).^2;

%  Minimum is at (0, 0)
% Used 20 instead of 10 as the constant to make the global minimum equal to
% 0 and simplify the calculations. We saw some formulation where the first
% term is 10d, with d being the dimensionality
rastrigin2d = @(x, y) 20 + x.^2 - 10 .* cos(2 .* pi .* x) + y.^2 - 10 .* cos(2 .* pi .* y);

%[maxFitness, bestParticle, particles] = runPso(rosenbrock2d);
[maxFitness, bestParticle, particles] = runPso(rastrigin2d);

rasFitness = zeros(numRuns,1);
rasPositions = zeros(numRuns,2);

for i=1:numRuns;
    [maxFitness, bestParticle, particles] = runPso(rastrigin2d);
    rasFitness(i,1) = maxFitness;
    rasPositions(i,1) = bestParticle(1);
    rasPositions(i,2) = bestParticle(2);
end

rasPosX =rasPositions(:,1);
rasPosY =rasPositions(:,2);

figure
scatter(rasPosX,rasPosY)

rasAvg = mean(rasFitness);
rasStandDev = std(rasFitness);


rosFitness = zeros(numRuns,1);
rosPositions = zeros(numRuns,2);

for i=1:numRuns;
    [maxFitness, bestParticle, particles] = runPso(rosenbrock2d);
    rosFitness(i,1) = maxFitness;
    rosPositions(i,1) = bestParticle(1);
    rosPositions(i,2) = bestParticle(2);
end

rosPosX =rosPositions(:,1);
rosPosY =rosPositions(:,2);

figure
scatter(rosPosX,rosPosY)

rosAvg = mean(rosFitness);
rosStandDev = std(rosFitness);


