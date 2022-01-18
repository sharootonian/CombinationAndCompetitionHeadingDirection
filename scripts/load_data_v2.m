function sub = load_data_v2(datadir, fname)

% subj	
% trial	
% condition	
% target	
% respond	
% error	
% trial_duration	
% fb	
% fb_true	
% fb_offset	
% fb_time
% conf angle

T = readtable([datadir fname]);

S = unique(T.subj);


for sn = 1:length(S)
    ind = strcmp(T.subj, S{sn});
    sub(sn).trial = T(ind,:).trial;
    sub(sn).FB = strcmp(T(ind,:).condition, 'FB');
    sub(sn).target = T(ind,:).target;
    sub(sn).respond = T(ind,:).respond;
    sub(sn).error = T(ind,:).error;
    sub(sn).trial_duration = T(ind,:).trial_duration;
    sub(sn).fb = T(ind,:).fb;
    sub(sn).fb_true = T(ind,:).fb_true;
    sub(sn).fb_offset = T(ind,:).fb_offset;
    sub(sn).fb_time = T(ind,:).fb_time;
    sub(sn).conf = T(ind,:).conf;
    sub(sn).viewAmount = T(ind,:).viewAmount;
end