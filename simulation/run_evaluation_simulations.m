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

initialize_sim_config;
eps = 0.0001;
version = 3;
result_file = 'boundary_results.mat';

if exist(result_file, 'file')
    results = load(result_file).results;
else
    results = struct();
end


for mcas = ["mcas_old", "mcas_new", "sa_mcas"]

    if ~isfield(results, mcas)
        results.(mcas) = struct();
    end
    
    % PILOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ~isfield(results.(mcas), 'pilot')
        results.(mcas).pilot = struct();
    end

    result = pilot_stall_vary_pitch(version, mcas, eps, results);
    if result ~= -1
           results.(mcas).pilot.pitch = result;
    end

    save('boundary_results.mat', 'results');

    result = pilot_stall_vary_recovery(version, mcas, eps, results);
    if result ~= -1
           results.(mcas).pilot.recovery = result;
    end

    save('boundary_results.mat', 'results');

    % SUDDEN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ~isfield(results.(mcas), 'sudden')
        results.(mcas).sudden = struct();
    end

    result = sudden_vary_injection(version, mcas, eps, results);
    if result ~= -1
           results.(mcas).sudden.injection = result;
    end

    save('boundary_results.mat', 'results');

    result = sudden_vary_duration(version, mcas, eps, results);
    if result ~= -1
           results.(mcas).sudden.duration = result;
    end

    save('boundary_results.mat', 'results');

    result = sudden_vary_recovery(version, mcas, eps, results);
    if result ~= -1
           results.(mcas).sudden.recovery = result;
    end

    save('boundary_results.mat', 'results');
    
    % DELTA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ~isfield(results.(mcas), 'delta')
        results.(mcas).delta = struct();
    end

    result = delta_vary_injection(version, mcas, eps, results);
    if result ~= -1
           results.(mcas).delta.injection = result;
    end
    
    save('boundary_results.mat', 'results');

    result = delta_vary_duration(version, mcas, eps, results);
    if result ~= -1
           results.(mcas).delta.duration = result;
    end
    
    save('boundary_results.mat', 'results');

    result = delta_vary_recovery(version, mcas, eps, results);
    if result ~= -1
           results.(mcas).delta.recovery = result;
    end

    save('boundary_results.mat', 'results');

    % GRADUAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ~isfield(results.(mcas), 'gradual')
        results.(mcas).gradual = struct();
    end

    result = gradual_lin_vary_coef(version, mcas, eps, results);
    if result ~= -1
           results.(mcas).gradual.lin = result;
    end
    
    save('boundary_results.mat', 'results');

    result = gradual_log_vary_coef(version, mcas, eps, results);
    if result ~= -1
           results.(mcas).gradual.log = result;
    end
    
    save('boundary_results.mat', 'results');


    result = gradual_quad_vary_coef(version, mcas, eps, results);
    if result ~= -1
           results.(mcas).gradual.quad = result;
    end
    
    save('boundary_results.mat', 'results');

end

