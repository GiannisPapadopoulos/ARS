initialPopulationSize = 100;

ga = GA(initialPopulationSize);

ga.run(10);

[maxFitness, fittest] = ga.bestFitness()