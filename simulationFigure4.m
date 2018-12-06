%This Matlab script can be used to generate Figure 4 in the article:
%
%Emil Bjornson, Erik G. Larsson, "How energy-efficient can a wireless
%communication system become?," Asilomar Conference on Signals, Systems,
%and Computers, Pacific Grove, USA, October 2018.
%
%Download article: https://arxiv.org/abs/1812.01688
%
%This is version 1.0 (Last edited: 2018-11-29)
%
%License: This code is licensed under the GPLv2 license. If you in any way
%use this code for research that results in publications, please cite our
%original article listed above.


close all;
clear;

%% Set parameter values

%Channel gain (in dB)
beta_dB = -80;

%Noise power spectral density at room temperature (-174 dBm/Hz) in dBW
N0_dBW = -174 - 30;

%Range of transmit power from 0 dBm to 40 dBm, measured in dBW
P_dBW = linspace(0,40,15) - 30;

%Range of bandwidth numbers in Hz
B = logspace(0,4,15)'*1e9;

%Set hardware-characterizing constants
nu = 1e-14; %J
eta = 1e-15; %J/bit


%% Compute results

%Compute the EE using (4) for all P and B values
P_dBW_repmat = repmat(P_dBW,[length(B) 1]);
B_repmat = repmat(B,[1 length(P_dBW)]);
C = B_repmat.*log2(1+db2pow(P_dBW_repmat + beta_dB - N0_dBW)./B_repmat);

%Compute the EE using (17)
EE = C ./ ( db2pow(P_dBW_repmat) + nu*B_repmat + eta*C);

%Compute x value in (19)
betaN0 = db2pow(beta_dB-N0_dBW);
e = exp(1);
x = lambertw(betaN0*nu/e - 1/e)+1;

%Compute optimal transmit power in (18) for the range of different B values
Pstar = (exp(x)-1)*B/betaN0;

%Compute the optimal EE in (21)
EEstar = x*log2(e)/( (exp(x)-1)/betaN0 + nu + eta*x*log2(e));

%Copmute the data rates at the optimal EE points for the range of different
%B values 
Cstar = B*x*log2(e);


%% Plot simulation results

%Plot Figure 4(a)
figure;
hold on; box on; grid on;
surf(P_dBW+30,B/1e9,EE/1e9,'LineWidth',1);
set(gca,'YScale','log');
set(gca,'ZScale','log');
xlabel('Transmit power $(P)$ [dBm]','Interpreter','Latex');
ylabel('Bandwidth $(B)$ [GHz]','Interpreter','Latex');
zlabel('Energy efficiency [Gbit/Joule]','Interpreter','Latex');
view(3);

plot3(pow2db(Pstar)+30,B/1e9,EEstar*ones(size(Pstar))/1e9,'k*-','LineWidth',4);
xlim([min(P_dBW+30) max(P_dBW+30)]);


%Plot Figure 4(b)
figure;
hold on; box on; grid on;
surf(P_dBW+30,B/1e9,C/1e9,'LineWidth',1); %,'FaceColor','interp'
set(gca,'YScale','log');
set(gca,'ZScale','log');
xlabel('Transmit power $(P)$ [dBm]','Interpreter','Latex');
ylabel('Bandwidth $(B)$ [GHz]','Interpreter','Latex');
zlabel('Data rate [Gbit/s]','Interpreter','Latex');
view(3);

plot3(pow2db(Pstar)+30,B/1e9,Cstar/1e9,'k*-','LineWidth',4);
xlim([min(P_dBW+30) max(P_dBW+30)]);

caxis([2 2e4]);
colormap(hsv);
