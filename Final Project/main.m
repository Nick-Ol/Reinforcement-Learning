%% Build a Gaussian MAB

NbArms1 = 500;
Arms = cell(1, NbArms1);
d = 100;

for i=1:NbArms1
    Arms{i} = rand(d, 1);
    Arms{i} = Arms{i} / norm(Arms{i});
end

theta1 = rand(d,1);
theta1 = theta1 / norm(theta1);
true_rewards_exp = zeros(1, NbArms1);
for i=1:NbArms1
    true_rewards_exp(i)= Arms{i}'*theta1;
end

[best_rew, best_arm] = max(true_rewards_exp)

%% LinUCB

T = 1000; % horizon
delta = 0.05; % concentration inequality holds with proba 1-delta
alpha = 1 + sqrt(log(2/delta)/2);
sigma_noise = 0.1;
% Nb_arms1 articles, nb_sample tested at each iteration for faster computation
nb_sample = 10;
[rew_lin,draws_lin,reg_lin,theta_estim_lin, Na_lin, Sa_lin] = linUCB(T, alpha, Arms, theta1, sigma_noise, nb_sample);
regret_lin = cumsum(reg_lin);
[val, idx] = max(Na_lin) % was the best arm, the most pulled one ?
Na_lin(best_arm) % best arm pulled ? times
true_rewards_exp(idx) % to be compared with best rew
figure;
plot(1:T, regret_lin)

%% Multiple theta
thetas = rand(d,NbArms1);
nb_samples = NbArms1; %no sampling, first
[rew_linmul,draws_linmul,reg_linmul,Na_linmul, Sa_linmul] = linUCB_multipletheta(T, alpha, Arms, thetas, sigma_noise, nb_sample);
regret_linmul = cumsum(reg_linmul);
figure;
plot(1:T, regret_linmul)

%% Other algorithms
[rew_oful,draws_oful,reg_oful,theta_estim_oful] = OFUL(T, delta, Arms, theta1, sigma_noise, nb_sample, 1);
regret_oful = cumsum(reg_oful);
[rew_thom,draws_thom,reg_thom] = Thompson(T, delta, Arms, theta1, sigma_noise, nb_sample);
regret_thom = cumsum(reg_thom);

figure;
hold on
plot(1:T, regret_lin)
plot(1:T,regret_oful)
plot(1:T,regret_thom)
legend('LinUCB', 'OFUL', 'Thompson Sampling')
hold off