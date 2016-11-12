function agent = updateAgent( agent,action,varargin )
%UPDATEAGENT Moves the agent according to it's state and action

% Output:   agent 3 x 1 array
%               [ longitudinal position, lane, velocity ]
%               position in units of meters

% Inputs:   agent
%           action 2 x 1 array
%               [ change lane? , change speed?]
%               +- 1 to adjust lane or speed

% constants
period = .1;

%   If no input args, initialize the agent 100 meters into the track
if nargin == 0
    agent = nan(3,1);
    agent(1) = 100;
    agent(2) = 2;
    agent(3) = 30; % starting speed - check to match aveV of obstacles?
    
else % must have agent and action input
    
    % respond to change lane action
    agent(2) = agent(2) + action(1);
    if     agent(2) > 3 % don't go outside of road - or maybe allow grass?
        agent(2) = 3;
    elseif agent(2) < 1
        agent(2) = 1;
    end
    % respond to change speed action
    agent(3) = agent(3) + 2*action(2);
    if agent(3) < 0
        agent(3) = 0; % don't move backwards??
    end
    
    % update agent state
    agent(1) = agent(1) + agent(3)*period;
    if agent(1) > 1000 % if agent goes beyond the track
        agent(1) = agent(1) - 1000; % send to beginning
    elseif agent(1) < 0
        agent(1) = agent(1) + 1000; %send to end
    end
    
end

end % EOF