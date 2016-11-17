function newReward = calcReward(action)
%CALCREWARDS Summary of this function goes here
%   Detailed explanation goes here

switch action(2) % only operate on the acceleration for now
    case 1
        newReward = 1;
    case -1
        newReward = -.5;
    otherwise
        newReward = 0;
end

