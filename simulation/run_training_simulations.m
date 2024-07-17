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

%% RUN SIMULATIONS
clc; clear;
initialize_sim_config;

%param_batch_accelerate;

%param_batch_climbturn;

%param_batch_descturn;

%param_batch_holdingpattern;

%param_batch_landing;

%param_batch_levelturns;

%param_batch_straightclimb;

%param_batch_straightdescend;

%param_batch_takeoff;

param_batch_takeoffstall;


%% FUNCTIONS
function param_batch_accelerate()
%     accel_amount_array = 0:10:100;
%     start_spd_array = 200:10:300;
    accel_amount_array = 100;
    start_spd_array = 200;
    
    for start_spd = start_spd_array
        for accel_amount = accel_amount_array
            end_spd = start_spd + accel_amount;
    
            disp("Start, end speed: ");
            disp([start_spd end_spd]);

            set_script_parameters([start_spd, end_spd, zeros(1, 23)]);

            filename = append("../data-collection/simulation-export/train_lvlaccel_start_", ...
                num2str(start_spd), "_end_", num2str(end_spd), ".csv");

            store_anomaly_params("anomalies/EmptyInjection.json");
            set_init_conds(10000, start_spd, 0, 0, 0, 0, 90);
            do_sim("straight_and_level_accelerate", "none", 100, evalin("base", "sortedParams"), 0, 0, 1, 1, filename);
        end
    end
end % function

function param_batch_climbturn()
    % turn_amount_array = -100:20:100;
    % climb_amount_array = 0:500:5000;
    turn_amount_array = 100;
    climb_amount_array = 5000;
    
    start_alt = 5000;
    start_heading = 180;
    
    for climb_amount = climb_amount_array
        for turn_amount = turn_amount_array
            
            disp("Start hdg, turn amount: ");
            disp([start_heading turn_amount]);
            disp("Start alt, climb amount: ");
            disp([start_alt climb_amount]);
    
            set_script_parameters([zeros(1, 8), start_alt, climb_amount, ...
                start_heading, turn_amount, zeros(1, 13)]);

            filename = append("../data-collection/simulation-export/train_climbturn_startheading_", ...
                num2str(start_heading), "_turn_amount_", num2str(turn_amount), ...
                "_start_alt_", num2str(start_alt), "_climb_amount_", num2str(climb_amount), ".csv");

            store_anomaly_params("anomalies/EmptyInjection.json");
            set_init_conds(start_alt, 240, 0, 0, 0, 0, start_heading);
            do_sim("climb_and_turn", "none", 300, evalin("base", "sortedParams"), 0, 0, 1, 1, filename);
        end
    end
end % function

function param_batch_descturn()
    % turn_amount_array = -100:20:100;
    % desc_amount_array = 0:-500:-5000;
    turn_amount_array = 120;
    desc_amount_array = -2500;
    
    start_alt = 10000;
    start_heading = 180;
    
    for desc_amount = desc_amount_array
        for turn_amount = turn_amount_array
            
            disp("Start hdg, turn amount: ");
            disp([start_heading turn_amount]);
            disp("Start alt, climb amount: ");
            disp([start_alt desc_amount]);
    
            set_script_parameters([zeros(1, 8), start_alt, desc_amount, ...
                    start_heading, turn_amount, zeros(1, 13)]);

            filename = append("../data-collection/simulation-export/train_descturn_startheading_", ...
                num2str(start_heading), "_turn_amount_", num2str(turn_amount), ...
                "_start_alt_", num2str(start_alt), "_desc_amount_", num2str(desc_amount), ".csv");

            store_anomaly_params("anomalies/EmptyInjection.json");
            set_init_conds(start_alt, 240, 0, 0, 0, 0, start_heading);
            % Using climb_and_turn with negative climb because it's the
            % same as descend and turn
            do_sim("climb_and_turn", "none", 300, evalin("base", "sortedParams"), 0, 0, 1, 1, filename);
        end
    end
end % function

