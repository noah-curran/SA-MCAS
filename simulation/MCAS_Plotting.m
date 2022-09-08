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

%% Plotting
clf;

hold on;
plot(time, h_asl, 'LineWidth', 2, 'Color', 'k');
% plot(time, 15000*ones(1, numel(H_ASL)), 'LineWidth', 2, 'LineStyle','--', 'Color', 'k');
xlim([start_time_s, end_time_s]);
% ylim([9950, 16000]);
set(gca, 'FontSize', 20);
ylabel("Altitude (ft)", 'FontSize', 32);
xlabel("Time (sec)", 'FontSize', 32);

% figure;
% hold on;
% plot(time, heading, 'LineWidth', 2, 'Color', 'k');
% % plot(time, 90*ones(1, numel(heading)), 'LineWidth', 2, 'LineStyle','--', 'Color', 'k');
% xlim([start_time_s, end_time_s]);
% % ylim([0, 100]);
% set(gca, 'FontSize', 20);
% ylabel("Heading (deg)", 'FontSize', 32);
% xlabel("Time (sec)", 'FontSize', 32);

figure;
hold on;
plot(time, vc, 'LineWidth', 2, 'Color', 'k');
% plot(time, 240*ones(1, numel(heading)), 'LineWidth', 2, 'LineStyle','--', 'Color', 'k');
xlim([start_time_s, end_time_s]);
% ylim([200, 250]);
set(gca, 'FontSize', 20);
ylabel("Calibrated Airspeed (kts)", 'FontSize', 32);
xlabel("Time (sec)", 'FontSize', 32);

end % function