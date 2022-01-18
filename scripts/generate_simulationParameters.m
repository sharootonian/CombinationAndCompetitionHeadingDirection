function Xsim = generate_simulationParameters(type,  N, varargin)

% Xsim = generate_simulatingParameters(type,  N, varargin)
%
% Generate N sets of parameters for simulation
%
% type = 1 => randomize from predefined LB and UB
%   function call is generate_simulatingParameters(1, N, LB, UB)
%
% type = 2 => randomize from LB = min(Xfit) and UB = max(Xfit)
%   function call is generate_simulatingParameters(2, N, Xfit)
% 
% type = 3 => scramble Xfit to remove correlations between parameters
%   generate_simulatingParameters(3, N, Xfit) scrambles all parameters
%   generate_simulatingParameters(3, N, Xfit, ind) scrambles only those
%       parameters specified in ind
%
% Robert Wilson 12/19/20

switch type
    
    case 1 % randomly choose parameters between predifined LB and UB
        LB = varargin{1};
        UB = varargin{2};
        %LB = [  0      -180       0         0           0          0       0       0     0    ];
        %UB = [  2      +180       4        20          20         20      20      20     1    ];
        for i = 1:N
            Xsim(i,:) = rand(size(LB)).*(UB-LB) + LB;
        end
        
    case 2 % compute LB and UB from Xfit and generate randomly from there
        
        Xfit = varargin{1};
        
        LB = min(Xfit);
        UB = max(Xfit);
        for i = 1:N
            Xsim(i,:) = rand(size(LB)).*(UB-LB) + LB;
        end
        
    case 3 % scramble Xfit - if ind is specified, only scrambles those parameters
        
        % get Xfit
        Xfit = varargin{1};
        
        % get parameters to randomize
        n_pars = size(Xfit,2);
        if nargin < 4
            ind = [1:n_pars]; 
        else
            ind = varargin{2};
        end
        
        for count = 1:N
            % randomly sample subject to match for unscrambled data
            sn = randperm(size(Xfit,1), 1);
            
            for i = 1:n_pars % for each parameter
                if sum(ind == i) > 0 % is this parameter randomly sampled?
                    % randomly sample parameter value
                    % get random subject for this parameter
                    r = randperm(size(Xfit,1), 1);
                    Xsim(count,i) = Xfit(r,i);
                else
                    % keep from this subject
                    Xsim(count,i) = Xfit(sn,i);
                end
            end
        end
        
        
    case 4 % do nothing
        % get Xfit
        Xfit = varargin{1};
        
        Xsim = Xfit;
end