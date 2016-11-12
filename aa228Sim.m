% aa228Sim runs at the highest level of our simulation.  Call it to run our
% game.

% Constants and variables
simPeriod = .05;   % 10 msec, length of time between dynamic sims
actPeriod = 2;    % 2 sec, take an action every 2 seconds
iterations = 10000; % How many simPeriod rounds do we want to run?
clear obstacles   % forg10ot last sim's obstacles
action = [0 0];

% set up the road
drawWorld(); 
% define a new set of random obstacles
obstacles = updateObstacles();
% define the agent
agent = updateAgent();

% move forward in time!
for t = 1:iterations
    
    % intialize rects graphics array to contain cars
    rectangles = gobjects(size(obstacles,1)+1);
    
    % draw obstacles and agent
    rectangles = drawWorld(obstacles, agent, rectangles);
    
    % pause for some fraction of a second
    pause(simPeriod);
    
    
    % wait for action command, but only every actPeriod
    if mod(t*simPeriod,actPeriod) == 0
        action = getArrowAction(); % HMI: arrow keys
        % action = getNumAction(); % HMI: NumPad
    end
    
    % remove the cars before proceeding to the next iteration
    delete(rectangles);
    
    % push obstacles forward
    obstacles = updateObstacles(obstacles); 
    agent = updateAgent(agent,action);
    action = [0 0];
end