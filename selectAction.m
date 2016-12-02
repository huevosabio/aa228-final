function [opt_action, opt_value] = selectAction(state, depth, simPeriod)
%selectAction/forwardSearch
% takes state s, and depth d
%pseudo code from the book

%%%%%% NOTES:
%% availableActions-> we have so far only discussed the scenario where all actions are available, 
%% and shortly mentioned the idea of making some actions unavailable, perhaps we should discuss this
%% potentialStates -> in a deterministic scenario (as is current), this will present just one next state;
%% however, we can explore the idea of other vehicles changing their behavior
%% T(s' | s,a ) -> is therefore 1.0 for that unique state

%function selectAction(s, d):
%	if d = 0:
%		return (nan, 0)
%	(a*, v*) = (nan, -inf)
%	for a in availableActions(s):
%		v = calcReward(s, a)
% 		for s' in potentialStates(s,a):
%			(a', v') = selectAction(s',d-1)
%			v = v + gamma * T(s' | s,a) v'
%		if v > v*:
%			(a*, v*) = (a,v)
%	return (a*,v*)
%

% gamma, not y
y = 0.9

if depth == 0
	% end of the search
	opt_action = nan;
	opt_value = 0;
	return
end

%default values
opt_action = nan;
opt_value = -inf;

%iterate over available actions and states
available_actions = getAvailableActions(state);
[nactions, columns] = size(available_actions);
for aidx = 1:nactions
	action = a(aidx, :);
	value = calcReward(state, action);
	[reachable_states, t_probs] = propagateStateAction(state, action, simPeriod);
	[~, nstates] = size(reachable_states);
	for sidx = 1:nstates
		next_state = reachable_states{sidx};
		[next_action, next_value] = selectAction(next_state, depth - 1, simPeriod);
		value = value + y * t_probs{sidx} * next_value;
	end
	if value > opt_value
		opt_action = action;
		opt_value = value;
	end
end

end