%% EXPERIMENTS
function midpoint = pilot_stall_vary_pitch(version, mcas, eps, results)
    clc; clearvars('-except', "mcas", "eps", "version", "results");
    initialize_sim_config;

    if isfield(results.(mcas).pilot, 'pitch')
        midpoint = -1;
        return;
    end

    low = 20;
    high = 90;
    next = -1;

    while abs(low - high) > eps
        next = (low+high)/2;

        store_anomaly_params('anomalies/EmptyInjection.json');
        set_script_parameters([zeros(1, 21), next, 250, 100, 5]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_pilot_stall_vary_pitch_val_", num2str(20+next), "_", int2str(version), ".csv");
        success = do_sim("takeoff_stall_pilot_reaction_delay", mcas, 350, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
        
        if success
            low = next;
            fprintf('Value of %.4f success.\n', next);
        else
            high = next;
            fprintf('Value of %.4f fail.\n', next);
        end

    end

    fprintf('pilot_stall_vary_pitch: Final mid value of %.4f.\n', next);
    midpoint = [low, high];
end % function

function midpoint = pilot_stall_vary_recovery(version, mcas, eps, results)
    clc; clearvars('-except', "mcas", "eps", "version", "results");
    initialize_sim_config;

    if isfield(results.(mcas).pilot, 'recovery')
        midpoint = -1;
        return;
    end

    low = 0;
    high = 10;
    next = -1;

    while abs(low - high) > eps
        next = (low+high)/2;

        store_anomaly_params('anomalies/EmptyInjection.json');
        set_script_parameters([zeros(1, 21), 50, 250, 100, next]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_pilot_stall_vary_recovery_val_", num2str(next), "_", int2str(version), ".csv");
        success = do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    
        if success
            low = next;
            fprintf('Value of %.4f success.\n', next);
        else
            high = next;
            fprintf('Value of %.4f fail.\n', next);
        end

    end

    fprintf('pilot_stall_vary_recovery: Final mid value of %.4f.\n', next);
    midpoint = [low, high];
end % function

function midpoint = sudden_vary_injection(version, mcas, eps, results)
    clc; clearvars('-except', "mcas", "eps", "version", "results");
    initialize_sim_config;

    if isfield(results.(mcas).sudden, 'injection')
        midpoint = -1;
        return;
    end

    low = 0;
    high = 90;
    next = -1;

    while abs(low - high) > eps
        next = (low+high)/2;

        store_anomaly_params_json(1, 100.0, 150.0, next, 2, 0, 0, 0, 0)
        % store_anomaly_params(append('anomalies/sudden_of_', num2str(next), '.0_during_100.0_to_150.0_on_2.json'));
        set_script_parameters([zeros(1, 21), 50, 250, 400, 5]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_sudden_injection_val_", num2str(next), "_recovery_enabled_grad_", int2str(version), ".csv");
        success = do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    
        if success
            low = next;
            fprintf('Value of %.4f success.\n', next);
        else
            high = next;
            fprintf('Value of %.4f fail.\n', next);
        end

    end

    fprintf('sudden_vary_injection: Final mid value of %.4f.\n', next);
    midpoint = [low, high];
end % function

function midpoint = sudden_vary_duration(version, mcas, eps, results)
    clc; clearvars('-except', "mcas", "eps", "version", "results");
    initialize_sim_config;

    if isfield(results.(mcas).sudden, 'duration')
        midpoint = -1;
        return;
    end

    low = 110;
    high = 180;
    next = -1;

    while abs(low - high) > eps
        next = (low+high)/2;

        store_anomaly_params_json(1, 100.0, next, 18.0, 2, 0, 0, 0, 0)
        % store_anomaly_params(append('anomalies/sudden_of_18.0_during_100.0_to_1', int2str(i), '.0_on_2.json'));
        set_script_parameters([zeros(1, 21), 50, 250, 400, 5]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_sudden_injection_duration_", num2str(next), "_recovery_enabled_grad_", int2str(version), ".csv");
        success = do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    
        if success
            low = next;
            fprintf('Value of %.4f success.\n', next);
        else
            high = next;
            fprintf('Value of %.4f fail.\n', next);
        end

    end

    fprintf('sudden_vary_duration: Final mid value of %.4f.\n', next);
    midpoint = [low, high];
end % function

function midpoint = sudden_vary_recovery(version, mcas, eps, results)
    clc; clearvars('-except', "mcas", "eps", "version", "results");
    initialize_sim_config;

    if isfield(results.(mcas).sudden, 'recovery')
        midpoint = -1;
        return;
    end

    low = 0;
    high = 10;
    next = -1;

    while abs(low - high) > eps
        next = (low+high)/2;

        store_anomaly_params_json(1, 100.0, 150.0, 18.0, 2, 0, 0, 0, 0)
        % store_anomaly_params(append('anomalies/sudden_of_18.0_during_100.0_to_150.0_on_2.json'));
        set_script_parameters([zeros(1, 21), 50, 250, 400, next]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_sudden_injection_delayed_recovery_", num2str(next), "_recovery_enabled_grad_", int2str(version), ".csv");
        success = do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    
        if success
            low = next;
            fprintf('Value of %.4f success.\n', next);
        else
            high = next;
            fprintf('Value of %.4f fail.\n', next);
        end

    end

    fprintf('sudden_vary_recovery: Final mid value of %.4f.\n', next);
    midpoint = [low, high];
end % function

function midpoint = delta_vary_injection(version, mcas, eps, results)
    clc; clearvars('-except', "mcas", "eps", "version", "results");
    initialize_sim_config;

    if isfield(results.(mcas).delta, 'injection')
        midpoint = -1;
        return;
    end

    low = 0;
    high = 90;
    next = -1;

    while abs(low - high) > eps
        next = (low+high)/2;

        store_anomaly_params_json(2, 100.0, 150.0, next, 2, 0, 0, 0, 0)
        % store_anomaly_params(append('anomalies/delta_of_', int2str(i), '.0_during_100.0_to_150.0_on_2.json'));
        set_script_parameters([zeros(1, 21), 50, 250, 400, 5]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_delta_injection_val_", num2str(next), "_recovery_enabled_grad_", int2str(version), ".csv");
        success = do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    
        if success
            low = next;
            fprintf('Value of %.4f success.\n', next);
        else
            high = next;
            fprintf('Value of %.4f fail.\n', next);
        end

    end

    fprintf('delta_vary_injection: Final mid value of %.4f.\n', next);
    midpoint = [low, high];
end % function

function midpoint = delta_vary_duration(version, mcas, eps, results)
    clc; clearvars('-except', "mcas", "eps", "version", "results");
    initialize_sim_config;

    if isfield(results.(mcas).delta, 'duration')
        midpoint = -1;
        return;
    end

    low = 110;
    high = 180;
    next = -1;

    while abs(low - high) > eps
        next = (low+high)/2;

        store_anomaly_params_json(2, 100.0, next, 18.0, 2, 0, 0, 0, 0)
        % store_anomaly_params(append('anomalies/delta_of_18.0_during_100.0_to_1', int2str(i), '.0_on_2.json'));
        set_script_parameters([zeros(1, 21), 50, 250, 400, 5]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_delta_injection_duration_", num2str(next), "_recovery_enabled_grad_", int2str(version), ".csv");
        success = do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    
        if success
            low = next;
            fprintf('Value of %.4f success.\n', next);
        else
            high = next;
            fprintf('Value of %.4f fail.\n', next);
        end

    end

    fprintf('delta_vary_duration: Final mid value of %.4f.\n', next);
    midpoint = [low, high];
end % function

function midpoint = delta_vary_recovery(version, mcas, eps, results)
    clc; clearvars('-except', "mcas", "eps", "version", "results");
    initialize_sim_config;

    if isfield(results.(mcas).delta, 'recovery')
        midpoint = -1;
        return;
    end

    low = 0;
    high = 10;
    next = -1;

    while abs(low - high) > eps
        next = (low+high)/2;

        store_anomaly_params_json(2, 100.0, 150.0, 18.0, 2, 0, 0, 0, 0)
        % store_anomaly_params(append('anomalies/delta_of_18.0_during_100.0_to_150.0_on_2.json'));
        set_script_parameters([zeros(1, 21), 50, 250, 400, next]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_delta_injection_delayed_recovery_", num2str(next), "_recovery_enabled_grad_", int2str(version), ".csv");
        success = do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    
        if success
            low = next;
            fprintf('Value of %.4f success.\n', next);
        else
            high = next;
            fprintf('Value of %.4f fail.\n', next);
        end

    end

    fprintf('delta_vary_recovery: Final mid value of %.4f.\n', next);
    midpoint = [low, high];
end % function

function midpoint = gradual_lin_vary_coef(version, mcas, eps, results)
    clc; clearvars('-except', "mcas", "eps", "version", "results");
    initialize_sim_config;

    if isfield(results.(mcas).gradual, 'lin')
        midpoint = -1;
        return;
    end

    low = 0;
    high = 3;
    next = -1;

    while abs(low - high) > eps
        next = (low+high)/2;

        store_anomaly_params_json(3, 100.0, 150.0, 0, 2, 1, next, 0, 120);
        % store_anomaly_params(append('anomalies/gradual_of_lin_', num2str(a, '%.1f'), '_0.0_120.0_during_100.0_to_150.0_on_2.json'));
        set_script_parameters([zeros(1, 21), 50, 250, 400, 5]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_gradual_injection_lin_coef_", num2str(next, '%.1f'), "_recovery_enabled_grad_", int2str(version), ".csv");
        success = do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    
        if success
            low = next;
            fprintf('Value of %.4f success.\n', next);
        else
            high = next;
            fprintf('Value of %.4f fail.\n', next);
        end

    end

    fprintf('gradual_lin_vary_coef: Final mid value of %.4f.\n', next);
    midpoint = [low, high];
end % function

function midpoint = gradual_log_vary_coef(version, mcas, eps, results)
    clc; clearvars('-except', "mcas", "eps", "version", "results");
    initialize_sim_config;

    if isfield(results.(mcas).gradual, 'log')
        midpoint = -1;
        return;
    end

    low = 0;
    high = 1000000;
    next = -1;

    while abs(low - high) > eps
        next = (low+high)/2;

        store_anomaly_params_json(3, 100.0, 150.0, 0, 2, 3, next, 0, 120);
        % store_anomaly_params(append('anomalies/gradual_of_log_', num2str(i, '%.1f'), '_0.0_120.0_during_100.0_to_150.0_on_2.json'));
        set_script_parameters([zeros(1, 21), 50, 250, 400, 5]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_gradual_injection_log_coef_", num2str(next), "_recovery_enabled_grad_", int2str(version), ".csv");
        success = do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    
        if success
            low = next;
            fprintf('Value of %.4f success.\n', next);
        else
            high = next;
            fprintf('Value of %.4f fail.\n', next);
        end
    
    end

    fprintf('gradual_log_vary_coef: Final mid value of %.4f.\n', next);
    midpoint = [low, high];
end % function

function midpoint = gradual_quad_vary_coef(version, mcas, eps, results)
    clc; clearvars('-except', "mcas", "eps", "version", "results");
    initialize_sim_config;

    if isfield(results.(mcas).gradual, 'quad')
        midpoint = -1;
        return;
    end

    low = 0;
    high = 3;
    next = -1;

    while abs(low - high) > eps
        next = (low+high)/2;

        store_anomaly_params_json(3, 100.0, 150.0, 0, 2, 2, 0, next, 120);
        % store_anomaly_params(append('anomalies/gradual_of_quad_', num2str(a, '%.1f'), '_', num2str(b, '%.1f'), '_120.0_during_100.0_to_150.0_on_2.json'));
        set_script_parameters([zeros(1, 21), 50, 250, 400, 5]);
        set_mcas_parameters([11, 2.5, 0.27, 18, 3.5, 0, 0.1, 0.105, 0.1]);
        filename = append("../data-collection/simulation-export/", mcas, "_gradual_injection_quad_coef_0.0_", num2str(next, '%.1f'), "_recovery_enabled_grad_", int2str(version), ".csv");
        success = do_sim("takeoff_stall_pilot_reaction_delay", mcas, 250, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
    
        if success
            low = next;
            fprintf('Value of %.4f success.\n', next);
        else
            high = next;
            fprintf('Value of %.4f fail.\n', next);
        end
    
    end

    fprintf('gradual_quad_vary_coef: Final mid value of %.4f.\n', next);
    midpoint = [low, high];
end % function
