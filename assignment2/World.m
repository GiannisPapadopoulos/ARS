classdef World
    %WORLD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ObstaclesX;
        ObstaclesY;
        Bounds; % x0, x_max, y_0, y_max
    end
    
    methods
        function obj = World()
            obj.ObstaclesX = [0 21.5 21.5 0    0 NaN 1.5 15.5 15.5 1.5 1.5 NaN 18.5 18.5 18.5];
            obj.ObstaclesY = [0 0    11.5 11.5 0 NaN 4   4    10   10  4   NaN 11.5 6    11.5];
            obj.Bounds = [0, 21.5, 0, 11.5];
        end
        
        function plotWorld(obj)
            plot(obj.ObstaclesX, obj.ObstaclesY);
            
        end
    end
    
end

