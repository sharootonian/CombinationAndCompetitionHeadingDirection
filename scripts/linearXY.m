function [B, P, res] = linearXY(sub, fb_flag, Xname, Yname)

for sn = 1:length(sub)
    
    ind = sub(sn).FB == fb_flag;
    X = getfield(sub(sn), Xname);%.target(ind);
    Y = getfield(sub(sn), Yname);
    X = X(ind);
    Y = Y(ind);
    
    [B(:,sn), ~, stats] = glmfit(X, Y);
    P(:,sn) = stats.p;
    
    res(sn).Y = Y - (B(2,sn) * X + B(1,sn));
    res(sn).Y2 = res(sn).Y.^2;
    res(sn).logY2 = log(res(sn).Y.^2);
    res(sn).X = X;
    res(sn).FB = sub(sn).FB(ind); % hack so we can use res as sub input to this function
end
