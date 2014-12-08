%% Adversarial Problem setting 

G = [2 -1  ; 0  1]; % gain matrix for player A
n=500; % horizon 


%% Oblivious adversary (EWF and EXP3)

% Define the Sequence of Player B
Seq = zeros(1,n);
for i = 1:n
    if (mod(i,3) == 0)
        Seq(i) = 1;
    else
        Seq(i) =2;
    end    
end

eta = sqrt(size(G,1)*log(size(G,1))/((exp(1)-1)*n)); %course's formula
%eta = 0.5;
beta = eta;
[ActionsEWF, RewardsEWF] = EWFplay(n,G,eta,Seq);
[ActionsEXP3, RewardsEXP3] = EXP3play(n,G,eta,beta,Seq);

maxRewards = zeros(1,n);
for i = 1:n
    maxRewards(i) = max(G(:,Seq(i)));
end

regretEWF = cumsum(maxRewards - RewardsEWF);
regretEXP3 = cumsum(maxRewards - RewardsEXP3);

figure;
hold on
plot(1:n, regretEWF)
plot(1:n, regretEXP3)
legend('Regret for EWF strategy', 'Regret for Exp3 strategy')
hold off



%% EXP 3 versus EXP 3 : nash equilibrium
%eta = 0.5;
%beta = eta;

[ActionsA,ActionsB,Rew]= EXP3vEXP3(n,eta,beta,G);

Pa = cumsum(ActionsA==1)./(1:n);
Pb = cumsum(ActionsB==1)./(1:n);

figure;
hold on
plot(1:n, Pa)
plot(1:n, Pb)
legend('Empirical probability that A choses 1', 'Empirical probability that B choses 1')
hold off

RewA = cumsum(Rew)./(1:n);

figure;
hold on
plot(1:n, RewA)
legend('Empirical mean of the rewards obtained by A')
hold off

%% EXP3 versus Thompson Sampling

Arm1=armBernoulli(0.2);
Arm2=armBernoulli(0.4);
Arm3=armBernoulli(0.5);

MAB={Arm1,Arm2,Arm3};

Means=[Arm1.mean Arm2.mean Arm3.mean];
mumax=max(Means);

N=500;
n=1000;

eta=sqrt(length(MAB)*log(length(MAB))/((exp(1)-1)*n));
beta = eta;

% Estimated cumulated regret up to time n

Reg1=zeros(1,n);
Reg2=zeros(1,n);

compt=0;

for i=1:N
    [~,rew1]= Thompson(n,MAB);
    % complete EXP3stochastic 
    [~,rew2]= EXP3stochastic(n,beta,eta,MAB);
    Reg1=Reg1 + (1:n)*mumax - cumsum(rew1);
    Reg2=Reg2 + (1:n)*mumax - cumsum(rew2);
    compt=compt+1
end

Reg1=Reg1/N;
Reg2=Reg2/N;

figure;
plot(1:n,Reg1,1:n,Reg2)
legend('Thompson Sampling', 'EXP3')

%% an other MAB :
Arm4=armBernoulli(0.39);
Arm5=armBernoulli(0.4);

MAB2={Arm4,Arm5};

Means2=[Arm4.mean Arm5.mean];
mumax2=max(Means2);

N=500;
n=1000;

eta=sqrt(length(MAB2)*log(length(MAB2))/((exp(1)-1)*n));
beta = eta;

% Estimated cumulated regret up to time n

Reg1=zeros(1,n);
Reg2=zeros(1,n);

compt2=0;

for i=1:N
    [~,rew1]= Thompson(n,MAB2);
    % complete EXP3stochastic 
    [~,rew2]= EXP3stochastic(n,beta,eta,MAB2);
    Reg1=Reg1 + (1:n)*mumax2 - cumsum(rew1);
    Reg2=Reg2 + (1:n)*mumax2 - cumsum(rew2);
    compt2=compt2+1
end

Reg1=Reg1/N;
Reg2=Reg2/N;

figure;
plot(1:n,Reg1,1:n,Reg2)
legend('Thompson Sampling', 'EXP3')
 