classdef armGaussian<handle
    % arm having a Beta distribution
    
    properties
        mu % expectation vector
        sigma % covariance matrix
    end
    
    methods
        function self = armGaussian(mu,sigma)
            self.mu=mu; 
            self.sigma = sigma;
        end
        
        function [reward] = play(self)
            reward = mvnrnd(self.mu,self.sigma);
        end
                
    end    
end