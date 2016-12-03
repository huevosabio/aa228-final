function availableActions = getAvailableActions(state)
%
% we should modify this if we think we want to include state dependent action set.
%
% Agreed. This may need to become more complex to limit lane changes off the road - John
% What's going on with the action comments below?? - John
%
% Contribtors: Ramon, John
%

% switch on the current lane of the agent
switch state(1,2)
    case 1 % lane = 1. action(1) cannot be -1 (down)
        availableActions = [0 -1;   % deccelerate case 53 % 5
                            0 0;    % no action case 54 % 6
                            0 1;    % accelerate case 55 % 7
                            1 -1;   % lane up, deccelerate case 56 % 8
                            1 0;    % 1 lane up case 57 % 9
                            1 1;    % lane up, accelerate otherwise
                            0 0];   % no action
    case 2 % lane = 2. All actions available
        availableActions = [-1 -1;  % lane down, deccelerate case 50 % 2
                            -1 0;   % 1 lane down case 51 % 3
                            -1 1;   % lane down, accelerate case 52 % 4
                            0 -1;   % deccelerate case 53 % 5
                            0 0;    % no action case 54 % 6
                            0 1;    % accelerate case 55 % 7
                            1 -1;   % lane up, deccelerate case 56 % 8
                            1 0;    % 1 lane up case 57 % 9
                            1 1;    % lane up, accelerate otherwise
                            0 0];   % no action
    case 3 % lane = 3. action(1) cannot be 1 (up)
        availableActions = [-1 -1;  % lane down, deccelerate case 50 % 2
                            -1 0;   % 1 lane down case 51 % 3
                            -1 1;   % lane down, accelerate case 52 % 4
                            0 -1;   % deccelerate case 53 % 5
                            0 0;    % no action case 54 % 6
                            0 1;    % accelerate case 55 % 7
                            0 0];   % no action
end

end