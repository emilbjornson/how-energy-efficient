%This Matlab script can be used to generate Figure 3 in the article:
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

%Range of channel gains (in dB)
beta_dB = -110:20:-70;

%Noise power spectral density at room temperature (-174 dBm/Hz) in dBW
N0_dBW = -174 - 30;

%Transmit power of 20 dBm, in dBW
P_dBW = -10;

%Define range of bandwidth numbers
B = logspace(-1,3,10)*1e9;


%% Compute results

%Compute the EE using (4)
EE = zeros(length(B),length(beta_dB));

for n = 1:length(beta_dB)
    
    EE(:,n) = (B/db2pow(P_dBW)).*log2(1+db2pow(P_dBW + beta_dB(n) - N0_dBW)./B);
    
end


%% Plot simulation results

%Plot Figure 3
figure;
hold on; box on; grid on;

plot(B/1e9,EE(:,3)/1e9,'r','LineWidth',2);
plot(B/1e9,EE(:,2)/1e9,'k--','LineWidth',2);
plot(B/1e9,EE(:,1)/1e9,'b-.','LineWidth',2);

set(gca,'XScale','log');
set(gca,'YScale','log');
xlabel('Bandwidth $(B)$ [GHz]','Interpreter','Latex');
ylabel('Energy efficiency [Gbit/Joule]','Interpreter','Latex');
legend({'$\beta=-70$ dB','$\beta=-90$ dB','$\beta=-110$ dB'},'Interpreter','Latex','Location','NorthWest');
