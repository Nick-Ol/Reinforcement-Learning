function [y]=Nextstate(x,a,d,M)
    y=max(0,min((x+a),M)-d);
end
