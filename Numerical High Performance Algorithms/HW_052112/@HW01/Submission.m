classdef Submission < handle
    properties
        matNr
        observed_t
				t
				rn
				foe
				fae
				observed_ut
        ut
				urn
				ufoe
				ufae
    end
    methods
        function obj = Submission(matNr)
            obj.matNr = matNr;
						obj.observed_t = Inf;
            obj.t = Inf;
						obj.rn = Inf;
						obj.foe = Inf;
						obj.fae = Inf;
						obj.observed_ut = Inf;
            obj.ut = Inf;
						obj.urn = Inf;
						obj.ufoe = Inf;
						obj.ufae = Inf;
        end
    end
end