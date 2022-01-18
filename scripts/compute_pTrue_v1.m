function p_true = compute_pTrue_v1( X, feedback, headAngle_feedback )

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

% get radian form of s_f, s_vel, and s_0
s_f_rad = s_f / 180 * pi;
s_0_rad = s_0 / 180 * pi;
s_vel_rad = s_vel / 180 * pi;
headAngle_feedback_rad = headAngle_feedback;

inverse_pTrue = 1 + sqrt( s_f_rad^2 + s_0_rad^2 + s_vel_rad^2 * headAngle_feedback_rad ) ...
    .* exp( (feedback - gamma * headAngle_feedback).^2 ...
    ./ (2 * (s_f^2 + s_0^2 + s_vel^2 * headAngle_feedback ))) ...
    * (1-omega) / omega;

p_true = 1 ./ inverse_pTrue;