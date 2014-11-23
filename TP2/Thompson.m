function [ rew, draws ] = Thompson( T, MAB )

rew = zeros(1, T);
draws = zeros(1, T);

nb_arms = size(MAB, 2);
obs = zeros(1, nb_arms);
Na = zeros(1, nb_arms);
Sa = zeros(1, nb_arms);

for t = 1:T
   for i = 1:nb_arms 
       %for each arm observe theta_a from pi_a
        obs(i) = betarnd(Sa(i) + 1, Na(i) - Sa(i) + 1);
   end
   %pick best arm
   [val, idx] = max(obs);
   draws(t) = idx;
   rew(t) = MAB{idx}.play();
   %update the posterior on A_i 
   Na(idx) = Na(idx) + 1;
   Sa(idx) = Sa(idx) + rew(t); 
   
end


end

