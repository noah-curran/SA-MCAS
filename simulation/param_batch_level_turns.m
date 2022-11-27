%% List of Scripts 
% (details in Documentation/Pilot Simulator/Script Descriptions.txt)

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

%% Initialize
clear;
initialize_sim_config;

%% RUN SIMULATIONS

% turn_amount_array = -100:2:100;
turn_amount_array = -10;
start_heading = 180;

    for turn_amount = turn_amount_array
        
        disp("Start, turn amount: ");
        disp([start_heading turn_amount]);

        script_params = [0, 0, 0, 0, 0, 0, start_heading, turn_amount, 0, 0, 0, 0, 0, 0, 0, 0];
        assignin("base", "script_params", script_params);

        set_script_parameters(script_params);
        set_init_conds(10000, 240, 0, 0, 0, 0, start_heading);
        run_sim("level_turns", "none", 200, sortedParams, 1, 0, 1, 1);
    end
