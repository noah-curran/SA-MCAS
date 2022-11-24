function select_MCAS(MCAS_str)
    % "From workspace" simulink block doesn't like strings, so turn string
    % into an array of ascii doubles. This is converted back into a string
    % in simulink before being supplied to the function block.

    % The "From workspace" block interprets first column as time data, so a
    % null character is appended to the array of actual ascii values to
    % prevent the first character of the string from being thrown out.
    ascii_arr = [0, double(char(MCAS_str))];

    % Put ascii array into workspace for simulink to read
    assignin('base', "function_block_MCAS", ascii_arr);
end % function
