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
% for i=1:3
%     alt = 10000 + 3000*i;
%     set_script_parameters(0, alt, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
%     run_sim("straight_and_climb", "none", 200, sortedParams, 1, false, 1);
% end

start_alt = 4000;
end_alt = 11000;

set_script_parameters(0, start_alt, end_alt, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
set_init_conds(start_alt, 300, 0, 0, 0, 0, 90);
run_sim("straight_and_climb", "none", 200, sortedParams, 1, 0, 0, 1);
