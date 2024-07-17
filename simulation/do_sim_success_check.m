function is_success = do_sim_success_check(script, MCAS, sim_time_sec, override_init_conds)
    select_script(script, override_init_conds);
    select_MCAS(MCAS);

    output = sim('MCASSimulation', sim_time_sec);

    h_asl = output.h_asl.Data(:);
    find(h_asl(:) < 0, 1, 'first')
    if isempty(find(h_asl(:) < 0, 1, 'first'))
        is_success = true
    else
        is_success = false
    end

end % function
