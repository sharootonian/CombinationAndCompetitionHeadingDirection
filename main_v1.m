clear
%
%% directories
addpath([pwd,'/data'])
datadir = '/data/';
figdir= '';
%% default plot parameters
defaultPlotParameters
%% load data
sub = load_data_v2(datadir,'dataconf.csv');
%% ========================================================================
%% characterize data set, participants and trials %%
%% characterize data set, participants and trials %%
%% characterize data set, participants and trials %%
%% ========================================================================

%% FIGURE XXX - how many trials for each subject
figure(1); clf
set(gcf, 'position',[440   504   468   200])
b = plot_trialsPerSubject_v1(gca, sub);
saveFigurePdf(gcf, 'KF_trials')
%% ========================================================================
%% no feedback condition %% no feedback condition %%
%% no feedback condition %% no feedback condition %%
%% no feedback condition %% no feedback condition %%
%% ========================================================================

%% fit No Feedback model to no feedback data
data_flag = 1;
model_flag = 1;
n_fit = 10;
for sn = 1:length(sub)
    [Xfit_nofeedback(sn,:)] = fit_any_v1( sub(sn), data_flag, model_flag, n_fit );
end

%% FIGURE 7 - data vs model - feedback error vs response error
sf = 1.3;
figure(1); clf;
set(gcf, 'position',[440   204   1.3*468*sf   1.3*300*sf])
hg = ones(6,1)*0.05;
wg = ones(7,1)*0.02;
wg(1) = 0.1;
hg(1) = 0.11;
[ax,hb,wb,ax2] = easy_gridOfEqualFigures(hg, wg);

% sort by slope (g - gamma)
slope = Xfit_nofeedback(:,1) - Xfit_nofeedback(:,3);
[~,ind] = sort(slope);

for sn = 1:length(sub)
    [l, f] = plot_compareFitWithData_nofeedback_v3( ax(sn), sub(ind(sn)), Xfit_nofeedback(ind(sn),:) )
end
set(ax2(1:end-1,:), 'xticklabel', [])
set(ax2(:,2:end), 'yticklabel', [])
set(ax, 'ylim', [-100 100])
a = add_oneExternalYLabel_v1(hg, wg, hb, wb, 90, 0.08, {'angle error, \theta_{\itt} - \alpha'});
set(a, 'fontsize', ceil(12*sf))

a = add_oneExternalXLabel_v1(hg, wg, hb, wb, -0.06, {'target angle, \alpha'}, 'bottom');
set(a, 'fontsize', ceil(12*sf))
set(ax, 'tickdir', 'out', 'fontsize', ceil(8*sf))
saveFigurePdf(gcf, [figdir 'KF_noFeedback'])

%% FIGURE 8 - histograms of fit parameter values
% g           = X(1); % targetGain - gain on memory of target
% b           = X(2); % targetBias - bias in memory of target
% gamma       = X(3); % velGain - gain on velocity cue
% sigma_mem   = X(4); % actual memory noise
% sigma_vel   = X(5); % actual velocity noise
% s_0         = X(6); % subject estimate of initial uncertainty
% s_vel       = X(7); % subject estimate of velocity noise
% s_f         = X(8); % subject estimate of feedback noise
% omega       = X(9); % subject pTrue

var_name = {'target gain'
    'target bias'
    'velocity gain'
    'target noise'
    'velocity noise'
    {'participant' 'initial uncertainty'}
    {'participant' 'velocity noise'}
    {'participant' 'feedback noise'}
    {'participant prior' 'on true feedback'}};
var_symbol = {'\gamma_A'
    '\beta_A'
    '\gamma_d'
    '\sigma_A'
    '\sigma_d'
    's_0'
    's_d'
    's_f'
    'r'};



ind = [1 2 4 5];
n = var_name(ind);
s = var_symbol(ind);
XX = Xfit_nofeedback(:,ind);

figure(1); clf;
set(gcf, 'position',[440   504   468   300])
hg = [0.13 0.2 0.08]
wg = [0.12 0.12 0.02];
ax = easy_gridOfEqualFigures(hg, wg);

clear ttl xl yl
for i = 1:length(ax)
    axes(ax(i)); hold on;
    [h,x] = hist(XX(:,i));
    b = bar(x, h, 'facecolor', AZred*0.5+0.5, 'barwidth',1 );
    ttl(i) = title(n(i));
    xl(i) = xlabel(['$' s{i} '/' var_symbol{3} '$'], 'interpreter', 'latex');
    yl(i) = ylabel('count');
end

