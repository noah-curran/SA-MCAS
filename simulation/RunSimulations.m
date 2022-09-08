%% Script Descriptions
% can init_conds be automatically executed for a given function? otherwise
% people need to look at the script to decide init_conds. Maybe this can be
% done in the select_script function? An array of inputs to the
% set_init_conds could be output or something?

% need to implement: takeoff (more important; working but needs to be made more realistic), landing

% straight_and_level: Start at and maintain 10k ft, 240 kts, 90 deg heading

% straight_and_level_accelerate: Start at and maintain 10k ft, 90 deg
% heading. Start at 240 kts and accelerate to 300 kts when t=15s.

% straight_and_climb: Start at and maintain 240 kts, 90 degree heading. Start at 10k ft and
% climb to 15k ft when t=15 seconds.

% straight_and_descend: Start at and maintain 240 kts, 90 degree heading. Start at 15k ft and
% descend to 10k ft when t=15 seconds.

% level_turns: Start at and maintain 240 kts, 10k ft. Start at 90 degree
% heading and turn to 180 degree heading at t=15 seconds. Turn to 90 degree
% heading once 180 degree heading is reached.

% climb_and_turn: Start at and maintain 240 kts. Start at 10k ft and climb to 15k ft at t=15
% seconds. Start at 90 degree heading and turn to 180 degree heading at t=15 seconds.

% descend_and_turn: Start at and maintain 240 kts. Start at 15k ft and descend to 10k ft at t=15
% seconds. Start at 180 degree heading and turn to 90 degree heading at t=15 seconds.

% holding_pattern: Start at and maintain 10k ft, 240 kts. Start at heading of 90 degrees.
% Hold heading 90 for 60 seconds, then begin a 180 degree turn to a heading of 270 degrees, turning 
% towards the pilot's right. Fly heading 270 for 60 seconds, then perform a 180 degree turn to a 
% heading of 90 degrees, again turning towards the pilot's right. Repeat indefinitely.
% Standard turn rate in large aircraft like the B737 is lower than 3 deg/s.

% takeoff: plane can take off and climb. Now need to make a more realistic takeoff

% landing: not implemented

%% CONFIGURATION

clear; clear all;

% Set up anomalies to inject.
fid = fopen("anomalies/Injection.json");
rawJson = fread(fid, inf);
strJson = char(rawJson');
fclose(fid);
Params = jsondecode(strJson).Injection;

% Sort the anomalies and put it in Simulink
T = struct2table(Params);
sortedT = sortrows(T, 'StartTime');
sortedParams = table2struct(sortedT);

Simulink.Bus.createObject(sortedParams);

% Configure the simulation files
num_sims = 0;   % leave at 0. Used for indexing simulations in the workspace

anomaly_params = 'anomalies/test.json';
test_script = 'scripts/737_cruise'; % not used, JSBSim SFunction still wants to see this though
aircraft_type = '737';
init_conds = 'init_auto';   % set_init_conds writes to init_auto
port_config = 'port_config/port_config_1';

%% RUN SIMULATION

run_sim("takeoff", "mcas_old", 180, 1);

%% FUNCTIONS

function run_sim(script, MCAS, sim_time_sec, do_plot)
    select_script(script);
    select_MCAS(MCAS);
    output = sim('MCASSimulation', sim_time_sec);

    % Plotting only occurs if second parameter was supplied and equal to 1.
    if ~exist("do_plot", 'var')
        do_plot = 0;
    end
    if do_plot == 1
        MCAS_Plotting(output);
    end

    % Index simulation and send output data to MATLAB base workspace
    sim_num = evalin("base", "num_sims") + 1;
    assignin('base', "num_sims", sim_num);
    assignin('base', append("sim_", int2str(sim_num), "_output"), output);
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
        case "holding_pattern"
            set_init_conds(10000, 240, 0, 0, 0, 0, 90);
        case "takeoff"
            % resting height is a bit less than 3.7 ft. Setting initial height to 0 causes
            % compression of landing gear, making plane jump up in the air before eventually
            % settling. Starting plane close to resting height minimizes this.
            set_init_conds(3.7, 0, 0, 0, 0, 0, 90);
        case "landing"
            error("implement initial conditions in select_script function");
            set_init_conds(10000, 240, 0, 0, 0, 0, 90);
        otherwise
            error("script not recognized for setting init_conds. Add script to switch/case.")
    end
end % function

