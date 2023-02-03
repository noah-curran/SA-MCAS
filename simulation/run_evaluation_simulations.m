%% script descriptions found in Documentation/Pilot Simulator/
% List of scripts:
% straight_and_level
% straight_and_level_accelerkenate
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
clc; clear;
initialize_sim_config;

sudden_vary_injection(version);

%sudden_vary_duration(version);

%sudden_vary_recovery(version);

%delta_vary_injection(version);

%delta_vary_duration(version);

%delta_vary_recovery(version);

%gradual_lin_vary_coef(version);     % missing JSON anomaly files.

%gradual_log_vary_coef(version);     % missing JSON anomaly files 0-99?

%gradual_quad_vary_coef(version);     % missing JSON anomaly files.


%% EXPERIMENTS
function sudden_vary_injection(version)
    %for i=0:30
    for i=0
        store_anomaly_params(append('anomalies/sudden_of_', int2str(i), '.0_during_100.0_to_130.0_on_2.json'));
        set_script_parameters([zeros(1, 19), i, zeros(1, 4), 10]);
        filename = append("../data-collection/simulation-export/sa_mcas_sudden_injection_val_", int2str(i), "_recovery_enabled_grad_", int2str(version), ".csv");
        run_sim("takeoff_anomaly", "sa_mcas", 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    end
end % function

function sudden_vary_duration(version)
    %for i=10:80
    for i=10
        store_anomaly_params(append('anomalies/sudden_of_18.0_during_100.0_to_1', int2str(i), '.0_on_2.json'));
        set_script_parameters([zeros(1, 19), i, zeros(1, 4), 10]);
        filename = append("../data-collection/simulation-export/sa_mcas_sudden_injection_duration_", int2str(i), "_recovery_enabled_grad_", int2str(version), ".csv");
        run_sim("takeoff_anomaly", "sa_mcas", 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    end
end % function

function sudden_vary_recovery(version)
    %for i=3:30
    for i=3
        store_anomaly_params(append('anomalies/sudden_of_18.0_during_100.0_to_130.0_on_2.json'));
        set_script_parameters([zeros(1, 19), 18, zeros(1, 4), i]);
        filename = append("../data-collection/simulation-export/sa_mcas_sudden_injection_delayed_recovery_", int2str(i), "_recovery_enabled_grad_", int2str(version), ".csv");
        run_sim("takeoff_anomaly", "sa_mcas", 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    end
end % function

function delta_vary_injection(version)
    %for i=0:30
    for i=0
        store_anomaly_params(append('anomalies/delta_of_', int2str(i), '.0_during_100.0_to_130.0_on_2.json'));
        set_script_parameters([zeros(1, 19), i, zeros(1, 4), 10]);
        filename = append("../data-collection/simulation-export/sa_mcas_delta_injection_val_", int2str(i), "_recovery_enabled_grad_", int2str(version), ".csv");
        run_sim("takeoff_anomaly", "sa_mcas", 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    end
end % function

function delta_vary_duration(version)
    %for i=10:80
    for i=10
        store_anomaly_params(append('anomalies/delta_of_18.0_during_100.0_to_1', int2str(i), '.0_on_2.json'));
        set_script_parameters([zeros(1, 19), i, zeros(1, 4), 10]);
        filename = append("../data-collection/simulation-export/sa_mcas_delta_injection_duration_", int2str(i), "_recovery_enabled_grad_", int2str(version), ".csv");
        run_sim("takeoff_anomaly", "sa_mcas", 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    end
end % function

function delta_vary_recovery(version)
    %for i=3:30
    for i=3
        store_anomaly_params(append('anomalies/delta_of_18.0_during_100.0_to_130.0_on_2.json'));
        set_script_parameters([zeros(1, 19), 18, zeros(1, 4), i]);
        filename = append("../data-collection/simulation-export/sa_mcas_delta_injection_delayed_recovery_", int2str(i), "_recovery_enabled_grad_", int2str(version), ".csv");
        run_sim("takeoff_anomaly", "sa_mcas", 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    end
end % function

function gradual_lin_vary_coef(version)
    %for i=0:30
    for i=0
        a = i/10;
        store_anomaly_params(append('anomalies/gradual_of_lin_', num2str(a, '%.1f'), '_0.0_120.0_during_100.0_to_130.0_on_2.json'));
        %set_script_parameters([zeros(1, 13), 18, 10]);
        filename = append("../data-collection/simulation-export/sa_mcas_gradual_injection_lin_coef_", num2str(a, '%.1f'), "_recovery_enabled_grad_", int2str(version), ".csv");
        run_sim("takeoff_anomaly", "sa_mcas", 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    end
end % function

function gradual_log_vary_coef(version)
    %for i=0:200
    for i=100
        store_anomaly_params(append('anomalies/gradual_of_log_', num2str(i, '%.1f'), '_0.0_120.0_during_100.0_to_130.0_on_2.json'));
        set_script_parameters([zeros(1, 19), 18, zeros(1, 4), 22.5]);
        filename = append("../data-collection/simulation-export/sa_mcas_gradual_injection_log_coef_", num2str(i, '%.1f'), "_recovery_enabled_grad_", int2str(version), ".csv");
        run_sim("takeoff_anomaly", "sa_mcas", 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    end
end % function

function gradual_quad_vary_coef(version)
    %for i=0:10
    for i=0
        a = i/10;
        %for j=0:30
        for j=0
            b = j/10;
            store_anomaly_params(append('anomalies/gradual_of_quad_', num2str(a, '%.1f'), '_', num2str(b, '%.1f'), '_120.0_during_100.0_to_130.0_on_2.json'));
            %set_script_parameters([zeros(1, 13), 18, 10]);
            set_script_parameters([zeros(1, 19), 18, zeros(1, 4), 10]);
            filename = append("../data-collection/simulation-export/sa_mcas_gradual_injection_quad_coef_", num2str(a, '%.1f'), "_", num2str(b, '%.1f'), "_recovery_enabled_grad_", int2str(version), ".csv");
            run_sim("takeoff_anomaly", "sa_mcas", 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
        end
    end
end % function
