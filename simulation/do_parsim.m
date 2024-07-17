function do_parsim(script, override_init_conds, MCAS, anomaly_file_path, mcas_params, script_params, sim_time_sec, file_name_num, do_csv, numjobs)
    select_script(script, override_init_conds);
    select_MCAS(MCAS);
    store_anomaly_params(anomaly_file_path);

    file_name = append("../data-collection/simulation-export/", MCAS, "_pilot_stall_vary_pitch_val_", int2str(20+file_name_num), "_par.csv");

    model = 'MCASSimulation';
    load_system(model);
    
    try
        parpool(numjobs);
    
        % format: [-999 (time stamp), script_params (size 25), mcas_params (size 9)
        simIn(1:numjobs) = Simulink.SimulationInput(model);
        for job=1:numjobs
            simIn(job) = setVariable(simIn(job), 'mcas_parameters', mcas_params{job});
            simIn(job) = setVariable(simIn(job), 'function_block_MCAS', evalin('base', 'function_block_MCAS'));
            
            simIn(job) = setVariable(simIn(job), 'script_parameters', script_params{job});
            simIn(job) = setVariable(simIn(job), 'function_block_script', evalin('base', 'function_block_script'));
    
            simIn(job) = setVariable(simIn(job), 'sortedParams', evalin('base', 'sortedParams'));
    
            simIn(job) = setVariable(simIn(job), 'test_script', "'scripts/737_cruise'");
            simIn(job) = setVariable(simIn(job), 'aircraft_type', "'737-RTCL'");
            simIn(job) = setVariable(simIn(job), 'init_conds', "'init_auto'");
            simIn(job) = setVariable(simIn(job), 'port_config', "'port_config/port_config_1'");
    
            simIn(job) = setVariable(simIn(job), 'slBus1', evalin('base', 'slBus1'));
    
            simIn(job) = setModelParameter(simIn(job), 'StopTime', int2str(sim_time_sec));
            % aircraft_type, 0.0083333, 0, test_script, init_conds, port_config
            % simIn(job) = setModelParameter(simIn(job), 'MCASSimulation/Flight Dynamics Model', 'S-function parameters', '"737-RTCL", 0.0083333, 0, "scripts/737_cruise", "init_auto", "port_config/port_config_1"');
        end
    
        output = parsim(simIn, ...
            'ShowSimulationManager', 'on', ...
            'TransferBaseWorkspaceVariables', 'off', ...
            'UseFastRestart', 'off', ...
            'UseParallel', true);
    catch err
        disp(err.message);
        delete(gcp('nocreate'));
%         clear;
        return
    end

    delete(gcp('nocreate'));

    assignin('base', "num_sims", evalin("base", "num_sims") + 1);
    %assignin('base', append("sim_", int2str(sim_num), "_output"), output);

    if do_csv == 1
        Write_to_CSV(output, file_name);
    end
end % function
