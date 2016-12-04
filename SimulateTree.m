function q = Simulate(state, depth, pi0, actPeriod)
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
T=cell(1);           %initialize empty cell array T
statecell=num2cell(state,[1,2]);       % make states into one cell

if depth == 0
	% end of the search
	return 0
end

if  any(ismember(statecell,T))==0   % if state not in T
%iterate over available actions
available_actions = getAvailableActions(state);
[nactions, columns] = size(available_actions);
for aidx = 1:nactions
	action = available_actions(aidx, :);
    N0=0;
    Q0=calcReward(state,action);
    N=N0;
    Q=Q0;
    T=[T;statecell]   %expansion: add the current state to set T
	return Rollout(s,d,pi0)

end
