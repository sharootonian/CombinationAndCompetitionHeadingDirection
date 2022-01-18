function [mean_error, var_error, rho_tf] = compute_pureKalmanFilter_v1( X, target, feedback, headAngle_feedback )

% [mean_error, var_error] = compute_pureKalmanFilter_v1( X, target, headAngle_t, feedback, headAngle_feedback )
% 
% Compute mean and variance of error distribution for Pure Kalman Filter
% model

% unpack parameters
g           = X(1); % targetGain - gain on memory of target
b           = X(2); % targetBias - bias in memory of target
gamma       = X(3); % velGain - gain on velocity cue
sigma_mem   = X(4); % actual memory noise
sigma_vel   = X(5); % actual velocity noise
s_0         = X(6); % subject estimate of initial uncertainty
s_vel       = X(7); % subject estimate of velocity noise
s_f         = X(8); % subject estimate of feedback noise

% kalman ratio
rho_tf = (s_0^2 + s_vel^2 * headAngle_feedback) ./ (s_f^2 + s_0^2 + s_vel^2 * headAngle_feedback);


% compute mean error
mean_error = ( (g - gamma) * target + b  + rho_tf .* (feedback - gamma * headAngle_feedback) ) / gamma;

% compute variance of error
% var_error = ( sigma_mem^2 ...
%     + sigma_vel^2 * ( headAngle_t - (2-rho_tf) .* rho_tf .* headAngle_feedback ) )  ...
%     / gamma^2;
var_error = ( sigma_mem^2 ...
    + sigma_vel^2 * ( target - (2-rho_tf) .* rho_tf .* headAngle_feedback ) )  ...
    / gamma^2;

% hack to remove -ve variances
var_error(var_error<0) = 0.0001;
