function run_sim(script, MCAS, sim_time_sec, injection_params, do_plot, do_no_anomalies, do_csv, init_cond_override)
    function_block_script_name_to_workspace(script);
    
    if ~init_cond_override  % must run set_init_conds 'manually' if override is enabled.
        select_script(script);
    end
    select_MCAS(MCAS);

    output = sim('MCASSimulation', sim_time_sec);
    
    if do_no_anomalies
        no_anomolies_run_handler(output, injection_params, do_plot, sim_time_sec);
    else
        % Plotting only occurs if do_plot was supplied and equal to 1.
        if ~exist("do_plot", 'var')
            do_plot = 0;
        end
        if do_plot == 1
            MCAS_Plotting(output, injection_params);
        end
    end

    % Index simulation and send output data to MATLAB base workspace
    sim_num = evalin("base", "num_sims") + 1;
    assignin('base', "num_sims", sim_num);
    %workspace_object_name = append("sim_", int2str(sim_num), "_output");
    %assignin('base', workspace_object_name, output);

    % csv dump only occurs if do_csv was supplied and equal to 1.
    if ~exist("do_csv", 'var')
        do_csv = 0;
    end
    if do_csv == 1
        %Write_to_CSV(workspace_object_name);
        Write_to_CSV_no_workspace(output);
    end

end % function
