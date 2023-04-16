function set_mcas_parameters(parameters)
    % Array with dummy 'timestamp' for feeding through to Simulink
    assignin('base', "mcas_parameters", [-999, parameters]);
end % function

% 1. MCAS cooldown time
% 2. MCAS trim amount (deg)
% 3. MCAS trim rate (deg/s)

% "defaults" would be cooldown=11, trim_amount=2.5, trim_rate=0.27