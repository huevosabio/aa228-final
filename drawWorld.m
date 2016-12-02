function [rectangles, world, score, varargout] = drawWorld(obstacles, agent, rectangles, rewards, world, score, varargin)
%DRAWWORLD Draw the environment, our car, and the other vehicles
%   1. Draw the environment
%       Call once without obstacles to initialize figure
%   2. Draw the obstacles
%       position in obstacles denotes C.O.M.
%   3. Draw our car
%   4. Draw scoreboard
%
% units: 1 meter = 1 pixel
%
% Contribtors: John
%
if nargin == 0
%%   1.    

    % create the figure with some properties
    % Road is 1000 meters long and 3*4 meters wide (+ 4 m grass x 2) = 20
    world = figure('Name', 'AA228 Road', 'Position',[0 200 1000*10 20*10]);
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
    

elseif nargin > 0
%%   2.    
    figure(world);
    % draw obstacles
    for i = 1:size(obstacles,1)
        % Each obstacle is 6m long and 3m wide
        rearRightPos = [ obstacles(i,1)-3 , 4*obstacles(i,2)+.5];
        rectangles(i) = rectangle('Position',[ rearRightPos , 6 , 3], 'FaceColor', 'r');
    end
    
%%   3.
    % draw agent
    % agent is 6m long and 3m wide
    rearRightPos = [ agent(1)-3 , 4*agent(2)+.5];
    % add it to the end of the rectangles array
    rectangles(end) = rectangle('Position',[ rearRightPos , 6 , 3], 'FaceColor', 'b');
    
end

% make some adjustments to the size of figure
xlim([0 1000])
ylim([0 20])

%%   4.
if nargin == 0
    % create the figure with some properties
    score = figure('Name','AA288 ScoreBoard','Position',[100 600 400 400]);
  
end

end % EOF
