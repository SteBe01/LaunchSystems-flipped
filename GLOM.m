%% GLOM (point A of whole flipped)

% NOTES FOR FLIPPED:
% groups of 2 or 3 people max
% 3-5 pages of report (1: introduction (small) - 2: equation detailing - 3: results and discussion)
% delivery: 2/3 days before final exam (genuary)

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

g = 9.81;

c1 = Is1*g/1000;
c2 = Is2*g/1000;
c3 = Is3*g/1000;

c = [c1 c2 c3]';
e = [eps1 eps2 eps3]';

fun = @(lambda) dv - c1*log(lambda*c1-1) - c2*log(lambda*c2-1) - c3*log(lambda*c3-1) + log(lambda)*sum(c) + sum(c.*log(c.*e));
lambda = fsolve(fun, 1);

m = (lambda.*c-1)./(lambda.*c.*e);

m3 = (m(3)-1)/(1-eps3*m(3))*m_pay;
m2 = (m(2)-1)/(1-eps2*m(2))*(m_pay+m3);
m1 = (m(1)-1)/(1-eps1*m(1))*(m_pay+m3+m2);
m_tot = m3 + m2 + m1 + m_pay;

ms3 = m3*eps3;
ms2 = m2*eps2;
ms1 = m1*eps1;
mp3 = m3-ms3;
mp2 = m2-ms2;
mp1 = m1-ms1;