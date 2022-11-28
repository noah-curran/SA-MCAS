function set_script_parameters(par)
    
    accel_start_spd = par(1);
    accel_end_spd = par(2);
    climb_start_alt = par(3);
    climb_final_alt = par(4);
    desc_start_alt = par(5);
    desc_end_alt = par(6);
    levelturn_start_hdg = par(7);
    levelturn_turn_amount = par(8);
    climbturn_start_alt = par(9);
    climbturn_climb_amount = par(10);
    climbturn_start_hdg = par(11);
    climbturn_turn_amount = par(12);
    holdpat_starting_heading = par(13);
    holdpat_leg_duration = par(14);
    takeoff_initial_climb_airspeed = par(15);
    takeoff_climb_shallower_alt = par(16);
    takeoff_final_climb_airspeed = par(17);
    takeoff_final_alt = par(18);
    landing_desc_rate = par(19);
    landing_final_ref_airspeed = par(20);
    landing_start_alt = par(21);
    takeoffstall_target_pitch = par(22);
    takeoffstall_final_climb_airspeed = par(23);
    takeoffstall_pullup_time = par(24);

    % add element -999 at beginning, which will be interpreted as timeseries
    % data by the "From Workspace" block and discarded from the array.
    arr = [-999, ...
        accel_start_spd, accel_end_spd, ...
        climb_start_alt, climb_final_alt, ...
        desc_start_alt, desc_end_alt, ...
        levelturn_start_hdg, levelturn_turn_amount, ...
        climbturn_start_alt, climbturn_climb_amount, climbturn_start_hdg, climbturn_turn_amount, ...
        holdpat_starting_heading, holdpat_leg_duration, ...
        takeoff_initial_climb_airspeed, takeoff_climb_shallower_alt, takeoff_final_climb_airspeed, takeoff_final_alt, ...
        landing_desc_rate, landing_final_ref_airspeed, landing_start_alt, ...
        takeoffstall_target_pitch, takeoffstall_final_climb_airspeed, takeoffstall_pullup_time
        ];

    assignin('base', "script_parameters", arr);
end