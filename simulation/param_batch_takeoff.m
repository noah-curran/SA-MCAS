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

initial_climb_airspeed_array = 160:20:200;    % 3
shallower_alt_array = 2000:1000:4000;         % 3
final_climb_airspeed_array = 220:20:300;      % 5
final_alt_array = 5000:2500:15000;            % 5

% initial_climb_airspeed_array = 180;
% shallower_alt_array = 2000;
% final_climb_airspeed_array = 250;
% final_alt_array = 10000;

for initial_climb_airspeed = initial_climb_airspeed_array
    for shallower_alt = shallower_alt_array
        for final_climb_airspeed = final_climb_airspeed_array
            for final_alt = final_alt_array

                disp("Initial climb airspeed, alt: ");
                disp([initial_climb_airspeed, shallower_alt]);
                disp("Final climb airspeed, alt: ");
                disp([final_climb_airspeed, final_alt]);

                set_script_parameters_zero;
                script_parameters(15) = initial_climb_airspeed;
                script_parameters(16) = shallower_alt;
                script_parameters(17) = final_climb_airspeed;
                script_parameters(18) = final_alt;
                assignin("base", "script_params", script_parameters);

                set_script_parameters(script_params);   % why is this necessary for parameters to be slotted correctly?
                %set_init_conds(12, 0, 0, 0, 0, 0, start_heading);
                run_sim("takeoff", "none", 500, sortedParams, 0, 0, 1, 0);
            end
        end
    end
end
