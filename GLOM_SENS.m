%% Glom sensitivity

clear, clc
close all

factor = 0.15;
n_vect = 25-1;

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
eps1_vect(end+1) = eps1;
eps2_vect = linspace(eps2*(1-factor), eps2*(1+factor), n_vect)';
eps2_vect(end+1) = eps2;
eps3_vect = linspace(eps3*(1-factor), eps3*(1+factor), n_vect)';
eps3_vect(end+1) = eps3;

m_stag_vect = zeros(3, 1, n_vect, n_vect, n_vect);
m_tot_vect = zeros(1, 1, n_vect, n_vect, n_vect);
m_prop_vect = m_stag_vect;

eps_mat = zeros(n_vect^3, 3);

idx = 1;
tic
for i1 = 1:length(eps1_vect)
    for i2 = 1:length(eps1_vect)
        for i3 = 1:length(eps1_vect)
            e = [eps1_vect(i1) eps2_vect(i2) eps3_vect(i3)]';
            [m_stag_temp, m_tot_temp, m_prop_temp] = TANDEM(Is, e, dv, m_pay, 0);
            m_stag_vect(:,:,i1,i2,i3) = m_stag_temp;
            m_tot_vect(:,:,i1,i2,i3) = m_tot_temp;
            m_prop_vect(:,:,i1,i2,i3) = m_prop_temp;

            eps_mat(idx, :) = e';
            idx = idx+1;
        end
    end
end
toc

% m = m_tot_vect(1,1,:,6,6);
% 
% plot(m_tot_vect(:,:,:,6,6), eps1_vect)

m_tot_vec = squeeze(m_tot_vect);
m_stag_vec = squeeze(m_stag_vect);
m_prop_vec = squeeze(m_prop_vect);

% scatter3(eps_mat(:,1), eps_mat(:,2), eps_mat(:,3), 40, m_tot_vec(:), 'filled')
% colorbar

%%

fig = figure; hold on; grid on;
plot(eps1_vect(1:end-1), squeeze(m_tot_vec(1:end-1, end, end)), 'DisplayName', "$\varepsilon_1$");
plot(eps2_vect(1:end-1), squeeze(m_tot_vec(end, 1:end-1, end)), 'DisplayName', "$\varepsilon_2$");
plot(eps3_vect(1:end-1), squeeze(m_tot_vec(end, end, 1:end-1)), 'DisplayName', "$\varepsilon_3$");
xline(eps1, 'k--', "Nominal $\varepsilon_1$", 'Interpreter','latex', 'HandleVisibility','off');
xline(eps2, 'k--', "Nominal $\varepsilon_2$", 'Interpreter','latex', 'HandleVisibility','off');
xline(eps3, 'k--', "Nominal $\varepsilon_3$", 'Interpreter','latex', 'HandleVisibility','off');
xlabel("$\varepsilon$", 'Interpreter','latex');
ylabel("GLOM");
legend("Interpreter","latex")

exportStandardizedFigure(fig, "GLOM_Sens", 0.5, 'addMarkers', false, 'forcedMarkers', 1, 'legendLocation', 'south', 'overwriteFigure', true);
