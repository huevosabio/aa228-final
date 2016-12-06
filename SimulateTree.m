function q = Simulate(state, depth, actPeriod)
%selectAction Monte Carlo Tree Search
% takes state s, and depth d
% pseudo code from the book
%
% Contribtors: Molly
%
%function Simulate(s, d, pi0):
%	if d==0
%      return 0
%   if s not in T
%      for a in available actions
%          (N(s,a),Q(s,a))<-(N0(s,a),Q0(s,a))
%      T=T and {s}
%      return Rollout(s,d,pi0)
%   a<-argmax_a Q(s,a) + c*sqrt(log(N(s))/N(s,a))
%   (s',r) ~ G(s,a)
%   q<-r+y*Simulate(s',d-1,pi0)
%   N(s,a)<-N(s,a)+1
%   Q(s,a)<-Q(s,a)+(q-Q(s,a))/N(s,a)
%   return q



y = 0.9;
c = 0.1;  %exploration bonus constant
T=cell(1);           %initialize empty cell array T
statecell=num2cell(state,[1,2]);       % make states into one cell  %%Is there a better way to map the state into a single element?

if depth == 0
	% end of the search
	q=0;
end

actions = getAvailableActions(state);
[nactions, columns] = size(available_actions);

N=[];
Q=[];
%%%%expansion stage%%%%%%
elseif  any(ismember(statecell,T))==0   % if state not in T   %%this seems not working, ismember has to take in cell arrays of strings???
    N=[N; zeros(1,nactions)];     %expanding the N0, Q0 with a new state in T
    Q=[Q; zeros(1,nactions)];     %initialize with all zero input
%iterate over available actions
    for aidx = 1:nactions
	    action = actions(aidx, :);
        N(end,aidx)=0        %initialize N(s,a)
        Q(end,aidx)=calcReward(state,action);   %initialize Q(s,a)
        T=[T;statecell];   % expansion: add the current state to set T
	    q=Rollout(state,depth,actPeriod)
    end
end

Ns=0         %initialized the visit count for the state N(s)
%%%%Search stage%%%%%
else
%iterate over available actions
    Ns=Ns+1;     %update state visit count
    [bool, sidx]=ismember(statecell,T,'rows')     %find the corresponding state in T to locate Q(s,a)
    Ns=any(ismember(statecell,T))    %N(s), number of time the state is visited
    a=[0 0];
    v=-inf;
    for aidx = 1:nactions
	    action = actions(aidx, :);
        maximizevalue=Q(sidx,aidx)+c*sqrt(log(Ns)/N(sidx,aidx));
        if maximizevalue>v
           v=maximizevalue;
           a=action;
           optaidx=aidx;
        end
     end
    [sp, t_probs] = propagateStateAction(state, a, actPeriod);     %find(s',r) given (s,a)
    r=calcReward(state,a);
    q=r+y*SimulateTree(sp,depth-1,actPeriod);
    N(sidx,optaidx)=N(sidx,optaidx)+1;
    Q(sidx,optaidx)=Q(sidx,optaidx)+(q-Q(sidx,optaidx))/N(sidx,optaidx);
end