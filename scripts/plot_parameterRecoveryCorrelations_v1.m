function plot_parameterRecoveryCorrelations_v1(ax, sim, model_flag, var_name, var_symbol, i, j)

global AZred AZblue

X_fit = vertcat(sim(:,model_flag).Xfit);
X_sim = vertcat(sim(:,model_flag).Xsim);

axes(ax); hold on;
set(ax, 'tickdir', 'out', 'fontsize', 12)

r_sim = corr(X_sim(:,i), X_sim(:,j), 'type', 'spearman');
r_fit = corr(X_fit(:,i), X_fit(:,j), 'type', 'spearman');

l = plot([X_sim(:,i) X_fit(:,i)]', [X_sim(:,j) X_fit(:,j)]','-', 'color', [1 1 1]*0.75)
l(2) = plot(X_sim(:,i), X_sim(:,j),'.');
l(3) = plot(X_fit(:,i), X_fit(:,j),'.');
l(4:5) = lsline;
set(l(2:3), 'marker','o', 'markerfacecolor', 'w', ...
    'markersize', 10, 'linewidth', 3)
set(l([2 5]), 'color', AZblue)
set(l([3 4]), 'color', AZred)
fancy_xlabel_v1({[var_name{i} ', '] ['$' var_symbol{i} '$']}, 2, 14)
fancy_ylabel_v1({[var_name{j} ', '] ['$' var_symbol{j} '$']}, 2, 14)

set(l(4:5), 'linewidth', 3)
legend(l(2:3), {
    sprintf('sim ( \\rho = %.2f )', r_sim) 
    sprintf('fit ( \\rho = %.2f )', r_fit) }, 'location', 'northoutside', 'interpreter', 'tex')
set(l(4:5), 'visible', 'off')