function [M_tot, dv1, dv2] = ROBUST(beta, dv, dv_loss, Is, e, m_pay, h)
%ROBUST applies the "brute force" method to compare the dv balance between
%stages to find the optimal mass for the launchers.
% First version: 09/10/2024
% Author: Pietro Bolsi
% More stages strategies can be implemented using alpha, beta vectors (dim
% = #stages -1), plot is a #stages dimensional representation.

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
% dv = c * log( 1 / MR ) = -c * log( MR ).  MR = Mf/M0. c = Is * g.

if nargin < 7

    h = 0.01;

end

alpha = 0:h:1 ;

n = length(alpha);

dv1 = zeros(n, 1); % [km/s]
dv2 = zeros(n, 1); % [km/s]
MR = zeros(2, n); % [kg/kg]
M = zeros(2, n); % [kg]
M_tot = zeros(n, 1); % [kg]

for i = 1:n

    a = alpha(i);

    dv1(i) = a * dv_id + beta * dv_loss;
    MR(1, i) = exp( -dv1(i) / c(1) );          %row containing the MR of stages 1
    dv2(i) = (1-a) * dv_id + (1-beta) * dv_loss;
    MR(2, i) = exp( -dv2(i) / c(2) );          %row containing the MR of stages 2

    M(2, i) = (1 - MR(2, i)) * m_pay / (MR(2, i) - e(2));             %row containing the Mass of the Second stage wrt each alpha
    M(1, i) = (1 - MR(1, i)) * (m_pay + M(2, i)) / (MR(1, i) - e(1)); %row containing the Mass of the First stage wrt each alpha
    M_tot(i) = sum(M(:, i)) + m_pay;     %vector of the total masses for each alpha value

end

MR  %controlla calcolo m1, m2
grid on
plot(alpha, M_tot)

end

