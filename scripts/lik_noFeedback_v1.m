function nLL = lik_noFeedbackModel_v1(X, target, headAngle_t)

actual_error = headAngle_t - target; % this matches what we have in paper

% compute mean and variance of response for no feedback model
% [mean_error, var_error] = compute_noFeedback_v1( X, target, headAngle_t );
[mean_error, var_error] = compute_noFeedback_v1( X, target );

% compute log probs
logProb = compute_choiceProb_v1( mean_error, var_error, actual_error, 'log' );

% compute negative log-likelihood
nLL = -sum(logProb);
