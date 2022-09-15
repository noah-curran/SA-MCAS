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
elevator_cmd = output_name.elevator_cmd_norm.Data(:);

JT610_time_sec = readmatrix("JT610_Granular_ADSB_Data.xlsx", "Range", "D2:D845");
JT610_altitude = readmatrix("JT610_Granular_ADSB_Data.xlsx", "Range", "I2:I845");

n_time = no_anomalies_output.tout(:);
n_h_asl = no_anomalies_output.h_asl.Data(:);
n_h_dot = no_anomalies_output.h_dot.Data(:);
n_pitch = no_anomalies_output.pitch.Data(:);
n_pitch_rate = no_anomalies_output.pitch_rate.Data(:);
n_heading = no_anomalies_output.heading.Data(:);
n_heading_rate = no_anomalies_output.heading_rate.Data(:);
n_roll = no_anomalies_output.roll.Data(:);
n_roll_rate = no_anomalies_output.roll_rate.Data(:);
n_beta = no_anomalies_output.beta.Data(:);
n_vc = no_anomalies_output.vc.Data(:);
n_throttle_cmd = no_anomalies_output.throttle_0_cmd.Data();

%% Plotting

i_start_t = find(time>=anomaly_params(1).StartTime,1);
i_end_t = find(time>=anomaly_params(1).EndTime,1);

clf;
% yyaxis right;
% plot(time, elevator_cmd, 'LineWidth', 0.5);
% ylabel('Pilot Elevator Control [normalized]');
% yyaxis left;
% hold on;
plot(n_time, n_h_asl, 'LineWidth', 1, 'Color', 'g', 'LineStyle', '-');
hold on;
plot(time(t_start_i:i_start_t), h_asl(t_start_i:i_start_t), 'LineWidth', 2, 'Color', [0.00,0.45,0.74], 'LineStyle', '-');
hold on;
plot(time(i_start_t:i_end_t), h_asl(i_start_t:i_end_t), 'LineWidth', 2, 'Color', [1.00,0.00,0.00], 'LineStyle', '-');
hold on;
plot(time(i_end_t:t_end_i), h_asl(i_end_t:t_end_i), 'LineWidth', 2, 'Color', [0.30,0.75,0.93], 'LineStyle', '-');
% set(gca, 'FontSize', 8, 'Units', 'inches', 'position', [0.13,0.110462962962963,3.75,3.0]);
set(gca, 'FontSize', 8);

xlabel("Time (sec)", 'FontSize', 10);
ylabel("Altitude (ft)", 'FontSize', 10);
ylim([0 3000]);
xlim([50 135]);
legend('Flight w/o erroneous AoA sensor', 'Flight before erroneous AoA sensor', ...
    'Flight during erroneous AoA sensor', 'Flight after erroneous AoA sensor', ...
    'FontSize', 8, 'Location', 'southwest');

% hold on;
% plot(JT610_time_sec+50, JT610_altitude, 'LineWidth', 2, 'Color', 'b');
% plot((time-41)*2.8, h_asl, 'LineWidth', 2, 'Color', 'r');
% xlim([40, 300]);
% ylim([0, 4000]);
% set(gca, 'FontSize', 20);
% xlabel("Time (sec)", 'FontSize', 32);
% ylabel("Altitude (ft)", 'FontSize', 32);
% legend("Crash Flight Data", "Simulation (stretched by factor of 2.8)", 'Location','northwest', 'FontSize', 30);


% hold on;
% plot(time, h_asl, 'LineWidth', 2, 'Color', 'k');
% xlim([start_time_s, end_time_s]);
% set(gca, 'FontSize', 20);
% ylabel("Altitude (ft)", 'FontSize', 32);
% xlabel("Time (sec)", 'FontSize', 32);
% yyaxis right;
% hold on;
% plot(time, vc, 'LineWidth', 2);
% ylabel("Airspeed (kts)", 'FontSize', 32);
% xlabel("Time (sec)", 'FontSize', 32);
% xline(17.5, '--', 'LineWidth', 2, 'Color', 'k');
% xline(52, '--', 'LineWidth', 2, 'Color', 'k');
% xline(75, '--', 'LineWidth', 2, 'Color', 'k');

% hold on;
% plot(time, h_asl, 'LineWidth', 2, 'Color', 'k');
% xlim([start_time_s, end_time_s]);
% set(gca, 'FontSize', 20);
% ylabel("Altitude (ft)", 'FontSize', 32);
% xlabel("Time (sec)", 'FontSize', 32);

% hold on;
% plot(time, h_asl, 'LineWidth', 2, 'Color', 'k');
% % plot(time, 15000*ones(1, numel(H_ASL)), 'LineWidth', 2, 'LineStyle','--', 'Color', 'k');
% xlim([start_time_s, end_time_s]);
% % ylim([9950, 16000]);
% set(gca, 'FontSize', 20);
% ylabel("Altitude (ft)", 'FontSize', 32);
% xlabel("Time (sec)", 'FontSize', 32);

% figure;
% hold on;
% plot(time, heading, 'LineWidth', 2, 'Color', 'k');
% % plot(time, 90*ones(1, numel(heading)), 'LineWidth', 2, 'LineStyle','--', 'Color', 'k');
% xlim([start_time_s, end_time_s]);
% % ylim([0, 100]);
% set(gca, 'FontSize', 20);
% ylabel("Heading (deg)", 'FontSize', 32);
% xlabel("Time (sec)", 'FontSize', 32);

% figure;
% hold on;
% plot(time, vc, 'LineWidth', 2, 'Color', '--k');
% % plot(time, 240*ones(1, numel(heading)), 'LineWidth', 2, 'LineStyle','--', 'Color', 'k');
% xlim([start_time_s, end_time_s]);
% % ylim([200, 250]);
% set(gca, 'FontSize', 20);
% ylabel("Calibrated Airspeed (kts)", 'FontSize', 32);
% xlabel("Time (sec)", 'FontSize', 32);

% figure;
% hold on;
% plot(time, throttle_cmd, 'LineWidth', 2, 'Color', 'k');
% xlim([start_time_s, end_time_s]);
% set(gca, 'FontSize', 20);
% ylabel("Throttle Cmd (norm)", 'FontSize', 32);
% xlabel("Time (sec)", 'FontSize', 32);

% figure;
% hold on;
% plot(time, h_dot, 'LineWidth', 2, 'Color', 'k');
% xlim([start_time_s, end_time_s]);
% set(gca, 'FontSize', 20);
% ylabel("Vertical Speed (fps)", 'FontSize', 32);
% xlabel("Time (sec)", 'FontSize', 32);

end % function