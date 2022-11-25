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

climb_amount_array = 1000:1000:10000;
start_alt_array = 1000:1000:10000;
% climb_amount_array = 10000;
% start_alt_array = 10000;

for start_alt = start_alt_array
    for climb_amount = climb_amount_array
        end_alt = start_alt + climb_amount;
        
%         disp("Start, end alt: ");
%         disp([start_alt end_alt]);

        set_script_parameters(0, start_alt, end_alt, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
        set_init_conds(start_alt, 300, 0, 0, 0, 0, 90);
        run_sim("straight_and_climb", "none", 400, sortedParams, 1, 0, 1, 1);
    end
end
