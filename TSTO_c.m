%% #1
%WE TRY TO SOLVE THE PROBLEM USING THE SAME DATA OF THE POINT "a)": WE TRY
%THREE DFFERENT COMBINATIONS OF I_sp, eps_s

clear, clc
close all

% Assumption on t_burn of 150 seconds from similar rockets 
% From the slides about stagin tburn is always considered around 200 seconds
t_burn = 150;

Is1 = 250;              % [s]
Is2 = 340;              % [s]
Is3 = 410;              % [s]
eps1 = 0.07;
eps2 = 0.11;
eps3 = 0.15;
m_pay = 5000;           % [kg]
dv = 10;                % [km/s]
[~, m_tot_3STO, ~] = TANDEM([Is1 Is2 Is3]', [eps1 eps2 eps3]', dv, m_pay, 0);
% m_tot_3STO = 220420;    % [kg]

%CASE a: Is1'=Is1, Is2'=Is2
Is_case_a = [Is1, Is2]';
eps_case_a = [eps1, eps2]';
[m_case_a, mtot_case_a, mprop_case_a] = TANDEM(Is_case_a, eps_case_a, dv, m_pay, 0);
dm_perc_a = (mtot_case_a - m_tot_3STO)/m_tot_3STO*100; %percentage of increase mass compared to 3STO 
TW_case_a = computeTW(Is_case_a(1), mtot_case_a, mprop_case_a(1), t_burn);

%CASE b: Is1'=Is2, Is2'=Is3
Is_case_b = [Is2, Is3]';
eps_case_b = [eps2, eps3]';
[m_case_b, mtot_case_b, mprop_case_b] = TANDEM(Is_case_b, eps_case_b, dv, m_pay, 0);
dm_perc_b = (mtot_case_b - m_tot_3STO)/m_tot_3STO*100; %percentage of increase mass compared to 3STO
TW_case_b = computeTW(Is_case_b(1), mtot_case_b, mprop_case_b(1), t_burn);

%CASE c: Is1'=Is1, Is2'=Is3
Is_case_c = [Is1, Is3]';
eps_case_c = [eps1, eps3]';
[m_case_c, mtot_case_c, mprop_case_c] = TANDEM(Is_case_c, eps_case_c, dv, m_pay, 0);
dm_perc_c = (mtot_case_c - m_tot_3STO)/m_tot_3STO*100; %percentage of increase mass compared to 3STO
TW_case_c = computeTW(Is_case_c(1), mtot_case_c, mprop_case_c(1), t_burn);

%CHECK THE T/W RATIOS TO SEE IF THE MISSION CAN BE ACCOMPLISHED

%% #2
%WE TRY TO SOLVE THE PROBLEM USING THE DIFFERENT DATA: FOR I_sp, eps_s WE
%TAKE VALUES FROM OTHER TSTO LAUNCHERS

clear, clc
close all

% Assumption on t_burn of 200 seconds from literature (e.g. slides dello
% staging)
% NOTE: Similar rockets are more on the 150 seconds side
t_burn = 150;

% Is1 = 250;              % [s]
% Is2 = 410;              % [s]
% eps1 = 0.07;
% eps2 = 0.15;

% Is1 = 250;              % [s]
% Is2 = 410;              % [s]
% %Is3 = 300;              % [s]
% eps1 = 0.07;
% %eps2 = 0.15;
% eps3 = 0.15;

% Consider data similar to Atlas V and data from other rockets
Is1 = 300; % [s]
Is2 = 400; % [s]

eps1 = 0.07;
eps2 = 0.1;

m_pay = 5000;           % [kg]
dv = 10;                % [km/s]
[~, m_tot_3STO, ~] = TANDEM([250 340 410]', [0.07 0.11 0.15]', dv, m_pay, 0);

%CASE 2: Is1'=Is1, Is2'=Is2, eps1'=eps1, eps2'=eps3
Is_case_2 = [Is1, Is2]';
eps_case_2 = [eps1, eps2]';
[m_case_2, mtot_case_2, mprop_case_2] = TANDEM(Is_case_2, eps_case_2, dv, m_pay, 0);
dm_perc_2 = (mtot_case_2 - m_tot_3STO)/m_tot_3STO*100; %percentage of increase mass compared to 3STO 
TW_case_2 = computeTW(Is_case_2(1), mtot_case_2, mprop_case_2(1), t_burn);

%%

function TW = computeTW(Isp, m_tot, m_prop, t_burn)
    m_dot = m_prop/t_burn;
    TW = m_dot*Isp/(m_tot);
end