function select_script(script_str, override_init_conds)
    % Ascii array with dummy 'timestamp' for feeding through to Simulink
    ascii_arr = [-999, double(char(script_str))];
    assignin('base', "function_block_script", ascii_arr);

    if ~override_init_conds
        switch script_str
            case "straight_and_level"
                set_init_conds(10000, 240, 0, 0, 0, 0, 90);
            case "straight_and_level_accelerate"
                set_init_conds(10000, 240, 0, 0, 0, 0, 90);
            case "straight_and_climb"
                set_init_conds(10000, 240, 0, 0, 0, 0, 90);
            case "straight_and_descend"
                set_init_conds(15000, 240, 0, 0, 0, 0, 90);
            case "level_turns"
                set_init_conds(10000, 240, 0, 0, 0, 0, 90);
            case "climb_and_turn"
                set_init_conds(10000, 240, 0, 0, 0, 0, 90);
            case "descend_and_turn"
                set_init_conds(15000, 240, 0, 0, 0, 0, 180);
            case "turn_then_descend"
                set_init_conds(15000, 240, 0, 0, 0, 0, 0);
            case "holding_pattern"
                set_init_conds(10000, 240, 0, 0, 0, 0, 90);
            case "takeoff"
                % resting height is a bit less than 3.7 ft.
                set_init_conds(3.7, 0, 0, 0, 0, 0, 90);
            case "takeoff_anomaly"
                set_init_conds(3.7, 0, 0, 0, 0, 0, 90);
            case "takeoff_JT610_no_intervention"
                set_init_conds(3.7, 0, 0, 0, 0, 0, 90);
            case "takeoff_JT610"
                set_init_conds(3.7, 0, 0, 0, 0, 0, 90);
            case "takeoff_stall_perfect_pilot"
                set_init_conds(3.7, 0, 0, 0, 0, 0, 90);
            case "takeoff_stall_pilot_reaction_delay"
                set_init_conds(3.7, 0, 0, 0, 0, 0, 90);
            case "landing"
                set_init_conds(3000, 200, 0, 0, 0, 0, 90);
            otherwise
                error("script not recognized for setting init_conds.")
        end
    end
end % function
