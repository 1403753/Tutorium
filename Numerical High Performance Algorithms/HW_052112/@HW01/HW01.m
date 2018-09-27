%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          METHODS:          %                         description:                         %
% -------------------------- % ------------------------------------------------------------ %
%  HW01                      %  class-constructor                                           %
%  checkSpecificFiles        %                                                              %
%  checkSpecificInterface    %                                                              %
%  evalSpecificRoutines      %                                                              %
%  loadTestInput             %                                                              %
%  revalidateRoutineStates   %                                                              %
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

classdef HW01 < HWXX & handle
    properties
		
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %  reference implementation values  %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
				
        A          % plu.m, input
        n          % plu.m, input
        X          % accuracy.m input
        plu_r      % result reference
        submission % student submission object

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %  routine states (1 == ok, 0 == error)  %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        plu
				pluStats
    end
    
    methods
        % Constructor
        function obj = HW01()
            obj@HWXX;
            hwxx = HWXX.CONST;
            % set hw specific parameters
            hwxx.CSVFILENAME    = 'HW01_SUMMARY.csv';
            hwxx.CSVHEADER      = 'MatNr.;part 1;runtime;';
            hwxx.SUMMARYPOSTFIX = '_Summary.txt';
            hwxx.SUMMARYDOC     = 'HW01_SUMMARY.doc';
            % hwxx.INPUTFNAME    = '100x100_real.txt';
            % hwxx.INPUTFNAME    = '4x4_int.txt';
            hwxx.INPUTFNAME    = '1000x1000_real.txt';
            
            hwxx.HWPARTNAME     = 'part ';
            hwxx.HWTOTALPARTS   = 1;
            hwxx.SUMMARYDIR     = [hwxx.ROOT '\HW01_SUMMARY'];
            hwxx.REFIMPLDIR     = [hwxx.ROOT '\@HW01\refImpl'];
            hwxx.INPUTDIR       = [hwxx.ROOT '\@HW01\input'];
            
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
            obj.A = importdata([HWXX.CONST.INPUTDIR '\' fName]);
            obj.n = size(obj.A, 1);
        end
        
        function mergeSummaries(obj)
            mergeSummaries@HWXX(obj);
            obj.enterSummaryDir();
            [~, idx] = sort([obj.submission.runtime]);
            fileID = fopen('RANKINGS.csv', 'w');
            fprintf(fileID, 'Nr.;MatNr.;Runtime (sec.);n == %i;\n', obj.n);
            for i = 1:length(idx)
                fprintf(fileID, '%i;%s;%f;\n', i,...
                    obj.submission(idx(i)).matNr, ...
                    obj.submission(idx(i)).runtime);
            end
            fclose(fileID);
            obj.enterRootDir();
        end
				
        function revalidateRoutineStates(obj)
            obj.plu = 1;
            obj.pluStats = 1;
        end
				
    end
    
end