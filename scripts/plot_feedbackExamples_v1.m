function [xl, yl, l] = plot_feedbackExamples_v1(ax, sub, fontsize)

global AZred AZblue

Xfit = ones(1,9);
model_flag = 1;

l = plot_compareFitWithData_feedback_v2( ax, sub, Xfit, model_flag, 10 )
set(l(1:2), 'visible', 'off')
set(l(3), 'marker','o', 'markersize', 5, 'color', [1 1 1]*0.5)

[xl] = fancy_xlabel_v1( { 'feedback offset, ' '$f - \theta_{t_f}$'}, 2, fontsize )
[yl] = fancy_ylabel_v1( {'response error, ' '$\theta_t - \alpha$'}, 2, fontsize )

