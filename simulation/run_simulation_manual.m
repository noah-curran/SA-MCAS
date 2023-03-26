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

clc; clear;
initialize_sim_config;
store_anomaly_params(append('anomalies/EmptyInjection.json'));
set_script_parameters([zeros(1, 21), 80, 300, 100, 0]);
filename = append("../data-collection/simulation-export/manual_output.csv");
do_sim("takeoff_stall", "none", 300, evalin("base", "sortedParams"), 1, 0, 0, 0, filename);
