%% Build a Gaussian MAB

Arm1 = armGaussian([0,1,0],[5,2,1;2,3,0;1,0,4]);
Arm2 = armGaussian([1,1,5],[2,1,1;1,5,2;1,2,4]);
Arm3 = armGaussian([2,3,-1],[3,0,0;0,4,0;0,0,1]);

% bandit : set of arms
MAB1 = {Arm1,Arm2,Arm3};
NbArms1 = length(MAB1);

theta1 = [1,1,1]';
true_rewards = zeros(1,NbArms1);
for i=1:NbArms1
    true_rewards(i)= MAB1{i}.mu*theta1;
end

%% Regret

T = 100; % horizon
alpha = 2;
[rew,draws,max_rew] = linUCB(T, alpha, MAB1, theta1);
regret = cumsum(max_rew - rew);
plot(1:T,regret)