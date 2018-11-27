%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          METHODS:          %                         description:                         %
% -------------------------- % ------------------------------------------------------------ %
%  HW02                      %  class-constructor                                           %
%  checkSpecificFiles        %                                                              %
%  checkSpecificInterface    %                                                              %
%  evalSpecificRoutines      %                                                              %
%  loadTestInput             %                                                              %
%  revalidateRoutineStates   %                                                              %
%  mergeSummaries            %                                                              %
% -------------------------- % ------------------------------------------------------------ %
%       EXT. METHODS:        %  //////////////////////////////////////////////////////////  %
% -------------------------- % ------------------------------------------------------------ %
%  loadRefImpl               %  evaluate reference implementation for result comparison     %
%  checkFilesPart *          %                                                              %
%  checkInterfacePart *      %                                                              %
%  evalRoutinesPart *        %                                                              %
%.                           .                                                              .
%.                           .                                                              .
%.                           .                                                              .
%                            %                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef HW02 < HWXX & handle
    properties
		
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %  reference implementation values  %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
				
				T 
				Ti 
				D
        submission    % student submission object
				
				% input
        n 
        A             
				x0
				sigma
				eps
				maxit
				l
        k
				
				% output
				lambda
				V
				it
				erreval
				errres
        
        % comparsion values
        rerrlambda
        errV

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %  routine states (1 == ok, 0 == error)  %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
				invit
				rqi
				rqi_k
    end
    
    methods
        % Constructor
        function obj = HW02()
            obj@HWXX;
            hwxx = HWXX.CONST;
            % set hw specific parameters
            hwxx.CSVFILENAME    = 'HW02_SUMMARY.csv';
            hwxx.CSVHEADER      = 'MatNr.;report;part 1;runtime;';
            hwxx.SUMMARYPOSTFIX = '_Summary.txt';
            hwxx.SUMMARYDOC     = 'HW02_SUMMARY.doc';
            hwxx.INPUTFNAME     = 'Ttest.txt';
            
            hwxx.HWPARTNAME     = 'part ';
            hwxx.HWTOTALPARTS   = 1;
            hwxx.SUMMARYDIR     = [hwxx.ROOT '\HW02_SUMMARY'];
            hwxx.REFIMPLDIR     = [hwxx.ROOT '\@HW02\refImpl'];
            hwxx.INPUTDIR       = [hwxx.ROOT '\@HW02\input'];
            
            % create context objects for analysis summaries on hw1_[x], x = 1, 2, ... , HWTOTALPARTS;
            % ctx = SummaryCtx.empty(hwxx.HWTOTALPARTS + 1, 0); % -> object preallocation not implemented in Octave
            for i = 1:hwxx.HWTOTALPARTS + 1
                ctx(i) = SummaryCtx();
            end
            
            obj.ctx = ctx;
            
            % submission = Submission.empty(length(hwxx.MATNRDIRS), 0); % -> object preallocation not implemented in Octave
            for i = 1:length(hwxx.MATNRDIRS)
                submission(i) = Submission(hwxx.MATNRDIRS(i).name);
            end
            
            obj.submission = submission;
            
        end
        
        loadRefImpl(obj); % external
        
        function [r, msg] = checkSpecificFiles(obj)
            funName = ['checkFilesPart' int2str(obj.partNr)];
            [r, msg] = feval(funName, obj); % external
            
        end
        
        function [r, msg] = checkSpecificInterface(obj)
            funName = ['checkInterfacePart' int2str(obj.partNr)];
            [r, msg] = feval(funName, obj); % external
        end
        
        function [r, msg] = evalSpecificRoutines(obj)
            funName = ['evalRoutinesPart' int2str(obj.partNr)];
            [r, msg] = feval(funName, obj); % external
        end
        
				function obj = loadTestInput(obj, fName)				
            obj.T = dlmread(fullfile(strcat(HWXX.CONST.INPUTDIR), strcat(fName)));
            obj.n = size(obj.T, 1);
        end
        
        function mergeSummaries(obj)
            mergeSummaries@HWXX(obj);
            obj.enterSummaryDir();
            [~, idx] = sort([obj.submission.rqi_t]);
            fileID = fopen('RANKINGS.csv', 'w');
            fprintf(fileID, 'Nr.;MatNr.;invit time (sec.);rqi time (sec.);rqi_k time (sec.);rel. err. eval (invit);rel. err. eval (rqi);rel. err. eval (rqi_k); abs. err. evec (invit); abs. err. evec (rqi); abs. err. evec (rqi_k);n == %i\n', obj.n);
            for i = 1:length(idx)
                fprintf(fileID, '%i;%s;%f;%f;%f;%1.0e;%1.0e;%1.0e;%1.0e;%1.0e;%1.0e;\n', ...
										i, ...
                    obj.submission(idx(i)).matNr, ...
                    obj.submission(idx(i)).invit_t, ...
                    obj.submission(idx(i)).rqi_t, ...
                    obj.submission(idx(i)).rqi_k_t, ...
										obj.submission(idx(i)).rerrl1, ...
										obj.submission(idx(i)).rerrl2, ...
										obj.submission(idx(i)).rerrl3, ...
										obj.submission(idx(i)).errV1, ...
										obj.submission(idx(i)).errV2, ...
										obj.submission(idx(i)).errV3);
            end
            fclose(fileID);
            obj.enterRootDir();
        end
				
        function revalidateRoutineStates(obj)
            obj.invit = 1;
            obj.rqi = 1;
            obj.rqi_k = 1;
        end
				
    end
    
end