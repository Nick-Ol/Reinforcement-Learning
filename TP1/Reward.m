function [r]=Reward(x,a,d,M,K,h,c,pr)
    r= -K*(a>0) - c*max(0,min(x+a,M) - x) - h*x + pr*min([d , x+a , M]);
end