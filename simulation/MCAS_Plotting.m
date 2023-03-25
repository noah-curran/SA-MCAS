function MCAS_Plotting(output_name, anomaly_params, no_anomalies_output)
%% Input Parameters for chart
start_time_s = 0;
end_time_s = max(output_name.tout);
sample_rate_hz = 120;   % dependent on incoming data
t_start_i = 1 + start_time_s * sample_rate_hz;
t_end_i = end_time_s * sample_rate_hz;
t_arr = t_start_i:t_end_i;

%% Data from Simulink
time = output_name.tout(:);
latitude = output_name.lat_deg.Data(:);
longitude = output_name.long_deg.Data(:);
h_asl = output_name.h_asl.Data(:);
h_dot = output_name.h_dot.Data(:);
pitch = output_name.pitch.Data(:);
pitch_rate = output_name.pitch_rate.Data(:);
heading = output_name.heading.Data(:);
heading_rate = output_name.heading_rate.Data(:);
roll = output_name.roll.Data(:);
roll_rate = output_name.roll_rate.Data(:);
alpha = output_name.alpha_deg.Data(:);
beta = output_name.beta.Data(:);
vc = output_name.vc.Data(:);
throttle_cmd = output_name.throttle_0_cmd.Data();
elevator_cmd = output_name.pilot_elevator_cmd.Data(:);
a_pilot_z_ft_sec2 = output_name.a_pilot_z_ft_sec2.Data(:);
JT610_time_sec = readmatrix("JT610_Granular_ADSB_Data.xlsx", "Range", "D2:D845");
JT610_altitude = readmatrix("JT610_Granular_ADSB_Data.xlsx", "Range", "I2:I845");

%n_time = no_anomalies_output.tout(:);
%n_h_asl = no_anomalies_output.h_asl.Data(:);
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
% plot_j610_data(output_name);
%plot_3d(output_name);
plot_alt_speed(output_name);
figure();
plot(alpha);

%% Plotting Anomaly/No Anomaly Figures
% %i_start_t = find(time>=100,1);
% i_start_t = find(time>=anomaly_params(1).StartTime,1);
% i_end_t = find(time>=anomaly_params(1).EndTime,1);
% % yyaxis right;
% % plot(time, elevator_cmd, 'LineWidth', 0.5);
% % hold on;
% % time_t = linspace(0, 150, length(alpha_deg));
% % plot(time_t, alpha_deg, 'LineWidth', 0.5, 'LineStyle', '-');
% % ylabel('AoA');
% % yyaxis left;
% 
% figure;
% hold on;
% %plot(n_time, n_h_asl, 'LineWidth', 1, 'Color', 'g', 'LineStyle', '-');
% plot(time(t_start_i:i_start_t), h_asl(t_start_i:i_start_t), 'LineWidth', 2, 'Color', [0.00,0.45,0.74], 'LineStyle', '-');
% plot(time(i_start_t:i_end_t), h_asl(i_start_t:i_end_t), 'LineWidth', 2, 'Color', [1.00,0.00,0.00], 'LineStyle', '-');
% plot(time(i_end_t:size(time)), h_asl(i_end_t:size(time)), 'LineWidth', 2, 'Color', [0.30,0.75,0.93], 'LineStyle', '-.');
% set(gca, 'FontSize', 8);
% xlabel("Time (sec)", 'FontSize', 10);
% ylabel("Altitude (ft)", 'FontSize', 10);
% ylim([0 9000]);
% xlim([40 150]);
% legend(...'Flight w/o erroneous AoA sensor', ...
%     'Flight before erroneous AoA sensor', ...
%     'Flight during erroneous AoA sensor', ...
%     'Flight after erroneous AoA sensor', ...
%     'FontSize', 8, 'Location', 'northwest');
% 
end % function

%% Plot functions
function plot_alt_speed(output)
time = output.tout(:);
h_asl = output.h_asl.Data(:);
vc = output.vc.Data(:);

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

function plot_3d(output)
latitude = output.lat_deg.Data(:);
longitude = output.long_deg.Data(:);
alt_asl_120hz = output.altitude_asl_120hz.Data(:);

figure;
hold on;
plot3(longitude, latitude, alt_asl_120hz);
xlabel("Longitude (deg)");
ylabel("Latitude (deg)");
zlabel("Altitude ASL (ft)");
xlim(axis_range(longitude, 0.0001));
ylim(axis_range(latitude, 0.0001));
zlim(axis_range(alt_asl_120hz, 500));
grid on;
view(45, 45);
end % function

function plot_j610_data(output)
JT610_time_sec = readmatrix("JT610_Granular_ADSB_Data.xlsx", "Range", "D2:D845");
JT610_altitude = readmatrix("JT610_Granular_ADSB_Data.xlsx", "Range", "I2:I845");

time = output.tout(:);
h_asl = output.h_asl.Data(:);

figure;
hold on;
plot(JT610_time_sec+65, JT610_altitude, 'LineWidth', 2, 'Color', 'b');
plot((time), h_asl, 'LineWidth', 2, 'Color', 'r');
set(gca, 'FontSize', 8);
xlabel("Time (sec)", 'FontSize', 10);
ylabel("Altitude (ft)", 'FontSize', 10);
xlim([30 800]);
legend("JT610 Flight Data", "Simulation", 'Location','northwest', 'FontSize', 8);
end % function

%% Helper Functions
function axis_lims = axis_range(x, min_range)
range = 1.1 * (max(x) - min(x));
range = max(range, min_range);

lower_bound = mean(x) - 0.5*range;
upper_bound = mean(x) + 0.5*range;

axis_lims = [lower_bound, upper_bound];
end % function
