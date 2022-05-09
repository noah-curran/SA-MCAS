classdef (Abstract) LogisticRegressionAnomalyDetector < AnomalyDetector
    %ANOMALY An abstract representation of an anomaly.
    %   This class is to be inherited by other class objects that are a
    %   type of anomaly detector. The inherited class will implement the
    %   detection algorithm and define how it will detect the anomaly.

    properties
        Type = DetectorType.LogisticRegression;
    end

    properties (Abstract)
        Model;
        Epsilon;
    end

    methods
        function results = runModel(obj, data)
            X = [ones(length(data),1) data];
            % https://stackoverflow.com/questions/47247946/logistic-regression-in-matlab
            results = 1 ./ (1 + exp(-X*obj.Model));
        end
    end
end

