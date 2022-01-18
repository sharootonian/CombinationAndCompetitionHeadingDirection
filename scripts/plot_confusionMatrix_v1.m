function [t] = plot_confusionMatrix_v1(ax, M, model_names, hg, wg, hb, wb)

axes(ax);
t = imageTextMatrix(round(M*100)/100);
hold on;
addFacetLines(M)


set(t, 'fontsize', 14)



set(ax, ...
    'xtick', 1:4, 'xticklabel', model_names, ...
    'ytick', 1:4, 'yticklabel', model_names, ...
    'xaxislocation', 'bottom', 'clim', [-1 1], ...
    'tickdir', 'out')
