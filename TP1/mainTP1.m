%% Problem setting 

M = 15; % taille du stock
K = 0.8; % frais de livraison
c = 0.5; % prix d'achat
h = 0.3; % co?t d'entretien
pr = 1; % prix de vente
gamma = 0.98; % calculé à partir du taux d'inflation

p = 0.1; % paramètre de la loi géométrique
D=zeros(1,M+1); % vecteur de la loi géométrique (tronquée)
D(1+(0:(M-1)))=p*(1-p).^(0:(M-1));
D(M+1)=1-sum(D);

x0=M; % stock initial

%% Visualisation d'une trajectoire

pi=2*ones(1,M+1);%exemple de politique
n=1000;

[X,R] = trajectory(n,x0,pi,D,M,K,h,c,pr);
plot(cumsum(gamma.^((1:n)-1).*R))



% Estimation du la récompense cumulée discountée

    

%% Calcul des paramètres du MDP

[P,R]=MDP(D,M,K,h,c,pr);

V0 = ((1:16) - ones(1,16))';
pol_eval_1(pi, P, R, gamma)
pol_eval_2(500,n,V0,pi,D,M,K,h,c,pr,gamma)
pol_eval_3(pi, P, R, gamma, 600)

%% Value iteration

nb_it=100;
V0=zeros(M+1,1);

tic
[V, pol]=VI(P,R,gamma,nb_it);
toc


%% Policy iteration 
%which one is the fastest ?
tic
[V, pol]=PI(P,R, gamma, nb_it, 1);
%note that 500 iterations are used for policy evaluation (arbitrary)
toc

tic
[V, pol]=PI(P,R, gamma, nb_it,3);
toc
%much faster using pol_eval_1 !
%and PI with pol_eval_1 much faster than VI for the same number of iterations


[V_PI, pi_PI] = PI(P,R, gamma, 500,1)
[V_VI, pi_VI] = VI(P, R, gamma, 500)

maxIterPlotting= 50;
errVI = zeros(1, maxIterPlotting);
errPI = zeros(1, maxIterPlotting);
errVI_p = zeros(1, maxIterPlotting);
errPI_p = zeros(1, maxIterPlotting);

for iter = 1:maxIterPlotting
    [V_value, piV] = VI(P, R, gamma, iter); %probable Schlemiel, starting from 0 again each time
    errVI(iter) = max(abs(V_value-V_VI));
    errVI_p(iter) = max(abs(piV-pi_VI));
    [V_policy, piP] = PI(P,R, gamma, iter, 1);
    errPI(iter) = max(abs(V_policy - V_PI));
    errPI_p(iter) = max(abs(piP - pi_PI));
end

plot(1:maxIterPlotting, errVI, 1:maxIterPlotting, errPI)
xlabel('iterations');
ylabel('norm difference for V');
legend({'Error for Value iteration', 'Error for Policy iteration'});

plot(1:maxIterPlotting, errVI_p, 1:maxIterPlotting, errPI_p)
xlabel('iterations');
ylabel('norm difference for pi');
legend({'Error for Value iteration', 'Error for Policy iteration'});
%we state that the PI algorithm converges much faster than VI

%% Q-Learning
tic
Qlearn = Qlearning(0.2, 20000, 200, M,K,h,c,pr,gamma)
toc

%Optimal policy associated :
pi_Qlearn = zeros(M+1, 1); %column vector
for x = 1:M+1
    [val, indx] = max(Qlearn(x,:));
    pi_Qlearn(x)= indx -1; %find the optimal policy
end
pi_Qlearn
