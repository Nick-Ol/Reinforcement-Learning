function [ Q, alphaNew ] = LSTD( k, lenTraj, gamma, thetasQ, maxIter, isDeterministic )

iter = 0;
alphaOld = zeros(k, 1);
alphaNew = rand(1,k)'/10;
Q = createQ(alphaNew, thetasQ);

while (iter < maxIter && max(abs(alphaNew - alphaOld)) > 0.01)
    iter = iter + 1
    % generate one trajectory
    r = zeros(1, lenTraj); % rewards
    S = zeros(lenTraj, 2); % state matrix
    pi = zeros(1, lenTraj); % actions chosen
    S(1, 1) = -1.2 + 1.8 * rand(1); % x
    S(1, 2) = -0.07 + 0.14 * rand(1); % v
    
    for t = 1:lenTraj-1
        if iter == 1 % pick random action
            pi(t) = randi([-1, 1]);
            [S(t+1, :), r(t+1)] = simulator(S(t, :), pi(t), isDeterministic);
        else % loop has already been looped over once, and Q is defined
            [val, idx] = max([Q(S(t, :), -1), Q(S(t, :), 0), Q(S(t, :), 1)]); %idx = 1, 2 or 3
            pi(t) = idx - 2;
            [S(t+1, :), r(t+1)] = simulator(S(t, :), pi(t), isDeterministic);  
        end
    end
    [valLast, idxLast] = max([Q(S(lenTraj, :), -1), Q(S(lenTraj, :), 0), Q(S(lenTraj, :), 1)]); %idx = 1, 2 or 3
    pi(lenTraj) = idxLast - 2;

    %compute all phi_i(X_t, A_t)
    Phi = zeros(k, lenTraj);
    for i = 1:k
        for t = 1:lenTraj
            Phi(i, t) = phiQ(S(t, :), pi(t), thetasQ(i,:));
        end
    end

    % compute matrix A and vector b
    A = zeros(k, k);
    b = zeros(k, 1);
    for i = 1:k
        b(i) = 1/lenTraj*sum(r.*Phi(i,  :));
        for j = 1:k
            for t = 1:lenTraj - 1
                A(i, j) = A(i, j) + Phi(i, t).*(Phi(j, t) - gamma*Phi(j, t+1)); 
            end
            A(i, j) = A(i, j)/lenTraj;
        end
    end
    alphaOld = alphaNew;
    alphaNew = A\b
    %alphaNew = inv(A)*b;
    Q = createQ(alphaNew, thetasQ);
end

end
