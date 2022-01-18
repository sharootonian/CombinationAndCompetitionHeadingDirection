function plot_parameterCorrelations_v1(ax, Xfit, model_flag, var_symbol)

global AZred AZblue

for i = 1:length(var_symbol)
v{i} = ['$' var_symbol{i} '$'];
end
[r,p] = corr(Xfit(:,:,model_flag), 'type', 'spearman');
r = r-diag(diag(r));
for i = 1:9
    for j = i:9
        r(i,j) = 0;
    end
end

thresh = 0.05/(8*9/2);
axes(ax)
t = imageTextMatrixStars_v3(round(r*100)/100, p, thresh, 2); 
t = t';
col = make_coolColorMap_v1(AZblue, [1 1 1], AZred);
colormap(col)
set(gca, 'clim', [-1 1], ...
    'xtick', 1:9, 'xticklabel', v, ...
    'ytick', 1:9, 'yticklabel', v, ...
    'ticklabelinterpreter', 'latex',...
    'tickdir', 'out', 'box', 'off', ...
    'fontsize', 14)
hold on;
% addFacetLines(r)
for i = 1:10
    plot(i-[0.5 0.5], [-0.5+i 9.5],'k')
    plot([0.5 -0.5+i], i-[0.5 0.5],'k')
end
ylim([0 11])

for i = 1:9
    for j = i:9
        set(t(i,j), 'visible', 'off')
    end
end

xlim([0.5 9.5])
ylim([0.5 9.5])