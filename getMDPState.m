function state = getMDPState(agent, obstacles, spoofIntruders)
%GETMDPSTATE prepares the MDP state for Forward Search
%
% Given information about the agent's and obstacles' absolute positions,
% convert to a delta state containing relative positions
%
%   Inputs:
%       agent
%       obstacles
%
%   Output:
%       state (3 x nearObs+1)
%           value 1,2 contains the agent's obsolute lane
%           rows thereafter contain relative state info from agent to each obs:
%           [ deltaPositon, deltaLane, deltaSpeed ]
%           delta* = agent* - obstacle*
%
%
% Contribtors: John
%
% constants
trackLength = 1000;             % track length
dPosMax = 100;                   % only include obstacles less than 100m away
numObs = size(obstacles,1);     % how many obstacles exist?

% intialize state with a single row for agent's lane
state = [ agent(1) agent(2) agent(3) ];

% loop over each obstacle to populate relative states
for i = 1:numObs
    % save the positions of the agent and obstacle of interest
    agentPos = agent(1);
    obsPos = obstacles(i,1);
    
    % deal with wrap-around problems
    if agentPos <= dPosMax && obsPos >= trackLength - dPosMax
        agentPos = agentPos + trackLength;
    elseif obsPos <= dPosMax && agentPos >= trackLength - dPosMax
        obsPos = obsPos + trackLength;
    end
    
    % calculate relative position
    dPos = agentPos - obsPos;
    % if obstable is near, add it to the state
    if abs(dPos) <= dPosMax
        dLane = agent(2) - obstacles(i,2);
        dV = agent(3) - obstacles(i,3);
        % wish I was smart enough to pre-allocate...
        state = [ state ; dPos dLane dV ];
    end
end

if spoofIntruders == 1 % add probabilitistic obstacles beyond visible horizon
    
    numObsNearby = size(state,1)-1;                 % how many intruders can we see?
    state = [ state; -99 -99 -99];                  % placeholder so we can see in calcReward()
    if numObsNearby ~= 0
        dV = mean(state(2:numObsNearby+1,3));       % use average of visible car's dV
        for i = 1:numObsNearby
            dPos = -dPosMax*(1+2*rand);             % rand between dPosMax and 2*dPosMax away
            dLane = agent(2) - randi(3);            % place into a random lane
        %     dLane = i-1; % cheating? yes
            state = [ state; dPos dLane dV];
        end
    end

    %state = [state; -3*dPosMax -1 dV; -3*dPosMax 0 dV; -3*dPosMax 1 dV]; % cheating? yes
end

end

