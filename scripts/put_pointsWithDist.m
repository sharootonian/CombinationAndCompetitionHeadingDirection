function [l, l2] = put_pointsWithDist(x, y, s, norm_factor, x_vals, marker, markersize, c1, c2)



l = put_points(x, y, marker, markersize, c1, c2);

% probability distributions
for i = 1:length(x)
    p(:,i) = normpdf(x_vals,x(i),s(i));
end

% remove very small probs
thresh = 0.001;
p(p<thresh) = nan;


% scale and invert
scale_factor = 0.75;
p_minus = p/norm_factor * scale_factor + y(1);
p_plus = -p/norm_factor * scale_factor + y(1);

l2(:,1) = plot(x_vals, p_minus);
l2(:,2) = plot(x_vals, p_plus);

% color
L = length(x);
if L == 1
    set(l2(1,:), 'color', c1);
    return
end

for i = 1:L
    f = (i-1)/(L-1);
    col = f * c2 + (1-f) * c1;
    set(l2(i,:), 'color', col);
end
