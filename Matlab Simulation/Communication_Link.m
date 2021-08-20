classdef Communication_Link < handle
    properties (Access = private)
        %% Communication
        nAgent
        AgentReportList
        VoronoiReportsList
        
        %% Voronooi handler, which handles any computation related to Voronoi properties
        VoronoiProcessor
    end
    
    methods
        function obj = Communication_Link(nAgents, regionConfig)
            obj.nAgent = nAgents;
            
            obj.AgentReportList = Agent_Coordinates_Report.empty(nAgents, 0);
            obj.VoronoiReportsList = Agent_Voronoi_Report.empty(nAgents, 0);
            for i = 1: nAgents
                obj.AgentReportList(i) = Agent_Coordinates_Report(i);
                obj.VoronoiReportsList(i) = Agent_Voronoi_Report(i);
            end
            
            obj.VoronoiProcessor = Voronoi2D_Handler(nAgents);
            obj.VoronoiProcessor.setup(regionConfig);
        end
                
        %% Upload the report structure
        function isValid = upload(obj, reportCoordinates)
            isValid = isa(reportCoordinates, 'Agent_Coordinates_Report');
            assert(isValid);

            thisID = reportCoordinates.getID();
            obj.AgentReportList(thisID) = reportCoordinates;
        end
        
        %% Download the report structure
        function out = download(obj, agentID)
            out = obj.VoronoiReportsList(agentID);
        end
        
        function loop(obj)
            % Compute the CVT according to the actual agents' coord
            % Split them into neighbors and some values
            % ...
            vmCmoord_2d_list = [30,20;23,22;46,94]; %zeros(nAgents, 2);
            ret = obj.VoronoiProcessor.exec_partition(vmCmoord_2d_list);
            
            for i = 1: nAgents
               obj.VoronoiReportsList(agentID).assign() 
            end
        end
    end
end

