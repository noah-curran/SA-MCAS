%% script descriptions found in Documentation/Pilot Simulator/
% List of scripts: straight_and_level, straight_and_level_accelerate, 
% straight_and_climb, straight_and_descend, level_turns, climb_and_turn, 
% descend_and_turn, turn_then_descend, holding_pattern, takeoff, 
% takeoff_stall_perfect_pilot, takeoff_stall_pilot_reaction_delay, 
% takeoff_anomaly, takeoff_JT610_no_intervention, takeoff_JT610,landing

clc; clear;
initialize_sim_config;
store_anomaly_params(append('anomalies/EmptyInjection.json'));
set_script_parameters([zeros(1, 21), 50, 300, 100, 3]);
set_mcas_parameters([11, 2.5, 0.27]);
filename = append("../data-collection/simulation-export/manual_output.csv");
do_sim("takeoff_stall_pilot_reaction_delay", "sa_mcas", 600, evalin("base", "sortedParams"), 1, 0, 0, 0, filename);
