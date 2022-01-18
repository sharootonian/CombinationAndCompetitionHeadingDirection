function a = put_textbox(ax, x, y, str, fontsize, linestyle, v_align, h_align)

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


a = annotation('textbox', [a(1) b(1) a(2)-a(1) b(2)-b(1)], ...
    'string', str, ...
    'horizontalalignment', h_align, ...
    'verticalalignment', v_align, ...
    'fontsize', fontsize, ...
    'backgroundcolor', 'w', ...
    'margin', 0, ...
    'linestyle', linestyle, 'interpreter', 'latex');