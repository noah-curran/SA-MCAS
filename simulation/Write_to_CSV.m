function Write_to_CSV(sim_output, file_name)
disp("Writing to CSV...");

% change labels depending on desired data for logging.
labels = ["h_asl", "pitch", "vc", "roll", "deadline_met"];

num_labels = numel(labels);
num_steps = numel(sim_output.tout);
output_matrix = -999*ones(num_steps, num_labels+1);
output_matrix(:, 1) = sim_output.tout;
%output_matrix(:, 2) = sim_output.deadline_met.Data(:);

for i=1:num_labels
    output_matrix(:, i+1) = eval(append("sim_output.", labels(i), ".Data(:)"));
end

output_matrix = num2cell(output_matrix);
headers = ["time", labels];
output_matrix = vertcat(headers, output_matrix);

writematrix(output_matrix, file_name);

disp("Written to CSV");
end
