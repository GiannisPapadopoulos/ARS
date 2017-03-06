initialPopulationSize = 100;

ga = GA(initialPopulationSize);

avgFitnessPerGeneration = ga.run(100);

[maxFitness, fittest] = ga.bestFitness()