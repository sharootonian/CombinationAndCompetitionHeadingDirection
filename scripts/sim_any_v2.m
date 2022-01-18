function sub = sim_any_v2(model_flag, X, expt)

% unpack expt
fb_flag             = expt.fb_flag;
feedback            = expt.feedback;
headAngle_feedback  = expt.headAngle_feedback;
target              = expt.target;


% store some things on sub
sub.model_flag  = model_flag;
sub.FB          = expt.fb_flag;
sub.fb          = expt.feedback;
sub.fb_true     = expt.headAngle_feedback;
sub.target      = expt.target;
sub.Xsim       = X; % keep track of simulation parameters for parameter recovery


% four models
%   1. no feedback model
%   2. pure KF model
%   3. sampling model
%   4. averaging model
%

%% for all models no feedback trials are simulated with the no feedback model
ind = fb_flag == 0;
% note: replacing headAngle_t for variance input with target instead
% because headAngle_t is a response of the subject not a response of the
% model
% [m,v] = compute_noFeedbackModel_v1( X, target(ind), headAngle_t(ind) );
[m,v] = compute_noFeedback_v1( X, target(ind) );

% remember that compute_xxx functions compute the headAngle_t - target so
% have to add target in to get the actual response.  Also remember that v
% is a variance not a standard deviation!
sub.respond(ind) = target(ind) + m + sqrt(v) .* randn(sum(ind),1);


%% feedback trials are simulated with different models
ind = fb_flag == 1;


switch model_flag
    
    case 1 % no feedback model
        %[m,v] = compute_noFeedbackModel_v1( X, target(ind), headAngle_t(ind) );
        [m,v] = compute_noFeedback_v1( X, target(ind) );
        sub.respond(ind) = target(ind) + m + sqrt(v) .* randn(sum(ind),1);
                
    case 2 % pure Kalman filter model
        %[m,v] = compute_KFModel_v1( X, target(ind), headAngle_t(ind), feedback(ind), headAngle_feedback(ind) );
        [m,v] = compute_pureKalmanFilter_v1( X, target(ind), feedback(ind), headAngle_feedback(ind) );
        sub.respond(ind) = target(ind) + m + sqrt(v) .* randn(sum(ind),1);
        
    case 3 % averaging model
        %[m,v] = compute_averagingModel_v1( X, target(ind), headAngle_t(ind), feedback(ind), headAngle_feedback(ind) );
        [m,v] = compute_averaging_v1( X, target(ind), target(ind), feedback(ind), headAngle_feedback(ind) );
        sub.respond(ind) = target(ind) + m + sqrt(v) .* randn(sum(ind),1);
        
    case 4 % sampling model
        %[m, v, p_true] = compute_samplingModel_v1( X, target(ind), headAngle_t(ind), feedback(ind), headAngle_feedback(ind) );
        [m, v, p_true] = compute_sampling_v1( X, target(ind), target(ind), feedback(ind), headAngle_feedback(ind) );
        r = rand(size(p_true));
        i2 = r < p_true;
        i1 = ~i2;
        sub.respond(ind) = target(ind) ...
            + i1.*( m(:,1) + sqrt(v(:,1)) .* randn(sum(ind),1) ) ...
            + i2.*( m(:,2) + sqrt(v(:,2)) .* randn(sum(ind),1) );
    
end     

sub.respond = sub.respond'; % hack to make the format fit