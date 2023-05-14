function set_mcas_parameters(parameters)
    % Array with dummy 'timestamp' for feeding through to Simulink
    assignin('base', "mcas_parameters", [-999, parameters]);
end % function

% 1. MCAS cooldown time
% 2. MCAS trim amount (deg)
% 3. MCAS trim rate (deg/s)
% 4. Pilot trim wheel rotations per degree
% 5. Pilot trim wheel rotations per second
% 6. Initial pilot energy
% 7. Energy input rate
% 8. Background energy burn rate
% 9. Trimming energy burn rate

% "defaults" would be cooldown=11, trim_amount=2.5, trim_rate=0.27,
% rotations_per_degree=18, rotations_per_second=7.2