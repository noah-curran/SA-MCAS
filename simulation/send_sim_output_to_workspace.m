function send_sim_output_to_workspace(output)
% Index simulation and send output data to MATLAB base workspace
    sim_num = evalin("base", "num_sims") + 1;
    assignin('base', "num_sims", sim_num);
    workspace_object_name = append("sim_", int2str(sim_num), "_output");
    assignin('base', workspace_object_name, output);
end
