function agent = updateAgent( simPeriod, agent, action, varargin )
%UPDATEAGENT Moves the agent according to its state and action
%
% Output:   agent 1 x 3 array
%               [ longitudinal position, lane, velocity ]
%               position in units of meters
%
% Inputs:   agent
%           action 2 x 1 array
%               [ change lane? , change speed?]
%               +- 1 to adjust lane or speed
%
% Contributors: John
%

% constants
length = 1000;      % length of our track in meters
lanes = 3;          % number of lanes in road
v = 30;             % initial speed of agent
x = 100;            % initial position of agent
l = 1;              % initial lane of agent

%   If no input args, initialize the agent
if nargin == 1
    agent = nan(1,3);
    agent(1) = x;
    agent(2) = l;
    agent(3) = v;
    
else % must have agent and action input
    % respond to change lane action
    agent(2) = agent(2) + action(1);
    if     agent(2) > 3 % don't go outside of road - or maybe allow grass?
        agent(2) = 3;
    elseif agent(2) < 1
        agent(2) = 1;
    end

     % update agent longitudinal position
    agent(1) = agent(1) + agent(3)*simPeriod + 0.5 * action(2) * simPeriod^2;
    if agent(1) > 1000 % if agent goes beyond the track
        agent(1) = agent(1) - 1000; % send to beginning
    elseif agent(1) < 0
        agent(1) = agent(1) + 1000; % or send to end
    end
    
    % respond to change speed action
    agent(3) = agent(3) + action(2) * simPeriod;
    %if agent(3) < 0
    %    agent(3) = 0; % don't move backwards
    %end
end

end % EOF