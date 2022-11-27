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

% turn_amount_array = -100:20:100;
% desc_amount_array = 0:-500:-5000;
turn_amount_array = 120;
desc_amount_array = -2500;

start_alt = 10000;
start_heading = 180;

for desc_amount = desc_amount_array
    for turn_amount = turn_amount_array
        
        disp("Start hdg, turn amount: ");
        disp([start_heading turn_amount]);
        disp("Start alt, climb amount: ");
        disp([start_alt desc_amount]);

        set_script_parameters_zero;
        script_parameters(9) = start_alt;
        script_parameters(10) = desc_amount;
        script_parameters(11) = start_heading;
        script_parameters(12) = turn_amount;
        assignin("base", "script_params", script_parameters);

        set_script_parameters(script_params);   % why is this necessary for parameters to be slotted correctly?
        set_init_conds(start_alt, 240, 0, 0, 0, 0, start_heading);
        % Using climb_and_turn with negative climb because it's the same as desc_and_turn.
        run_sim("climb_and_turn", "none", 300, sortedParams, 1, 0, 1, 1);
    end
end