set(ax, 'fontsize', 12, 'tickdir', 'out');
set([xl], 'fontsize', 14)
set([yl], 'fontsize', 13)
set(ttl, 'fontsize', 14, 'fontweight', 'normal')
addABCs(ax, [-0.09 0.06], 24)
saveFigurePdf(gcf, [figdir 'KF_noFeedbackParameters'])


%% ========================================================================
%% feedback condition %% feedback condition %% feedback condition %%
%% feedback condition %% feedback condition %% feedback condition %%
%% feedback condition %% feedback condition %% feedback condition %%
%% ========================================================================


%% FIGURE 6 - Illustration of qualitative properties of models for
%% feedback condition
model_name = {'Path Integration' 'Kalman Filter' 'Cue Combination' 'Hybrid'};

feedback = [-180:180]';
headAngle_t = nan(size(feedback));
target = ones(size(feedback))*180;
headAngle_feedback = zeros(size(feedback));
scale = 50;
bias = 0;

X = [1 0 1 10 1 20 0.1 20 0.8];

clear ttl xl yl

figure(1); clf;
set(gcf, 'position',[440   504   468   400])
ax = easy_gridOfEqualFigures([0.11 0.19 0.07], [0.12 0.13 0.04]);

set(ax, 'fontsize', 11, 'ylim', [-100 100])

l = [];
for i = 1:4
    l = [l plot_allFeedback_v1( ax(i), i, X, target,  headAngle_t, feedback, headAngle_feedback )];
    ttl(i) = title(model_name{i}, 'fontweight', 'normal')
    %xl(i) = xlabel('feedback offset, $f - \theta_{t_f}$', 'interpreter', 'latex')
    fancy_xlabel_v1({'feedback offset, ' ' $f - \theta_{t_f}$'},2,12)
    fancy_ylabel_v1({'response error, ' '$\theta_{t} - \alpha$'}, 2, 12)
end

set(l(1:3), 'linewidth', 3)
set(ax, 'ylim', [-100 100],  'tickdir', 'out', ...
    'xtick', [-180:90:180])
set(ttl, 'fontsize', 14)
% set([xl yl], 'fontsize', 14)
addABCs(ax, [-0.09 0.07], 20)
saveFigurePdf(gcf, [figdir 'KF_modelPredictions'])
% s = plot_sampling_v1( ax(4), scale, bias, X, target,  headAngle_t, feedback, headAngle_feedback );



%% fit all models
%% **take about 10min**
clear Xfit
data_flag   = 3;
n_fit       = 100;
tic
for model_flag  = 1:4
    for sn = 1:length(sub)
        disp([model_flag sn])
        % use fit_any_v1 for non-parallel evaluation of starting points
        %[Xfit(sn,:,model_flag), nLL(sn,model_flag), BIC(sn,model_flag), AIC(sn,model_flag)] ...
        %    = fit_any_v1( sub(sn), data_flag, model_flag, n_fit );
        [Xfit(sn,:,model_flag), nLL(sn,model_flag), BIC(sn,model_flag), AIC(sn,model_flag)] ...
            = fit_any_parallel_v1( sub(sn), data_flag, model_flag, n_fit );
    end
end
toc
% save FK_modelFits_010521c_parallel

%% FIGURE 10 - Model comparison
model_name = {'Path Integration' 'Kalman Filter' 'Cue Combination' 'Hybrid'};

figure(1); clf;
sf = 1.5;
set(gcf, 'position',[440   504   468*sf   130*sf]*1.33)

ax = easy_gridOfEqualFigures([0.29  0.07], [0.24 0.1  0.03]);
[b, yl, nBestFit, best_model] = plot_modelComparison(ax(2), BIC, model_name);

