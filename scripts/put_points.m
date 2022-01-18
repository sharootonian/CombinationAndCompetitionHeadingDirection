function l = put_points(x, y, marker, markersize, c1, c2)

l = plot(x, y, 'marker', marker, 'linestyle', 'none', 'markersize', markersize);

L = length(l);
if L == 1
    set(l(1), 'color', c1, 'markerfacecolor', c1);
    return
end

for i = 1:L
    f = (i-1)/(L-1);
    col = f * c2 + (1-f) * c1;
    set(l(i), 'color', col, 'markerfacecolor', col);
end
