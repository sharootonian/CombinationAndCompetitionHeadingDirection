function [mean_error, var_error] = compute_noFeedback_v1( X, target )

% [mean_error, var_error] = compute_noFeedback_v1( X, target )
%
% Compute mean and variance of error distribution for No Feedback model

% unpack parameters
g           = X(1); % targetGain - gain on memory of target
b           = X(2); % targetBias - bias in memory of target
gamma       = X(3); % velGain - gain on velocity cue
sigma_mem   = X(4); % actual memory noise
sigma_vel   = X(5); % actual velocity noise

% compute mean error
mean_error = ( (g - gamma) * target + b )/ gamma;

% compute variance of error
% NOTE: need to think about whether target or headAngle_t is better here
%var_error = sigma_mem^2 + sigma_vel^2 * headAngle_t;
var_error = ( sigma_vel^2 * target + sigma_mem^2 ) / gamma^2;
