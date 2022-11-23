function Write_to_CSV(sim_object_name)
labels = ["h_asl", "h_dot", "vc", "pitch", "pitch_rate", "roll", "roll_rate", ...
    "heading", "heading_rate", "alpha_deg", "a_pilot_x_ft_sec2", "a_pilot_y_ft_sec2", ...
    "a_pilot_z_ft_sec2", "pitch_accel_rad_sec2", "roll_accel_rad_sec2", ...
    "yaw_accel_rad_sec2", "lat_deg", "long_deg", "flaps_pos_norm", "engine_percent", ...
    "pilot_elevator_cmd", "throttle_0_cmd", "temp_rankine", "pressure_psf"];

sim_object = evalin("base", sim_object_name);
num_labels = numel(labels);
num_steps = numel(sim_object.tout);
output_matrix = -999*ones(num_steps, num_labels+1);

output_matrix(:, 1) = sim_object.tout;

for i=1:num_labels
    output_matrix(:, i+1) = evalin("base", append(sim_object_name, ".", labels(i), ".Data(:)"));
end

output_matrix = num2cell(output_matrix);

headers = ["time", labels];
output_matrix = vertcat(headers, output_matrix);

date_time = string(datetime('now', 'Format', 'MM_dd-HH_mm'));
file_name = append("../data-collection/simulation-export/", date_time, "_", sim_object_name, ".csv");
writematrix(output_matrix, file_name);

disp("Written to CSV");
end
