classdef LiftDragRatioDetector < AnomalyDetector
    %LIFTDRAGRATIODETECTOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Type = DetectorType.ClosedForm;
        Epsilon
    end
    
    methods
        function obj = LiftDragRatioDetector(epsilon)
            %LIFTDRAGRATIODETECTOR Construct an instance of this class
            %   Detailed explanation goes here
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
            liftDragRatioEstimate = 1/tan(AoA);

            C_L = inputData(:,4);
            C_D = inputData(:,5);
            liftDragRatio = C_L/C_D;

            [row,~] = size(liftDragRatio);

            errors = zeros(row);
            for r=1:row
                if abs(liftDragRatioEstimate - liftDragRatio) > obj.Epsilon
                    errors(r) = true;
                else
                    errors(r) = false;
                end
            end
        end
    end
end

