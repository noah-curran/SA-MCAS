classdef (Abstract) PolynomialRegressionAnomalyDetector < AnomalyDetector
    %ANOMALY An abstract representation of an anomaly.
    %   This class is to be inherited by other class objects that are a
    %   type of anomaly detector. The inherited class will implement the
    %   detection algorithm and define how it will detect the anomaly.

    properties
        Type = DetectorType.PolynomialRegression;
    end

    properties (Abstract)
        Model;
        Epsilon;
    end

    methods
        function results = runModel(obj, data)
            results = polyval(obj.Model, data);
        end
    end
end

