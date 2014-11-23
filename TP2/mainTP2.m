%% Build your own bandit problem 

% this is an example, please change the parameters or arms!
Arm1=armBernoulli(0.4); %mean 0.4
Arm2=armBeta(4,12); %mean 0.25
Arm3=armExp(9); %mean 0.11
Arm4=armFinite([0.2 0.4 0.7 0.8],[0.1 0.3 0.3 0.3]); %mean 0.59

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

alpha_range = logsample(.01, 1, 10);
reg_alpha = zeros(size(alpha_test,2),n);
i = 1;
for alpha = alpha_range
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
[reg_alpha_val, reg_alpha_idx] = min(reg_alpha(:,n));

%% (Expected) regret curve for UCB and the naive strategy
alpha = alpha_range(reg_alpha_idx);

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
Arm7 = armBernoulli(0.8);
MAB_easy ={Arm1, Arm7, Arm5, Arm6};

NbArms_easy=length(MAB_easy);

Means_easy=zeros(1,NbArms_easy);
for i=1:NbArms
    Means_easy(i)=MAB_easy{i}.mean;
end

n = 20000;

c_easy = complexity(MAB_easy);
lower_bound_easy = c_easy*log(1:n);

[rew_easy,draws_easy] = UCB(n,alpha,MAB_easy);
reg_easy = cumsum(max(Means_easy) - rew_easy);

hold on
plot(1:n, lower_bound_easy)
plot(1:n, reg_easy)
legend('Lower bound', 'Regret curve')



%% Difficult problem 

ArmDiff1 = armBernoulli(0.22);
ArmDiff2 = armBernoulli(0.24);
ArmDiff3 = armBernoulli(0.23);
ArmDiff4 = armBernoulli(0.25);
MAB_diff ={ArmDiff1, ArmDiff2, ArmDiff3, ArmDiff4};

Means_diff=zeros(1,NbArms_ber);
for i=1:NbArms
    Means_diff(i)=MAB_diff{i}.mean;
end

c_diff = complexity(MAB_diff); %68

%% UCB versus Thompson Sampling

%"Easy" problem :
%UCB and lower bound already computed earlier on
n = 20000;

[rew_thom_easy,draws_thom_easy] = Thompson(n,MAB_ber);
reg_thom_easy = cumsum(max(Means_ber) - rew_thom_easy);

hold on
plot(1:n, lower_bound_easy)
plot(1:n, reg_easy)
plot(1:n, reg_thom_easy)
legend('Lower bound', 'Regret curve for UCB', 'Regret curve for Thompson sampling')

%"Difficult" problem :
n = 20000;
alpha = 0.1;

c_diff = complexity(MAB_diff);
lower_bound_diff = c_diff*log(1:n);

[rew_ucb_diff,draws_ucb_diff] = UCB(n,alpha,MAB_diff);
reg_ucb_diff = cumsum(max(Means_diff) - rew_ucb_diff);

[rew_thom_diff,draws_thom_diff] = Thompson(n,MAB_diff);
reg_thom_diff = cumsum(max(Means_diff) - rew_thom_diff);

hold on
plot(1:n, lower_bound_diff)
plot(1:n, reg_ucb_diff)
plot(1:n, reg_thom_diff)
legend('Lower bound', 'Regret curve for UCB', 'Regret curve for Thompson sampling')


