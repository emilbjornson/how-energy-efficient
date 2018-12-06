%This Matlab script can be used to generate Figure 1 in the article:
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
beta_dB = -110:-50;

%Noise power spectral density at room temperature (-174 dBm/Hz) in dBW
N0_dBW = -174 - 30;


%% Compute results

%Computing the EE limit in (5) in dB scale
EE_dB = beta_dB - N0_dBW + 10*log10(log2(exp(1)));


%% Plot simulation results

%Plot Figure 1
figure;
hold on; box on; grid on;
plot(beta_dB,10.^(EE_dB/10)/1e9,'LineWidth',2);
set(gca,'YScale','log');
xlabel('Channel gain $\beta=|h|^2$ [dB]','Interpreter','Latex');
ylabel('Energy efficiency [Gbit/Joule]','Interpreter','Latex');