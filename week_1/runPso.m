function [maxFitness, bestParticle, particles] = runPso(func)
    % Delay between each step, to better visialize the particles' movement
    delay=0.01;
    
    % The formulation is as a maximization problem, so we negate the
    % function
    fitnessFunc = @(x,y) -func(x,y);

    % A particle is represented as:
    % [x, y, vx, vy pbx, pby, pbestFitness, gbx, gby] 

    % Limit the space to finite values for initialization [xmin, xmax,
    % ymin, ymax]
    range = [-10, 10, -10, 10];
    vRange = [-10,10];

    numIterations = 50;
    numParticles = 40;
    neighborhoodSize = numParticles - 1;
    
    % Weights for velocity update
    alpha = 0.3;
    beta = 0.3;
    gamma = 0.3;

    % Matrix of size numParticles x 9
    % Columns 1 and 2 are the particle's current position
    % Columns 3 and 4 are the current velocity
    % Columns 5 and 6 are pbest
    % Column 7 is F(pbest)
    % Columns 8 and 9 are gbest for the current iteration
    particles = zeros(numParticles,9);
    
    
    % Initialize particles
    for i=1:numParticles
        particles(i, 1:2) = [randDouble(range(1), range(2)), randDouble(range(3), range(4))];
        particles(i, 3:4) = [randDouble(vRange(1), vRange(2)), randDouble(vRange(1), vRange(2))];
        % The best position seen so far at iteration 0 is the current
        % position
        particles(i, 5:6) = particles(i, 1:2);
        particles(i, 7) = fitnessFunc(particles(i,1), particles(i,2));
    end
      
        
    %plot(particles(:,1:2),'rx');
    
    bestNeighbors = findBestNeighbors(particles, fitnessFunc, neighborhoodSize);
    [maxFitness, bestParticle] = findBestParticle(particles, fitnessFunc);
    
%             f = @(x,y) (1-x).^2 + 100*(y-x.^2).^2;
% 
%         x = linspace(-10,10); y = linspace(-10,10);
%         [xx,yy] = meshgrid(x,y); ff = f(xx,yy);

    for i=1:numIterations
        pause(delay);
        bestNeighbors= findBestNeighbors(particles, fitnessFunc, neighborhoodSize);
        particles(:,8:9) = bestNeighbors(:,1:2);
        % Update velocity
        r = rand(numParticles,1);
        r(:,2) = r(:,1);
        particles(:,3:4) =  alpha * particles(:,3:4)  + beta * r .* (particles(:,5:6) - particles(:,1:2))   + gamma * (1-r) .* (particles(:,8:9) - particles(:,1:2));
       
        for j=1:numParticles
            % Update personal best positions
            fitnessValue = fitnessFunc(particles(j,1), particles(j,2));
            if fitnessValue > particles(j,7)
                particles(j,7) = fitnessValue;
                particles(j,5:6) = particles(j,1:2);
            end
        end
        % Update positions
        particles(:,1:2) = particles(:,1:2) + particles(:,3:4);
        
        [maxFitness, bestParticle] = findBestParticle(particles, fitnessFunc);
        particles;
        i, maxFitness
%         hold off;
%         plot(particles(:,1), particles(:,2),'rx');
%         hold on;
%         plot([-10,10],[1,1],'b');
%         plot([1,1],[-10,10],'b');
        plotPso(particles, func)
        

%         levels = 10:10:300;
%         LW = 'linewidth'; FS = 'fontsize'; MS = 'markersize';
%         contour(x,y,ff,levels,LW,1.2), colorbar
%         %axis([-1.5 1.5 -1 3])
%         axis square;
    end;
    [maxFitness, bestParticle] = findBestParticle(particles, fitnessFunc);
    maxFitness
    'best particle', bestParticle(1:2)
    
end

function [] = plotPso(particles, func)
    hold off;
    limits = [-10,10];
    ezsurf(func);
    hold on;
    for i = 1:length(particles)
        % plot(particles(i,1),particles(i,2),'r.','MarkerSize',20);
        x = particles(i,1);
        y = particles(i,2);
        plot3(x,y,func(x,y),'r.','MarkerSize',20);
    end
    % cameratoolbar;
    % cameratoolbar('SetMode','orbit');
    rotate3d on;
    view(15,60);
end

% Returns a real value in [low, high)
function [d] = randDouble(low, high)
    d = rand(1) * (high-low) + low;
end

% Returns for each particle the the best neighbor
function [neighbors] = findBestNeighbors(particles, fitnessFunc, neighborhoodSize )
    neighbors = zeros(size(particles));
    positions = particles(:,1:2);
     % The first neighbor found will be the particle itself (distance
     % 0), hence we find k+1 and ignore it
    idx = knnsearch(positions, positions, 'k', neighborhoodSize+1);
    for i=1:length(particles)
        bestNeighborFitness = -inf;
        for j=2:neighborhoodSize+1
            neighbor = particles(idx(i,j),:);
            neighborFitness = fitnessFunc(neighbor(1), neighbor(2));
            if neighborFitness > bestNeighborFitness
                bestNeighborFitness = neighborFitness;
                neighbors(i,:) = neighbor;
            end
        end
    end
end

function [maxFitness, bestParticle] = findBestParticle(particles, fitnessFunc)
    maxFitness = -inf;
    for i=1:length(particles)
        particle=particles(i,:);
        fitnessValue = fitnessFunc(particle(1), particle(2));
        if fitnessValue > maxFitness
            maxFitness=fitnessValue;
            bestParticle=particle;
        end
    end
end


