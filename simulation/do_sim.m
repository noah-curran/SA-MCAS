function do_sim(script, MCAS, sim_time_sec, injection_params, do_plot, do_no_anomalies, override_init_conds, do_csv, file_name)
    select_script(script, override_init_conds);
    select_MCAS(MCAS);

    output = sim('MCASSimulation', sim_time_sec);
    
    if do_no_anomalies
        store_anomaly_params('anomalies/EmptyInjection.json');
        select_script("takeoff");   % should be select_script(script)?
        no_anomalies_output = sim('MCASSimulation', sim_time_sec);
    end

    if exist("do_plot", 'var')
        if do_plot && do_no_anomalies
            MCAS_Plotting(output, injection_params, no_anomalies_output);
        end
        if do_plot && ~do_no_anomalies
            MCAS_Plotting(output, injection_params);
        end
    end

    assignin('base', "num_sims", evalin("base", "num_sims") + 1);
    %assignin('base', append("sim_", int2str(sim_num), "_output"), output);

    if exist("do_csv", 'var')
        if do_csv == 1
            Write_to_CSV(output, file_name);
        end
    end
end % function