set(ax(2), 'xticklabel', [])
axes(ax(1)); hold on;
Y = BIC - repmat(BIC(:,4), [1 4]);
r = (rand(size(Y,1),1)-0.5)*0.2;
for i = 1:4
    plot(r+i, Y(:,i)','o', 'markersize', 8, 'color', AZred);
end
plot([0.5 4.5], [0 0], 'k--')
set(gca, 'view', [90 90], 'xtick', 1:4, 'xticklabel', model_name, ...
    'xlim', [0.5 4.5], 'ylim', [-200 600])
set(ax, ...
    'tickdir',      'out', ...
    'fontsize',     12*sf);

ylabel('BIC(Model) - BIC(Hybrid)')
% xlabel('model')

addABCs(ax(1), [-0.22 0.08], 18*sf)
addABCs(ax(2), [-0.04 0.08], 18*sf, 'B')
saveFigurePdf(gcf, [figdir 'KF_modelComparison'])

%% FIGURE S11 - histogram of fit parameters


% parameter order - to fit with order in which parameters are discussed in
% paper
par_order = [3 5 1 2 4 6 7 8 9];


model_flag = 4;
XX = Xfit(:, :, model_flag);
figure(1); clf;
set(gcf, 'position',[440   504   468   400])

ax = easy_gridOfEqualFigures([0.09 0.18 0.18 0.05], [0.08 0.1 0.1 0.01]);

for i = 1:9
    par_num = par_order(i)
    axes(ax(i)); hold on;
    [h,x] = hist(XX(:,par_num));
    b = bar(x, h, 'facecolor', AZred*0.5+0.5, 'barwidth',1 );
    ttl(i) = title(var_name{par_num});
    xl(i) = xlabel(['$' var_symbol{par_num} '$'], 'interpreter', 'latex');
    yl(i) = ylabel('count');
end
set(ax, 'fontsize', 11, 'tickdir', 'out')
% set(ax([1 3]), 'xlim', [0.4 1.6])
set(ax([3]), 'xtick', [0.6 1 1.4])
set(ax(end), 'xlim', [-0.05 1.05])
set([xl], 'fontsize', 14)
set([yl], 'fontsize', 12)
set(ttl, 'fontweight', 'normal', 'fontsize', 12)
addABCs(ax, [-0.06 0.05], 20)

if model_flag == 1
    set(ax([1 6:9]), 'visible', 'off')
end

% boxplot(Y);
% bar(M - M(4))
saveFigurePdf(gcf, [figdir 'KF_feedbackParameters_' num2str(model_flag)])

%% mean parameter values
M = mean(XX(:,par_order))
var_symbol(par_order)

for i = 1:length(par_order)
    name = var_name{par_order(i)};
    if iscell(name)
        name = [name{1} ' ' name{2}];
    end
    disp(sprintf('%s, %s = %.2f', name, var_symbol{par_order(i)}, M(i)))
end


%% FIGURE 11 - comparison between data and model
figure(1); clf;
set(gcf, 'position',[240   204   468   400]*1.33)
ax = easy_gridOfEqualFigures([0.11 0.19 0.07], [0.12 0.13 0.04]);

set(ax, 'fontsize', 11, 'ylim', [-100 100])

% set(gcf, 'position',[440   504   468   300])
idx = [2 30 10 25];
% ax = easy_gridOfEqualFigures([0.12 0.2 0.07], [0.14 0.15 0.03]);
set(ax, 'fontsize', 10)
for i = 1:length(ax)
    axes(ax(i)); hold on;
    sn = idx(i);
    [l, f] = plot_compareFitWithData_feedback_v3( gca, sub(sn), Xfit(sn,:,model_flag), model_flag, 20 );
    plot([-180 180], [-180 180], 'k--')
    plot([-180 180], [0 0], 'k--')
    set(l(3), 'marker', 'o', 'markersize', 5, 'color', [1 1 1]*0.5, ...
        'markerfacecolor', 'w');
    set(f, 'visible', 'off')
    uistack(l(3),'bottom')
    title(['participant ' num2str(sn)], 'fontsize', 14, 'fontweight', 'normal')
    fancy_xlabel_v1({'feedback offset, ' '$f - \theta_{t_f}$'}, 2, 11);
    fancy_ylabel_v1({'response error, ' '$\theta_{t} - \alpha$'}, 2, 11);
end
set(ax, 'tickdir', 'out')
set(ax, 'ylim', [-200 200], 'xlim', [-200 200], ...
    'xtick', [-180:90:180], 'ytick', [-180:90:180])

% addABCs(ax, [-0.11 0.06], 20)
addABCs(ax, [-0.09 0.07], 20)
saveFigurePdf(gcf, [figdir 'KF_modelVsData_examples'])


%% FIGURE S13 - comparison between data and model ALL
sf = 1.3;
figure(1); clf;
set(gcf, 'position',[440   504   468*sf   300*sf])
hg = ones(6,1)*0.05;
wg = ones(7,1)*0.04;
wg(1) = 0.08;
hg(1) = 0.11;
hg(end) = 0.02;
wg(end) = 0.02;
[ax,hb,wb,ax2] = easy_gridOfEqualFigures(hg, wg);


for i = 1:length(ax)
    axes(ax(i)); hold on;
    sn = i;
    [l, f] = plot_compareFitWithData_feedback_v3( gca, sub(sn), Xfit(sn,:,model_flag), model_flag, 20 );
    plot([-180 180], [-180 180], 'k--')
    plot([-180 180], [0 0], 'k--')
    set(l(3), 'marker', 'o', 'markersize', 4, 'color', [1 1 1]*0.75, ...
        'markerfacecolor', 'w');
    set(f, 'visible', 'off')
    uistack(l(3),'bottom')
    %fancy_xlabel_v1({'feedback offset, ' '$f - \theta_{t_f}$'}, 2, 12)
    %fancy_ylabel_v1({'response error, ' '$\theta_{t} - \phi$'}, 2, 12)
end
set(ax2(1:end-1,:), 'xticklabel', [])
set(ax2(:,2:end), 'yticklabel', [])
set(ax, 'ylim', [-200 200], 'xlim', [-200 200], ...
    'xtick', [-180:180:180], 'ytick', [-180:180:180])
a = add_oneExternalYLabel_v1(hg, wg, hb, wb, 90, 0.06, {'response error'});
set(a, 'fontsize', ceil(12*sf))

a = add_oneExternalXLabel_v1(hg, wg, hb, wb, -0.06, {'feedback offset'}, 'bottom');
set(a, 'fontsize', ceil(12*sf))
set(ax, 'tickdir', 'out', 'fontsize', ceil(8*sf))

i3 = best_model == 3;
i1 = best_model == 1;
set(ax([i3]), 'color', AZsand*0.25+0.75)
set(ax([i1]), 'color', AZcactus*0.25+0.75)
set(gcf, 'InvertHardcopy', 'off')
saveFigurePdf(gcf, [figdir 'KF_modelVsData_all'])

%% FIGURE 12 - implied Kalman gain with fit parameters
model_flag = 4;
XX = Xfit(:,:,model_flag);
KG = nan(500,30);

for sn = 1:length(sub)
    ind                 = sub(sn).FB == 1;
    target              = sub(sn).target(ind);
    headAngle_t         = sub(sn).respond(ind);
    headAngle_feedback  = sub(sn).fb_true(ind);
    feedback            = sub(sn).fb(ind);

    [~, ~, rho_tf] = compute_pureKalmanFilter_v1( XX(sn,:), target, feedback, headAngle_feedback );
    KG(1:length(rho_tf),sn) = rho_tf;
end

M = nanmean(KG,1)
[~,ind] = sort(M);
% boxplot(KG(:,ind))
figure(1); clf;
set(gcf, 'position',[440   504   468   200]*1.33)
ax = easy_gridOfEqualFigures([0.23 0.03], [0.1 0.03]);
% ax(2) = easy_gridOfEqualFigures([0.23 0.03], [0.8 0.03]);
axes(ax(1)); hold on;
set(ax, 'fontsize', 14)
for i = 1:length(sub)
    plot(i+(rand(size(KG,1),1)-0.5)*0.5, KG(:,ind(i)), ...
        '.', 'color', [1 1 1]*0.75, ...
        'markersize', 7)
    idx = ~isnan(KG(:,ind(i)));
    s = sort(KG(idx,ind(i)));
    uq(i) = s(round(length(s)*0.95));
    lq(i) = s(round(length(s)*0.05));
end

errorbar(1:length(ind), M(ind), M(ind)-lq, uq-M(ind),'color', AZred, ...
    'marker', '.', 'linestyle', 'none', 'markersize', 15, 'linewidth', 1)

fancy_ylabel_v1({'Kalman gain, ' '$K_{t_f}$'}, 2, 14)
xlim([0.5 30.5])
set(ax(1), 'ylim', [0 1.05], 'xtick', [1 5:5:30], 'tickdir', 'out', 'ytick', [0 0.5 1], 'yticklabel', {'0' '.5' '1'})
xlabel('subject (ordered by average Kalman gain)')
% axes(ax(2)); hold on
% [h,x] = hist(M, [0:0.05:1]);
% bar(x, h, 'facecolor', AZred*0.5+0.5, 'barwidth', 1)
% set(ax(2), 'view', [90 90], 'xdir', 'reverse', 'xlim', [0 1.05], 'xtick', [0 0.5 1], 'xticklabel', {0 '.5' 1})
% ylabel('count')
saveFigurePdf(gcf, [figdir 'KF_kalmanGain'])

%% FIGURE S12 - correlations between parameters 
model_flag = 4;
XX = Xfit(:,:,model_flag);
figure(1); clf;
set(gcf, 'position',[440   504   468   250])
% ax = easy_gridOfEqualFigures([0.48 0.03], [0.17 0.12])
% ax(2:3) = easy_gridOfEqualFigures([0.1 0.65], [0.1 0.12 0.05]);
% ax = easy_gridOfEqualFigures([0.1 0.1], [0.1 0.1 0.1 0.03]);
ax = easy_gridOfEqualFigures([0.12 0.03], [0.11 0.32]);
ax(2:3) = easy_gridOfEqualFigures([0.15 0.18 0.06], [0.76 0.03]);

plot_parameterCorrelations_v1(ax, Xfit(:,par_order,:), model_flag, var_symbol(par_order))
% saveFigurePdf(gcf, '~/Desktop/KF_parameterCorrelations')
ix = [3 3 ];%3 ]%3 3];
iy = [1 5 ];%8 ]%5 8];

