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
        
        A          % plu.m, linSolve.m, accuracy.m input
        n          % plu.m, linSolve.m, accuracy.m solveL/U.m input
        B          % solveL/U.m input
        L          % input for norm computation
        U          % input for norm computation
        X          % accuracy.m input
        plu_r      % result reference
        tx         % 'true x' accuracy.m input
        solveL_b   % solveL.m input
        solveL_x   % accuracy.m input
        solveL_r   % result reference
        solveL_f   % result reference
        
        solveU_b   % solveU.m input
        solveU_r   % result reference
        solveU_f   % result reference
        
        linSolve_b % linSolve.m input
        
        linSolve_r % result reference
        linSolve_f % result reference
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %  routine states (1 == ok, 0 == error)  %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        plu
        accuracy
        solveL
        solveU
        linSolve
    end
    
    methods
        % Constructor
        function obj = HW01()
            obj@HWXX;
            hwxx = HWXX.CONST;
            % set hw specific parameters
            hwxx.CSVFILENAME    = 'HW01_SUMMARY.csv';
            hwxx.CSVHEADER      = 'MatNr.;report;part 1;part 2;part 3;';
            hwxx.SUMMARYPOSTFIX = '_Summary.txt';
            hwxx.SUMMARYDOC     = 'HW01_SUMMARY.doc';
            hwxx.INPUTFNAME     = '100x100_real.txt';
            % hwxx.INPUTFNAME    = '4x4_int.txt';
            % hwxx.INPUTFNAME    = '1000x1000_real.txt';
            
            hwxx.HWPARTNAME     = 'part ';
            hwxx.HWTOTALPARTS   = 3;
            hwxx.SUMMARYDIR     = [hwxx.ROOT '\HW01_SUMMARY'];
            hwxx.REFIMPLDIR     = [hwxx.ROOT '\@HW01\refImpl'];
            hwxx.INPUTDIR       = [hwxx.ROOT '\@HW01\input'];
            
            % create context objects for analysis summaries on hw1_[x], x = 1, 2, ... , HWTOTALPARTS;
            % ctx = SummaryCtx.empty(hwxx.HWTOTALPARTS + 1, 0); % -> object preallocation not implemented in Octave
            for i = 1:hwxx.HWTOTALPARTS + 1
                ctx(i) = SummaryCtx();
            end
            
            obj.ctx = ctx;
            
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
        
        function loadTestInput(obj, fName)
            obj.A = importdata([HWXX.CONST.INPUTDIR '\' fName]);
            obj.n = size(obj.A, 1);
        end
        
        function revalidateRoutineStates(obj)
            obj.plu = 1;
            obj.accuracy = 1;
            obj.solveL = 1;
            obj.solveU = 1;
            obj.linSolve = 1;
        end
        
    end
    
end