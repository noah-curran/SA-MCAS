function MCAS_Plotting(output_name)
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

JT610_time_sec = readmatrix("JT610_Granular_ADSB_Data.xlsx", "Range", "D2:D845");
JT610_altitude = readmatrix("JT610_Granular_ADSB_Data.xlsx", "Range", "I2:I845");

%% Plotting
clf;

hold on;
plot(JT610_time_sec+50, JT610_altitude, 'LineWidth', 2, 'Color', 'b');
plot((time-41)*2.8, h_asl, 'LineWidth', 2, 'Color', 'r');
xlim([40, 300]);
ylim([0, 4000]);
set(gca, 'FontSize', 20);
xlabel("Time (sec)", 'FontSize', 32);
ylabel("Altitude (ft)", 'FontSize', 32);
legend("Crash Flight Data", "Simulation (stretched by factor of 2.8)", 'Location','northwest', 'FontSize', 30);


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