classdef Individual
   
    properties
        Theta;
        Fitness;
    end
    
     methods
         function obj = Individual()
            obj.Fitness = 0;
        end
         
%         function obj = Individual(Theta)
%             obj.Theta = Theta;
%             obj.Fitness = 0;
%         end
        
        % Input 1x5 matrix, sensorDistances
        % returns [speedR; speedL]
        function differentials = steering(obj, distances)            
            m = size(distances, 1);
            X = [ones(m, 1) distances]; % bias node
            % clamp output in [-alpha, alpha]
            alpha = 1;
            differentials = 2 * alpha * (sigmoid(X*obj.Theta) -  0.5);
        end
     end
end