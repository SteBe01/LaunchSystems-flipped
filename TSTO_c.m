%% #1
%WE TRY TO SOLVE THE PROBLEM USING THE SAME DATA OF THE POINT "a)": WE TRY
%THREE DFFERENT COMBINATIONS OF I_sp, eps_s

clear, clc
close all

Is1 = 400;              % [s]
Is2 = 350;              % [s]
Is3 = 300;              % [s]
eps1 = 0.1;
eps2 = 0.15;
eps3 = 0.2;
m_pay = 5000;           % [kg]
dv = 10;                % [km/s]
m_tot_3STO = 191527;    % [kg]

%CASE a: Is1'=Is1, Is2'=Is2
Is_case_a = [Is1, Is2]';
eps_case_a = [eps1, eps2]';
[m_case_a, mtot_case_a, mprop_case_a] = TANDEM(Is_case_a, eps_case_a, dv, m_pay, 0);
dm_perc_a = (mtot_case_a - m_tot_3STO)/m_tot_3STO; %percentage of increase mass compared to 3STO 

%CASE b: Is1'=Is2, Is2'=Is3
Is_case_b = [Is2, Is3]';
eps_case_b = [eps2, eps3]';
[m_case_b, mtot_case_b, mprop_case_b] = TANDEM(Is_case_b, eps_case_b, dv, m_pay, 0);
dm_perc_b = (mtot_case_b - m_tot_3STO)/m_tot_3STO; %percentage of increase mass compared to 3STO

%CASE c: Is1'=Is1, Is2'=Is3
Is_case_c = [Is1, Is3]';
eps_case_c = [eps1, eps3]';
[m_case_c, mtot_case_c, mprop_case_c] = TANDEM(Is_case_c, eps_case_c, dv, m_pay, 0);
dm_perc_c = (mtot_case_c - m_tot_3STO)/m_tot_3STO; %percentage of increase mass compared to 3STO

%CHECK THE T/W RATIOS TO SEE IF THE MISSION CAN BE ACCOMPLISHED

%% #2
%WE TRY TO SOLVE THE PROBLEM USING THE DIFFERENT DATA: FOR I_sp, eps_s WE
%TAKE VALUES FROM OTHER TSTO LAUNCHERS

clear, clc
close all

Is1 = 400;              % [s]
Is2 = 350;              % [s]
Is3 = 300;              % [s]
eps1 = 0.1;
eps2 = 0.15;
eps3 = 0.2;
m_pay = 5000;           % [kg]
dv = 10;                % [km/s]
m_tot_3STO = 191527;    % [kg]

%CASE 2: Is1'=Is1, Is2'=Is2, eps1'=eps1, eps2'=eps3
Is_case_2 = [Is1, Is2]';
eps_case_2 = [eps1, eps3]';
[m_case_2, mtot_case_2, mprop_case_2] = TANDEM(Is_case_2, eps_case_2, dv, m_pay, 0);
dm_perc_2 = (mtot_case_2 - m_tot_3STO)/m_tot_3STO; %percentage of increase mass compared to 3STO 