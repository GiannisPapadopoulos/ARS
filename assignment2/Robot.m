classdef Robot <handle
    %ROBOT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Position
        Orientation
        SensorPositions
        maxSpeed
        radius
    end
    
    methods
        function obj = Robot(x, y, angle)
            obj.Position = [x;y];
            obj.Orientation = angle;
            obj.SensorPositions = [-40;-20;0;20;40];
            obj.maxSpeed = 0.03;
            obj.radius = 0.5; 
        end
        
        function plotRobot(obj)
            % Plot the robot
            centerX = obj.Position(1);
            centerY = obj.Position(2);
            angle = obj.Orientation;
            % First we plot the body
            robotCircle=rectangle('Position',[obj.Position(1) - obj.radius, obj.Position(2) - obj.radius, obj.radius*2, obj.radius*2],...
                'Curvature',[1,1], 'EdgeColor', 'r');
            % Then the line that points into the direction in which the robot is facing
            robotLine=line([centerX,centerX+obj.radius*cos(deg2rad(angle))], ...
                [centerY,centerY+obj.radius*sin(deg2rad(angle))], 'color','r');
        end
        
        function moveRobotDifferential(obj, speedR, speedL, world)
            speedR = speedR;
            speedL = speedL;
            
            if abs(speedR - speedL) < 1.0e-6
                %move forward
                obj.Position(1) = obj.Position(1) + speedL * cos(deg2rad(obj.Orientation));
                obj.Position(2) = obj.Position(2) + speedR * sin(deg2rad(obj.Orientation));
            else
                %curve radius
                R = (obj.radius) * (speedR + speedL) / (speedR - speedL);
      
                %wdt
                wdt = (speedR - speedL)*0.01 / (2*obj.radius);
                               
                iccx = obj.Position(1) - R * sin(deg2rad(obj.Orientation));
                iccy = obj.Position(2) + R * cos(deg2rad(obj.Orientation));

                newX = cos(wdt) * (obj.Position(1) - iccx) - sin(wdt) * (obj.Position(2) - iccy) + iccx;
                newY = sin(wdt) * (obj.Position(1) - iccx) + cos(wdt) * (obj.Position(2) - iccy) + iccy;
                newAngle = wdt + deg2rad(obj.Orientation);
                
                
                obj.Position(1) = newX;
                obj.Position(2) = newY;
                obj.Orientation = rad2deg(newAngle);
            end
            
            % collDetect(obj, world);
        end
        
        function moveRobotAngle(obj, angle, world)
            if angle ~= 0
                rotateRobot(obj,angle);
            end
            
            dX = cos(deg2rad(obj.Orientation)) * obj.maxSpeed;
            dY = sin(deg2rad(obj.Orientation)) * obj.maxSpeed;
            
            obj.Position(1) = obj.Position(1) + dX;
            obj.Position(2) = obj.Position(2) + dY;
            
            collDetect(obj, world);
        end
        
        
        function rotateRobot(obj, angle)
            %make it turn smoothly later
            obj.Orientation = obj.Orientation + angle;
        end
        
        function isCol = isCollision(obj, world)
            %get intersections of robot square with world
            x = obj.Position(1);
            y = obj.Position(2);
            
            hitboxX = [x-obj.radius x+obj.radius x+obj.radius x-obj.radius x-obj.radius];
            hitboxY = [y-obj.radius y-obj.radius y+obj.radius y+obj.radius y-obj.radius];
            
            [isx, isy] = polyxpoly(world.ObstaclesX, world.ObstaclesY, hitboxX, hitboxY);
            if size(isx) > 0
                %mapshow(isx,isy,'DisplayType','point','Marker','x')
                %error('CRASH! ')
                isCol = 1;            
            else
                isCol = 0;
            end
                
        end
        
        function isInBounds = isInBounds(obj, world)
            x = obj.Position(1);
            y = obj.Position(2);
            bounds = world.Bounds;
            epsilon = 1E-3;
            isInBounds = x >= bounds(1) - epsilon & x <= bounds(2) + epsilon & y >= bounds(3) -epsilon & y <= bounds(4) + epsilon;
        end
        
        function collDetect(obj, world)
            %get intersections of robot square with world
            x = obj.Position(1);
            y = obj.Position(2);
            
            hitboxX = [x-obj.radius x+obj.radius x+obj.radius x-obj.radius x-obj.radius];
            hitboxY = [y-obj.radius y-obj.radius y+obj.radius y+obj.radius y-obj.radius];
            
            [isx, isy] = polyxpoly(world.ObstaclesX, world.ObstaclesY, hitboxX, hitboxY);
            if size(isx) > 0
                mapshow(isx,isy,'DisplayType','point','Marker','x')
                error('CRASH! ')
            end
        end
        
        function distance = getSensorDistance(obj, id, world)
            sightangle = mod(obj.Orientation + obj.SensorPositions(id) , 360);            
            distance = getAngleMeasure(obj,world, sightangle);
        end
        
        function distances = getAllSensorDistances(obj, world)
            distances = zeros(1,5);
            for id=1:5
                sightangle = mod(obj.Orientation + obj.SensorPositions(id) , 360);            
                distance = getAngleMeasure(obj,world, sightangle);
                distances(id) = distance;
                % distances(id) = getSensorDistance(obj, id, world);
            end
            
        end
        
        function angleMeasure = getAngleMeasure(obj, world, sightangle)
            %create polyline for sight
            sightlineX = [obj.Position(1), obj.Position(1) + 100 * cos(deg2rad(sightangle))];
            sightlineY = [obj.Position(2), obj.Position(2) + 100 * sin(deg2rad(sightangle))];
                        
            %get intersections
            [isx, isy] = polyxpoly(world.ObstaclesX, world.ObstaclesY, sightlineX, sightlineY);
            
            %now get and return smallest distance
            %mapshow(isx,isy,'DisplayType','point','Marker','x')
            
            %distances = (norm(([isx - obj.Position(1),isy - obj.Position(2)] )));
            distances = sqrt(sum(abs([isx - obj.Position(1),isy - obj.Position(2)]).^2,2));
            angleMeasure = min(distances);                  
        end
        
    end
    
end

