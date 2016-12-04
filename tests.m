% tests for reward


% test that there is no crash
state = [nan 1 nan; -9 0 0]; % same lane, car is behind, same velocity
action = [0 0]; %stay in this position
reward = calcReward(state, action);
assert(reward == 0);

% test right before bumper, no crash
state = [nan 1 nan; -6 0 0]; % same lane, car is right behind, same velocity
reward = calcReward(state, action);
assert(reward == 0);

%test bumper crash
state = [nan 1 nan; -5 0 0]; % same lane, car is right behind, same velocity
reward = calcReward(state, action);
assert(reward == -100);

%test no crash after action
state = [nan 1 nan; -11 0 0];
action = [0 1];
reward = calcReward(state, action);
assert(reward == 2);

%test no crash after action
state = [nan 1 nan; -8 0 0];
action = [0 1];
reward = calcReward(state, action);
assert(reward == 2);

%test bumper crash after action
state = [nan 1 nan; -7 0 0];
action = [0 1];
reward = calcReward(state, action)
assert(reward == -98);

%test overpass crash after action
state = [nan 1 nan; -9 0 0];
action = [0 9];
reward = calcReward(state, action)
assert(reward == -82);