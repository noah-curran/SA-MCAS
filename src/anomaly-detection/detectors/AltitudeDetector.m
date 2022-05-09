classdef AltitudeDetector < LinearRegressionAnomalyDetector
    %TESTDETECTOR Summary of this class goes here
    %   Detailed explanation goes here
    
    methods
        function obj = AltitudeDetector(model, epsilon)
            %TESTDETECTOR Construct an instance of this class
            %   Detailed explanation goes here
            obj.Model = model;
            obj.Epsilon = epsilon;
        end

        function dataDelta = getDataDelta(data)
            [row, ~] = size(data);
            dataDelta = zeros(row-1, 1);
            for r=1:row-1
                dataDelta(r,1) = data(r+1,1) - data(r,1);
            end
        end

        function errors = detection(obj, inputData)
            AoA = inputData(:,1);
            Altitude = inputData(:,2);

            AltitudeDelta = getDataDelta(Altitude);

            estAltitudeDelta = runModel(AoA);

            % https://pressbooks.lib.vt.edu/aerodynamics/chapter/chapter-5-altitude-change-climb-and-guide/
            % Altitude drops once stalling. (happens ~18 degrees)
            % Speed drops as altitude drops.
            [row,~] = size(AltitudeDelta);

            errors = zeros(row);
            for r=1:row
                if abs(AltitudeDelta - estAltitudeDelta) > obj.Epsilon
                    errors(r) = true;
                else
                    errors(r) = false;
                end
            end
        end
    end
end

