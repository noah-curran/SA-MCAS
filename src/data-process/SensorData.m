classdef SensorData
    %SENSORDATA Stores location of sensor data and processes it.
    %   This class takes the file path to sensor data and then separately
    %   can load this data in locally. This data can then be processed for
    %   used, filtered, and graphed. The data proccessing done in this
    %   class will be used to output the data to be used by a source block
    %   in Simulink. See this documentation page for information about how
    %   the Data will be used:
    %   https://www.mathworks.com/help/simulink/slref/fromworkspace.html
    %
    %   THE FILTERING IN THIS CLASS IS FOR INFORMATIONAL USE ONLY AND IS
    %   NOT TO BE USED IN EXPERIMENTS. THE FILTERING FOR EXPERIMENTS SHOULD
    %   HAPPEN DURING SIMULINK OPERATION AS ITS OWN BLOCK SUCH AS THIS:
    %   https://www.mathworks.com/help/dsp/ref/lowpassfilter.html
    
    properties
        DataPath {mustBeFile} = "./SensorData.m"
        ParamsPath {mustBeFile} = "./SensorData.m"
        Data = 0
        Params = 0
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
            %PROCESSDATA The data that is imported is processed all at once.
            %   The data will all be processed to downsample any
            %   oversampling of data that is not accurate to the typical
            %   sampling of a sensor. Downsampling will not remove entries,
            %   it will simply turn oversampled entries into those of the
            %   value at the correct sampling rate.
            % 
            %   MAYBE:
            %   The data is also ensured to be sampled during a consistent
            %   rate that is within the percentage set by the parameters.

            if obj.Data == 0
                ME = MException("SensorData:processData", ...
                    "Data has not been loaded and cannot be processed.");
                throw(ME)
            end

            intervalLeeway = obj.Params.intervalLeeway;
            sensorFrequencies = obj.Params.sensor_frequencies;
            processedData = obj.Data;
            % TODO: First ensure that the sensor readings are within
            % the leeway of one another. (This feature is not necessarily
            % the most important, so do this last.)
            
            % TODO: Then downsample the frequencies.
            % Use the processedData to perform these tasks.
            
            obj.Data = processedData;
        end

        function obj = filterData(obj, order)
            %FILTERDATA The data that is imported is filtered all at once.
            %   The data will all be filtered by a lowpass filter
            %   using butterworth. The parameter "order" will be passed
            %   into the butterworth filter. NOTE THAT THIS FUNCTION IS
            %   JUST TO CHECK THE FILTER LOOKS GOOD AND WILL NOT BE USED IN
            %   EXPERIMENTS.

            if obj.Data == 0
                ME = MException("SensorData:filterData", ...
                    "Data has not been loaded and cannot be filtered.");
                throw(ME)
            end

            filterData = obj.Data;
            % TODO: Filter the data using a lowpass filter. Ensure it looks
            % smooth.

            obj.Data = filterData;
        end

        function graphData(obj, sensors)
            %GRAPHDATA Graph the given sensor data names.
            %   The given sensors should be provided in the format of an
            %   array such as
            %   
            %       [["sensor1", "sensor2", ...], ... ["sensorn"]]
            %
            %   where the sensors in the same bracket group are overlayed
            %   on one another within the same graph and the sensors in
            %   separate bracket groups appear vertically stacked with the
            %   first group at the top. This method is used as a helper for
            %   verifying the other methods implemented in this class are
            %   correct.

            arguments
                obj SensorData
                sensors (:,:,:) string
            end

            if obj.Data == 0
                ME = MException("SensorData:graphData", ...
                    "Data has not been loaded and cannot be graphed.");
                throw(ME)
            end

            % TODO: Graph the data using matlab plots as described in the
            % description of this method.

        end
    end
end

