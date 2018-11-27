classdef Submission < handle
    properties
        matNr
        invit_t
        rqi_t
        rqi_k_t
				rerrl1
				rerrl2
				rerrl3
				errV1	
				errV2	
				errV3	
		end
    methods
        function obj = Submission(matNr)
            obj.matNr = matNr;
						obj.invit_t = Inf;
						obj.rqi_t = Inf;
						obj.rqi_k_t = Inf;
						obj.rerrl1 = Inf;
						obj.rerrl2 = Inf;
						obj.rerrl3 = Inf;
						obj.errV1 = Inf;
						obj.errV2 = Inf;
						obj.errV3 = Inf;
        end
    end
end