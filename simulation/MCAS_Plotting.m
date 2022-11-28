function MCAS_Plotting(output_name, anomaly_params, no_anomalies_output)
%% Input Parameters for chart
start_time_s = 0;
end_time_s = max(output_name.tout);
sample_rate_hz = 120;   % dependent on incoming data

%% Plotting Framework
t_start_i = 1 + start_time_s * sample_rate_hz;
t_end_i = end_time_s * sample_rate_hz;
t_arr = t_start_i:t_end_i;

%% Data from Simulink
time = output_name.tout(:);
h_asl = output_name.h_asl.Data(:);
h_dot = output_name.h_dot.Data(:);
pitch = output_name.pitch.Data(:);
pitch_rate = output_name.pitch_rate.Data(:);
heading = output_name.heading.Data(:);
heading_rate = output_name.heading_rate.Data(:);
roll = output_name.roll.Data(:);
roll_rate = output_name.roll_rate.Data(:);
beta = output_name.beta.Data(:);
vc = output_name.vc.Data(:);
throttle_cmd = output_name.throttle_0_cmd.Data();
elevator_cmd = output_name.pilot_elevator_cmd.Data(:);

latitude = output_name.lat_deg.Data(:);
longitude = output_name.long_deg.Data(:);
alpha_deg = output_name.alpha_deg.Data(:);

a_pilot_z_ft_sec2 = output_name.a_pilot_z_ft_sec2.Data(:);

JT610_time_sec = readmatrix("JT610_Granular_ADSB_Data.xlsx", "Range", "D2:D845");
JT610_altitude = readmatrix("JT610_Granular_ADSB_Data.xlsx", "Range", "I2:I845");

% n_time = no_anomalies_1_output.tout(:);
% n_h_asl = no_anomalies_1_output.h_asl.Data(:);
% n_h_dot = no_anomalies_1_output.h_dot.Data(:);
% n_pitch = no_anomalies_1_output.pitch.Data(:);
% n_pitch_rate = no_anomalies_1_output.pitch_rate.Data(:);
% n_heading = no_anomalies_1_output.heading.Data(:);
% n_heading_rate = no_anomalies_1_output.heading_rate.Data(:);
% n_roll = no_anomalies_1_output.roll.Data(:);
% n_roll_rate = no_anomalies_1_output.roll_rate.Data(:);
% n_beta = no_anomalies_1_output.beta.Data(:);
% n_vc = no_anomalies_1_output.vc.Data(:);
% n_throttle_cmd = no_anomalies_1_output.throttle_0_cmd.Data();

%% Plotting
% plot_j610_data();
% plot_3d(output_name);
plot_alt_speed(output_name);
% figure;
% plot(time, pitch);

% i_start_t = find(time>=anomaly_params(1).StartTime,1);
% i_end_t = find(time>=anomaly_params(1).EndTime,1);
% yyaxis right;
% plot(time, elevator_cmd, 'LineWidth', 0.5);
% hold on;
% time_t = linspace(0, 300, length(alpha_deg));
% plot(time_t, alpha_deg, 'LineWidth', 0.5, 'LineStyle', '-');
% ylabel('AoA');
% yyaxis left;
% hold on;
% plot(time, h_asl, 'LineWidth', 1, 'Color', 'g', 'LineStyle', '-');
% hold on;
% plot(time(t_start_i:i_start_t), h_asl(t_start_i:i_start_t), 'LineWidth', 2, 'Color', [0.00,0.45,0.74], 'LineStyle', '-');
% hold on;
% plot(time(i_start_t:i_end_t), h_asl(i_start_t:i_end_t), 'LineWidth', 2, 'Color', [1.00,0.00,0.00], 'LineStyle', '-');
% hold on;
% plot(time(i_end_t:t_end_i), h_asl(i_end_t:t_end_i), 'LineWidth', 2, 'Color', [0.30,0.75,0.93], 'LineStyle', '-');
% set(gca, 'FontSize', 8, 'Units', 'inches', 'position', [0.13,0.110462962962963,3.75,3.0]);
% set(gca, 'FontSize', 8);
% xlabel("Time (sec)", 'FontSize', 10);
% ylabel("Altitude (ft)", 'FontSize', 10);
% ylim([0 8000]);
% xlim([50 300]);
% legend('Flight w/o erroneous AoA sensor', 'Flight before erroneous AoA sensor', ...
%     'Flight during erroneous AoA sensor', 'Flight after erroneous AoA sensor', ...
%     'FontSize', 8, 'Location', 'southwest');
% legend('Flight stalling', ...
%     'FontSize', 8, 'Location', 'southwest');

