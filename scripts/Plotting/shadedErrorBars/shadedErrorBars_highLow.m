function f = shadedErrorBars_highLow(x, y, y_high, y_low)

% x = tm;
% y = Y(1,:);
% y_sem = Ysem(1,:);

top = y + y_high;
bot = y - y_low;

yy = [top bot(end:-1:1)];
xx = [x   x(end:-1:1) ];

f = fill(xx, yy, 'r');
set(f, 'linestyle', 'none')
