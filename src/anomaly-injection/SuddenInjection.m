classdef SuddenInjection < AnomalyInjection

    properties 
        Value = 0;
    end
    
    methods 
        function obj = SuddenInjection(value)
            obj.Value = value;
        end

        function outputData = injection(obj, inputata)
                outputData = obj.Value;
        end

    end

end

