function nLL = lik_averaging_v1(X, target, headAngle_t, feedback, headAngle_feedback)

actual_error = headAngle_t - target; % this matches what we have in paper

[mean_error, var_error] = compute_averaging_v1( X, target, headAngle_t, feedback, headAngle_feedback );
logP = compute_choiceProb_v1(   mean_error,   var_error, actual_error, 'log');


% compute negative log-likelihood
nLL = -sum(logP);
