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

[rew_naive,draws_naive]=naive(n,MAB);
reg_naive = cumsum(max(Means) - rew_naive);
legendInfo{1}= 'Regret for naive';

reg_alpha = zeros(size(0:0.1:2,2),n);
i = 1;
for alpha = 0:0.1:2
    [rew_ucb,draws_ucb] = UCB(n,alpha,MAB);
    reg_alpha(i,:) = cumsum(max(Means) - rew_ucb);
    legendInfo{i+1} = sprintf('Regret for UCB with alpha = %f', alpha);
    
    i = i+1;
end

hold on
plot(1:n, reg_naive)
plot(1:n,reg_alpha(:,1:end))
legend(legendInfo)

%select the alpha which gives the smallest regret at horizon :
[reg_val, reg_idx] = min(reg_alpha(:,n));

%% (Expected) regret curve for UCB and the naive strategy
MCn = 100;
regMC1= 0;
regMC2=0;
for simu = 1:MCn
    [rew1,draws1]=UCB(n,alpha,MAB);
    regMC1= sum(max(Means) - rew1) + regMC1;
    [rew2,draws2]=naive(n,MAB);
    regMC2= sum(max(Means) -rew2) + regMC2;
end
regMC1 =regMC1/MCn;
regMC2 = regMC2/MCn;


%% Easy Problem

Arm5 = armBernoulli(0.2);
Arm6 = armBernoulli(0.24);
Arm7 = armBernoulli(0.55);
MAB1 ={Arm1, Arm7, Arm5, Arm6};

c = complexity(MAB1);
%% Difficult problem 



%% UCB versus Thompson Sampling

