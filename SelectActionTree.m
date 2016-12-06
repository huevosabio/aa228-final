function q = SelectActionTree(state, depth, actPeriod)
%selectAction Monte Carlo Tree Search
% takes state s, and depth d
% pseudo code from the book
%
% Contribtors: Molly
%
%function SelectAction(s, d):
%    loop
%        Simulate(s,d,pi0);
%    return argmax_a Q(s,a)