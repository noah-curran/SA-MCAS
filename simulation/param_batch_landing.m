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

desc_rate_array = -10:-2:-16;            % 4
final_ref_airspeed_array = 130:5:150;   % 5
start_alt_array = 1500:1000:5500;       % 5

for start_alt = start_alt_array
    for final_ref_airspeed = final_ref_airspeed_array
        for desc_rate = desc_rate_array

            disp("Desc rate, final ref airspeed, start alt: ");
            disp([desc_rate final_ref_airspeed start_alt]);

            set_script_parameters_zero;
            script_parameters(19) = desc_rate;
            script_parameters(20) = final_ref_airspeed;
            script_parameters(21) = start_alt;
            assignin("base", "script_params", script_parameters);

            set_script_parameters(script_params);   % why is this necessary for parameters to be slotted correctly?
            set_init_conds(start_alt, 200, 0, 0, 0, 0, 90);
            run_sim("landing", "none", 600, sortedParams, 0, 0, 1, 1);
        end
    end
end
