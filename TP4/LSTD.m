function [ Q, alpha ] = LSTD( k, lenTraj, thetas, maxIter )

for iter = 1:maxIter %TODO change this to a while loop with stopping criterion
    %generate one trajectory
    r = zeros(1, lenTraj); %rewards
    S = zeros(lenTraj, 2); % state matrix
    S(1, 1) = randi([-120, 60])/100; %x
    S(1, 2) = randi(-70, 70)/1000; %v
    
    for t = 1:lenTraj
        if iter == 1 %pick random action
            [S(t+1, :), r(t+1)] = simulator(S(t, :), randi([-1, 1]));
        else %loop has already been looped over once, and Q is defined
            [val, idx] = min([Q(S(t, :), -1), Q(S(t, :), 0), Q(S(t, :), 1)]); %idx = 1, 2 or 3
            [S(t+1, :), r(t+1)] = simulator(S(t, :), idx - 2);  
        end
    end

    %compute all phi_i(X_t, A_t)
    Phi = zeros(k, lenTraj);
    for i = 1:k
        for t = 1:lenTraj
            Phi(i, t) = phiQ(S(t, 1), pi(t), thetas(i));
        end
    end

    %compute matrix A and vector b
    A = zeros(k, k);
    b = zeros(k, 1);
    for i = 1:k
        b(i) = 1/n*sum(r.*Phi(i,  :));
        for j = 1:k
            for t = 1:lenTraj - 1
                A(i, j) = A(i, j) + Phi(i, t).*(Phi(j, t) + gamma*Phi(j, t+1)); 
            end
        end
    end
    alpha = b\A;
    Q = createQ(alpha, thetas);
end
end

