function plot_parameterRecovery_v1( sim, model_flag, var_name, var_symbol, par_order )

global AZred AZblue
% a bit of a hack to get parameter order to match paper
var_name = var_name(par_order);
var_symbol = var_symbol(par_order);

X_sim = vertcat(sim.Xsim);
X_fit = vertcat(sim.Xfit);
X_sim = X_sim(:,par_order);
X_fit = X_fit(:,par_order);
[r,p] = nancorr(X_sim, X_fit(:,par_order), 'spearman');

figure(1); clf;
set(gcf, 'position',[440   504   468   400])
hg = [0.1 0.18 0.18 0.05];
wg = [0.1 0.12 0.12 0.03];

% only plot parameters that exist
switch model_flag
    case 1
        n_pars = 4;
        off_ax = [1 6:9];
    case 2
        n_pars = 7;
        off_ax = [8:9];
    otherwise
        n_pars = 9;
        off_ax = [];
end
on_ax = setdiff( 1:9, off_ax);
ax = easy_gridOfEqualFigures(hg, wg);
set(ax, 'tickdir', 'out', 'fontsize', 11)
for i = 1:length(on_ax);
    axes(ax(i)); hold on;
    
    j = on_ax(i);
    
    ttl(i) = title(var_name{j}, 'fontweight', 'normal');
    l2(i) = plot(X_sim(:,j), X_fit(:,j), 'o', 'markersize', 5);
    set(l2(i), 'color', AZblue*0.5+0.5, 'linewidth',1)
    l1(i) = lsline;
    set(l1(i), 'linewidth', 3, 'color', AZred)
    xlm = get(ax(i), 'xlim');
    l3(i) = plot(xlm, xlm, 'k--');
    [r,p] = nancorr(X_sim(:,j), X_fit(:,j), 'spearman');
    t(i) =  text(0.05, 0.9, sprintf('$r$ = %.2f', r), 'units', 'normalized', 'interpreter', 'latex', ...
        'horizontalalignment', 'left', 'backgroundcolor', [AZred 0.25], ...
        'margin', 1) ;
    
    xl = fancy_xlabel_v1( {['$' var_symbol{i} '$'] ' sim'}, 1, 12 )
    yl = fancy_ylabel_v1( {['$' var_symbol{i} '$'] ' fit'}, 1, 12 )
    
end
for j = n_pars+1:9
     set(ax(j), 'visible', 'off')
end
% for j = 1:length(off_ax)
%     set(ax(off_ax(j)), 'visible', 'off')
% end



addABCs(ax(1:length(on_ax)), [-0.06 0.05], 20)