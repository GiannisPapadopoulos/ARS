classdef GA
   properties
        World
        Individuals;
   end 
    
   methods
       
       function obj = GA(initialPopulationSize)
           obj.World = World();
           obj.Individuals = repmat(Individual(),1,initialPopulationSize);
           for i=1:initialPopulationSize
               % Initialize theta to random values
               theta = rand(6,2);
               obj.Individuals(i).Theta = theta;
           end
       end
       
       function run(obj, numGenerations)
           for i = 1:numGenerations
               for j = 1: length(obj.Individuals)
                   % TODO
                   % Run for x steps and calculate fitness
               end
               fittest = obj.doSelection();
               newIndividuals = reproduce(fittest);
               obj.Individuals = newIndividuals;
           end 
       end
       
       function selected = doSelection(obj)
           % TODO Return fittest individuals
       end
       
       function newGeneration = reproduce(obj)
           % TODO Return fittest individuals
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