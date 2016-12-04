function newReward = calcReward(state, action)
%CALCREWARDS calculates the new reward for update in the scoreboad and for
%use in selectAction
%
%   Re-writing to return reward based on MDP state and action
%   Calculates sum of rewards from relative state of each intruder,
%   then adds (or subtracts) reward for accelerating
%
%   inputs:
%       state: (intruders+1) x 3 matrix
%           row 1       = [ position,     lane,      speed ]
%           rows 2:end  = [ deltaPositon, deltaLane, deltaSpeed ]
%                           delta* = agent* - obstacle*
%       action: 1 x 2 array
%           [ changeLane, changeSpeed ]
%
% Contributors: John, Ramon, Molly
%

%% constants and initializations
intruders = size(state,1) - 1;  % first row of state if for agent state
newReward = 0;                  % intialize
actPeriod = 2;                  % should we pass this in?
crashReward = -100;             % dominating cost for crashing
changeLaneReward = -1;          % minor cost to change lane
accelerateReward = 2;           % incentive to accelerate
decelerateReward = -1;          % minor cost to decelerate
carLength = 6;

%% loop over each intruder to find crashes
for i = 1:intruders
    % if deltaPos_1 * deltaPos_2 < 0,
    % and deltaLane + laneChangeAction == 0, agent and intruder crashed
    % x = (1/2)a * t^2 + v * t + x
    dx1 = state(i+1,1);
    dx2 = state(i+1,1) + actPeriod*state(i+1,3) + .5 * action(2) * actPeriod^2;
    sameLane = state(i+1,2) + action(1) == 0;
    if sameLane & ((dx1*dx2 <= 0) | (abs(dx1) - carLength < 0 | abs(dx2) - carLength < 0))
        newReward = newReward + crashReward;
    end
end

%% consider change lane action
if action(1) ~= 0 % changed lane
    newReward = newReward + changeLaneReward;
end

%% consider accelerate action
if action(2) > 0 % accelerating
    newReward = newReward + action(2)*accelerateReward;
elseif action(2) < 0 % decelerating
    newReward = newReward + abs(action(2))*decelerateReward;
end

%% old, calculated reward for accelating / decellerating
% switch action(2) % only operate on the acceleration for now
%     case 1
%         newReward = 1;
%     case -1
%         newReward = -.5;
%     otherwise
%         newReward = 0;
end

