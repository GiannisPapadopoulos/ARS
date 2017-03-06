classdef GA <handle
   properties
       PopulationSize;
       NumSteps; % Used to evaluate each individual
       World;
       Individuals;
   end 
    
   methods
       
       function obj = GA(initialPopulationSize)
           obj.PopulationSize = initialPopulationSize;
           obj.World = World();
           obj.NumSteps = 50;
           obj.Individuals = repmat(Individual(),1,initialPopulationSize);
           for i=1:initialPopulationSize
               % Initialize theta to random values
               theta = rand(6,2);
               obj.Individuals(i).Theta = theta;
           end
       end
       
       function avgFitnessPerGeneration = run(obj, numGenerations)
           avgFitnessPerGeneration = zeros(1, numGenerations);
           for i = 1:numGenerations
               i
               for j = 1: length(obj.Individuals)
                   fitness = simulateAndCalculateFitness(obj, obj.Individuals(j));
                   obj.Individuals(j).Fitness = fitness;
               end
               avgFitnessPerGeneration(i) = obj.averageFitness()
               obj.bestFitness()
               fittest = obj.doSelection();
               if i < numGenerations
                   newIndividuals = obj.reproduce(fittest);
                   obj.Individuals = newIndividuals;
               end
           end 
           avgFitnessPerGeneration
       end
       
       function fitness = simulateAndCalculateFitness(obj, individual)
           % random initial positions which don't collide with any walls
           initialPositions = [1 1; 5 2; 10 1.5; 15 2; 18 4; 20 8; 17 9; 10 10.75; 5 10.75; 20 2 ]; 
           r = randi([1 length(initialPositions)],1,1);
           randAngleDeg = rand(1) * 360;
           robot = Robot(initialPositions(r,1), initialPositions(r,2), randAngleDeg);
           avgSpeed = 0;
           numCollisions = 0;
           for i = 0:obj.NumSteps
               pos = robot.Position;
               differentials = individual.steering(robot.getAllSensorDistances(obj.World));
               robot.moveRobotDifferential(differentials(1), differentials(2), obj.World);
               if robot.isCollision(obj.World)
                   numCollisions = numCollisions + 1;
                   % Reset to a safe position
                    r = randi([1 length(initialPositions)],1,1);
                    randAngleDeg = rand(1) * 360;
                    robot.Position = [initialPositions(r,1), initialPositions(r,2)];
                    robot.Orientation = randAngleDeg;
               else
                    deltaPos = robot.Position - pos;
                    speed = norm(deltaPos);
                    avgSpeed = avgSpeed + speed / obj.NumSteps;
               end
           end
           fitness = (obj.NumSteps - numCollisions) * avgSpeed;
       end
       
       function sortByFitness(obj)
           individuals = [obj.Individuals];
           [~, ind] = sort([individuals.Fitness]);
           obj.Individuals = individuals(ind);
       end
       
       function selected = doSelection(obj)
           %TODO Should I still sort or is this already done?
           sortByFitness(obj);
           
           %Return the top 10 percent
           
           
           % TODO Return fittest individuals
           
           selected = obj.Individuals(1:length(obj.Individuals) / 10);
           %from = size(obj.Individuals,2)/10;
           %selected(from:size(obj.Individuals)) = [];  %the [] value is the matlab equivalent of null for an object
       end
       
       function newGeneration = reproduce(obj, fittest)
           numOffspring = length(obj.Individuals) / length(fittest);
           newGeneration = repmat(Individual(),1,obj.PopulationSize);
           k = 1;
           for i = 1 : length(fittest)
               theta = fittest(i).Theta;
               for j = 1 : numOffspring
                   % Random values in [-0.1, 0.1]
                   mutation = rand(6,2) * 0.2 - 0.1;
                   mutatedTheta = theta + mutation;
                   newGeneration(k).Theta = mutatedTheta;
                   k = k + 1;
               end
           end
       end
       
       function avgFitness = averageFitness(obj)
           sumFitness = 0;
           for j = 1: length(obj.Individuals)
               sumFitness = sumFitness + obj.Individuals(j).Fitness;
           end
           avgFitness = sumFitness / length(obj.Individuals);
       end
       
       function [maxFitness, fittest] = bestFitness(obj)
           maxFitness = -Inf;
           fittest = Individual();
           for j = 1: length(obj.Individuals)
               if obj.Individuals(j).Fitness > maxFitness
                   maxFitness = obj.Individuals(j).Fitness;
                   fittest = obj.Individuals(j);
               end
           end
       end
       
   end
end