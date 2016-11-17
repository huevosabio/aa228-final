function [ obstacles ] = updateObstacles(obstacles, varargin)
%updateObstaclePositions Moves the vehicles in the obtsacles matrix
%according to their velocities and the elapsed time between iterations

%   Input:  obstacles numObs x 3 matrix
%           [ longitudinal position, lane, velocity ]
%           with as many rows as there are vehicles
%           position in units of meters

%   Output: obstacles

% constants
numObs = 20; %the number of vehicles on our road
length = 1000; %length of our track in meters
lanes = 3; %number of lanes in our road
period = .1; %number of seconds between iterations
aveV = 20; %average speed of vehicles on the road
sigmaV = 5; %deviation of speeds of vehicles on the road


%   If obstacles is not passed in, it must be created for the beginning of
%   the simulation:
if nargin == 0
    obstacles = nan(numObs,3); %intitialize
    normV = normrnd(aveV,sigmaV,numObs); %calculate the vehicles speeds
    for i = 1:numObs
       obstacles(i,1) = rand*length; %populate with positions and speeds
       obstacles(i,2) = randi(lanes);
       obstacles(i,3) = abs(normV(i)); %no negative speeds
    end
%   If obstacles is passed in, push them forward according to their speeds
else
    for i = 1:numObs
        obstacles(i,1) = obstacles(i,1) + period*obstacles(i,3);
        if obstacles(i,1) > 1000 % if vehicle goes beyond the track
            obstacles(i,1) = obstacles(i,1) - 1000; % send to beginning
        elseif obstacles(i,1) < 0
            obstacles(i,1) = obstacles(i,1) + 1000; %send to end
        end
    end
end

end %EOF

