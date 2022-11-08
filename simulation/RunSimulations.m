% script descriptions found in Documentation/Pilot Simulator/...
% ...Script Descriptions.txt
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

%% CONFIGURATION

clear; clear all;

% Configure the simulation files
num_sims = 0;   % leave at 0. Used for indexing simulations in the workspace
anomaly_params = 'anomalies/EmptyInjection.json';
test_script = 'scripts/737_cruise'; % not used, JSBSim SFunction still wants to see this though
aircraft_type = '737-RTCL';
init_conds = 'init_auto';   % function set_init_conds writes to init_auto
port_config = 'port_config/port_config_1';

% Set up anomalies to inject.
fid = fopen(anomaly_params);
rawJson = fread(fid, inf);
strJson = char(rawJson');
fclose(fid);
Params = jsondecode(strJson).Injection;

% Sort the anomalies and put it in Simulink
T = struct2table(Params);
sortedT = sortrows(T, 'StartTime');
global sortedParams;
sortedParams = table2struct(sortedT);
Simulink.Bus.createObject(sortedParams);

%% RUN SIMULATIONS
for i=1:3
    alt = 10000 + 3000*i;
    set_script_parameters(0, alt, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    run_sim("straight_and_climb", "none", 200, sortedParams, 1, false, 1);
end

%% FUNCTIONS

function run_sim(script, MCAS, sim_time_sec, injection_params, do_plot, do_no_anomalies, do_csv)
    select_script(script);
    select_MCAS(MCAS);

    output = sim('MCASSimulation', sim_time_sec);
    
    if do_no_anomalies

        % Set up no anomalies to inject.
        fid = fopen('anomalies/EmptyInjection.json');
        rawJson = fread(fid, inf);
        strJson = char(rawJson');
        fclose(fid);
        Params = jsondecode(strJson).Injection;
        
        % Sort the no anomalies and put it in Simulink
        T = struct2table(Params);
        sortedT = sortrows(T, 'StartTime');
        global sortedParams;
        sortedParams = table2struct(sortedT);
    
        no_anomalies_output = sim('MCASSimulation', sim_time_sec);

        % Plotting only occurs if do_plot was supplied and equal to 1.
        if ~exist("do_plot", 'var')
            do_plot = 0;
        end
        if do_plot == 1
            MCAS_Plotting(output, injection_params, no_anomalies_output);
        end

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
    workspace_object_name = append("sim_", int2str(sim_num), "_output");
    assignin('base', workspace_object_name, output);

    % csv dump only occurs if do_csv was supplied and equal to 1.
    if ~exist("do_csv", 'var')
        do_csv = 0;
    end
    if do_csv == 1
        Write_to_CSV(workspace_object_name);
    end

end % function

function select_MCAS(MCAS_str)
    % "From workspace" simulink block doesn't like strings, so turn string
    % into an array of ascii doubles. This is converted back into a string
    % in simulink before being supplied to the function block.

    % The "From workspace" block interprets first column as time data, so a
    % null character is appended to the array of actual ascii values to
    % prevent the first character of the string from being thrown out.
    ascii_arr = [0, double(char(MCAS_str))];

    % Put ascii array into workspace for simulink to read
    assignin('base', "function_block_MCAS", ascii_arr);
end % function

function select_script(script_str)
    % "From workspace" simulink block doesn't like strings, so turn string
    % into an array of ascii doubles. This is converted back into a string
    % in simulink before being supplied to the function block.

    % The "From workspace" block interprets first column as time data, so a
    % null character is appended to the array of actual ascii values to
    % prevent the first character of the string from being thrown out.
    ascii_arr = [0, double(char(script_str))];

    % Put ascii array into workspace for simulink to read
    assignin('base', "function_block_script", ascii_arr);

    % Set initial conditions based on what script is being run
    switch script_str
        case "straight_and_level"
            set_init_conds(10000, 240, 0, 0, 0, 0, 90);
        case "straight_and_level_accelerate"
            set_init_conds(10000, 240, 0, 0, 0, 0, 90);
        case "straight_and_climb"
            set_init_conds(10000, 240, 0, 0, 0, 0, 90);
        case "straight_and_descend"
            set_init_conds(15000, 240, 0, 0, 0, 0, 90);
        case "level_turns"
            set_init_conds(10000, 240, 0, 0, 0, 0, 90);
        case "climb_and_turn"
            set_init_conds(10000, 240, 0, 0, 0, 0, 90);
        case "descend_and_turn"
            set_init_conds(15000, 240, 0, 0, 0, 0, 180);
        case "turn_then_descend"
            set_init_conds(15000, 240, 0, 0, 0, 0, 0);
        case "holding_pattern"
            set_init_conds(10000, 240, 0, 0, 0, 0, 90);
        case "takeoff"
            % resting height is a bit less than 3.7 ft. Plane settles
            % quickly with 3.7 starting "altitude"
            set_init_conds(3.7, 0, 0, 0, 0, 0, 90);
        case "takeoff_JT610"
            set_init_conds(3.7, 0, 0, 0, 0, 0, 90);
        case "takeoff_stall"
            set_init_conds(3.7, 0, 0, 0, 0, 0, 90);
        case "landing"
            set_init_conds(3000, 200, 0, 0, 0, 0, 90);
        otherwise
            error("script not recognized for setting init_conds. Add script to switch/case.")
    end
end % function