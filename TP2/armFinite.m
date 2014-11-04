classdef armFinite<handle
    % arm with finite support
    
    properties
        X % support of the distribution
        P % associated probabilities
        mean % expectation of the arm
        var % variance of the arm 
    end
    
    methods
        function self = armFinite(X,P)
            self.X=X;
            self.P = P;
            self.mean = sum(X.*P);
            self.var = sum(X.^2.*P)-(self.mean).^2;
        end
        
        function [reward] = play(self)
            i=simu(self.P);
            reward = self.X(i);
        end
                
    end    
end