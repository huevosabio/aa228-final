function availableActions = getAvailableActions(state)
%
% we should modify this if we think we want to include state dependent action set.
%
% Agreed. This may need to become more complex to limit lane changes off the road - John
% What's going on with the action comments below?? - John
%
% Contribtors: Ramon, John, Molly
%

% Contribtors: Ramon, John, Molly

% switch on the current lane of the agent
switch state(1,2)
    case 1 % lane = 1
        availableActions = [0 0;        %       no action
                            0 -8;      %               deccelerate 10
                            0 -2;       %               deccelerate 5
                            0 1;        %               accelerate
                            0 2;        %               accelerate
                            1 -8;      % lane up,      deccelerate 10
                            1 -2;       % lane up,      deccelerate 5
                            1 1;        % lane up,      accelerate
                            1 2;        % lane up,      accelerate
                            1 0];       % lane up
    case 2 % lane = 2
        availableActions = [0 0;        %       no action
                            0 -8;      %               deccelerate 10
                            0 -2;       %               deccelerate 5
                            0 1;        %               accelerate
                            0 2;        %               accelerate
                            -1 -8;     % lane down,    deccelerate 10 
                            -1 -2;      % lane down,    deccelerate 5
                            -1 1;       % lane down,    accelerate
                            -1 2;       % lane down,    accelerate
                            -1 0;       % lane down
                            1 -8;      % lane up,      deccelerate 10
                            1 -2;       % lane up,      deccelerate 5
                            1 1;        % lane up,      accelerate
                            1 2;        % lane up,      accelerate
                            1 0];       % lane up
    case 3 % lane = 3
        availableActions = [0 0;        %       no action
                            0 -8;      %               deccelerate 10
                            0 -2;       %               deccelerate 5
                            0 1;        %               accelerate
                            0 2;        %               accelerate
                            -1 -8;     % lane down,    deccelerate 10 
                            -1 -2;      % lane down,    deccelerate 5
                            -1 1;       % lane down,    accelerate
                            -1 2;       % lane down,    accelerate
                            -1 0];      % lane down
                        
end
