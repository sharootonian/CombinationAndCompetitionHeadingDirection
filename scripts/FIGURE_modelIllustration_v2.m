clear
defaultPlotParameters

figure(1); clf;
set(gcf, 'position', [200 800 468*1.5 280])
ax = easy_gridOfEqualFigures([0.2 0.09], [0.32 0.03]);
pathIntegration(ax)
saveFigurePdf(gcf, '~/Desktop/PathIntegration')
%%
figure(1); clf;
set(gcf, 'position', [200 800 468*1.5 330])
ax = easy_gridOfEqualFigures([0.17 0.09], [0.32 0.03]);
landmarkNavigation(ax)
saveFigurePdf(gcf, '~/Desktop/LandmarkNavigation')
%%
figure(1); clf;
set(gcf, 'position', [200 200 468*1.5 400]*1.33)
ax = easy_gridOfEqualFigures([0.15 0.09], [0.4 0.03]);
cueCombination(ax);
saveFigurePdf(gcf, '~/Desktop/CueCombination')

%%
figure(1); clf;
set(gcf, 'position', [200 800 468*1.5 400])
ax = easy_gridOfEqualFigures([0.15 0.09], [0.4 0.03]);
cueCompetition(ax);
saveFigurePdf(gcf, '~/Desktop/CueCompetition')

%%




function cueCompetition(ax)

global AZred AZblue AZsand AZcactus
ax.TickLabelInterpreter = 'latex';
fontsize = 18;

true_target = 250;
est_target = 220;
gray = [1 1 1]*0.9;


true_heading  = [0:50:200];
est_heading   = [0 40 90 140 210];
est_heading_s = [3 6  9  12 15];
feedback = 110;
feedback_s = 5;
est_heading2   = [nan nan 100 160 est_target];
est_heading2_s = [nan nan 3 6  9   ];
norm_factor = normpdf(0, 0, est_heading_s(1));
x_vals = [-50:0.1:300];

axes(ax); hold on; set(ax, 'ydir', 'reverse')
l = put_points( true_target, 1, 's', 10, AZred,  AZblue)
l = put_points(  est_target, 2, 's', 10, AZblue, AZblue)
l = put_points(true_heading, 3, 'V', 10, gray,   AZred)

[l, l2] = put_pointsWithDist( est_heading, 4, est_heading_s,  norm_factor, x_vals, '^', 10, gray,   AZblue)
[l, l2] = put_pointsWithDist(    feedback, 5, feedback_s,     norm_factor, x_vals, '*', 10, AZsand, AZsand)
[l, l2] = put_pointsWithDist(est_heading2, 7, est_heading2_s, norm_factor, x_vals, '^', 10, gray,   AZblue)
[l, l2] = put_pointsWithDist(est_heading2, 9, est_heading2_s, norm_factor, x_vals, '^', 10, gray,   AZcactus)
% [l, l2] = put_pointsWithBiDist([est_heading; est_heading2], 9, [est_heading_s; est_heading2_s], norm_factor, 0.8, x_vals, 'o', 10, gray, AZcactus)

plot([1 1]*est_target, [2 9], '--', 'color', AZblue)
plot([1 1]*true_target, [0.5 1], '--', 'color', 'k')
plot([1 1]*true_heading(end), [0.5 3], '--', 'color', 'k')
plot([est_heading(3) est_heading(3) feedback feedback], [4 5.5 5.5 5], 'k-')
% plot((est_heading(3)+feedback)/2*[1 1], [5.5 7], 'k-')
plot(est_heading2(3)*[1 1], [5.5 7], 'k-')

ylim([0 10])
xlim([-50 300])
a = put_arrow(ax, [250 est_target], [5.5 5.5])
a = put_textbox(ax, [true_heading(end) true_target], [0.5 -0.5], 'measured error', fontsize, 'none', 'bottom', 'center')
a = put_doublearrow(ax, [true_heading(end) true_target], [0.5 0.5])
a = put_textbox(ax, [true_target 300], [6.5 4.5], 'respond when $m^{hy}_t = A$', fontsize, 'none', 'middle', 'center')
% a = put_arrow(ax, [12.5 (est_heading(3)+feedback)/2], [6 6])
a = put_arrow(ax, [12.5 est_heading2(3)], [6 6])
a = put_textbox(ax, [-35 65], [6.75 5.5], 'combine path integration and feedback', fontsize, 'none', 'middle', 'center')

