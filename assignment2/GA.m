classdef GA
   properties
       PopulationSize;
       World;
       Individuals;
   end 
    
   methods
       
       function obj = GA(initialPopulationSize)
           obj.PopulationSize = initialPopulationSize;
           obj.World = World();
           obj.Individuals = repmat(Individual(),1,initialPopulationSize);
           for i=1:initialPopulationSize
               % Initialize theta to random values
               theta = rand(6,2);
               obj.Individuals(i).Theta = theta;
           end
       end
       
       function run(obj, numGenerations)
           avgFitnessPerGeneration = zeros(numGenerations , 1);
           for i = 1:numGenerations
               for j = 1: length(obj.Individuals)
                   % TODO
                   % Run for x steps and calculate fitness
                   fitness = simulateAndCalculateFitness(obj, obj.Individuals(j));
                   obj.Individuals(j).Fitness = fitness;
               end
               avgFitnessPerGeneration(i) = obj.averageFitness();
               fittest = obj.doSelection();
               newIndividuals = obj.reproduce(fittest);
               obj.Individuals = newIndividuals;
           end 
           avgFitnessPerGeneration
       end
       
       function fitness = simulateAndCalculateFitness(obj, individuals)
           % random initial positions which don't collide with any walls
           initialPositions = [1 1; 5 2; 10 1.5; 15 2; 18 4; 20 8; 17 9; 10 10.75; 5 10.75; 20 2 ]; 
           r = randi([1 length(initialPositions)],1,1);
           randAngleDeg = rand(1) * 360;
           robot = Robot(initialPositions(r,1), initialPositions(r,2), randAngleDeg);
           fitness = 0;
       end
       
       function sortByFitness(obj)
           [~, ind] = sort([obj.Individuals]);
           obj.Individuals = obj.Individuals(ind);
       end
       
       function selected = doSelection(obj)
           % TODO Return fittest individuals
           selected = obj.Individuals;
       end
       
       function newGeneration = reproduce(obj, fittest)
           % TODO Return fittest individuals
           newGeneration = fittest;
       end
       
       function avgFitness = averageFitness(obj)
           sumFitness = 0;
           for j = 1: length(obj.Individuals)
               sumFitness = sumFitness + obj.Individuals(j).Fitness;
           end
           avgFitness = sumFitness / length(obj.Individuals);
       end
       
       function maxFitness = bestFitness(obj)
           maxFitness = -Inf;
           for j = 1: length(obj.Individuals)
               if obj.Individuals(j).Fitness > maxFitness
                   maxFitness = obj.Individuals(j).Fitness;
               end
           end
       end
       
   end
end