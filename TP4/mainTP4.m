%% Creation of the features

d = 20;% number of features
thetasQ  = rand_featureQ(d); 
% matrix thetasQ represents the feature space chosen 
% each line of this matrix is a vector that represents a feature  

% discount parameter
gamma=0.8;

%% How to visualize a linear combination of features?
alpha=ones(1,d);
Q=createQ(alpha,thetasQ);
V = @(s) Q(s,0);
plotf(V) 

%% Fitted Q
Q_fitted = fittedQ(d, 10, gamma, 100);
V_fitted = @(s) Q_fitted(s,0);
plotf(V_fitted) 



