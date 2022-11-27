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

    % add element -999 at beginning, which will be interpreted as timeseries
    % data by the "From Workspace" block and discarded from the array.
    arr = [-999, ...
        accel_start_spd, accel_end_spd, ...
        climb_start_alt, climb_final_alt, ...
        desc_start_alt, desc_end_alt, ...
        levelturn_start_hdg, levelturn_turn_amount, ...
        climbturn_start_alt, climbturn_climb_amount, climbturn_start_hdg, climbturn_turn_amount, ...
        holdpat_starting_heading, holdpat_leg_duration
        ];

    assignin('base', "script_parameters", arr);
end