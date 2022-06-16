clc; clear all;

fid = fopen("anomaly-injection/Injection.json");
rawJson = fread(fid, inf);
strJson = char(rawJson');
fclose(fid);
Params = jsondecode(strJson).Injection;

% Simulink.Bus.createObject(Params);


%% Todo: convert the injection information to linked list 

% sort the Params
T = struct2table(Params);
sortedT = sortrows(T, 'StartTime');
sortedParams = table2struct(sortedT);

% % % store Params in a linked list
% temp = Params(1);
% node = Node(temp.InjectionType, temp.StartTime, temp.EndTime, temp.Val, temp.Type, temp.Coef1, temp.Coef2, temp.Freq);
% list = LinkedList(node);
% 
% for i = 2 : length(Params)
%     temp = Params(i);
%     node = Node(temp.InjectionType, temp.StartTime, temp.EndTime, temp.Val, temp.Type, temp.Coef1, temp.Coef2, temp.Freq);
%     addNode(list, node);
% end

% A = sortedParams(1);
Simulink.Bus.createObject(sortedParams);