a = 0.05;
b = 0.86;
c = 0.14;
tx = [a a a a a];
ty = [b b c b c];

set(ax(2:3), 'xlim', [0.5 1.5]);%, 'xtick', [0.6 1 1.4])
clear xl yl
for i = 1:length(ix)

    axes(ax(i+1)); hold on;
    plot(XX(:,ix(i)), XX(:,iy(i)), 'o', 'markersize', 4, 'color', AZblue*0.5+0.5)
    l = lsline;
    set(l, 'color', AZred, 'linewidth', 3)
    [r,p] = corr(XX(:,ix(i)), XX(:,iy(i)), 'type', 'spearman');
    text(tx(i), ty(i), sprintf('$\\rho$ = %.2f', r), ...
        'units', 'normalized', 'interpreter', 'latex', ...
        'backgroundcolor', AZred*0.25+0.75, 'margin', 1)
    xl(i) = xlabel(['$' var_symbol{ix(i)} '$'], 'interpreter', 'latex', 'fontsize', 14);
    yl(i) = ylabel(['$' var_symbol{iy(i)} '$'], 'interpreter', 'latex', 'fontsize', 14);
end


xxx = [0.5 1.5];
yyy = 2*xxx - 1;
axes(ax(2)); hold on;
plot(xxx, yyy, 'k--')

