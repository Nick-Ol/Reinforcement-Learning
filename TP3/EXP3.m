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
            self.nbActions=nbActions;
            self.eta=eta;
            self.beta=beta;
            self.w=ones(1,nbActions);
        end
        
        function self = init(self)
            % initialize weights
            self.w=ones(1,self.nbActions);
        end
        
        function [action] = play(self)
            % chooses the next action
            p=(1-self.beta)*self.w/sum(self.w)+self.beta/self.nbActions;
            action=simu(p);
            self.lastAction=action;
        end
        
        function self = getReward(self,r)
            % r the last rewards received by A
            p=(1-self.beta)*self.w/sum(self.w)+self.beta/self.nbActions;
            self.w(self.lastAction)=self.w(self.lastAction)*exp(self.eta*r/p(self.lastAction));
        end
                
    end    
end
