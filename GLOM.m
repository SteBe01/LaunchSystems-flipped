%% GLOM (point A of whole flipped)

% NOTES FOR FLIPPED:
% groups of 2 or 3 people max
% 3-5 pages of report (1: introduction (small) - 2: equation detailing - 3: results and discussion)
% delivery: 2/3 days before final exam (genuary)

clear, clc
close all

Is1 = 250;              % [s]
Is2 = 340;              % [s]
Is3 = 410;              % [s]
Is = [Is1 Is2 Is3]';

eps1 = 0.07;
eps2 = 0.11;
eps3 = 0.15;
e = [eps1 eps2 eps3]';

m_pay = 5000;           % [kg]
dv = 10;                % [km/s]

[m_stag, m_tot, m_prop] = TANDEM(Is, e, dv, m_pay, 1);
