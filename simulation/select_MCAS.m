function select_MCAS(MCAS_str)
    % Ascii array with dummy 'timestamp' for feeding through to Simulink
    ascii_arr = [-999, double(char(MCAS_str))];
    assignin('base', "function_block_MCAS", ascii_arr);
end % function
