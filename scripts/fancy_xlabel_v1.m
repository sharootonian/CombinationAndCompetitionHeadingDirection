function xl = fancy_xlabel_v1( txt, whichIsLaTeX, fontsize )

%%
% first get the y-location of the x-label
% xl = xlabel(txt{1});
xl = xlabel('Test Text ghy')
% get(xl);

set(xl, 'units', 'normalized', 'fontsize', fontsize)

e0 = get(xl, 'extent');
xl.delete

clear xl
%% 
% next put the text in a random location just to get the extent
xx = 0.5;
yy = 0.5

delta = [ 0 0  + 0.005];
delta(whichIsLaTeX) = 0;
xl(1) = text(xx, yy+delta(1), txt{1}, 'units', 'normalized', 'horizontalalignment', 'right');
xl(2) = text(xx, yy+delta(2), txt{2}, ...
    'units', 'normalized', ...
    'horizontalalignment', 'left');

set(xl(whichIsLaTeX), 'interpreter', 'latex')

set([xl], 'fontsize', fontsize)

% auto center
% get extent of xl1 and xl2
e1 = xl(1).Extent;
e2 = xl(2).Extent;

% compute width
w = e1(3)+e2(3);

% anchor point
a = 0.5 + e1(3) - w/2;

% now delete original text
xl.delete
clear xl
% xl(1).delete; xl2.delete

% now redraw the text in the correct location
xx = a;
yy = e0(2)+e0(4)/3;
xl(1) = text(xx, yy+delta(1), txt{1}, 'units', 'normalized', 'horizontalalignment', 'right');
xl(2) = text(xx, yy+delta(2), txt{2}, ...
    'units', 'normalized', ...
    'horizontalalignment', 'left');
set(xl(whichIsLaTeX), 'interpreter', 'latex')

set([xl], 'fontsize', fontsize)

