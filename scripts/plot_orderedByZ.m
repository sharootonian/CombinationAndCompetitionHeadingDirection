function [ax, m, l, axPars] = plot_orderedByZ(sub, fb_flag, Z, Xname, Yname);

% [ax, m, l] = plot_orderedByZ(sub, Z, Xname, Yname);
% 
% ax - axes
% m - markers
% l - line
% sub - subjects
% Z - thing to sort by
% Xname, Yname - fieldnames of sub to use

global AZred AZblue

clf;
hg = ones(6,1)*0.05;
wg = ones(7,1)*0.02;
wg(1) = 0.1;
hg(1) = 0.1;
[ax,hb,wb,ax2] = easy_gridOfEqualFigures(hg, wg);

[~,idx] = sort(Z);

for i = 1:length(idx)
    sn = idx(i);
    ind = sub(sn).FB == fb_flag;
    X = getfield(sub(sn), Xname);%.target(ind);
    Y = getfield(sub(sn), Yname);%.error(ind);
    X = X(ind); Y = Y(ind);
    
    axes(ax(i)); hold on;
    m(i) = plot(X, Y, 'o', 'color', AZred, ...
        'markersize', 5, 'linewidth', 1)
    xlim([0 360])
    l(i) = lsline;
    set(l(i), 'color', AZblue)
end

set(ax, ...
    'xlim',  [-40 400], ...
    'xtick', [0 180 360])
set(ax2(1:end-1,:), 'xticklabel', [])
set(ax2(:,2:end), 'yticklabel', [])

axPars.hg = hg;
axPars.hb = hb;
axPars.wg = wg;
axPars.wb = wb;