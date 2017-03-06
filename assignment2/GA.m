classdef GA
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
           obj.NumSteps = 30;
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
                   fitness = 0;
                   obj.Individuals(j).Fitness = fitness;
               end
               avgFitnessPerGeneration(i) = obj.averageFitness();
               fittest = obj.doSelection();
               newIndividuals = obj.reproduce(fittest);
               obj.Individuals = newIndividuals;
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
                    avgSpeed = speed / obj.NumSteps;
               end
           end
           fitness = (obj.NumSteps - numCollisions) * avgSpeed;
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