xxx = [0.5 1.5];
yyy = xxx;
% axes(ax(3)); hold on;
% plot(xxx, yyy, 'k--')
set(ax, 'tickdir', 'out')
set([xl yl], 'fontsize', 14)
% set(ax(end), 'visible', 'off')
addABCs(ax(1), [-0.09 0.01], 20, 'A')
addABCs(ax(2:3), [-0.08 0.03], 20, 'BCDEF')
polyfit(X(:,3), X(:,5),1)
saveFigurePdf(gcf, [figdir 'KF_parameterCorrelations'])



%% ========================================================================
%% parameter recovery %% parameter recovery %% parameter recovery %%
%% parameter recovery %% parameter recovery %% parameter recovery %%
%% parameter recovery %% parameter recovery %% parameter recovery %%
%% ========================================================================


%% simulate fake data for parameter recovery
clear sim
Nsim = 30;

for model_flag = 1:4
    rng(10); % set random seed for reproducibility
    Xsim = generate_simulationParameters(3,  Nsim, Xfit(:,:,model_flag));
    expt = generate_simulationTrials(sub, Nsim);
    for count = 1:length(expt)
        sim(count, model_flag) = sim_any_v2(model_flag, Xsim(count,:), expt(count));
    end
end

%% fit fake data for BOTH conditions (data_flag = 3)
data_flag = 3;
n_fit = 100;
tic
for model_flag = 4
    for sn = 1:length(sim)
        disp(['model_flag = ' num2str(model_flag) '; subject = ' num2str(sn)])
        % uncomment/comment to switch back from parallel
        %[sim(sn).Xfit] = fit_any_v1( sim(sn), data_flag, model_flag, n_fit );
        [sim(sn,model_flag).Xfit] = fit_any_parallel_v1( sim(sn, model_flag), data_flag, model_flag, n_fit );
    end
end
toc

%% FIGURE S10 plot parameter recovery
for model_flag = 4
    plot_parameterRecovery_v1( sim(:, model_flag), model_flag, var_name, var_symbol, par_order )
end

%% FIGURE S7 does it introduce corrleations? No!!!
figure(1); clf;
set(gcf, 'position',[440   504   468   250])
ax = easy_gridOfEqualFigures([0.2 0.04], [0.12 0.15 0.07]);
i = 1; j = 3;
plot_parameterRecoveryCorrelations_v1(ax(1), sim, model_flag, var_name, var_symbol, i, j)
addABCs(ax, [-0.07 0.0], 24)
i = 3; j = 5;
plot_parameterRecoveryCorrelations_v1(ax(2), sim, model_flag, var_name, var_symbol, i, j)

