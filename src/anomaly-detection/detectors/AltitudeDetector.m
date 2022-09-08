classdef AltitudeDetector < LinearRegressionAnomalyDetector
    %TESTDETECTOR Summary of this class goes here
    %   Detailed explanation goes here
    
    methods
        function obj = AltitudeDetector(model)
            %TESTDETECTOR Construct an instance of this class
            %   Detailed explanation goes here
            obj.Model = model;
        end

        function dataDelta = getDataDelta(data)
            [row, ~] = size(data);
            dataDelta = zeros(row-1, 1);
            for r=1:row-1
                dataDelta(r,1) = data(r+1,1) - data(r,1);
            end
        end

        function inInterval = detection(obj, alpha, hbar)

            [predAlpha, ci] = runModel(hbar);

            % https://pressbooks.lib.vt.edu/aerodynamics/chapter/chapter-5-altitude-change-climb-and-guide/
            % Altitude drops once stalling. (happens ~18 degrees)
            % Speed drops as altitude drops.

            if (predAlpha + ci(1) > alpha) && (predAlpha + ci(2) < alpha)
                inInterval = true;
            else
                inInterval = false;
            end
        end
    end
end

