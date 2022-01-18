function s = plot_sampling_v1( ax, scale, bias, X, target,  headAngle_t, feedback, headAngle_feedback )

global AZred AZblue

axes(ax); hold on;
[mean_error, var_error, p_true] = compute_sampling_v1( X, target,  headAngle_t, feedback, headAngle_feedback );
s(1) = scatter(feedback-headAngle_feedback, mean_error(:,1), (1-p_true)*scale+bias, AZblue, 'filled');
s(2) = scatter(feedback-headAngle_feedback, mean_error(:,2), p_true*scale+bias, AZred, 'filled');
