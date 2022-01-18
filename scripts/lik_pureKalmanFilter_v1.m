function nLL = lik_pureKalmanFilter_v1(X, target, headAngle_t, feedback, headAngle_feedback)

actual_error = headAngle_t - target; % this matches what we have in paper

% [feedback_mean, feedback_var] = compute_pureKalmanFilter_v1( X(1:8), target, headAngle_t, feedback, headAngle_feedback );
[feedback_mean, feedback_var] = compute_pureKalmanFilter_v1( X(1:8), target, feedback, headAngle_feedback );
logP   = compute_choiceProb_v1(   feedback_mean,   feedback_var, actual_error, 'log');

% compute negative log-likelihood
nLL = -sum(logP);
