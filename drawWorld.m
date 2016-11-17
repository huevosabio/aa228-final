function [rectangles, world, score, varargout] = drawWorld(obstacles, agent, rectangles, rewards, world, score, varargin)
%DRAWWORLD Draw the environment, our car, and the other vehicles
%   1. Draw the environment
%       Road is 1000 meters long and 3*4 meters wide (+ 4 m grass x 2)
%       Call once without obstacles to initialize figure
%   2. Draw the obstacles
%       Each obstacle is 6m long and 3m wide
%       position in obstacles denotes C.O.M.
%   3. Draw our car
%   4. Draw scoreboard

% units: 1 meter = 1 pixel


%   1.
if nargin == 0
    
    % create the figure with some properties
    world = figure('Name', 'AA228 Road', 'Position',[0 200 1000*10 20*10]); %, 'OuterPosition',[0 100 1000*10 20*10]);
    hold on;
    % draw the grass
    grass  = rectangle('Position',[0 0 1000 20], 'FaceColor','g');
    % draw the pavement
    grey = [.4 .4 .4];
    pavement   = rectangle('Position',[0 4 1000 12], 'FaceColor',grey);
    % draw the dashed lane markers
    plot([0 1000],[8 8],'LineStyle','--','Color','w')
    plot([0 1000],[12 12],'LineStyle','--','Color','w')

    rectangles = []; % just to have it ...
    
%   2.
elseif nargin > 0
    
    figure(world);
    
    % draw obstacles
    for i = 1:size(obstacles,1)
        rearRightPos = [ obstacles(i,1)-3 , 4*obstacles(i,2)+.5];
        rectangles(i) = rectangle('Position',[ rearRightPos , 6 , 3], 'FaceColor', 'r');
    end
    
%   3.
    
    % draw agent
    rearRightPos = [ agent(1)-3 , 4*agent(2)+.5];
    rectangles(end) = rectangle('Position',[ rearRightPos , 6 , 3], 'FaceColor', 'b');
    
end

xlim([0 1000])
ylim([0 20])

%   4.

if nargin == 0
    % create the figure with some properties
    score = figure('Name','AA 288 ScoreBoard','Position',[100 600 400 400]);

% elseif nargin > 0
%     
%     length(rewards)
%     figure(score);
%     plot(rewards);
%     hold on;
%     
end

end % EOF

