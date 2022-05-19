classdef (Abstract) Anomaly
    %ANOMALY An abstract representation of an anomaly.
    %   This class is to be inherited by other class objects that are a
    %   type of anomaly. The inherited class will implement the
    %   injection algorithm and define the shape of the anomaly.

    properties (Abstract)
        Type {mustBeText}
    end
    
    methods (Abstract)
        outputData = injection(obj, inputData)
    end
end

