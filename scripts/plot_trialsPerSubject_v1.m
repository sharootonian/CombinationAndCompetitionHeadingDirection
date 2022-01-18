function b = plot_trialsPerSubject_v1(ax, sub)

global AZred AZblue

for sn = 1:length(sub)
    ind = sub(sn).FB == 0;
    N_trials(sn) = sum(~isnan(sub(sn).respond));
    N_nofeedback(sn) = sum(~isnan(sub(sn).respond(ind)));
    N_feedback(sn) = sum(~isnan(sub(sn).respond(~ind)));
end

sNum = 1:length(sub);
[~,ind] = sort(N_trials);
axes(ax);
hold on;
b = bar([N_nofeedback(ind); N_feedback(ind)]', 'stacked');
set(b(1), 'facecolor', AZblue*0.5+0.5)
set(b(2), 'facecolor', AZred*0.5+0.5)
set(gca, 'xtick', [1 5:5:length(sub)], ...
    'tickdir', 'out', 'fontsize', 14)
xlabel({'subject number [sorted by trials]'})
ylabel('number of trials')
legend(b(2:-1:1), {'feedback' 'no feedback'}, 'location', 'eastoutside')
