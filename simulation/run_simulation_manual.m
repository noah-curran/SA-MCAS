%% script descriptions found in Documentation/Pilot Simulator/
% List of scripts: straight_and_level, straight_and_level_accelerate, 
% straight_and_climb, straight_and_descend, level_turns, climb_and_turn, 
% descend_and_turn, turn_then_descend, holding_pattern, takeoff, 
% takeoff_stall_perfect_pilot, takeoff_stall_pilot_reaction_delay, 
% takeoff_anomaly, takeoff_JT610_no_intervention, takeoff_JT610,landing

clc; clear;
initialize_sim_config;
store_anomaly_params(append('anomalies/EmptyInjection.json'));
%set_script_parameters([zeros(1, 25)]);  % straight and level
set_script_parameters([zeros(1, 21), 50, 300, 100, 1]);  % takeoff_stall
%set_script_parameters([zeros(1, 14), 180, 2000, 300, 10000, zeros(1, 7)]);  % normal takeoff
set_mcas_parameters([11, 2.5, 0.27, 18, 7.2, 0, 0.1, 0.105, 0.1]);
filename = append("../data-collection/simulation-export/manual_output.csv");
do_sim("takeoff_stall_pilot_reaction_delay", "sa_mcas", 300, evalin("base", "sortedParams"), 1, 0, 0, 0, filename);
