function [Q] = createQ(alpha,thetas)
Q = @(s,a) sum(arrayfun(@(i) alpha(i)*phiQ(s,a,thetas(i,:)),1:length(thetas(:,1))));

