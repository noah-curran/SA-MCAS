classdef SensorData
    %SENSORDATA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        DataPath {mustBeFile} = "./SensorData.m"
        ParamsPath {mustBeFile} = "./SensorData.m"
        Data
        Params
    end
    
    methods
        function obj = SensorData(dataPath, paramsPath)
            %SENSORDATA Construct an instance of this class
            %   The path names for the required sensor data to process and
            %   the accompanying parameters for processing the sensor data
            %   are included here.

            obj.DataPath = dataPath;
            obj.ParamsPath = paramsPath;
        end
        
        function obj = readData(obj)
            %READDATA Reads the data from the file paths passed in.
            %   The sensor data is first obtained from the .csv file and
            %   loaded into the class locally. Then, the parameters for
            %   processing the sensor data are obtained from the JSON file
            %   as a string and decoded into JSON format.

            % Load the sensor data from the .csv file.
            obj.Data = readMatrix(obj.DataPath);

            % Load the parameters for processing the sensor data from the
            % .json file.
            fid = fopen(obj.ParamsPath);
            rawJson = fread(fid, inf);
            strJson = char(rawJson');
            fclose(fid);
            obj.Params = jsondecode(strJson);
        end

        function obj = processData(obj)
            %PROCESSDATA TODO: Summary.
            %   TODO: Long explanation.

            intervalLeeway = obj.Params.intervalLeeway;
            sensorFrequencies = obj.Params.sensor_frequencies;
            processedData = obj.Data;
            % TODO: First ensure that the sensor readings are within
            % the leeway of one another. Then downsample the frequencies.
            % Use the processedData to perform these tasks.
            
            obj.Data = processedData;
        end

        function obj = filterData(obj)
            %FILTERDATA TODO: Summary.
            %   TODO: Long explanation.

            filterData = obj.Data;
            % TODO: Filter the data using a lowpass filter. Ensure it looks
            % smooth.

            obj.Data = filterData;
        end

        function graphData(obj, sensors)
            %GRAPHDATA TODO: Summary.
            %   TODO: Long explanation.

            arguments
                obj SensorData
                sensors (:,:,:) string
            end

            % TODO: Graph the data using matlab plots.

        end
    end
end

