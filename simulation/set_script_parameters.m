function set_script_parameters(parameters)
    % Array with dummy 'timestamp' for feeding through to Simulink
    assignin('base', "script_parameters", [-999, parameters]);
end % function

%% NEW order:
%     1. accel_start_spd
%     2. accel_end_spd
%     3. climb_start_alt
%     4. climb_final_alt
%     5. desc_start_alt
%     6. desc_end_alt
%     7. levelturn_start_hdg
%     8. levelturn_turn_amount
%     9. climbturn_start_alt
%     10. climbturn_climb_amount
%     11. climbturn_start_hdg
%     12. climbturn_turn_amount
%     13. holdpat_starting_heading
%     14. holdpat_leg_duration
%     15. takeoff_initial_climb_airspeed
%     16. takeoff_climb_shallower_alt
%     17. takeoff_final_climb_airspeed
%     18. takeoff_final_alt
%     19. landing_desc_rate
%     20. landing_final_ref_airspeed
%     21. landing_start_alt
%     22. takeoffstall_target_pitch
%     23. takeoffstall_final_climb_airspeed
%     24. takeoffstall_pullup_time
%     25. pilot_reaction_time
