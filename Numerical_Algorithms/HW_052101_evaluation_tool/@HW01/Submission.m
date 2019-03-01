classdef Submission < handle
    properties
        matNr
				R
				rn_L
				foe_L
				rn_U
        foe_U
				rn_linSol
				foe_linSol
				ctx;
    end
    methods
        function obj = Submission(matNr)
            obj.matNr = matNr;
						obj.ctx = SubmissionCtx();
						obj.R = Inf;
						obj.rn_L = Inf;
						obj.foe_L = Inf;
            obj.rn_U = Inf;
						obj.foe_U = Inf;
						obj.rn_linSol = Inf;
						obj.foe_linSol = Inf;
        end
    end
end