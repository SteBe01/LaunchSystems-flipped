%% Glom sensitivity

clear, clc
close all

factor = 0.15;
n_vect = 10;

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

eps1_vect = linspace(eps1*(1-factor), eps1*(1+factor), n_vect)';
eps2_vect = linspace(eps2*(1-factor), eps2*(1+factor), n_vect)';
eps3_vect = linspace(eps3*(1-factor), eps3*(1+factor), n_vect)';

m_stag_vect = zeros(3, 1, n_vect, n_vect, n_vect);
m_tot_vect = zeros(1, 1, n_vect, n_vect, n_vect);
m_prop_vect = m_stag_vect;

for i1 = 1:length(eps1_vect)
    for i2 = 1:length(eps1_vect)
        for i3 = 1:length(eps1_vect)
            e = [eps1_vect(i1) eps2_vect(i2) eps3_vect(i3)]';
            [m_stag_temp, m_tot_temp, m_prop_temp] = TANDEM(Is, e, dv, m_pay, 0);
            m_stag_vect(:,:,i1,i2,i3) = m_stag_temp;
            m_tot_vect(:,:,i1,i2,i3) = m_tot_temp;
            m_prop_vect(:,:,i1,i2,i3) = m_prop_temp;
        end
    end
end

m = m_tot_vect(1,1,:,6,6);

plot(m_tot_vect(:,:,:,6,6), eps1_vect)