%% parameter recovery for No Feedback model on no feedback trials
clear sim
Nsim = 30;

model_flag = 1;
rng(10); % set random seed for reproducibility
Xsim = generate_simulationParameters(3,  Nsim, Xfit(:,:,model_flag));
expt = generate_simulationTrials(sub, Nsim);
for count = 1:length(expt)
    sim(count, model_flag) = sim_any_v2(model_flag, Xsim(count,:), expt(count));
end


%% fit fake data for no feedback condition only (data_flag = 1)
data_flag = 1;
n_fit = 100;
model_flag = 1;
for sn = 1:length(sim)
    disp(['model_flag = ' num2str(model_flag) '; subject = ' num2str(sn)])
    % uncomment/comment to switch back from parallel
    %[sim(sn).Xfit] = fit_any_v1( sim(sn), data_flag, model_flag, n_fit );
    [sim(sn,model_flag).Xfit] = fit_any_parallel_v1( sim(sn, model_flag), data_flag, model_flag, n_fit );
end

%% Figure S89 plot parameter recovery
model_flag = 1;
plot_parameterRecovery_v1( sim(:, model_flag), model_flag, var_name, var_symbol, par_order )
saveFigurePdf(gcf, ['~/Desktop/KF_parameterRecovery_noFeedback_' num2str(model_flag)]);


%% ========================================================================
%% confusion matrix %% confusion matrix %% confusion matrix %%
%% confusion matrix %% confusion matrix %% confusion matrix %%
%% confusion matrix %% confusion matrix %% confusion matrix %%
%% ========================================================================

%% simulate fake data for confusion matrix
Nsim = 30;

clear sim
for model_flag = 1:4
    Xsim = generate_simulationParameters(4,  Nsim, Xfit(:,:,model_flag));
    expt = generate_simulationTrials(sub, Nsim);
    for count = 1:length(expt)
        sim(count, model_flag) = sim_any_v2(model_flag, Xsim(count,:), expt(count));
    end
end


%% compute confusion matrix
clear nLL BIC AIC
n_fit       = 100;
for model_flag_sim  = 1:4
    for model_flag_fit  = 1:4

        for i = 1:length(sim(:, model_flag_sim))
            disp(sprintf('sim = %d, fit = %d, sub = %d', model_flag_sim, model_flag_fit, i));
            [~, ~, BIC(i, model_flag_fit, model_flag_sim), AIC(i, model_flag_fit, model_flag_sim)] ...
               = fit_any_parallel_v1( sim(i, model_flag_sim), data_flag, model_flag_fit, n_fit );
        end
    end
end

%% FIGURE S4 - confusion matrix 
model_name = {'Path Integration' 'Kalman Filter' 'Cue Combination' 'Hybrid'};
% model_name{2} = 'Kalman Filter';
CM = zeros(4);
% go through each subject and each simulated model and find the best fit
for i = 1:size(sim,1)
    for model_flag_sim = 1:4
        [minBIC] = min(BIC(i,:,model_flag_sim));
        % get update to row of confusion matrix (allow for ties)
        dum = BIC(i,:,model_flag_sim) == minBIC;
        dum = dum / sum(dum);

        % update confusion matrix
        CM(model_flag_sim,:) = CM(model_flag_sim,:) + dum;
    end
end

% normalize confusion matrix to get p(fit | sim)
p_fitGivenSim = CM ./ repmat(sum(CM,2), [1 size(CM,2)]);

% normalize to get p(sim | fit)
p_simGivenFit = CM ./ repmat(sum(CM,1), [ size(CM,1) 1]);


figure(1); clf;
set(gcf, 'position',[440   504   468   300])
hg = [0.35 0.18];
wg = [0.26 0.08 0.03];

[ax, hb, wb] = easy_gridOfEqualFigures(hg, wg);
[t] = plot_confusionMatrix_v1(ax(1), p_fitGivenSim, model_name, hg, wg, hb, wb);
set(t(p_fitGivenSim>=0.5), 'color', 'w')
set(t, 'fontsize', 12)
% [t] = plot_confusionMatrix_v1(ax(1), p_simGivenFit, model_name, hg, wg, hb, wb);
[t] = plot_confusionMatrix_v1(ax(2), p_simGivenFit, model_name, hg, wg, hb, wb);
set(t(p_simGivenFit>0.5), 'color', 'w')
set(t, 'fontsize', 12)
set(ax(2), 'yticklabel', [])
set(ax, 'fontsize', 12)
yl = add_externalYlabelsRotation_v1(wg, hg, wb, hb, 90, 0.02, {'simulated model'});
xl = add_externalXlabelsBottom(wg, hg, wb, hb, -0.25, {'fit model'});
xl2 = add_externalXlabelsBottom(sum(wg(1:2))+wb(1), hg, wb(1), hb, -0.25, {'fit model'});

