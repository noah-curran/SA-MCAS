%% script descriptions found in Documentation/Pilot Simulator/
% List of scripts:
% straight_and_level
% straight_and_level_accelerate
% straight_and_climb
% straight_and_descend
% level_turns
% climb_and_turn
% descend_and_turn
% turn_then_descend
% holding_pattern
% takeoff
% takeoff_stall
% landing

%% RUN SIMULATIONS
clear;

initialize_sim_config;

myCluster = parcluster('Processes');
delete(myCluster.Jobs);

num_jobs = 1;

for mcas = ["mcas_old"]

    pilot_stall_vary_pitch(version, mcas, num_jobs);

%     pilot_stall_vary_recovery(version, mcas);
%     
%     sudden_vary_injection(version, mcas);
%     
%     sudden_vary_duration(version, mcas);
%     
%     sudden_vary_recovery(version, mcas);
%     
%     delta_vary_injection(version, mcas);
%     
%     delta_vary_duration(version, mcas);
%     
%     delta_vary_recovery(version, mcas);
%     
%     gradual_lin_vary_coef(version, mcas);
% 
%     gradual_log_vary_coef(version, mcas);
%     
%     gradual_quad_vary_coef(version, mcas);

end

%% EXPERIMENTS
function pilot_stall_vary_pitch(version, mcas, num_jobs)
    clc; clearvars('-except', "mcas", "num_jobs");
    initialize_sim_config;

    for i=0:30/num_jobs
        
        mcas_params = cell(num_jobs, 1);
        script_params = cell(num_jobs, 1);
        for job_num = 1:num_jobs
            mcas_params{job_num} = [-999, 11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1];
            script_params{job_num} = [-999, zeros(1, 21), 20+(job_num+i*num_jobs), 250, 100, 5];
        end

        do_parsim("takeoff_stall_pilot_reaction_delay", 0, mcas, ...
            "anomalies/EmptyInjection.json", mcas_params, script_params, ...
            350, i, 1, num_jobs);
    end
end % function

function pilot_stall_vary_recovery(version, mcas)
    clc; clearvars('-except', "mcas");
    initialize_sim_config;

    for i=0:30
        store_anomaly_params('anomalies/EmptyInjection.json');
        set_script_parameters([zeros(1, 21), 50, 250, 100, i]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_pilot_stall_vary_recovery_val_", int2str(i), "_", int2str(version), ".csv");
        do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    end
end % function

function sudden_vary_injection(version, mcas)
    clc; clearvars('-except', "mcas");
    initialize_sim_config;

    for i=0:30
        store_anomaly_params(append('anomalies/sudden_of_', int2str(i), '.0_during_100.0_to_150.0_on_2.json'));
        set_script_parameters([zeros(1, 21), 50, 250, 400, 5]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_sudden_injection_val_", int2str(i), "_recovery_enabled_grad_", int2str(version), ".csv");
        do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    end
end % function

function sudden_vary_duration(version, mcas)
    clc; clearvars('-except', "mcas");
    initialize_sim_config;

    for i=10:80
        store_anomaly_params(append('anomalies/sudden_of_18.0_during_100.0_to_1', int2str(i), '.0_on_2.json'));
        set_script_parameters([zeros(1, 21), 50, 250, 400, 5]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_sudden_injection_duration_", int2str(i), "_recovery_enabled_grad_", int2str(version), ".csv");
        do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    end
end % function

function sudden_vary_recovery(version, mcas)
    clc; clearvars('-except', "mcas");
    initialize_sim_config;

    for i=3:30
        store_anomaly_params(append('anomalies/sudden_of_18.0_during_100.0_to_150.0_on_2.json'));
        set_script_parameters([zeros(1, 21), 50, 250, 400, i]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_sudden_injection_delayed_recovery_", int2str(i), "_recovery_enabled_grad_", int2str(version), ".csv");
        do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    end
end % function

function delta_vary_injection(version, mcas)
    clc; clearvars('-except', "mcas");
    initialize_sim_config;

    for i=0:30
        store_anomaly_params(append('anomalies/delta_of_', int2str(i), '.0_during_100.0_to_150.0_on_2.json'));
        set_script_parameters([zeros(1, 21), 50, 250, 400, 5]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_delta_injection_val_", int2str(i), "_recovery_enabled_grad_", int2str(version), ".csv");
        do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    end
end % function

function delta_vary_duration(version, mcas)
    clc; clearvars('-except', "mcas");
    initialize_sim_config;

    for i=10:80
        
        store_anomaly_params(append('anomalies/delta_of_18.0_during_100.0_to_1', int2str(i), '.0_on_2.json'));
        set_script_parameters([zeros(1, 21), 50, 250, 400, 5]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_delta_injection_duration_", int2str(i), "_recovery_enabled_grad_", int2str(version), ".csv");
        do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    end
end % function

function delta_vary_recovery(version, mcas)
    clc; clearvars('-except', "mcas");
    initialize_sim_config;

    for i=3:30
        if i ~= 19 && i~=28 && i~=29
            continue;
        end
        store_anomaly_params(append('anomalies/delta_of_18.0_during_100.0_to_150.0_on_2.json'));
        set_script_parameters([zeros(1, 21), 50, 250, 400, i]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_delta_injection_delayed_recovery_", int2str(i), "_recovery_enabled_grad_", int2str(version), ".csv");
        do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    end
end % function

function gradual_lin_vary_coef(version, mcas)
    clc; clearvars('-except', "mcas");
    initialize_sim_config;

    for i=0:30
        a = i/10;
        store_anomaly_params(append('anomalies/gradual_of_lin_', num2str(a, '%.1f'), '_0.0_120.0_during_100.0_to_150.0_on_2.json'));
        set_script_parameters([zeros(1, 21), 50, 250, 400, 5]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_gradual_injection_lin_coef_", num2str(a, '%.1f'), "_recovery_enabled_grad_", int2str(version), ".csv");
        do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    end
end % function

function gradual_log_vary_coef(version, mcas)
    clc; clearvars('-except', "mcas");
    initialize_sim_config;

    for i=100:200
        store_anomaly_params(append('anomalies/gradual_of_log_', num2str(i, '%.1f'), '_0.0_120.0_during_100.0_to_150.0_on_2.json'));
        set_script_parameters([zeros(1, 21), 50, 250, 400, 5]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_gradual_injection_log_coef_", int2str(i), "_recovery_enabled_grad_", int2str(version), ".csv");
        do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    end
end % function

function gradual_quad_vary_coef(version, mcas)
    clc; clearvars('-except', "mcas");
    initialize_sim_config;

    for i=0:10
        a = i/10;
        for j=0:30
            b = j/10;
            store_anomaly_params(append('anomalies/gradual_of_quad_', num2str(a, '%.1f'), '_', num2str(b, '%.1f'), '_120.0_during_100.0_to_150.0_on_2.json'));
            set_script_parameters([zeros(1, 21), 50, 250, 400, 5]);
            set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
            filename = append("../data-collection/simulation-export/", mcas, "_gradual_injection_quad_coef_", num2str(a, '%.1f'), "_", num2str(b, '%.1f'), "_recovery_enabled_grad_", int2str(version), ".csv");
            do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
        end
    end
end % function
