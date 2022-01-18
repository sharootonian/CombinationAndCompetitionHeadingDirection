function nLL = lik_sampling_v1(X, target, headAngle_t, feedback, headAngle_feedback)

actual_error = headAngle_t - target; % this matches what we have in paper
[~,~,~,logP] ...
    = compute_sampling_v1( X, target, headAngle_t, feedback, headAngle_feedback );
% compute negative log-likelihood
nLL = -sum(logP);
