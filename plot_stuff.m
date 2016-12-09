% plot stuff
close all;

%% phantoms
% numObs = [0	10	20	30	40	50	60	70	80];
% 
% spoofAve = [80	24.64705882	-0.058823529	17.41176471	28.41176471	11.11764706	20.82352941	24	7.470588235];
% noSpoofAve = [80	41	-88.23529412	-149.4705882	-147.4705882	-126.5882353	-31.11764706	-41.76470588	-2.705882353];
% 
% spoofVar = [0	48.99212563	58.73016119	35.86093864	6.571407079	29.45960815	6.118778176	6.525966235	33.36274366]./2;
% noSpoofVar = [0	47.55182931	95.63012657	174.483479	175.9405373	199.0087373	126.7433174	66.45345953	38.8265596]./2;
% 
% figure(); hold on;
% errorbar(numObs,spoofAve,spoofVar,'LineWidth',2)
% errorbar(numObs,noSpoofAve,noSpoofVar,'LineWidth',2)
% legend('Phantoms','No Phantoms')
% title('Reward per Action vs. Number of Intruders')
% xlim([-5 85])
% ylim([-200 100])

%% time to calc
% depth = [1 2 3 4 5 6];
% actions = [15 12 9 6 3];
% 
% calcMDPtimes = [5.44E-04	4.87E-04	5.69E-04	6.29E-04	6.93E-04;
%                 0.0037      0.0027      0.0021      0.0015      8.12E-04;
%                 0.0474      0.0227      0.01        0.0048      0.0012;
%                 0.5934      0.2202      0.0711      0.0151      0.0022;
%                 6.2795      2.5174      0.5188      0.0907      0.0047;
%                 86.031      23.1079     3.3506      0.4305      0.01];
%             
% logCalcMDPtimes = [ -3.26E+00	-3.31E+00	-3.24E+00	-3.20E+00	-3.16E+00
%                     -2.43E+00	-2.57E+00	-2.68E+00	-2.82E+00	-3.09E+00
%                     -1.32E+00	-1.64E+00	-2.00E+00	-2.32E+00	-2.92E+00
%                     -2.27E-01	-6.57E-01	-1.15E+00	-1.82E+00	-2.66E+00
%                     7.98E-01	4.01E-01	-2.85E-01	-1.04E+00	-2.33E+00
%                     1.93E+00	1.36E+00	5.25E-01	-3.66E-01	-2.00E+00];
%                 
% surf(actions,depth,logCalcMDPtimes, 'MeshStyle', 'none')
% title('log Time per Forward Search vs. Depth and |Action Space|')
% xlabel('|A|')
% xlim([2 15])
% ylabel('depth')
% ylim([1 6])
% zlabel('log( time )')

%% reward per depth
% depth =   [1 2 3 4];
% rewards = [-303.9354839	-5.35483871	0.483870968	21.41935484];
% var =     [220.9364141	63.14527458	45.48723392	21.20829751];
% 
% x = [.5 4.5];
% y = [0 0];
% 
% figure(); hold on;
% errorbar(depth,rewards,var,'o','LineWidth',2)
% plot(x,y,'--')
% title('Reward per Action vs. Forward Search Depth')
% breakyaxis([-250,-100]);

%% action histogram
laneChanges = AA228MDP_data.Action_History(:,1);
C = categorical(laneChanges,[-1 0 1],{'left','none','right'});
accelerations = AA228MDP_data.Action_History(:,2);
D = categorical(accelerations,[-8 -2 0 1 2],{'-8','-2','0', '1', '2'});
figure();
subplot(1,2,1)
histogram(C)
title('Lane Change Actions')
subplot(1,2,2)
histogram(D)
title('Acceleration Actions')


