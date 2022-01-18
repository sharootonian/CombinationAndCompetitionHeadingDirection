function expt = generate_simulationTrials(sub, N)

% expt = generate_simulationTrials(sub, N)
%
% get N subjects worth of simulation trials by picking randomly from trials
% seen by subjects

for count = 1:N
    
    % pick a random subject to get trials from
    sn = randperm(length(sub), 1);
    
    % get the trials from this random subject
    expt(count).fb_flag             = sub(sn).FB;
    expt(count).target              = sub(sn).target;
    expt(count).headAngle_feedback  = sub(sn).fb_true;
    expt(count).feedback            = sub(sn).fb;
    
end