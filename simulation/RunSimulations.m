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

set_script_parameters_zero;
script_parameters(14) = 120;
set_init_conds(10000, 240, 0, 0, 0, 0, 120);
%disp(script_parameters(13));
run_sim("holding_pattern", "none", 600, sortedParams, 1, 0, 0, 1);
