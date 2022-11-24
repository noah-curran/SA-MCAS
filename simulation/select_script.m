function select_script(script_str)
    % Set initial conditions based on what script is being run
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
            % resting height is a bit less than 12 ft. Plane settles
            % quickly with 12 starting "altitude"
            set_init_conds(12, 0, 0, 0, 0, 0, 90);
        case "takeoff_JT610"
            set_init_conds(12, 0, 0, 0, 0, 0, 90);
        case "takeoff_stall"
            set_init_conds(12, 0, 0, 0, 0, 0, 90);
        case "landing"
            set_init_conds(3000, 200, 0, 0, 0, 0, 90);
        otherwise
            error("script not recognized for setting init_conds. Add script to switch/case.")
    end
end % function
