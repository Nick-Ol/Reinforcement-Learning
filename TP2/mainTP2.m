%% Build your own bandit problem 

% this is an example, please change the parameters or arms!
Arm1=armBernoulli(0.4);
Arm2=armBeta(4,6);
Arm3=armExp(2);
Arm4=armFinite([0.2 0.3 0.5 0.8],[0.1 0.3 0.3 0.3]);

MAB={Arm1,Arm2,Arm3,Arm4};
% bandit : set of arms

NbArms=length(MAB);

Means=zeros(1,NbArms);
for i=1:NbArms
    Means(i)=MAB{i}.mean;
end

% Display the means of your bandit (to find the best)
Means


%% Comparison of the regret on one run of the bandit algorithm

n=5000; % horizon

alpha=;

[rew1,draws1]=UCB(n,alpha,MAB);
reg1=;
[rew2,draws2]=naive(n,MAB);
reg2=;


plot(1:n,reg1,1:n,reg2)


%% (Expected) regret curve for UCB and the naive strategy




%% Easy Problem



%% Difficult problem 



%% UCB versus Thompson Sampling

