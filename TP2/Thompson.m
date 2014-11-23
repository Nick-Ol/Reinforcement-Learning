function [ rew, draws ] = Thompson( T, MAB )

rew = zeros(1, T);
draws = zeros(1, T);

nb_arms = size(MAB, 2);
obs = zeros(1, nb_arms);
Na = zeros(1, nb_arms);
Sa = zeros(1, nb_arms);

%initializing
for t = 1:length(MAB)
    Sa(t) = MAB{t}.play();
    Na(t) = 1;
    [val, idx] = max(Sa);
    rew(1) = val;
    draws(1) = idx;
end

for t = 2:T
   for i = 1:nb_arms 
       %for each arm observe theta_a from pi_a
        obs(i) = betarnd(Sa(t) + 1, Na(t) - Sa(t) + 1);
   end
   %pick best arm
   [val, idx] = max(obs);
   rew(t) = val;
   draws(t) = idx;
   %update the posterior on A_t 
   Na(draws(t-1)) = Na(draws(t-1)) + 1;
   Sa(draws(t-1)) = Sa(draws(t-1)) + obs(draws(t-1)); 
   
end


end

