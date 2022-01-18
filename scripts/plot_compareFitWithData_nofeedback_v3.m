function [l, f,r] = plot_compareFitWithData_nofeedback_v3( ax, sub, Xfit )


global AZblue AZred
% get data
% compare fit with nofeedback data ------------------------------------------
ind = sub.FB == 0;
target = sub.target(ind);
headAngle_t = sub.respond(ind);
actual_error = headAngle_t - target;
conf = sub.conf(ind)

% [mean_error, var_error] = compute_noFeedback_v1( Xfit, target, headAngle_t );
[mean_error, var_error] = compute_noFeedback_v1( Xfit, target );


axes(ax); hold on;

[X, ind] = sort(target);
% 
% f = shadedErrorBars(X', mean_error(ind)', sqrt(var_error(ind))');
% set(f, 'facecolor', AZblue*0.25 +0.75)
% 
f=0
% 
% e = errorbar(target, mean_error, sqrt(var_error), ...
%     'linestyle', 'none', ...
%     'marker','.', 'color', AZblue*0.5+0.5)
l(2) = plot(target, conf, 'o', ...
    'color', AZblue*0.5+0.5, 'markersize', 5, 'markerfacecolor', 'none', ...
    'linewidth', 1);
% l(1) = plot(X, mean_error(ind), '-', 'color', AZblue, 'linewidth', 3)
set(ax, 'xlim',  [-40 400], ...
    'xtick', [0 180 360])
l = lsline;
set(l, 'color', AZred, 'linewidth', 3)
[r,p] = corr(sub.target(ind), sub.conf(ind), 'type', 'spearman');
    text(.01, .86, sprintf('$r$ = %.2f', r), ...
        'units', 'normalized', 'interpreter', 'latex', ...
        'backgroundcolor', AZred*0.25+0.75, 'margin', 1)
    
% xl = xlabel('target, \phi');
% yl = ylabel('response error, \theta_{t} - \phi');

% set([xl yl], 'interpreter', 'latex')
% ax(i).TickLabelInterpreter = 'latex';
% set(ax, 'TickLabelInterpreter', 'latex', 'fontsize', 14, 'tickdir', 'out')