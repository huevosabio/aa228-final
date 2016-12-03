% AA228SIM
%
% Run to our Forward Search MPD algorithm and simulation
%
% Authors: John, Molly, and Ramon

close all; % reset the game and all figures

%% Constants and variables
simPeriod = .05;        % 10 msec, length of time between dynamic sims
actPeriod = 2;          % 2 sec, take an action every 2 seconds
playTime = 60;          % How many seconds to play a round?
iterations = 60/.05;    % How many simPeriod rounds do we want to run?
clear obstacles;        % forget last sim's obstacles
action = [0 0];         % initialize action to 'do nothing'
depth = 3;
% init rewards history vector, one entry for 2 sec time step
rewards = zeros(1, playTime/actPeriod);

%% Initialize the simulation
% open the 'AA228 Road' figure and draw the road (world holds handle)
% open the 'AA228 Scoreboard' figure (score holds handle)
[~, world, score] = drawWorld();
% define a new set of random obstacles
obstacles = updateObstacles(simPeriod);
% define the agent
agent = updateAgent(simPeriod);

%% move forward simPeriod seconds (actions only requested at actPeriods)
for t = 1:iterations
    %% Draw the obstacles and agents at this period's locations
    % intialize rects graphics array to contain cars
    rectangles = gobjects(size(obstacles,1)+1);
    % draw obstacles and agent
    [rectangles, handles] = drawWorld(obstacles, agent, rectangles, rewards, world, score);
    % pause for some fraction of a second
    pause(simPeriod);    
    
    %% call for new action, propogate cars, calc reward
    
    % get action command, but only every actPeriod
    if mod(t*simPeriod,actPeriod) == 0
        % calculate the relative state needed for MDP
        state = getMDPState(agent, obstacles)
        
        % get an action, either by button press or MDP
%         action = getArrowAction(); % HMI: arrow keys
        %action = getNumAction(); % HMI: NumPad
        action = selectAction(state, depth, simPeriod);
%         action = runForwardSearch()? % HMI: none
    end
    
    % propogate obstacles forward
    obstacles = updateObstacles(simPeriod, obstacles ); 
    agent = updateAgent(simPeriod, agent, action );
    
    % add the reward associated with this state-action
    if mod(t*simPeriod,actPeriod) == 0
        rewards(t*simPeriod/actPeriod) = rewards(max([1 (t*simPeriod/actPeriod-1)])) + calcReward(state, action);
        figure(score);
        plot(rewards);
    end
    
    %% cleanup before the end of this iteration
    % remove the cars before proceeding to the next iteration
    delete(rectangles);
    % reset action until next 2 second period.
    action = [0 0];
end