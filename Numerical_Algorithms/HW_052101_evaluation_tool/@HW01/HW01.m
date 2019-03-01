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

classdef HW01 < handle
    properties (Constant)
        CONST = Config       % Static Data Object with settings/constants
    end

    properties
		
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %  reference implementation values  %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
				
        A             % plu.m, input
        n             % plu.m, input
        R             % reference residual plu.m PART1
        rn_L          % relative residual of solveL.m, accuracy.m output
        foe_L         % relative forward error of solveL.m, accuracy.m, output
        rn_U          % relative residual of solveU.m, accuracy.m output
        foe_U         % relative forward error of solveU.m, accuracy.m, output
        rn_linSol     % relative residual of linSolve, accuracy.m output
        foe_linSol    % relative forward error of linSolve, accuracy.m, output
        submission    % student submission object
        projDir
        submissionNr

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %  routine states (1 == ok, 0 == error)  %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        plu
				accuracy
        solveL
        solveU
				linSolve
				assignment1   % script
		end
    
    methods
        % Constructor
        function obj = HW01()
            hwxx = obj.CONST;
            % set hw specific parameters
						hwxx.SUBMDIR        = [hwxx.SUBMDIR '_HW01'];
						allFiles            = dir(fullfile(hwxx.SUBMDIR, 'a*'));
            hwxx.MATNRDIRS       = allFiles([allFiles.isdir]);
            hwxx.CSVFILENAME    = 'HW01_SUMMARY.csv';
            hwxx.CSVHEADER      = 'Nr.;MatNr. / Last Name;Notes;PART I;R;reference;PART II;rel. res. L;reference;forw. err. L;reference;rel. res. U;reference;forw. err. U;reference;PART III;rel. res.;reference;forw. err.;reference;n == %i\n';
            % hwxx.INPUTFNAME     = '100x100_real.txt';
            % hwxx.INPUTFNAME    = '4x4_int.txt';
            
            % hwxx.SUMMARYDIR     = [hwxx.ROOT '\HW01_SUMMARY'];
            hwxx.SUMMARYDIR     = hwxx.ROOT;
            hwxx.REFIMPLDIR     = [hwxx.ROOT '\@HW01\refImpl'];
            hwxx.INPUTDIR       = [hwxx.ROOT '\@HW01\input'];
            
            % submission = Submission.empty(length(hwxx.MATNRDIRS), 0); % -> object preallocation not implemented in Octave
            for i = 1:length(hwxx.MATNRDIRS)
                submission(i) = Submission(hwxx.MATNRDIRS(i).name);
            end

            obj.submission = submission;
            
        end
        
				function checkReportFile(obj)
            if obj.CONST.VERBOSE, fprintf(1, 'check report\n'); end
            obj.enterProjDir();
            if (~isempty(dir('*.pdf')) && ~exist(fullfile(obj.projDir, 'report.pdf'), 'file'))
								obj.submission(obj.submissionNr).ctx.addText("PDF file found (mislabeled report?).  ");
            elseif ~exist(fullfile(obj.projDir, 'report.pdf'), 'file')
								obj.submission(obj.submissionNr).ctx.addText("PDF file missing.  ");
            end
            obj.enterRootDir();
        end
				
				
        loadRefImpl(obj); % external
        
        function run(obj)
						obj.checkReportFile();
            obj.enterProjDir();
            feval('checkFiles', obj); % external
            obj.enterRootDir();
            obj.enterProjDir();
						feval('checkInterface', obj); % external
            obj.enterRootDir();
            obj.enterProjDir();
            feval('evalRoutines', obj); % external
            obj.enterRootDir();
            obj.addToCSV();
						rehash;
        end

        function obj = loadTestInput(obj, fName)
            obj.A = importdata([obj.CONST.INPUTDIR '\' fName]);
            obj.n = size(obj.A, 1);
        end
        
        function createCSV(obj)
            obj.enterSummaryDir();
            fileID = fopen(obj.CONST.CSVFILENAME, 'w');
            fprintf(fileID, obj.CONST.CSVHEADER, obj.n);
            fclose(fileID);
            obj.enterRootDir();
        end
        
        function addToCSV(obj)
            obj.enterSummaryDir();
            fileID = fopen(obj.CONST.CSVFILENAME, 'a');            
            fprintf(fileID, '%i;%s;%s; ;%1.0e;%1.0e; ;%1.0e;%1.0e;%1.0e;%1.0e;%1.0e;%1.0e;%1.0e;%1.0e; ;%1.0e;%1.0e;%1.0e;%1.0e\n', ...
						    obj.submissionNr, ...
                obj.submission(obj.submissionNr).matNr, ...
								obj.submission(obj.submissionNr).ctx.getText(), ...
                obj.submission(obj.submissionNr).R, ...
								obj.R, ...
								obj.submission(obj.submissionNr).rn_L, ...
								obj.rn_L, ...
                obj.submission(obj.submissionNr).foe_L, ...
								obj.foe_L, ...
								obj.submission(obj.submissionNr).rn_U, ...
								obj.rn_U, ...
                obj.submission(obj.submissionNr).foe_U, ...
								obj.foe_U, ...                    
								obj.submission(obj.submissionNr).rn_linSol, ...
								obj.rn_linSol, ...
                obj.submission(obj.submissionNr).foe_linSol, ...
								obj.foe_linSol);
            fclose(fileID);
            obj.enterRootDir();
        end
				
        function revalidateRoutineStates(obj)
            obj.plu = 1;
            obj.accuracy = 1;
            obj.solveL = 1;
            obj.solveU = 1;
            obj.linSolve = 1;
						obj.assignment1 = 1;
        end
		
				function enterProjDir(obj)
            if ~exist(obj.projDir, 'dir')
                error('project directory not available');
            end
            cd(obj.projDir);
            if obj.CONST.VERBOSE, fprintf(1, ' cd projDir %s\n', obj.projDir); end
        end
    end
		
		methods (Static = true)
        function enterRootDir()
            if ~exist(HW01.CONST.ROOT, 'dir')
                error('root not set');
            end
            cd(HW01.CONST.ROOT);
            if HW01.CONST.VERBOSE, fprintf(1, ' cd ROOT\n'); end
        end
        
        function enterSummaryDir()
            if ~exist(HW01.CONST.SUMMARYDIR, 'dir')
                mkdir(HW01.CONST.SUMMARYDIR);
            end
            cd(HW01.CONST.SUMMARYDIR);
            if HW01.CONST.VERBOSE, fprintf(1, ' cd SUMMARYDIR %s\n', HW01.CONST.SUMMARYDIR); end
        end
    end
    
end