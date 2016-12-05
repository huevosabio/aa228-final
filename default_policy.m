function pi0=default_policy(state)   %create a default policy
     actions=getAvailableActions(state);
     sizeofactions=size(actions);
     numActions=sizeofactions(1,1);
     k=randperm(numActions);
     pi0=actions(k(1),:);        %pick a random action from the available action
end
