function no_anomolies_run_handler(output, injection_params, do_plot, sim_time_sec)
    % Set up no anomalies to inject.
    fid = fopen('anomalies/EmptyInjection.json');
    rawJson = fread(fid, inf);
    strJson = char(rawJson');
    fclose(fid);
    Params = jsondecode(strJson).Injection;
    
    % Sort the no anomalies and put it in Simulink
    T = struct2table(Params);
    sortedT = sortrows(T, 'StartTime');
    global sortedParams;
    sortedParams = table2struct(sortedT);
    
    no_anomalies_output = sim('MCASSimulation', sim_time_sec);
    
    % Plotting only occurs if do_plot was supplied and equal to 1.
    if ~exist("do_plot", 'var')
        do_plot = 0;
    end
    if do_plot == 1
        MCAS_Plotting(output, injection_params, no_anomalies_output);
    end
end
