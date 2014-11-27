%% Adversarial Problem setting 

G = [2 -1  ; 0  1] % gain matrix for player A
n=500; % horizon 


%% Oblivious adversary (EWF and EXP3)

% Define the Sequence of Player B
Seq = 




%% EXP 3 versus EXP 3 : nash equilibrium




%% EXP3 versus Thompson Sampling

Arm1=armBernoulli(0.2);
Arm2=armBernoulli(0.4);
Arm3=armBernoulli(0.5);

MAB={Arm1,Arm2,Arm3};

Means=[Arm1.mean Arm2.mean Arm3.mean];
mumax=max(Means);

eta=0.01;
beta=0.1;

N=500;
n=1000;

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

plot(1:n,Reg1,1:n,Reg2)
legend('Thompson Sampling', 'EXP3')

    
    
    
    
    

