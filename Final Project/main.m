%% Build a Gaussian MAB

MAB1 = {};
NbArms1 = 1000;
d = 5;

for i=1:NbArms1
    mu = rand(d,1);
    A = rand(d,d);
    sigma = (A+A')/2 + d*eye(d,d);
    MAB1{i} = armGaussian(mu,sigma);
end

theta1 = rand(d,1);
theta1 = theta1 / norm(theta1);
true_rewards_exp = zeros(1,NbArms1);
for i=1:NbArms1
    true_rewards_exp(i)= MAB1{i}.mu'*theta1;
end

max(true_rewards_exp)

%% Regret

T = 500; % horizon
delta = 0.05; % confidence 1-delta
alpha = 1 + sqrt(log(2/delta)/2);
sigma_noise = 0.1;
% 1000 articles, 100 potential at each turn to compute faster
[rew_lin,draws_lin,reg_lin,theta_estim_lin] = linUCB(T, alpha, MAB1, theta1, sigma_noise, 100);
regret_lin = cumsum(reg_lin);
[rew_oful,draws_oful,reg_oful,theta_estim_oful] = OFUL(T, delta, MAB1, theta1, sigma_noise, 100, 1);
regret_oful = cumsum(reg_oful);
[rew_thom,draws_thom,reg_thom] = Thompson(T, delta, MAB1, theta1, sigma_noise, 100);
regret_thom = cumsum(reg_thom);

figure;
hold on
plot(1:T, regret_lin)
plot(1:T,regret_oful)
plot(1:T,regret_thom)
legend('LinUCB', 'OFUL', 'Thompson Sampling')
hold off