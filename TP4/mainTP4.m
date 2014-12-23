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
figure(1);
plotf(V)

%% Fitted Q
[Q_fitted, alpha_fitted] = fittedQ(d, 5000, gamma, thetasQ, 100);
V_fitted = @(s) max(arrayfun(@(a)Q_fitted(s,a),[-1,0,1]));
figure(2);
plotf(V_fitted)

%% LSTD
[Q_lstd, alpha_lstd] = LSTD(d, 5000, gamma, thetasQ, 100);
V_lstd = @(s) max(arrayfun(@(a)Q_lstd(s,a),[-1,0,1]));
figure(3);
plotf(V_lstd)
