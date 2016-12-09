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

% Constants
roadLength = 1000; %300;   % meters
screenWidth = 1920*2; %1280; % pixels

if nargin == 0
%%   1.    

    % create the figure with some properties
    % Road is 1000 meters long and 3*4 meters wide (+ 4 m grass x 2) = 20
    world = figure('Name', 'AA228 Road', 'Position',[0 530 screenWidth 160]);
    h = gca;
    h.Position = [0 0 1 .8];
    set(world, 'menubar', 'none');
    hold on;
    % draw the grass
    grass  = rectangle('Position',[0 0 roadLength 20], 'FaceColor','g');
    % draw the pavement
    grey = [.4 .4 .4];
    pavement   = rectangle('Position',[0 4 roadLength 12], 'FaceColor',grey);
    % draw the dashed lane markers
    plot([0 roadLength],[8 8],'LineStyle','--','Color','w')
    plot([0 roadLength],[12 12],'LineStyle','--','Color','w')

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
    
    title('Stanford AA228 Project: Molly Zhang, Ramon Iglesias, John Alsterda');

end

xlim([0 roadLength]);

%%   4.
if nargin == 0
    % create the figure with some properties
    score = figure('Name','AA288 ScoreBoard','Position',[440 230 400 300]);
    set(score, 'menubar', 'none');
end

end % EOF
