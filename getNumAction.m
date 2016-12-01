function action = getNumAction()
%GETNUMACTION waits for the user to enter an action at the numPad

k = waitforbuttonpress; % MATLAB won't proceed until a button is pressed
f = gcf;
val = double(get(f,'CurrentCharacter')); % map button press to a value

switch val
    
    case 49 % 1
        action = [-1 -1]; % lane down, deccelerate
    case 50 % 2
        action = [-1 0]; % 1 lane down
    case 51 % 3
        action = [-1 1]; % lane down, accelerate
    case 52 % 4
        action = [0 -1]; % deccelerate
    case 53 % 5
        action = [0 0]; % no action
    case 54 % 6
        action = [0 1];  % accelerate
    case 55 % 7
        action = [1 -1]; % lane up, deccelerate
    case 56 % 8
        action = [1 0];  % 1 lane up
    case 57 % 9
        action = [1 1]; % lane up, accelerate
    otherwise
        action = [0 0]; % no action
        fprintf('keystroke value = %s\n',num2str(val)) % see button press
end

end