% hold on;
% plot(JT610_time_sec+50, JT610_altitude, 'LineWidth', 2, 'Color', 'b');
% plot((time-10), h_asl, 'LineWidth', 2, 'Color', 'r');
% xlim([45, 800]);
% ylim([0, 6000]);
% set(gca, 'FontSize', 8);
% xlabel("Time (sec)", 'FontSize', 10);
% ylabel("Altitude (ft)", 'FontSize', 10);
% legend("JT610 Flight Data", "Simulation", 'Location','northwest', 'FontSize', 8);

% yyaxis right;
% hold on;
% plot((time), pitch, 'LineWidth', 2);
% ylabel("Pitch (degrees)", 'FontSize', 10);
% yyaxis left;
% hold on;
% plot((time), h_asl, 'LineWidth', 2);
% xlim([45, 210]);
% ylim([0, 10000]);
% set(gca, 'FontSize', 8);
% xlabel("Time (sec)", 'FontSize', 10);
% ylabel("Altitude (ft)", 'FontSize', 10);
% legend("JT610 Flight Data", "Simulation", 'Location','northwest', 'FontSize', 8);

end % function

%% Plots as functions
function plot_alt_speed(output_name)
time = output_name.tout(:);
h_asl = output_name.h_asl.Data(:);
vc = output_name.vc.Data(:);

figure;
hold on;
plot(time, h_asl, "LineWidth", 2, "Color", 'k');
ylabel("Altitude (ft)");
xlabel("Time (sec)");
yyaxis right;
plot(time, vc, "LineWidth", 2);
ylabel("Airspeed (kts)");
set(gca, 'FontSize', 20);
end % function

function plot_3d(output_name)
latitude = output_name.lat_deg.Data(:);
longitude = output_name.long_deg.Data(:);
h_asl = output_name.h_asl.Data(:);

figure;
hold on; % make plots into functions
plot3(longitude, latitude, h_asl);
xlabel("Longitude (deg)");
ylabel("Latitude (deg)");
zlabel("Altitude ASL (ft)");
xlim(axis_range(longitude, 0.0001));
ylim(axis_range(latitude, 0.0001));
zlim(axis_range(h_asl, 500));
grid on;
view(45, 45);
% %axis vis3d; % why is this making the axis titles hard to see?
end % function

function plot_j610_data()
JT610_time_sec = readmatrix("JT610_Granular_ADSB_Data.xlsx", "Range", "D2:D845");
JT610_altitude = readmatrix("JT610_Granular_ADSB_Data.xlsx", "Range", "I2:I845");

figure;
hold on;
plot(JT610_time_sec, JT610_altitude, 'LineWidth', 2);
set(gca, 'FontSize', 20);
xlabel("Time (sec)", 'FontSize', 32);
ylabel("Altitude (ft)", 'FontSize', 32);
end % function

%% Helper Functions

function axis_lims = axis_range(x, min_range)
range = 1.1 * (max(x) - min(x));
range = max(range, min_range);

lower_bound = mean(x) - 0.5*range;
upper_bound = mean(x) + 0.5*range;

axis_lims = [lower_bound, upper_bound];
end % function