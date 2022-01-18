function a = put_doublearrow(ax, x, y)

xl = get(ax, 'xlim');
yl = get(ax, 'ylim');
pos = get(ax, 'position');

% transform x into absolute position
for i = 1:length(x)
    a(i) = x2a(x(i), xl, pos(1), pos(3)+pos(1));
end

% transform y into absolute position
for i = 1:length(y)
    b(i) = x2a(yl(end) - y(i) + yl(1), yl, pos(2), pos(4)+pos(2));
end

a = annotation('doublearrow', a, b);
