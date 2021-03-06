function [states, t_probs] = propagateStateAction(state, action, actPeriod)
%propagateStateAction
% given a state and an action, it simulates one time step and returns the likely next states
% the new states 

% NOTES:
% this is currently discrete, once we include uncertain behavior of the other cars
% we could play with the idea of other states
% Unlike the simulation, here we only update with regards to the nearby objects, we don't care for the rest
% Code largely drawn from updateAgent
% we might want to include the x and v states of our agent in the mdp as well
%
% Contribtors: Ramon, Molly
%
% empty thing
[rows, cols] = size(state);
t_probs{1} = 1.0;                   % deterministic, for now
states{1} = NaN([rows, cols]);

%% Update Agent (first row of state)
% update w.r.t. xPos
states{1}(1,1) = state(1,1) + actPeriod*state(1,3) + 0.5 * action(2) * actPeriod^2;
% update w.r.t. speed
states{1}(1,3) = state(1,3) + action(2)*actPeriod;
% update w.r.t. lane
states{1}(1,2) = state(1,2) + action(1);
% line below not necessary, because getAvailableActions limits lane change options
% states{1}(1,2) = max(min(4, state(1,2) + action(1)), 1); % don't go outside of road - or maybe allow grass?
% dL = states{1}(1,2) - state(1,2); %effective change (this should be cleaner)

%% Update Relative States
if rows > 1 % counting the case where there are no intruders
	% update diff in velocities
	states{1}(2:end,3) = state(2:end,3) + action(2); % DOES NOT PROHIBIT GOING IN REVERSE!
	% update diff in lanes
	states{1}(2:end,2) = state(2:end,2) + action(1);
	% updates diff in position
        % BUG?!                                           2?
	states{1}(2:end,1) = state(2:end,1) + states{1}(2:end,3) * actPeriod; % no need to safe guard for end of track
end

end