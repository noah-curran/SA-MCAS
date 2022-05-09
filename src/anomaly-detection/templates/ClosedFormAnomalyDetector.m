classdef (Abstract) ClosedFormAnomalyDetector < AnomalyDetector
    %ANOMALY An abstract representation of an anomaly.
    %   This class is to be inherited by other class objects that are a
    %   type of anomaly detector. The inherited class will implement the
    %   detection algorithm and define how it will detect the anomaly.

    properties
        Type = DetectorType.ClosedForm;
    end

    properties (Abstract)
        Epsilon;
    end
end

