function Q=Rollout(state,depth,actPeriod)
%   Rollout function in Monte Carlo Tree Search
%   pseudo code from book
%   function Rollout(s,d,pi0)
%       if d==0
%          return 0
%   a ~ pi0(s)
%   (s',r) ~ G(s,a)
%   return r+y*Rollout(s',d-1,pi0)

    y=0.9;

    if depth==0
       Q=0;
    end
    action=default_policy(state);
    [sp, t_probs] = propagateStateAction(state, action, actPeriod);
    r=calcReward(state,action)
    Q=r+y*Rollout(sp,depth-1);
end