function param_batch_holdingpattern()
    % start_heading_array = 0:30:360;
    % leg_duration_array = 0:20:240;
    start_heading_array = 90;
    leg_duration_array = 200;
    
    for start_heading = start_heading_array
        for leg_duration = leg_duration_array
            
            disp("Start hdg, leg duration: ");
            disp([start_heading leg_duration]);
    
            set_script_parameters([zeros(1, 12), start_heading, ...
                    leg_duration, zeros(1, 11)]);

            filename = append("../data-collection/simulation-export/train_holdingpattern_startheading_", ...
                num2str(start_heading), "_leg_duration_", num2str(leg_duration), ".csv");

            store_anomaly_params("anomalies/EmptyInjection.json");
            set_init_conds(10000, 240, 0, 0, 0, 0, start_heading);
            do_sim("holding_pattern", "none", 600, evalin("base", "sortedParams"), 0, 0, 1, 1, filename);
        end
    end
end % function

function param_batch_landing()
%     desc_rate_array = -10:-2:-16;            % 4
%     final_ref_airspeed_array = 130:5:150;   % 5
%     start_alt_array = 1500:1000:5500;       % 5
    desc_rate_array = -10;
    final_ref_airspeed_array = 130;
    start_alt_array = 1500;
    
    for start_alt = start_alt_array
        for final_ref_airspeed = final_ref_airspeed_array
            for desc_rate = desc_rate_array
    
                disp("Desc rate, final ref airspeed, start alt: ");
                disp([desc_rate final_ref_airspeed start_alt]);
    
                set_script_parameters([zeros(1, 18), desc_rate, final_ref_airspeed, ...
                    start_alt, zeros(1, 4)]);

                filename = append("../data-collection/simulation-export/train_landing_start_alt_", ...
                num2str(start_alt), "_desc_rate_", num2str(desc_rate), "_final_airspeed_", ...
                num2str(final_ref_airspeed), ".csv");

                store_anomaly_params("anomalies/EmptyInjection.json");
                set_init_conds(start_alt, 200, 0, 0, 0, 0, 90);
                do_sim("landing", "none", 600, evalin("base", "sortedParams"), 0, 0, 1, 1, filename);
            end
        end
    end
end % function

function param_batch_levelturns()
    % turn_amount_array = -100:2:100;
    turn_amount_array = -10;
    start_heading = 180;

    for turn_amount = turn_amount_array
        
        disp("Start, turn amount: ");
        disp([start_heading turn_amount]);

        set_script_parameters([zeros(1, 6), start_heading, turn_amount, zeros(1, 17)]);

        filename = append("../data-collection/simulation-export/train_levelturns_turn_amount_", ...
                num2str(turn_amount), ".csv");

        store_anomaly_params("anomalies/EmptyInjection.json");
        set_init_conds(10000, 240, 0, 0, 0, 0, start_heading);
        do_sim("level_turns", "none", 200, evalin("base", "sortedParams"), 0, 0, 1, 1, filename);
    end
end % function

function param_batch_straightclimb()
    % climb_amount_array = 1000:1000:10000;
    % start_alt_array = 1000:1000:10000;
    climb_amount_array = 10000;
    start_alt_array = 10000;
    
    for start_alt = start_alt_array
        for climb_amount = climb_amount_array
            end_alt = start_alt + climb_amount;
            
            disp("Start, end alt: ");
            disp([start_alt end_alt]);
    
            set_script_parameters([zeros(1, 2), start_alt, end_alt, zeros(1, 21)]);

            filename = append("../data-collection/simulation-export/train_straightclimb_start_alt_", ...
                num2str(start_alt), "_end_alt_", num2str(end_alt), ".csv");

            store_anomaly_params("anomalies/EmptyInjection.json");
            set_init_conds(start_alt, 300, 0, 0, 0, 0, 90);
            do_sim("straight_and_climb", "none", 400, evalin("base", "sortedParams"), 0, 0, 1, 1, filename);
        end
    end
end % function