xl3 = add_externalXlabelsTop(wg, hg, wb, hb, 0.03, {'confusion matrix   p(fit | sim)'});
xl4 = add_externalXlabelsTop(sum(wg(1:2))+wb(1), hg, wb, hb, 0.03, {'inversion matrix   p(sim | fit)'});
set([xl yl xl2 xl3 xl4], 'fontsize', 16)

set(ax, 'xticklabelrotation', 40, 'tickdir', 'out')
% [t, xl, yl] = plot_confusionMatrix_v1(ax(2), p_simGivenFit, model_names, ...
%     hg, wb(1)+wg(1)+wg(2:end), hb, wb(2:end)); % positioning here is a hack
% set(ax(2), 'yticklabel', []);
% set(yl, 'visible', 'off')

% axes(ax(1));

col = make_coolColorMap_v1(AZblue, [1 1 1], AZred);
% colormap(col)
colormap(ax(1), col)
col = make_coolColorMap_v1(AZblue, [1 1 1], AZblue);
set(ax(2), 'colormap', col)

addABCs(ax, [-0.02 0.18], 22);
saveFigurePdf(gcf, [figdir 'KF_confusionMatrix'])


%% FIGURE 15 - data vs model - target angle vs response confidence
sf = 1.3;
figure(1); clf;
set(gcf, 'position',[440   204   1.5*468*sf   1.5*300*sf])
hg = ones(6,1)*0.05;
wg = ones(7,1)*0.02;
wg(1) = 0.1;
hg(1) = 0.11;
[ax,hb,wb,ax2] = easy_gridOfEqualFigures(hg, wg);
subsig=0;
% sort by slope (g - gamma)
slope = Xfit_nofeedback(:,1) - Xfit_nofeedback(:,3);
[~,ind] = sort(slope);

for sn = 1:length(sub)
    [l, f,r] = plot_compareFitWithData_nofeedback_v3( ax(sn), sub(ind(sn)), Xfit_nofeedback(ind(sn),:) );
    if (r>=0.4)
        subsig(sn)=1
    else
        subsig(sn)=0
    end


end
subsig = logical(subsig);

a = add_oneExternalYLabel_v1(hg, wg, hb, wb, 90, 0.08, {'ConfRating (deg)'});
set(a, 'fontsize', ceil(12*sf))
a = add_oneExternalXLabel_v1(hg, wg, hb, wb, -0.06, {'Target angle \alpha'}, 'bottom');
set(a, 'fontsize', ceil(12*sf))
set(ax, 'tickdir', 'out', 'fontsize', ceil(8*sf))

% set(ax([i3]), 'color', AZsand*0.25+0.75)
set(ax([subsig]), 'color', AZcactus*0.25+0.75)

set(gcf, 'InvertHardcopy', 'off')
saveFigurePdf(gcf, 'confidence_target')

%%
%% FIGURE XXX - data vs model - error vs response confidence
sf = 1.3;
figure(1); clf;
set(gcf, 'position',[440   204   1.5*468*sf   1.5*300*sf])
hg = ones(6,1)*0.05;
wg = ones(7,1)*0.02;
wg(1) = 0.1;
hg(1) = 0.11;
[ax,hb,wb,ax2] = easy_gridOfEqualFigures(hg, wg);

for i = 1:length(sub)
    axes(ax(i)); hold on;
    plot(sub(i).error , sub(i).conf, 'o', 'markersize', 4, 'color', AZblue*0.5+0.5)
        l = lsline;
    set(l, 'color', AZred, 'linewidth', 3)
    [r,p] = corr(sub(i).error, sub(i).conf, 'type', 'spearman');
    text(.01, .86, sprintf('$r$ = %.2f', r), ...
        'units', 'normalized', 'interpreter', 'latex', ...
        'backgroundcolor', AZred*0.25+0.75, 'margin', 1)
end
a = add_oneExternalYLabel_v1(hg, wg, hb, wb, 90, 0.08, {'ConfRating (deg)'});
set(a, 'fontsize', ceil(12*sf))
a = add_oneExternalXLabel_v1(hg, wg, hb, wb, -0.06, {'angle error, \alpha- \theta'}, 'bottom');
set(a, 'fontsize', ceil(12*sf))
set(ax, 'tickdir', 'out', 'fontsize', ceil(8*sf))
set(gcf, 'InvertHardcopy', 'off')
saveFigurePdf(gcf, 'confidence_AngleError')

