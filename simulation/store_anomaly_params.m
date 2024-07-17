function store_anomaly_params(anomaly_params)
    fid = fopen(anomaly_params);
    rawJson = fread(fid, inf);
    strJson = char(rawJson');
    fclose(fid);

    params_table = struct2table(jsondecode(strJson).Injection);
    sorted_params_struct = table2struct(sortrows(params_table, 'StartTime'));
    assignin('base', "sortedParams", sorted_params_struct);

    assignin('base', 'anom_param_bus', Simulink.Bus.createObject(sorted_params_struct));
end
