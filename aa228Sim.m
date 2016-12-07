
% AA228SIM
%
% Run to start our Forward Search MPD algorithm and simulation
%
% Authors: John, Molly, and Ramon

close all;          % reset the game and all figures
clear obstacles;    % forget last sim's obstacles

%% Constants and variables
simPeriod = .05;                    % 10 msec, length of time between dynamic sims
actPeriod = 2;                      % 2 sec, take an action every 2 seconds
playTime = 100;                      % How many seconds to play a round?
SIMiters = playTime/simPeriod;      % How many simPeriods will we run?
MDPiters = playTime/actPeriod;      % How many MDP decisions will we make?
depth = 4;                          % depth of Forward Search
rewards = 0;                        % init rewards history vector, one entry for 2 sec time step
randomActionProb = 0.0;             % prob that an obstacle it will execute a random aciton other than [0 0]

%% Initialize the simulation
% open the 'AA228 Road' figure and draw the road (world holds handle)
% open the 'AA228 Scoreboard' figure (score holds handle)
[~, world, score] = drawWorld();
% define a new set of random obstacles
obstacles = updateObstacles(simPeriod);
% define the agent
agent = updateAgent(simPeriod);

%% Data To Be Saved
absStateHist = nan(SIMiters*(1+size(obstacles,1)),3);   % all states over simulation
actionHist = nan(MDPiters,2);                           % all actions
rewardHist = nan(MDPiters,1);                           % all rewards

%% move forward simPeriod seconds (actions only requested at actPeriods)
MDPiteration = 0; % index for action / reward arrays, increments every actPeriod
for t = 0:SIMiters-1
    %% Save the state at beginning of iteration
    absStateHist( 1 + (t)*(1+size(obstacles,1)) : ...
                  1 + (t)*(1+size(obstacles,1)) + size(obstacles,1), : ) = [agent; obstacles];
    
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
        MDPiteration = MDPiteration + 1;
        % calculate the relative state needed for MDP
        state = getMDPState(agent, obstacles);
        
        % get an action, either by button press or MDP
%         action = getNumAction(); % HMI: NumPad
        [action, anticipatedReward] = selectAction(state, depth, actPeriod); % Forward Search

        % get actions by the obstacles
        obsActions = getObstacleActions(obstacles, randomActionProb);
        
        % Save action
        actionHist(MDPiteration,:) = action;
    end
    
    % propogate obstacles forward
    obstacles = updateObstacles(simPeriod, obstacles, obsActions );
    agent = updateAgent(simPeriod, agent, action );
    
    % add the reward associated with this state-action
    if mod(t*simPeriod,actPeriod) == 0
        newReward = calcReward(state, action);
        
        % for scoreboard graphic only
        rewards = [ rewards, rewards(end)+newReward ];
        figure(score);
        plot(rewards,'LineWidth',2);
        
        % save reward
        rewardHist(MDPiteration) = newReward;
    end
    
    %% cleanup before the end of this iteration
    % remove the cars before proceeding to the next iteration
    delete(rectangles);
    % reset action until next 2 second period.
    %action = [0 0];
    % reset lane action until next 2 second period
    action(1) = 0;
    obsActions(:,1) = 0;
end

%% Save Data
AA228MDP_data = struct('Absolute_State_History', absStateHist,...
                       'Action_History',         actionHist,...
                       'Reward_History',         rewardHist);
% check to see if filename already exists!
name = 'AA228MDP_data_';
index = 1;
indexChar = int2str(index);
while exist(strcat(name,indexChar,'.mat')) == 2
    index = index+1;
    indexChar = int2str(index);
end
save(strcat(name,indexChar),'AA228MDP_data');
                   