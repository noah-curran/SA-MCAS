classdef DeltaInjection < AnomalyInjection

    properties 
        DeltaVal = 0;
    end
    
    methods 

        function obj = DeltaInjection(value)
            obj.DeltaVal = value;
        end

        function outputData = injection(obj, inputData)
                outputData = inputData + obj.DeltaVal;

        end

    end

end



