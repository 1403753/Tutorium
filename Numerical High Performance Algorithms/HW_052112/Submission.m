classdef Submission < handle
    properties
        matNr
        runtime
    end
    methods
        function obj = Submission(matNr)
            obj.matNr = matNr;
            obj.runtime = Inf;
        end
    end
end