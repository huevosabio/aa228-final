function [states, t_probs] = propagateStateAction(state, action, simPeriod)
%propagateStateAction
% given a state and an action, it simulates one time step and returns the likely next states
% the new states 

% NOTES:
% this is currently discrete, once we include uncertain behavior of the other cars
% we could play with the idea of other states
% Unlike the simulation, here we only update with regards to the nearby objects, we don't care for the rest
% Code largely drawn from updateAgent
% we might want to include the x and v states of our agent in the mdp as well

% empty thing
[rows, cols] = size(state);
t_probs{1} = 1.0;
states{1} = NaN([rows, cols]);

% update w.r.t. lane

states{1}(1,2) = max(min(4, state(1,2) + action(1)), 1); % don't go outside of road - or maybe allow grass?
dL = states{1}(1,2) - state(1,2); %effective change (this should be cleaner)

if rows > 1 % counting the case where there are no intruders
	% update diff in velocities
	states{1}(2:end,3) = state(2:end,3) + action(2); % DOES NOT PROHIBIT GOING IN REVERSE!
	% update diff in lanes
	states{1}(2:end,2) = state(2:end,2) + dL; % safe guarded against grassy territory
	% updates diff in position
	states{1}(2:end,1) = state(2:end,1) + states{1}(2:end,2) * simPeriod; % no need to safe guard for end of track
end

end