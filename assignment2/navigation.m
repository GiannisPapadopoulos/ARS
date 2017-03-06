w = World()
r = Robot(10,2,0)

w.plotWorld();
r.plotRobot();

% All sensor distances
distances = r.getAllSensorDistances(w)

Theta = rand(6,2);