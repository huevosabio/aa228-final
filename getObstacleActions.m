function obsActions = getObstacleActions(obstacles, randomActionProb)
	% chooses a random action (other than [0, 0]) with probablity randomActionProb
	% input: obstacles is the array of obstacles
	% output: array of actions with 2 columns and same number of rows as obstacles

	%NOTE: inspired from http://stackoverflow.com/questions/31665504/generate-random-samples-from-arbitrary-discrete-probability-density-function-in

	obsActions = zeros(size(obstacles,1), 2);

	for i = 1:size(obstacles,1)
		if rand < randomActionProb
			availableActions = getAvailableActions(obstacles(i,:));

			% discrete distr from 
			% completely arbitrary, favoring forward moving actions
			weights = 10 * (availableActions(2:end,2) + abs(availableActions(2:end,2))) + 1;
			weights = weights / sum(weights);
			cdf = [0; cumsum(weights)];
			interVal = interp1(cdf,[0:1/(length(cdf)-1):1],rand);
			choice = ceil(interVal*length(cdf));

			%choice = randsample(2:size(availableActions,1),1);
			obsActions(i,:) = availableActions(choice,:);
		end
	end
end