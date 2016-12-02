function newReward = calcReward(state, action)
%CALCREWARDS calculates the new reward for update in the scoreboad
%   This function likely to become obsolete after defining Q

switch action(2) % only operate on the acceleration for now
    case 1
        newReward = 1;
    case -1
        newReward = -.5;
    otherwise
        newReward = 0;
end

