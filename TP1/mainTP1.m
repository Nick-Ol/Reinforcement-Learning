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

MCn = 1000;
MCestim = 0;
i = 1;
while i <= MCn
    [X, R] = trajectory(n,x0,pi,D,M,K,h,c,pr);
    MCestim = MCestim + sum(gamma.^((1:n)-1).*R);
    i = i+1;
end
disp(MCestim/MCn)
    

%% Calcul des paramètres du MDP

[P,R]=MDP(D,M,K,h,c,pr);

pol_eval_1(pi, P, R, gamma)
pol_eval_2(1000,n,x0,pi,D,M,K,h,c,pr,gamma)

%% Value iteration

nb_it=100;
V0=zeros(M+1,1);

tic
[V, pol]=VI(P,R,gamma,V0,nb_it);
toc


%% Policy iteration 


%% Q-Learning
