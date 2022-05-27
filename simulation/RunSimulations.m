%%%
% Test Documentation
%
% To run a test, you must define the following variables:
% anomaly_params: a JSON file that describes the anomalies that must be
%   included in the test.
% test_script: the file that is in the scripts/ directory that this test
%   will run.
% aircraft_type: the aircraft type that is used from the aircraft/
%   directory.
% init_conds: the XML file that is in aircraft/<aircraft_type>/ and
%   describes the initial conditions used.
%
% For each test, block it off by using %% right before it, and give the
% test a descriptive name in order to understand what it is trying to
% achieve. Inside the test code, display the same descriptive test name and
% run the simulation. Finally, clean up the workspace.
%
% Example test to show how we format them:
%% Example test run of a 737 to show how to simulate.
% Necessary variable definitions.
anomaly_params = 'anomalies/test.json';
test_script = 'scripts/737_cruise';
aircraft_type = '737';
init_conds = 'cruise_init';
port_config = 'port_config/test';
port_config2 = 'port_config/test2';

% Run this simulation.
disp('Example test run of a 737 to show how to simulate.');
sim('MCASSimulation');

% Clean up the workspace.
%clear functions;
%clear all;
