classdef EXP3<handle
    % EXP 3 strategy for one player
    
    properties
        nbActions
        eta % learning rate
        beta % exploration parameter
        w 
        lastAction
    end
    
    methods
        
        function self = EXP3(eta,beta,nbActions)
 
        end
        
        function self = init(self)
  
        end
        
        function [action] = play(self)
            % chooses the next action
        end
        
        function self = getReward(self,r)
            % r the last rewards recieved by A
         end
                
    end    
end
