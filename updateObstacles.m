function [ obstacles ] = updateObstacles(simPeriod, obstacles, obsActions, varargin)
%updateObstaclePositions Moves the vehicles in the obtsacles matrix
%according to their velocities and the elapsed time between iterations

%   Input:  obstacles numObs x 3 matrix
%           [ longitudinal position, lane, velocity ]
%           with as many rows as there are vehicles
%           position in units of meters
%
%   Output: obstacles
%
% Contribtors: John
%

%% constants
numObs = 20;                        % number of vehicles on our road
trackLength = 1000;                 % length of track in meters
lanes = 3;                          % number of lanes in our road
aveV = 20;                          % average speed of vehicles on the road
sigmaV = 5;                         % deviation of speeds of vehicles on the road
setUpMode = 1;                      %   1: random instruders;
randomActionProb = 0.1;                   % Probability that it will execute a random action, set 0.0 to make it deterministic
                                    %   2: intruders init according to matrix defineIntruders
%defineIntruders = [ 100, 1, 0;...   
%                    100, 2, 0];     % 2 non-moving intruders - needs to change lane twice
%defineIntruders = [ 150, 1, 0;...   
%                    150, 2, 0;...
%                    160, 1, 0;...
%                    160, 2, 0];     % must decelerate!
defineIntruders = [ 150, 1, 0;...   
                    150, 2, 0;...
                    150, 3, 0;...
                    160, 1, 0;...
                    160, 2, 0;...
                    160, 3, 0;];     % choose between three crashes
%defineIntruders = [ 100, 3, 0];     % 1 obstacle, outta the way                 

%% If obstacles not passed in, must be created for the beginning of simulation:
if nargin == 1
    % initialize intruders according to setUpMode
    if setUpMode == 1 % numObs random intruders
        % intitialize obstacles matrix
        obstacles = nan(numObs,3);
        % calculate the vehicles speeds, each distributed normally
        normV = normrnd(aveV,sigmaV,numObs);
        for i = 1:numObs
           % populate with positions and speeds
           obstacles(i,1) = rand*trackLength;
           obstacles(i,2) = randi(lanes);
           obstacles(i,3) = abs(normV(i)); %no negative speeds
        end
    elseif setUpMode == 2 % obstacles exactly as written to defineIntruders
        obstacles = defineIntruders;
    end
    
% If 'obstacles' is passed in, push them forward according to their speeds
% NOTE: this could be vectorized
else
    for i = 1:size(obstacles,1)
        %propagate lane changes
        obstacles(i,2) = obstacles(i,2) + obsActions(i,1);
        if     obstacles(i,2) > 3 % don't go outside of road - or maybe allow grass?
            obstacles(i,2) = 3;
        elseif obstacles(i,2) < 1
            obstacles(i,2) = 1;
        end


        % propogate longitudinal postion according to speed
        obstacles(i,1) = obstacles(i,1) + obstacles(i,3)*simPeriod + 0.5 * obsActions(i,2) * simPeriod^2;
        % if vehicle goes beyond the track
        if obstacles(i,1) > 1000
            obstacles(i,1) = obstacles(i,1) - 1000; % send to beginning
        elseif obstacles(i,1) < 0
            obstacles(i,1) = obstacles(i,1) + 1000; % or send to end
        end

        obstacles(i,3) = obstacles(i,3) + obsActions(i,2) * simPeriod;
    end
end

end %EOF

