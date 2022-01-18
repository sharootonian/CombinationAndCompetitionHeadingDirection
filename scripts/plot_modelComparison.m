function [b, yl, nBestFit, ind] = plot_modelComparison(ax, BIC, model_names)

global AZred

[~,ind] = min(BIC')
[nBestFit, x] = hist(ind, 1:4);

axes(ax); hold on;
b = bar(x, nBestFit);
set(b, 'barwidth', 0.9, 'facecolor', AZred)
set(gca, ...
    'view',         [90 90], ...
    'xtick',        [1:4], ...
    'xticklabel',   model_names, ...
    'xlim',         [0.25 4.75] ...
    )
yl = ylabel('number best fit');
% xl = xlabel('model');
