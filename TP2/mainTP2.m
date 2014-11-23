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

n = 5000; % horizon

[rew_naive,draws_naive]=naive(n,MAB);
reg_naive = cumsum(max(Means) - rew_naive);
legendInfo{1}= 'Regret for naive';

alpha_test = 0.1:0.2:2;
reg_alpha = zeros(size(alpha_test,2),n);
i = 1;
for alpha = alpha_test
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
alpha = 0.1;

MCn = 100;
regMC_naive = 0;
regMC_UCB =0;
for simu = 1:MCn
    [rew_naive,draws_naive] = naive(n,MAB);
    regMC_naive = sum(max(Means)-rew_naive) + regMC_naive;
    [rew_UCB,draws_UCB] = UCB(n,alpha,MAB);
    regMC_UCB = sum(max(Means)-rew_UCB) + regMC_UCB;
end
regMC_naive =regMC_naive/MCn;
regMC_UCB = regMC_UCB/MCn;


%% Easy Problem

Arm5 = armBernoulli(0.2);
Arm6 = armBernoulli(0.24);
Arm7 = armBernoulli(0.55);
MAB_ber ={Arm1, Arm7, Arm5, Arm6};

NbArms_ber=length(MAB_ber);

Means_ber=zeros(1,NbArms_ber);
for i=1:NbArms
    Means_ber(i)=MAB_ber{i}.mean;
end

n = 20000;

c = complexity(MAB_ber);
lower_bound = c*log(1:n);

[rew_ber,draws_ber] = UCB(n,alpha,MAB_ber);
reg_ber = cumsum(max(Means_ber) - rew_ber);

hold on
plot(1:n, lower_bound)
plot(1:n, reg_ber)
legend('Lower bound', 'Regret curve')



%% Difficult problem 

ArmDiff1 = armBernoulli(0.22);
ArmDiff2 = armBernoulli(0.24);
ArmDiff3 = armBernoulli(0.23);
ArmDiff4 = armBernoulli(0.25);
MAB_diff ={ArmDiff1, ArmDiff2, ArmDiff3, ArmDiff4};
c_diff = complexity(MAB_diff); %67

%% UCB versus Thompson Sampling

