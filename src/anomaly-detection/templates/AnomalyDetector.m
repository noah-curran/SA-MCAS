classdef (Abstract) AnomalyDetector
    %ANOMALY An abstract representation of an anomaly.
    %   This class is to be inherited by other class objects that are a
    %   type of anomaly detector. The inherited class will implement the
    %   detection algorithm and define how it will detect the anomaly.

    properties (Abstract)
        Type {mustBeText}
    end
    
    methods (Abstract)
        errors = detection(obj, inputData)
    end
end

