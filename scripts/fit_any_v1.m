function [Xfit, nLL, BIC, AIC] = fit_any_v1( sub, data_flag, model_flag, n_fit )

% [Xfit, nLL, BIC, AIC] = fit_any_v1( sub, data_flag, model_flag, n_fit )
% 
% Run fit for (almost) any combination of model and data
%
% four models
%   1. no feedback model
%   2. pure KF model
%   3. averaging model
%   4. sampling model
%
% data to fit
%   1. no feedback condition alone (only no feedback model makes sense to
%       fit this!)
%   2. feedback condition alone (fit all models and compare)
%   3. both no feedback and feedback conditions together
%

% general initial conditions and bounds
%       g    |   b   |  gamma | sigma_mem | sigma_vel |  s_0  | s_vel |  s_f  | omega
X0 = [  1        0        1         1           1          2      10       1     0.1  ];
LB = [  0      -180       0         0           0          0       0       0     0    ];
UB = [  2      +180       4        20          20         20      20      20     1    ];


switch model_flag
    
    case 1 % no feedback model
        % note have extra inputs on the function handle to make it play
        % nicely when we add data (which could potentially be data from the
        % feedback condition too)
        %model = @(x, tar, head_t, feed, head_f) ...
        %    lik_noFeedbackModel_v1(x, tar, head_t);
        model = @(x, tar, head_t, feed, head_f) ...
            lik_noFeedback_v1(x, tar, head_t);
        
        % when fitting this model alone we need to set gamma = 1
        v = 3; X0(v) = 1; LB(v) = 1; UB(v) = 1;
        n_parameters = 4;
        
    case 2 % pure Kalman filter model
        model = @(x, tar, head_t, feed, head_f) ...
            lik_pureKalmanFilter_v1(x, tar, head_t, feed, head_f);
        % when fitting this model alone we need to set s_f = 1
        v = 8; X0(v) = 1; LB(v) = 1; UB(v) = 1;
        
        n_parameters = 7;
    
    case 3 % averaging model
        model = @(x, tar, head_t, feed, head_f) ...
            lik_averaging_v1(x, tar, head_t, feed, head_f);
        n_parameters = 9;
    
    case 4 % sampling model
        model = @(x, tar, head_t, feed, head_f) ...
            lik_sampling_v1(x, tar, head_t, feed, head_f);
        n_parameters = 9;
    
end

switch data_flag
    case 1 % no feedback condition
        
        ind                 = sub.FB == 0;
        target              = sub.target(ind);
        headAngle_t         = sub.respond(ind);
        
        % load data into objective function
        obFunc = @(x) model(x, target, headAngle_t);
        n_dataPoints = sum(ind);
        
    case 2 % feedback condition alone
        
        ind                 = sub.FB == 1;
        target              = sub.target(ind);
        headAngle_t         = sub.respond(ind);
        headAngle_feedback  = sub.fb_true(ind);
        feedback            = sub.fb(ind);
        
        % load data into objective function
        obFunc = @(x) model(x, target, headAngle_t, feedback, headAngle_feedback);
        n_dataPoints = sum(ind);
        
    case 3 % both
        ind                 = sub.FB == 0;
        target_0            = sub.target(ind);
        headAngle_t_0       = sub.respond(ind);
        n_dataPoints_0      = sum(ind);
        
        ind                 = sub.FB == 1;
        target_1            = sub.target(ind);
        headAngle_t_1       = sub.respond(ind);
        headAngle_feedback_1 = sub.fb_true(ind);
        feedback_1          = sub.fb(ind);
        n_dataPoints_1      = sum(ind);
        % load data into objective function
        % NOTE: in this case we should always have the no feedback model in
        % the no feedback condition but then we ALSO get the model in the
        % feedback condition.  nLLs are summed to get the total negative
        % log-likelihood of the model
        obFunc = @(x) ...
            lik_noFeedback_v1(x, target_0, headAngle_t_0) ...
            + model(x, target_1, headAngle_t_1, feedback_1, headAngle_feedback_1);
        n_dataPoints = n_dataPoints_0 + n_dataPoints_1;
        
end

options = optimoptions('fmincon', 'display', 'off');
% set upper and lower bounds for resampling
LB2 = LB;
UB2 = UB;
% fit the model
count = 1;
while count <= n_fit
    % for i = 1:n_fit
    try
        [Xfit{count}, E(count)] = fmincon(obFunc, X0, [], [], [], [], LB, UB, [], options);
        count = count + 1;
    end
    X0 = rand(size(LB2)).*(UB2-LB2) + LB2;
    
end



[nLL,ind] = min(E);

Xfit = Xfit{ind};

BIC = 2 * nLL + log(n_dataPoints) * n_parameters;
AIC = 2 * nLL + 2 * n_parameters;