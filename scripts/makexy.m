function [x, y] = makexy(m,sigma)
x = [(m-sigma*3):.1:(m+sigma*3)];
y = normpdf(x,m,sigma);
end