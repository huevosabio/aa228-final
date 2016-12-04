function availableActions = getAvailableActions(state)

% Contribtors: Ramon, John, Molly

% switch on the current lane of the agent
switch state(1,2)
    case 1 % lane = 1. action(1) cannot be -1 (down)
        availableActions = [0 -10;   % deccelerate 10
                            0 -5;   % deccelerate 5
                            0 0;    % no action case
                            0 1;    % accelerate case
                            1 -10;   % lane up, deccelerate 10
                            1 -5;   % lane down, deccelerate 5
                            1 0;    % 1 lane up
                            1 1];    % lane up, accelerate]
    case 2 % lane = 2. All actions available
        availableActions = [-1 -10;  % lane down, deccelerate 10 
                            -1 -5;  % lane down, deccelerate 5
                            -1 0;   % 1 lane down case
                            -1 1;   % lane down, accelerate case
                            0 -10;   % deccelerate 10
                            0 -5;   % deccelerate 5
                            0 0;    % no action case
                            0 1;    % accelerate case
                            1 -10;   % lane up, deccelerate 10
                            1 -5;   % lane down, deccelerate 5
                            1 0;    % 1 lane up
                            1 1];    % lane up, accelerate]
    case 3 % lane = 3. action(1) cannot be 1 (up)
        availableActions = [-1 -10;  % lane down, deccelerate 10 
                            -1 -5;  % lane down, deccelerate 5
                            -1 0;   % 1 lane down case
                            -1 1;   % lane down, accelerate case
                            0 -10;   % deccelerate 10
                            0 -5;   % deccelerate 5
                            0 0;    % no action case
                            0 1];    % accelerate case

end