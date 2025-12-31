% Analytic Design of the biogas burner
% Autor: Ketshia Ngalula Aziza
% 12 Febuary 2025
clc; clear; close all;
%% Open a file for writing
fileID = fopen('burner_analysis.txt', 'w');

%% User Inputs
fprintf('Inputs these values: \n');
d_p = input('Enter the flame port diameter (mm): ');
e = input ('Enter the inter port spacing (mm): ');
n = input ('Enter the number air inlets: ')
%% Constants
Cv_biogas = 22; % MJ/m^3
eta = 0.58; % burner efficiency
x_CH4 = 0.6; % mole fraction of ch4;
s = 0.94; % Specific gravity of biogas
Cd = 0.94; % Orifice discharge coefficient
rho = 1.0994; % kg/m^3 (biogas density)
rho_m = 1.15; % kg/m^3 (mixture density)
p= 10; % supply presure in mbar
mu = 1.71e-5; % Pa.s (dynamic viscosity at 30°C)
g = 9.81; % Gravity acceleration
v_p = 0.25; % Laminar flame speed (m/s)
P_required = 1.5; % kw


%% Step 1: Injector Design
Q_biogas = (3600 * P_required*10^(-3)) / (eta * Cv_biogas); % m^3/h
Q_biogas_s = Q_biogas / 3600; % m^3/s
Q_biogas_ss = rho * Q_biogas_s; % kg/s
fprintf(fileID,'Biogas Flow Rate: %.5f m^3/h (%.5f m^3/s)(%.5f kg/s)\n', Q_biogas, Q_biogas_s, Q_biogas_ss);

d_j = round(sqrt((Q_biogas) / (0.036 * Cd * sqrt(p/s))), 2); % mm
d_i = d_j * 10^(-3); %mm
fprintf(fileID,'Injector Diameter: %.5f mm (%.5f m)\n', d_j, d_i);
v_j = (4 * Q_biogas) /(3600 * pi * d_i^2); % m/s
fprintf(fileID, 'Fuel Jet Velocity: %.5f m/s\n', v_j);

%% Step 2: Air Entrainment Calculations and throat diameter design
% Compute air requirement based on combustion equation
R = x_CH4 * 9.52; % Corrected air requirement based on stoichiometric combustion % Stoichiometric air requirement
r = 0.5 * R;

d_t = round(d_j * ((r / (sqrt(s)) + 1)),2); % mm
d_t1= d_t*0.001; % m

Q_m = (Q_biogas * (1 + r)) / 3600; % m^3/s
fprintf(fileID, 'Optimum Mixture Flow Rate: %.5f m^3/s\n', Q_m);

v_t = v_j * (d_j^2 / d_t^2); % m/s

%% Step 2.1: Design with Stoichiometric Air Requirement
d_t2 = round(d_j * ((R /sqrt(s)) + 1), 2); % mm
d_t22 = d_t2*0.001; % m
fprintf(fileID, 'Throat Diameter (Design): %.5f mm (%.5f m)\n', d_t2, d_t22);

Q_m2 = (Q_biogas * (1 + R)) / 3600; % m^3/s
fprintf(fileID, 'Design Mixture Flow Rate: %.5f m^3/s\n', Q_m2);

v_t2 = v_j * (d_j^2 / d_t2^2); % m/s
fprintf(fileID, 'Design Gas Stream Velocity: %.5f m/s\n', v_t2);

%% Step 2.2: Mixing Tube Selection
mixing_type = input('Is the mixing tube a diffuser (1) or a cylinder (2)? ');
if mixing_type == 2
    L_t = 10 * d_t2; % mm
    L_t1 = L_t*0.001; % m
    fprintf(fileID,'Mixing Tube Length (Cylinder): %.5f mm\n', L_t);
else
    L_d = 2 * d_t; % mm
    L_t = 10 * d_t; % mm
    L_t1 = L_t*0.001; % m
    fprintf(fileID, 'Injector Nozzle Distance: %.5f mm\n', L_d);
    fprintf(fileID, 'Mixing Tube Length (Venturi): %.5f mm\n', L_t);
