%% Problem setup
NbArms1 = 1000;
Arms = cell(1, NbArms1);
d = 10;
seed = 1;
rng(seed);
for i=1:NbArms1
    Arms{i} = 10 * rand(d, 1) - 5;
    Arms{i} = Arms{i} / norm(Arms{i});
end

theta1 = rand(d,1);
theta1 = theta1 / norm(theta1);
true_rewards_exp = zeros(1, NbArms1);
for i=1:NbArms1
    true_rewards_exp(i)= Arms{i}'*theta1;
end
hist(true_rewards_exp, 20);
title('Histogram of mean rewards');
[best_rew, best_arm] = max(true_rewards_exp);

sigma_noise = 1;
T = 10000; % horizon
delta = 0.05; % concentration inequality holds with proba 1-delta
alpha = 1 + sqrt(log(2/delta)/2);
% Nb_arms1 articles, nb_samples tested at each iteration
nb_samples = 100;

%% LinUCB
[rew_lin,draws_lin,reg_lin,theta_estim_lin, Na_lin, Sa_lin] = linUCB(T, alpha, Arms, theta1, sigma_noise, nb_samples, seed);
regret_lin = cumsum(reg_lin);
[most_pulls, most_pulled_arm] = max(Na_lin);% was the best arm, the most pulled one ?
most_pulled_arm_rew = true_rewards_exp(most_pulled_arm); % to be compared with best rew
best_arm_pulls = Na_lin(best_arm); % best arm pulled ? times
figure
plot(1:T, regret_lin)
legend('LinUCB')

%% Naive: linUCB with alpha = 0
[rew_naive,draws_naive,reg_naive,theta_estim_naive, Na_naive, Sa_naive] = linUCB(T, 0, Arms, theta1, sigma_noise, nb_samples, seed);
regret_naive = cumsum(reg_naive);
[most_pulls_naive, most_pulled_arm_naive] = max(Na_naive); % was the best arm, the most pulled one ?
most_pulled_arm_rew_naive = true_rewards_exp(most_pulled_arm_naive); % to be compared with best rew
best_arm_pulls_naive = Na_naive(best_arm); % best arm pulled ? times
figure;
plot(1:T, regret_naive)
legend('Naive')

%% Influence of the exploration rate alpha
nb_alphas = 10;
alpha_range = logsample(.01, 3, nb_alphas);
regret_alpha = zeros(nb_alphas,T);
legendInfo = cell(1, nb_alphas+1);
legendInfo{1}= 'Regret for naive';
i = 1;
for alpha = alpha_range
    [rew_alpha,draws_alpha,reg_alpha,theta_estim_alpha, Na_alpha, Sa_alpha] = linUCB(T, alpha, Arms, theta1, sigma_noise, nb_samples, seed);
    regret_alpha(i,:) = cumsum(reg_alpha);
    legendInfo{i+1} = sprintf('Regret for linUCB with alpha = %f', alpha);
    
    i = i+1
end

figure;
hold on
plot(1:T, regret_naive)
plot(1:T,regret_alpha(:,1:T))
legend(legendInfo,'Location','northwest')
hold off

%select the alpha which gives the smallest regret at horizon :
[alpha_best_val, alpha_best_idx] = min(regret_alpha(:,T));
alpha_best = alpha_range(alpha_best_idx);

%% Disjoint Linear Model
thetas = rand(d, NbArms1);
for k = 1:NbArms1
    thetas(:, k) = thetas(:, k)/norm(thetas(:, k));
end

true_rewards_exp_mul = zeros(1, NbArms1);
for i=1:NbArms1
    true_rewards_exp_mul(i)= Arms{i}'*thetas(:, i);
end

[best_rew_mul, best_arm_mul] = max(true_rewards_exp_mul);

nb_samples = 100;
[rew_linmul,draws_linmul,reg_linmul,Na_linmul, Sa_linmul] = linUCB_multipletheta(T, alpha, Arms, thetas, sigma_noise, nb_samples);
regret_linmul = cumsum(reg_linmul);
[most_pulls_mul, most_pulled_arm_mul] = max(Na_linmul); % was the best arm, the most pulled one ?
most_pulled_arm_rew_mul = true_rewards_exp_mul(most_pulled_arm_mul); % to be compared with best rew
best_arm_pulls_mul = Na_linmul(best_arm_mul); % best arm pulled ? times
figure;
plot(1:T, regret_linmul)
legend('LinUCB for disjoint linear model')

%% OFUL
[rew_oful,draws_oful,reg_oful,theta_estim_oful,Na_oful,Sa_oful] = OFUL(T, delta, Arms, theta1, sigma_noise, nb_samples, 1, seed);
regret_oful = cumsum(reg_oful);
[most_pulls_oful, most_pulled_arm_oful] = max(Na_oful); % was the best arm, the most pulled one ?
most_pulled_arm_rew_oful = true_rewards_exp(most_pulled_arm_oful); % to be compared with best rew
best_arm_pulls_oful = Na_oful(best_arm); % best arm pulled ? times
figure;
plot(1:T, regret_oful)
legend('OFUL')

%% Thompson Sampling
[rew_thom,draws_thom,reg_thom,Na_thom,Sa_thom] = Thompson(T, delta, Arms, theta1, sigma_noise, nb_samples, seed);
regret_thom = cumsum(reg_thom);
[most_pulls_thom, most_pulled_arm_thom] = max(Na_thom); % was the best arm, the most pulled one ?
most_pulled_arm_rew_thom = true_rewards_exp(most_pulled_arm_thom); % to be compared with best rew
best_arm_pulls_thom = Na_thom(best_arm); % best arm pulled ? times
figure;
plot(1:T,regret_thom)
legend('Thompson Sampling')

%% All together
figure;
plot(1:T, regret_lin)
plot(1:T, regret_naive)
plot(1:T, regret_oful)
plot(1:T, regret_thom)
legend('LinUCB', 'naive', 'OFUL', 'Thompson Sampling')
hold off