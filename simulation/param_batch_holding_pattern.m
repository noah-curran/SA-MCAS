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

% start_heading_array = 0:30:360;
% leg_duration_array = 0:20:240;

start_heading_array = 90;
leg_duration_array = 200;

for start_heading = start_heading_array
    for leg_duration = leg_duration_array
        
        disp("Start hdg, leg duration: ");
        disp([start_heading leg_duration]);

        set_script_parameters_zero;
        script_parameters(13) = start_heading;
        script_parameters(14) = leg_duration;
        assignin("base", "script_params", script_parameters);

        set_script_parameters(script_params);   % why is this necessary for parameters to be slotted correctly?
        set_init_conds(10000, 240, 0, 0, 0, 0, start_heading);
        run_sim("holding_pattern", "none", 600, sortedParams, 1, 0, 0, 1);
    end
end
