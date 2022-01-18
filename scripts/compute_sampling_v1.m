function [mean_error, var_error, p_true, logP, nofeedback_mean, nofeedback_var, feedback_mean, feedback_var, p_nofeedback, p_feedback] = compute_sampling_v1( X, target, headAngle_t, feedback, headAngle_feedback )

actual_error = headAngle_t - target;

% unpack parameters
g           = X(1); % targetGain - gain on memory of target
b           = X(2); % targetBias - bias in memory of target
gamma       = X(3); % velGain - gain on velocity cue
sigma_mem   = X(4); % actual memory noise
sigma_vel   = X(5); % actual velocity noise
s_0         = X(6); % subject estimate of initial uncertainty
s_vel       = X(7); % subject estimate of velocity noise
s_f         = X(8); % subject estimate of feedback noise
omega       = X(9); % subject pTrue

% compute p_true
p_true = compute_pTrue_v1( X, feedback, headAngle_feedback );

% no feedback
% [nofeedback_mean, nofeedback_var] = compute_noFeedback_v1( X(1:5), target, headAngle_t );
[nofeedback_mean, nofeedback_var] = compute_noFeedback_v1( X(1:5), target );
p_nofeedback = compute_choiceProb_v1( nofeedback_mean, nofeedback_var, actual_error, 'normal');
logP_nofeedback = compute_choiceProb_v1( nofeedback_mean, nofeedback_var, actual_error, 'log');

% feedback
% [feedback_mean, feedback_var] = compute_pureKalmanFilter_v1( X(1:8), target, headAngle_t, feedback, headAngle_feedback );
[feedback_mean, feedback_var] = compute_pureKalmanFilter_v1( X(1:8), target, feedback, headAngle_feedback );
p_feedback   = compute_choiceProb_v1(   feedback_mean,   feedback_var, actual_error, 'normal');

% combine
thresh = 10^-10;
i0 = (p_true < thresh) | (p_feedback == 0);
i1 = ~i0;
logP(i1) = log(p_true(i1) .* p_feedback(i1) + (1 - p_true(i1)) .* p_nofeedback(i1));
logP(i0) = logP_nofeedback(i0);


mean_error = [nofeedback_mean feedback_mean];
var_error = [nofeedback_var feedback_var];