function [M_tot, dv1, dv2, MASS] = ROBUST(beta, dv, dv_loss, Is, e, m_pay, h)
%ROBUST applies the "brute force" method to compare the dv balance between
%stages to find the optimal mass for the launchers.
% First version: 09/10/2024
% Author: Pietro Bolsi
% More stages strategies can be implemented using alpha, beta vectors (dim
% = #stages -1), plot is a #stages dimensional representation.

if dv_loss > dv
    error('Losses cannot be greater than the required dv');
end

%Problem setting:
dv_id = dv - dv_loss; % [km/s]    dv == dv_req
g = 9.80665; %[m/s^2]
c = Is*g/1000; %[m/s]

% dv_req = dv_id + dv_loss
% dv_req = dv1 + dv2
% dv1 = alpha * dv_id + beta * dv_loss
% dv2 = (1-alpha) * dv_id + (1-beta) * dv_loss
%
% Tsiolkovsky:
% dv = c * log( n ) = -c * log( MR ).  MR = Mf/M0. c = Is * g. n=1/MR.

if nargin < 7
    h = 0.01;
end

%Compute alpha extremes:
a_m = 1 - (1 / dv_id) * ( c(2) * log( 1/e(2) ) + ( beta-1 ) * dv_loss ) + 0.01;
a_M =     (1 / dv_id) * ( c(1) * log( 1/e(1) ) -  beta * dv_loss ) - 0.01;
if a_M < a_m
    disp('Launch not possible');
end
a_min = max(a_m, 0);
a_max = min(a_M, 1);

alpha = a_min:h:a_max ;

l = length(alpha);

%Initialize:
dv1 = zeros(l, 1); % [km/s]
dv2 = zeros(l, 1); % [km/s]
n = zeros(2, l); % [kg/kg]
M = zeros(3, l); % [kg]
M(3, :) = m_pay * ones(1, l); % [kg]
M_tot = zeros(l, 1); % [kg]

for i = 1:l

    a = alpha(i);

    dv1(i) = a * dv_id + beta * dv_loss;
    n(1, i) = exp( dv1(i) / c(1) );          %row containing the n of stages 1
    dv2(i) = (1-a) * dv_id + (1-beta) * dv_loss;
    n(2, i) = exp( dv2(i) / c(2) );          %row containing the n of stages 2

    M(2, i) = (n(2, i) - 1) * sum(M(:, i)) / (1 - n(2, i)*e(2)); %row containing the Mass of the Second stage wrt each alpha    
    M(1, i) = (n(1, i) - 1) * sum(M(:, i)) / (1 - n(1, i)*e(1)); %row containing the Mass of the First stage wrt each alpha
    
    M_tot(i) = sum(M(:, i));     %vector of the total masses for each alpha value

end

MASS.M0_min = min(M_tot);
c = find( M_tot == min(M_tot) );
MASS.stg2 = M(2, c); 
MASS.stg1 = M(1, c); 
MASS.prop2 = MASS.stg2 * (1-e(2));
MASS.prop1 = MASS.stg1 * (1-e(1));

figure(1);
plot(alpha, M_tot);
xlabel('alpha');
ylabel('M_{tot} [kg]');
grid on

figure(2);
v_staging = dv1 - beta * dv_loss;
plot(v_staging, M_tot);
xlabel('Staging speed [km/s]');
ylabel('M_{tot} [kg]');
grid on

end

