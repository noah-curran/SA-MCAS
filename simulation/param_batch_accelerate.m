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

accel_amount_array = 0:10:100;
start_spd_array = 200:10:300;
% accel_amount_array = 100;
% start_spd_array = 200;

for start_spd = start_spd_array
    for accel_amount = accel_amount_array
        end_spd = start_spd + accel_amount;
        
        disp("Start, end speed: ");
        disp([start_spd end_spd]);

        script_params = [start_spd, end_spd, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        assignin("base", "script_params", script_params);

        set_script_parameters(script_params);
        set_init_conds(10000, start_spd, 0, 0, 0, 0, 90);
        run_sim("straight_and_level_accelerate", "none", 100, sortedParams, 0, 0, 1, 1);
    end
end