end

%% Step 2.3: Air Inlet Port Design
A_t = (pi * d_t2^2) / 4; % mm^2
d_air_inlet = round(sqrt((4 * A_t) / (n * pi)), 2); % mm
fprintf(fileID, 'Diameter of Each Air Inlet Port: %.5f mm\n', d_air_inlet);

%% Step 3: Pressure Drop Verification
p_t = 10^5 - rho * (v_j^2 / (2 * g)) * (1 - (d_j / d_t2)^4);
fprintf(fileID, 'Throat Pressure: %.5f Pa\n', p_t);

Re = (4 * rho_m * Q_m) / (pi * mu * d_t22);
if Re < 2000
    f = 64 / Re;
    fprintf(fileID, 'the flow is laminar. \n');
    fprintf(fileID, 'Reynold number: %.5f .\n', Re );
else
    f = 0.316 / (Re^(1/4));
    fprintf(fileID, 'the flow is turbulent. \n');
    fprintf(fileID, 'Reynold number: %.5f .\n', Re );
end

Delta_p = (f / 2) * rho * (16 * Q_m^2 * L_t1) / (pi^2 * d_t22^5);
fprintf(fileID, 'Pressure Drop: %.5f Pa\n', Delta_p);
if Delta_p < rho * (v_j^2 / (2 * g)) * (1 - (d_j / d_t2)^4)
    fprintf(fileID, 'Pressure drop is much lower than the driving pressure in the throat.\n');
end

%% Step 4: Flame Port Design
r_f = input ('Enter a number between 1 and 5 for the reduction factor: ');
A_p = (1.20 * Q_m) / v_p; % m^2
A_p2 = A_p * 10^6 ; % mm^2
n_p = round((4 * A_p2) / (r_f*pi * d_p^2));
fprintf(fileID, 'Number of total Flame Ports: %.5f\n', n_p);
fprintf(fileID, 'The total Flame Ports Aera: %.5f\n', A_p2);

%% step 5: Flame port confuguration.
% Distribute the total ports across three circles
if n_p < 35
    n1 = n_p;
    D1 = round (n1*(d_p + e)/pi,2);
    fprintf(fileID, 'Flame Ports (First Circle): %.5f, Diameter: %.5f mm\n', n1, D1);

elseif  n_p>= 35 && n_p < 50
    n1 = round (0.70*n_p); 
    n2 = n_p-n1;
    % Calculate the corresponding diameters of the circles
    D1 = round (n1*(d_p + e)/pi,2); 
    D2 = round(n2 * (d_p + e)/pi, 2);
    fprintf(fileID, 'Flame Ports (First Circle): %.5f, Diameter: %.5f mm\n', n1, D1);
    fprintf(fileID, 'Flame Ports (Intermediate Circle): %.5f, Diameter: %.5f mm\n', n2, D2);
elseif n_p>= 50 && n_p < 100
n1 = round (0.5*n_p); 
n2 = round(0.35*n_p);
n3 = n_p - (n1 + n2); 
% Calculate the corresponding diameters of the circles
D1 = round (n1*(d_p + e)/pi,2); 
D2 = round(n2* (d_p + e)/pi, 2);
D3 = round(n3 * (d_p + e)/pi, 2);
else 
n1 = round (0.45*n_p); 
n2 = round(0.35*n_p);
n3 = n_p - (n1 + n2); 
% Calculate the corresponding diameters of the circles
D1 = round (n1*(d_p + e)/pi,2); 
D2 = round(n2* (d_p + e)/pi, 2);
D3 = round(n3 * (d_p + e)/pi, 2);
fprintf(fileID, 'Flame Ports (First Circle): %.5f, Diameter: %.5f mm\n', n1, D1);
fprintf(fileID, 'Flame Ports (Intermediate Circle): %.5f, Diameter: %.5f mm\n', n2, D2);
fprintf(fileID, 'Flame Ports (Last Circle): %.5f, Diameter: %.5f mm\n', n3, D3);
end

%% Close the file
fclose(fileID);

fprintf('Burner analysis data saved in "burner_analysis.txt".\n');
