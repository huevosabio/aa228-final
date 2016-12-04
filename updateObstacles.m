function [ obstacles ] = updateObstacles(simPeriod, obstacles, varargin)
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
setUpMode = 2;                      %   1: random instruders; 
defineIntruders = [ 200, 1, 0;...       2: intruders init according to matrix defineIntruders
                    200, 2, 0];     % each row with 3 params: xPos, lane, speed

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
else
    for i = 1:size(obstacles,1)
        % propogate longitudinal postion according to speed
        obstacles(i,1) = obstacles(i,1) + simPeriod*obstacles(i,3);
        % if vehicle goes beyond the track
        if obstacles(i,1) > 1000
            obstacles(i,1) = obstacles(i,1) - 1000; % send to beginning
        elseif obstacles(i,1) < 0
            obstacles(i,1) = obstacles(i,1) + 1000; % or send to end
        end
    end
end

end %EOF

