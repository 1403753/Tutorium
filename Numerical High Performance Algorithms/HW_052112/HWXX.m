%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          METHODS:          %                         description:                           %
% -------------------------- % -------------------------------------------------------------- %
%  HWXX                      %  class-constructor, creates context for the detailed homework  %
%                            %  analysis report                                               %
%  addCSV                    %  add a CSV to the CSV-file                                     %
%  checkFiles                %  check if mandatory files exist and are correctly labeled      %
%  checkInterface            %  check if interface is implemented correctly                   %
%  checkReportFile           %  check if 'report.pdf' exists in the students main folder      %
%  createSummaryCSV          %  creates the CSV-file for the exercise-analysis survey         %
%  createSummarySpecific     %  creates individual exercise analysis summaries                %
%  enterProjDir              %  cd to current project directory                               %
%  enterRootDir              %  cd to root directory                                          %
%  enterSummaryDir           %  cd to exercise-analysis summaries folder                      %
%  evalRoutines              %  evaluate routine result(s)                                    %
%  existProjDir              %  check if the current project directory exists                 %
%  genLine                   %  generate custom text-lines for detailed summaries             %
%  mergeSummaries            %  merge specific summaries into one doc file                    %
%  resetCtx                  %  clears everything from the detailed summary context           %
%  run                       %  start exercise checking/evaluation                            %
% -------------------------- % -------------------------------------------------------------- %
%    "ABSTRACT" METHODS:     %  ////////////////////////////////////////////////////////////  %
% -------------------------- % -------------------------------------------------------------- %
%  checkSpecificFiles        %  check files on current exercise                               %
%  checkSpecificInterface    %  check Interface on current exercise                           %
%  evalSpedificRoutines      %  evaluate results from current routine(s)                      %
%  loadRefImpl               %  evaluate reference implementation for result comparison       %
%                            %                                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef HWXX < handle
    
    properties (Constant)
        CONST = Config       % Static Data Object with settings/constants
    end
    
    properties
        ctx                  % context of analysis summaries
        dLine                % dotted Line (-----)
        eLine                % equal Line (=====)
        partNr               % part identifyer if homework consits of multiple parts
        projDir              % current directory for file processing (e.g. file-checking/evaluation)
        submissionNr         % indentifyer of current submisson
    end
    
    methods
        
        function obj = HWXX()
            obj.dLine = obj.genLine('-----', 14);
            obj.eLine = obj.genLine('=====', 14);
        end
        
        function addCSV(obj, string, value)
            if HWXX.CONST.VERBOSE, fprintf(1, 'addCSV\n'); end
            if ~ischar(string) && ~isstring(string)
                error('Context.addText: input must be char/string');
            end
            
            oldDir = pwd;
            obj.enterSummaryDir();
            fileID = fopen(HWXX.CONST.CSVFILENAME, 'a');
            if nargin == 2
                fprintf(fileID, string);
            elseif nargin == 3
                fprintf(fileID, string, value);
            else
                error('wrong number of input parameters');
            end
            fclose(fileID);
            cd(oldDir);
        end
        
        function r = checkFiles(obj)
            if HWXX.CONST.VERBOSE, fprintf(1, 'file check\n'); end
            obj.enterProjDir();
            obj.ctx(obj.partNr).addText('\n');
            obj.ctx(obj.partNr).addText('\n -> start file check ..\n\n');
            [r, msg] = obj.checkSpecificFiles();
            rehash; % reinitialize load path directory cache
            
            obj.ctx(obj.partNr).addText('\n -> FILE CHECK:');
            switch r
                case 0
                    csvmsg = ' .. file(s) missing .. ';
                    obj.ctx(obj.partNr).addText([csvmsg '\n\n']);
                    obj.addCSV([csvmsg msg]);
                case 1
                    obj.ctx(obj.partNr).addText(' ok\n\n');
                case 2
                    csvmsg = ' .. file(s) missing, sufficient amount of files (wrong label?) .. ';
                    obj.ctx(obj.partNr).addText([csvmsg '\n\n']);
                    obj.addCSV([csvmsg msg]);
                    r = 0;
                otherwise
                    error('unknown error-code');
            end
            obj.enterRootDir();
        end
        
        function r = checkInterface(obj)
            if HWXX.CONST.VERBOSE, fprintf(1, 'interface check\n'); end
            obj.enterProjDir();
            obj.ctx(obj.partNr).addText('\n -> start interface check ..\n\n');
            [r, msg] = obj.checkSpecificInterface();
            rehash; % reinitialize load path directory cache
            obj.ctx(obj.partNr).addText('\n -> INTERFACE CHECK:');
            csvmsg = ' .. interface failure ..';
            switch r
                case 0
                    obj.ctx(obj.partNr).addText([csvmsg '\n\n']);
                    if ~isempty(msg)
                        obj.addCSV([csvmsg msg]);
                    end
                case 1
                    obj.ctx(obj.partNr).addText(' ok\n\n');
                case 99
                    obj.ctx(obj.partNr).addText(' couldn''t test script, ''clear'' command used?');
                    obj.ctx(obj.partNr).addText([csvmsg '\n\n']);
                    if ~isempty(msg)
                        obj.addCSV([csvmsg msg]);
                    end
                    r = 0;
                otherwise
                    error('unknown error-code');
            end
            obj.enterRootDir();
        end
        
        function checkReportFile(obj)
            if HWXX.CONST.VERBOSE, fprintf(1, 'check report\n'); end
            obj.ctx(HWXX.CONST.HWTOTALPARTS + 1).addText('\n -> REPORT CHECK:');
            obj.enterProjDir();
            if exist(fullfile(obj.projDir, 'report.pdf'), 'file')
                obj.ctx(HWXX.CONST.HWTOTALPARTS + 1).addText(' ok\n');
                obj.addCSV('ok;');
            elseif ~isempty(dir('*.pdf'))
                str = ' PDF file found (mislabeled report?)';
                obj.ctx(HWXX.CONST.HWTOTALPARTS + 1).addText([str '\n']);
                obj.addCSV([str ';']);
            else
                str = ' PDF file missing';
                obj.ctx(HWXX.CONST.HWTOTALPARTS + 1).addText([str '\n']);
                obj.addCSV([str ';']);
            end
            obj.ctx(HWXX.CONST.HWTOTALPARTS + 1).addText(obj.dLine);
            obj.enterRootDir();
        end
        
        function createSummarySpecific(obj)
            if HWXX.CONST.VERBOSE, fprintf(1, 'create .txt-file\n'); end
            
            matNr = HWXX.CONST.MATNRDIRS(obj.submissionNr).name;
            
            obj.enterSummaryDir();
            fileID = fopen([matNr HWXX.CONST.SUMMARYPOSTFIX], 'w');
            
            fprintf(fileID, obj.eLine);
            fprintf(fileID, ...
                '  NR. %i                    HOMEWORK SUMMARY          MatNr: %s\n', ...
                obj.submissionNr, matNr);
            fprintf(fileID, obj.eLine);
            fprintf(fileID, [obj.ctx(HWXX.CONST.HWTOTALPARTS + 1).getText() '\n']);
            for k = 1:HWXX.CONST.HWTOTALPARTS
                fprintf(fileID, [obj.ctx(k).getText() '\n']);
            end
            fclose(fileID);
            obj.enterRootDir();
        end
        
        function createSummaryCSV(obj)
            if HWXX.CONST.VERBOSE, fprintf(1, 'create CSV-file\n'); end
            obj.enterSummaryDir();
            if exist(HWXX.CONST.CSVFILENAME, 'file')
                delete (HWXX.CONST.CSVFILENAME)
            end
            obj.addCSV('%s', HWXX.CONST.CSVHEADER);
            obj.addCSV('Total Submissions: %i;', length(HWXX.CONST.MATNRDIRS));
            obj.enterRootDir();
        end
        
        function enterProjDir(obj)
            if ~exist(obj.projDir, 'dir')
                error('project directory not available');
            end
            cd(obj.projDir);
            if HWXX.CONST.VERBOSE, fprintf(1, ' cd projDir %s\n', obj.projDir); end
        end
        
        function evalRoutines(obj)
            if HWXX.CONST.VERBOSE, fprintf(1, 'evaluate routine(s)\n'); end
            obj.enterProjDir();
            obj.ctx(obj.partNr).addText('\n -> start routine evaluation ..\n\n');
            [r, msg] = obj.evalSpecificRoutines();
            obj.ctx(obj.partNr).addText('\n -> ROUTINE EVALUATION: ');
            rehash; % reinitialize load path directory cache
            switch r
                case 0
                    csvmsg = ' .. evaluation failure ..';
                    obj.ctx(obj.partNr).addText([csvmsg '\n\n']);
                    if ~isempty(msg)
                        obj.addCSV([csvmsg msg ';']);
                    else
                        obj.addCSV(';');
                    end
                case 1
                    csvmsg = 'ok';
                    obj.ctx(obj.partNr).addText([csvmsg '\n\n']);
                    obj.addCSV([csvmsg ';']);
                otherwise
                    error('unknown error-code');
            end
            obj.enterRootDir();
        end
        
        function r = genLine(~, pattern, n)
            r = blanks(length(pattern)*n);
            for i = 1:n
                r((i-1)*length(pattern)+1:(i)*length(pattern)) = pattern(:);
            end
            r = [r '\n'];
        end
        
        function mergeSummaries(obj)
            obj.enterSummaryDir();
            if exist(HWXX.CONST.SUMMARYDOC, 'file')
                delete (HWXX.CONST.SUMMARYDOC)
            end
            fout = fopen(HWXX.CONST.SUMMARYDOC, 'a');
            
            fprintf(fout, '\n');
            str = obj.genLine('*-**-', 5);
            fprintf(fout, str);
            fprintf(fout, '  TOTAL SUBMISSIONS: %i\n', length(HWXX.CONST.MATNRDIRS));
            fprintf(fout, str);
            fprintf(fout, '\n');
            
            S = dir(['a*' HWXX.CONST.SUMMARYPOSTFIX]);
            
            fnm = natsort({S.name});
            for k = 1:numel(fnm)
                fid = fopen(fnm{k},'rt');
                
                while ~feof(fid)
                    fprintf(fout,'%s\n',fgetl(fid));
                end
                
                fclose(fid);
            end
            fclose(fout);
            
            obj.enterRootDir()
        end
        
        function resetCtx(obj)
            
            if HWXX.CONST.VERBOSE, fprintf(1, 'reset Context\n'); end
            for i = 1:HWXX.CONST.HWTOTALPARTS + 1
                obj.ctx(i) = SummaryCtx();
            end
        end
        
        function run(obj)
            obj.ctx(obj.partNr).addText([HWXX.CONST.HWPARTNAME '%i:\n'], obj.partNr);
            obj.checkFiles();
            obj.checkInterface();
            obj.evalRoutines();
        end
        
    end
    
    methods (Abstract) %-> not implemented in Octave
        %[r, msg] = checkSpecificFiles(obj);
        %[r, msg] = checkSpecificInterface(obj);
        %loadRefImpl(obj);
        %[r, msg] = evalSpecificRoutines(obj);
        %revalidateRoutineStates(obj);
    end
    
    methods (Static = true)
        function enterRootDir()
            if ~exist(HWXX.CONST.ROOT, 'dir')
                error('root not set');
            end
            cd(HWXX.CONST.ROOT);
            if HWXX.CONST.VERBOSE, fprintf(1, ' cd ROOT\n'); end
        end
        
        function enterSummaryDir()
            if ~exist(HWXX.CONST.SUMMARYDIR, 'dir')
                mkdir(HWXX.CONST.SUMMARYDIR);
            end
            cd(HWXX.CONST.SUMMARYDIR);
            if HWXX.CONST.VERBOSE, fprintf(1, ' cd SUMMARYDIR %s\n', HWXX.CONST.SUMMARYDIR); end
        end
    end
    
end