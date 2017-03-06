w = World()
r = Robot(10,2,0)

w.plotWorld();
%r.plotRobot();


% All sensor distances
distances = r.getAllSensorDistances(w)

Theta = rand(6,2);

initialPositions = [1 1; 5 2; 10 1.5; 15 2; 18 4; 20 8; 17 9; 10 10.75; 5 10.75; 20 2 ]; 

for i = 1:length(initialPositions)
    r = Robot(initialPositions(i, 1), initialPositions(i, 2), 0);
    r.plotRobot();
end