set(gca, 'ytick', [1:5 7 9], ...
    'yticklabel', ...
    {'true target, $\alpha$' 
    'remembered target, $A$' 
    'true heading, $\theta_t$'
    'path integration estimate, $m_t$'
    'feedback, $f$'
    'Kalman filter estimate, $\hat{m}_t$' 
    'hybrid estimate, $m^{hy}_t$'}, ...
    'fontsize', fontsize, ...
    'tickdir', 'out')

grid on
xlabel('heading angle', 'interpreter', 'latex')

end


function cueCombination(ax)

global AZred AZblue AZcactus AZsand

ax.TickLabelInterpreter = 'latex';
fontsize = 18;

true_target = 250;
est_target = 220;
gray = [1 1 1]*0.9;


true_heading  = [0:50:200];
est_heading   = [0 40 90 140 210];
est_heading_s = [3 6  9  12 15];
feedback = 110;
feedback_s = 5;
est_heading2   = [nan nan 100 160 222.5];
est_heading2_s = [nan nan 3 6  9   ];
norm_factor = normpdf(0, 0, est_heading_s(1));
x_vals = [-50:0.1:300];

axes(ax); hold on; set(ax, 'ydir', 'reverse')
l = put_points( true_target, 1, 's', 10, AZred,  AZblue)
l = put_points(  est_target, 2, 's', 10, AZblue, AZblue)
l = put_points(true_heading, 3, 'V', 10, gray,   AZred)

[l, l2] = put_pointsWithDist( est_heading, 4, est_heading_s,  norm_factor, x_vals, '^', 10, gray,   AZblue)
[l, l2] = put_pointsWithDist(    feedback, 5, feedback_s,     norm_factor, x_vals, '*', 10, AZsand, AZsand)
[l, l2] = put_pointsWithDist(est_heading2, 7, est_heading2_s, norm_factor, x_vals, '^', 10, gray,   AZblue)
[l, l2] = put_pointsWithBiDist([est_heading; est_heading2], 9, [est_heading_s; est_heading2_s], norm_factor, 0.8, x_vals, 'o', 10, gray, AZcactus)

plot([1 1]*est_target, [2 9], '--', 'color', AZblue)
plot([1 1]*true_target, [0.5 1], '--', 'color', 'k')
plot([1 1]*true_heading(end), [0.5 3], '--', 'color', 'k')
plot([est_heading(3) est_heading(3) feedback feedback], [4 5.5 5.5 5], 'k-')
% plot((est_heading(3)+feedback)/2*[1 1], [5.5 7], 'k-')
plot(est_heading2(3)*[1 1], [5.5 7], 'k-')

ylim([0 10])
xlim([-50 300])
a = put_arrow(ax, [250 est_target], [5.5 5.5])
a = put_textbox(ax, [true_heading(end) true_target], [0.5 -0.5], 'measured error', fontsize, 'none', 'bottom', 'center')
a = put_doublearrow(ax, [true_heading(end) true_target], [0.5 0.5])
a = put_textbox(ax, [true_target 300], [6.5 4.5], 'respond when $m^{comb}_t = A$', fontsize, 'none', 'middle', 'center')
% a = put_arrow(ax, [12.5 (est_heading(3)+feedback)/2], [6 6])
a = put_arrow(ax, [12.5 est_heading2(3)], [6 6])
a = put_textbox(ax, [-35 65], [6.75 5.5], 'combine path integration and feedback', fontsize, 'none', 'middle', 'center')

set(gca, 'ytick', [1:5 7 9], ...
    'yticklabel', ...
    {'true target, $\alpha$' 
    'remembered target, $A$' 
    'true heading, $\theta_t$'
    'path integration estimate, $m_t$'
    'feedback, $f$'
    'Kalman filter estimate, $\hat{m}_t$' 
    'combined estimate, $m^{comb}_t$'}, ...
    'fontsize', fontsize, ...
    'tickdir', 'out')

grid on
xlabel('heading angle', 'interpreter', 'latex')


end

function landmarkNavigation(ax)

global AZred AZblue AZsand
ax.TickLabelInterpreter = 'latex';
fontsize = 18;

true_target = 250;
est_target = 220;
gray = [1 1 1]*0.9;

true_heading  = [0:50:200];
est_heading   = [0 40 90 nan nan];
est_heading_s = [3 6  9  nan nan ];
feedback = 115;
feedback_s = 4;
ss = 1 / (1 / feedback_s^2 + 1 / est_heading_s(3)^2);
mu = (feedback / feedback_s^2 + est_heading(3) / est_heading_s(3)^2) * ss;

