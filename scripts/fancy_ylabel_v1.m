function yl = fancy_ylabel_v1( txt, whichIsLaTeX, fontsize )

%%
% first get the y-location of the x-label
yl = ylabel(txt{1});
% get(xl);

set(yl, 'units', 'normalized', 'fontsize', fontsize)

e0 = get(yl, 'extent');
yl.delete

clear yl
%% 
% next put the text in a random location just to get the extent
xx = 0.5;
yy = 0.5;

delta = [ 0 0  + 0.005];
delta(whichIsLaTeX) = 0;

yl(1) = text(xx+delta(1), yy, txt{1}, 'units', 'normalized', 'horizontalalignment', 'right', 'rotation', 90);
yl(2) = text(xx+delta(2), yy, txt{2}, ...
    'units', 'normalized', ...
    'horizontalalignment', 'left', ...
    'rotation', 90);

set(yl(whichIsLaTeX), 'interpreter', 'latex')
set(yl, 'fontsize', fontsize)

% auto center
% get extent of xl1 and xl2
e1 = yl(1).Extent;
e2 = yl(2).Extent;

% compute height
h = e1(4)+e2(4);

% anchor point
a = 0.5 + e1(4) - h/2;

% now delete original text
yl.delete; clear yl
% yl1.delete; yl2.delete

% now redraw the text in the correct location
yy = a;
xx = e0(1)+e0(3)/2;
yl(1) = text(xx+delta(1), yy, txt{1}, 'units', 'normalized', 'horizontalalignment', 'right', 'rotation', 90);
yl(2) = text(xx+delta(2), yy, txt{2}, ...
    'units', 'normalized', ...
    'horizontalalignment', 'left', ...
    'rotation', 90);

set(yl, 'fontsize', fontsize)
set(yl(whichIsLaTeX), 'interpreter', 'latex')
