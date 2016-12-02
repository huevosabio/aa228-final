function availableActions = getAvailableActions(state)

% we should modify this if we think we want to include state dependnet action set.

availableActions = [-1 -1; % lane down, decceleratecase 50 % 2
		-1 0; % 1 lane downcase 51 % 3
		-1 1; % lane down, acceleratecase 52 % 4
		0 -1; % decceleratecase 53 % 5
		0 0; % no actioncase 54 % 6
		0 1;  % acceleratecase 55 % 7
		1 -1; % lane up, decceleratecase 56 % 8
		1 0;  % 1 lane upcase 57 % 9
		1 1; % lane up, accelerateotherwise
		0 0]; % no action

end