est_heading2   = [nan nan mu 160 est_target ];
est_heading2_s = [nan nan 0 3  6   ]+sqrt(ss);
norm_factor = normpdf(0, 0, est_heading_s(1));
x_vals = [-50:0.1:300];

axes(ax); hold on; set(ax, 'ydir', 'reverse')
l = put_points( true_target, 1, 's', 10, AZred,  AZblue)
l = put_points(  est_target, 2, 's', 10, AZblue, AZblue)
l = put_points(true_heading, 3, 'V', 10, gray,   AZred)

[l, l2] = put_pointsWithDist( est_heading, 4, est_heading_s,  norm_factor, x_vals, '^', 10, gray,   AZblue)
[l, l2] = put_pointsWithDist(    feedback, 5, feedback_s,     norm_factor, x_vals, '*', 10, AZsand, AZsand)
[l, l2] = put_pointsWithDist(est_heading2, 7, est_heading2_s, norm_factor, x_vals, '^', 10, gray,   AZblue)

plot([1 1]*est_target, [2 7], '--', 'color', AZblue)
plot([1 1]*true_target, [0.5 1], '--', 'color', 'k')
plot([1 1]*true_heading(end), [0.5 3], '--', 'color', 'k')
plot([est_heading(3) est_heading(3) feedback feedback], [4 5.5 5.5 5], 'k-')
plot(est_heading2(3)*[1 1], [5.5 7], 'k-')

ylim([0 8])
xlim([-50 300])
a = put_arrow(ax, [250 est_target], [5 5])
a = put_textbox(ax, [true_heading(end) true_target], [0.5 -0.5], 'measured error', fontsize, 'none', 'bottom', 'center')
a = put_doublearrow(ax, [true_heading(end) true_target], [0.5 0.5])
a = put_textbox(ax, [true_target 300], [6.5 3.5], 'respond when $\hat{m}_t = A$', fontsize, 'none', 'middle', 'center')
a = put_arrow(ax, [12.5 est_heading2(3)], [6 6])
a = put_textbox(ax, [-35 65], [6.75 5.5], 'combine path integration and feedback', fontsize, 'none', 'middle', 'center')

set(gca, 'ytick', [1:5 7], ...
    'yticklabel', ...
    {'true target, $\alpha$' 
    'remembered target, $A$' 
    'true heading, $\theta_t$'
    'estimated heading, $m_t$'
    'feedback, $f$'
    'combined estimate, $\hat{m}_t$'}, ...
    'fontsize', fontsize, ...
    'tickdir', 'out')
grid on
xlabel('heading angle', 'interpreter', 'latex')




end















function pathIntegration(ax)

global AZred AZblue
ax.TickLabelInterpreter = 'latex';
fontsize = 18;

true_target = 250;
est_target = 220;
gray = [1 1 1]*0.9;

true_heading  = [0:50:200];
est_heading   = [0 40 90 160 est_target];
est_heading_s = [3 6  9  12  15];
norm_factor = normpdf(0, 0, est_heading_s(1));
x_vals = [-50:0.1:300];

axes(ax); hold on; set(ax, 'ydir', 'reverse')
l = put_points( true_target, 1, 's', 10, AZred,  AZblue)
l = put_points(  est_target, 2, 's', 10, AZblue, AZblue)
l = put_points(true_heading, 3, 'V', 10, gray,   AZred)

[l, l2] = put_pointsWithDist(est_heading, 4, est_heading_s, norm_factor, x_vals,'^', 10, gray, AZblue)

plot([1 1]*est_target, [2 4], '--', 'color', AZblue)
plot([1 1]*true_target, [0.5 1], '--', 'color', 'k')
plot([1 1]*true_heading(end), [0.5 3], '--', 'color', 'k')

ylim([0 5])
a = put_arrow(ax, [250 est_target], [2.5 2.5])
a = put_textbox(ax, [true_heading(end) true_target], [0.5 -0.5], 'measured error', fontsize, 'none', 'bottom', 'center')
a = put_doublearrow(ax, [true_heading(end) true_target], [0.5 0.5])
a = put_textbox(ax, [true_target 300], [3.5 2.5], 'respond when $m_t = A$', fontsize, 'none', 'bottom', 'center')

set(gca, 'ytick', 1:4, ...
    'yticklabel', ...
    {'true target, $\alpha$' 
    'remembered target, $A$' 
    'true heading, $\theta_t$'
    'estimated heading, $m_t$'}, ...
    'fontsize', fontsize, ...
    'tickdir', 'out')
grid on
xlabel('heading angle', 'interpreter', 'latex')
end