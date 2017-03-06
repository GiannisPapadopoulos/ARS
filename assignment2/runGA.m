initialPopulationSize = 100;

ga = GA(initialPopulationSize);

[avgFitnessPerGeneration, stdFitnessPerGeneration] = ga.run(1);

[maxFitness, fittest] = ga.bestFitness()