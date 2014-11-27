classdef EWF<handle
    % EWF strategy for one player
    
    properties
        nbActions
        eta % learning rate
        w % unnormalized weights
        lastAction 
    end
    
    methods
        
        function self = EWF(eta,nbActions)
            self.nbActions=nbActions;
            self.eta=eta;
            self.w=ones(1,nbActions);
        end
        
        function self = init(self)
            % initialize weights
            self.w=ones(1,self.nbActions);
        end
        
        function [action] = play(self)
            % draws from current vector of weights
            % return action chosen and update lastest action of the
            % strategy
            p=self.w/sum(self.w);
            action=simu(p);
            self.lastAction=action;
        end
        
        function self = getReward(self,R)
            % update weight given 
            % warning: R a VECTOR of size nbActions
            self.w=self.w.*exp(self.eta*R);
        end
                
    end    
end
