% Configure the simulation files
num_sims = 0;   % leave at 0. Used for indexing simulations in the workspace
anomaly_params = 'anomalies/EmptyInjection.json';
test_script = 'scripts/737_cruise'; % not used, JSBSim SFunction still wants to see this though
aircraft_type = '737-RTCL';
init_conds = 'init_auto';   % function set_init_conds writes to init_auto
port_config = 'port_config/port_config_1';

% Set up anomalies to inject.
fid = fopen(anomaly_params);
rawJson = fread(fid, inf);
strJson = char(rawJson');
fclose(fid);
Params = jsondecode(strJson).Injection;

% Sort the anomalies and put it in Simulink
T = struct2table(Params);
sortedT = sortrows(T, 'StartTime');
global sortedParams;
sortedParams = table2struct(sortedT);
Simulink.Bus.createObject(sortedParams);
