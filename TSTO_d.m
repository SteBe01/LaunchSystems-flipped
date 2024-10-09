%% POINT d)
%We fix beta=1, and make alpha vary. For the Is, eps can be assumed
%different values (suggestion: use same values of 1 case of point c), so
%that you can compare the results of point c) and d))

clear; 
clc;
close all;

%Data:
m_pay = 5000;           % [kg]
dv = 10;                % [km/s] dv required. dv_req = dv_id + dv_loss
beta = 1;

%Assumptions:
Is1 = 400;              % [s]
Is2 = 350;              % [s]
eps1 = 0.1;
eps2 = 0.2;
dv_loss = 1.3;          % [km/s] assumed dv_loss

%Previous results:
m_tot_3STO = 191527;    % [kg]

%Problem setting:
dv_id = dv - dv_loss; % [km/s]

[M_tot, dv1, dv2] = ROBUST(beta, dv, dv_loss, [Is1, Is2], [eps1, eps2], m_pay, 0.001);