%% Conf vs feedback sd
model_flag=4
sf = 1.3;
figure(1); clf;
set(gcf, 'position',[440   204   1.5*468*sf   1.5*300*sf])
hg = ones(6,1)*0.05;
wg = ones(7,1)*0.04;
wg(1) = 0.08;
hg(1) = 0.11;
hg(end) = 0.02;
wg(end) = 0.02;
[ax,hb,wb,ax2] = easy_gridOfEqualFigures(hg, wg);
subsig=0
for i= 1:length(ax)
    ind = sub(i).FB == 1;
    target = sub(i).target;
    feedback = sub(i).fb;
    headAngle_feedback = sub(i).fb_true;
    SamplingV=0

    X=Xfit(i,:,model_flag)
    %[m, v, p_true] = compute_samplingModel_v1( X, target(ind), headAngle_t(ind), feedback(ind), headAngle_feedback(ind) );
    [m, v, p_true] = compute_sampling_v1( X, target(ind), target(ind), feedback(ind), headAngle_feedback(ind) );

    for(t = 1:length(p_true))
        if (p_true(t)>=0.5)
            SamplingV(t)= v(t,2);
        else
            SamplingV(t)= v(t,1);
        end
    end

    axes(ax(i)); hold on;
    plot(sqrt(SamplingV), sub(i).conf(ind), 'o', 'markersize', 4, 'color', AZblue*0.5+0.5)
        l = lsline;
    set(l, 'color', AZred, 'linewidth', 3)
    [r,p] = corr(sqrt(SamplingV'), sub(i).conf(ind), 'type', 'spearman');
    text(.01, .86, sprintf('$r$ = %.2f', r), ...
        'units', 'normalized', 'interpreter', 'latex', ...
        'backgroundcolor', AZred*0.25+0.75, 'margin', 1)

    if (r>=0.4)
        subsig(i)=1
    else
        subsig(i)=0
    end
end
subsig=logical(subsig);
a = add_oneExternalYLabel_v1(hg, wg, hb, wb, 90, 0.07, {'ConfRating (deg)'});
set(a, 'fontsize', ceil(12*sf))
a = add_oneExternalXLabel_v1(hg, wg, hb, wb, -0.06, {'Feedback Condition, \sigma_\theta'}, 'bottom');
set(a, 'fontsize', ceil(12*sf))
set(ax, 'tickdir', 'out', 'fontsize', ceil(8*sf))

set(ax([subsig]), 'color', AZcactus*0.25+0.75)
set(gcf, 'InvertHardcopy', 'off')

saveFigurePdf(gcf, 'confidence_FeedbackSD')
%% Figure S16

model_flag = 4;
XX = Xfit(:,:,model_flag);
KG = nan(500,30);

for sn = 1:length(sub)
    ind                 = sub(sn).FB == 1;
    target              = sub(sn).target(ind);
    headAngle_t         = sub(sn).respond(ind);
    headAngle_feedback  = sub(sn).fb_true(ind);
    feedback            = sub(sn).fb(ind);

    [~, ~, rho_tf] = compute_pureKalmanFilter_v1( XX(sn,:), target, feedback, headAngle_feedback );
    KG(1:length(rho_tf),sn) = rho_tf;
end

figure(1); clf;
set(gcf, 'position',[440   504   468   200]*1.33)
ax = easy_gridOfEqualFigures([0.23 0.03], [0.1 0.03]);
% ax(2) = easy_gridOfEqualFigures([0.23 0.03], [0.8 0.03]);
axes(ax(1)); hold on;
set(ax, 'fontsize', 14)

KG_clean=KG(~isnan(KG));
KG_clean(2170)=[]; %remove one trial that viewangle was 0
foo=readtable([datadir 'dataconf2.csv']).viewAmount;
viewAmount= foo(foo~=0)
scatter(KG_clean,viewAmount, [],AZblue*0.5+0.5)
hold on
l = lsline;
set(l, 'color', AZred, 'linewidth', 3)
[r,p] = corr(KG_clean,viewAmount, 'type', 'spearman');
    text(.01, .86, sprintf('$r$ = %.2f', r), ...
        'units', 'normalized', 'interpreter', 'latex', ...
        'backgroundcolor', AZred*0.25+0.75, 'margin', 1)
    
    
fancy_xlabel_v1({'Kalman gain, ' '$K_{t_f}$'}, 2, 14)
ylabel('Feedback View (deg)')