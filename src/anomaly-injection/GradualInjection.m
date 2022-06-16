classdef GradualInjection < AnomalyInjection

    properties 
        Type = 0;
        Coef1 = 0;
        Coef2 = 0;
        step_time = 0;
        Time = 0;
    end
    
    methods 
        function obj = GradualInjection(type, coef1, coef2, freq, time)
            obj.Type = type;
            obj.Coef1 = coef1;
            obj.Coef2 = coef2;
            obj.step_time = 1/freq;
            obj.Time = time;
        end

        function outputData = injection(obj, prev)
                if obj.Type == 1
                    outputData = prev + obj.Coef1 * obj.step_time;
                elseif obj.Type == 2
                     outputData = prev + obj.Coef1 * obj.step_time^2 + 2 * obj.Coef1 * obj.step_time * (obj.Time - obj.step_time) + obj.Coef2 * obj.step_time; 
                else
                     outputData = prev + obj.Coef1 * log(obj.Time / (obj.Time - obj.step_time));
                end
        end

    end
end


