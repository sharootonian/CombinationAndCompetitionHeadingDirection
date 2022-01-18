function [l, f] = plot_compareFitWithData_feedback_v3( ax, sub, Xfit, model_flag, varargin )

if nargin < 5
    sf = 10;
else
    sf = varargin{1};
end
sf

global AZblue AZred

% compare fit with feedback data ------------------------------------------
ind = sub.FB == 1;
target = sub.target(ind);
headAngle_t = sub.respond(ind);
headAngle_feedback = sub.fb_true(ind);
feedback = sub.fb(ind);
actual_error = headAngle_t - target;

[mean_error, var_error, p_true] = compute_sampling_v1( Xfit, target,  headAngle_t, feedback, headAngle_feedback );

axes(ax); hold on;

x = feedback - headAngle_feedback;

col = {AZblue AZred}
[~,ind] = sort(x);
for i = 1:2
    f(i) = shadedErrorBars(x(ind)', mean_error(ind,i)', sqrt(var_error(ind,i)'));
    %f(i) = shadedErrorBars(x(ind)', mean_error(ind,i)', var_error(ind,i)'.^2*100);
    %f(i) = shadedErrorBars(x(ind)', mean_error(ind,i)', var_error(ind,i)'*1);
    set(f(i), 'facecolor', col{i}, 'facealpha', 0.25)
end

ind = ~isnan(p_true) & (p_true ~= 1) & (p_true ~= 0);
l(2) = scatter(x(ind), mean_error(ind,2), p_true(ind)*sf, AZred, 'filled');
l(1) = scatter(x(ind), mean_error(ind,1), (1-p_true(ind))*sf, AZblue,'filled');

% l(1) = plot(x, mean_error(:,1),'.');
% l(2) = plot(feedback - headAngle_feedback, mean_error(:,2),'.');
l(3) = plot(feedback - headAngle_feedback, actual_error,'.');
xl = get(gca, 'xlim');