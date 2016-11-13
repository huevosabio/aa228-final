% aa228Sim runs at the highest level of our simulation.  Call it to run our
% game.

close all;

% Constants and variables
simPeriod = .05;      % 10 msec, length of time between dynamic sims
actPeriod = 2;        % 2 sec, take an action every 2 seconds
playTime = 60;        % How many seconds to play a round?
iterations = 60/.05;  % How many simPeriod rounds do we want to run?
clear obstacles       % forg10ot last sim's obstacles
action = [0 0];
rewards = zeros(1, playTime/actPeriod);

% set up the road
[~, world, score] = drawWorld();
% define a new set of random obstacles
obstacles = updateObstacles();
% define the agent
agent = updateAgent();

% move forward in time!
for t = 1:iterations
    
    % intialize rects graphics array to contain cars
    rectangles = gobjects(size(obstacles,1)+1);
    
    % draw obstacles and agent
    [rectangles, handles] = drawWorld(obstacles, agent, rectangles, rewards, world, score);
    
    % pause for some fraction of a second
    pause(simPeriod);    
    
    % wait for action command, but only every actPeriod
    if mod(t*simPeriod,actPeriod) == 0
%         action = getArrowAction(); % HMI: arrow keys
        action = getNumAction(); % HMI: NumPad
    end
    
    % remove the cars before proceeding to the next iteration
    delete(rectangles);
    
    % push obstacles forward
    obstacles = updateObstacles(obstacles); 
    agent = updateAgent(agent,action);
    
    % add the reward associated with this state-action
    if mod(t*simPeriod,actPeriod) == 0
        
        rewards(t*simPeriod/actPeriod) = rewards(max([1 (t*simPeriod/actPeriod-1)])) + calcReward(action);

        figure(score);
        plot(rewards);
        
    end
    
    action = [0 0]; % reset action until next 2 second period.
end