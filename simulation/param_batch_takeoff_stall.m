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

pitch_target_array = 25:5:50;             % 6
final_climb_airspeed_array = 225:10:275;  % 6
pullup_time_array = 80:20:160;            % 5

% pitch_target_array = 25;
% final_climb_airspeed_array = 275;
% pullup_time_array = 160;

for pitch_target = pitch_target_array
    for final_climb_airspeed = final_climb_airspeed_array
        for pullup_time = pullup_time_array

            disp("pitch_target, final climb speed, pullup time: ");
            disp([pitch_target final_climb_airspeed pullup_time]);

            set_script_parameters_zero;
            script_parameters(22) = pitch_target;
            script_parameters(23) = final_climb_airspeed;
            script_parameters(24) = pullup_time;
            assignin("base", "script_params", script_parameters);

            set_script_parameters(script_params);   % why is this necessary for parameters to be slotted correctly?
            % set_init_conds(pitch_target, 200, 0, 0, 0, 0, 90);
            run_sim("takeoff_stall", "none", 300, sortedParams, 0, 0, 1, 0);
        end
    end
end
