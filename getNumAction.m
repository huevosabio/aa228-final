function action = getNumAction()
%GETNUMACTION Summary of this function goes here
%   Detailed explanation goes here

k = waitforbuttonpress;
f = gcf;
val = double(get(f,'CurrentCharacter'))

if     val == 28
    action = [0 -1]; % deccelerate
elseif val == 29
    action = [0 1];  % accelerate
elseif val == 30
    action = [1 0];  % 1 lane up
elseif val == 31
    action = [-1 0]; % 1 lane down
end

end