function param_batch_straightdescend()
%     descent_amount_array = 10000:-1000:1000;
%     start_alt_array = 20000:-1000:11000;
    descent_amount_array = 10000;
    start_alt_array = 20000;
    
    for start_alt = start_alt_array
        for descent_amount = descent_amount_array
            end_alt = start_alt - descent_amount;
            
            disp("Start, end alt: ");
            disp([start_alt end_alt]);
    
            set_script_parameters([zeros(1, 4), start_alt, end_alt, zeros(1, 19)]);

            filename = append("../data-collection/simulation-export/train_straightdescend_start_alt_", ...
                num2str(start_alt), "_end_alt_", num2str(end_alt), ".csv");

            store_anomaly_params("anomalies/EmptyInjection.json");
            set_init_conds(start_alt, 300, 0, 0, 0, 0, 90);
            do_sim("straight_and_climb", "none", 600, evalin("base", "sortedParams"), 0, 0, 1, 1, filename);
        end
    end
end % function

function param_batch_takeoff()
%     initial_climb_airspeed_array = 160:20:200;    % 3
%     shallower_alt_array = 2000:1000:4000;         % 3
%     final_climb_airspeed_array = 220:20:300;      % 5
%     final_alt_array = 5000:2500:15000;            % 5
    
    initial_climb_airspeed_array = 180;
    shallower_alt_array = 2000;
    final_climb_airspeed_array = 250;
    final_alt_array = 10000;
    
    for initial_climb_airspeed = initial_climb_airspeed_array
        for shallower_alt = shallower_alt_array
            for final_climb_airspeed = final_climb_airspeed_array
                for final_alt = final_alt_array
    
                    disp("Initial climb airspeed, alt: ");
                    disp([initial_climb_airspeed, shallower_alt]);
                    disp("Final climb airspeed, alt: ");
                    disp([final_climb_airspeed, final_alt]);
    
                    set_script_parameters([zeros(1, 14), initial_climb_airspeed, ...
                        shallower_alt, final_climb_airspeed, final_alt, zeros(1, 7)]);

                    filename = append("../data-collection/simulation-export/train_takeoff_initial_airspeed_", ...
                    num2str(initial_climb_airspeed), "_shallowing_alt_", num2str(shallower_alt), ...
                    "_final_airspeed_", num2str(final_climb_airspeed), "_final_alt_", num2str(final_alt), ".csv");

                    store_anomaly_params("anomalies/EmptyInjection.json");
                    % using default initial conditions
                    % set_init_conds(12, 0, 0, 0, 0, 0, start_heading);
                    do_sim("takeoff", "none", 500, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
                end
            end
        end
    end
end % function

function param_batch_takeoffstall()
%     pitch_target_array = 25:5:50;             % 6
%     final_climb_airspeed_array = 225:10:275;  % 6
%     pullup_time_array = 80:20:160;            % 5
    
    pitch_target_array = 25;
    final_climb_airspeed_array = 275;
    pullup_time_array = 160;

    for pitch_target = pitch_target_array
        for final_climb_airspeed = final_climb_airspeed_array
            for pullup_time = pullup_time_array
    
                disp("pitch_target, final climb speed, pullup time: ");
                disp([pitch_target final_climb_airspeed pullup_time]);
    
                set_script_parameters([zeros(1, 21), pitch_target, final_climb_airspeed, ...
                    pullup_time, zeros(1, 1)]);

                filename = append("../data-collection/simulation-export/train_takeoffstall_pitch_target_", ...
                    num2str(pitch_target), "_final_airspeed_", num2str(final_climb_airspeed), ...
                    "_pullup_time_", num2str(pullup_time), ".csv");

                store_anomaly_params("anomalies/EmptyInjection.json");
                % using default initial conditions
                % set_init_conds(pitch_target, 200, 0, 0, 0, 0, 90);
                do_sim("takeoff_stall", "none", 500, evalin("base", "sortedParams"), 0, 0, 0, 1, filename);
            end
        end
    end
end % function
