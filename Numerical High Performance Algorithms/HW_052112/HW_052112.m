%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     HW_052112                      %
%                                                    %
%  This script provides homework-testing and         %
%  creates                                           %
%    o) a general summary CSV file of all submitted  %
%       homeworks                                    %
%    o) specific, detailed analysis reports          %
%    o) a merged document of all detailed analysis   %
%       reports                                      %
%  Ideally, only the desired handler-object          %
%  (i.e. HW01, HW02, etc.) at the beginning must     %
%  be set.                                           %
%                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%
%  Initialization  %
%%%%%%%%%%%%%%%%%%%%

% add root to search path
addpath(pwd);

% manually set HW-path and HW-object
addpath([pwd '\@HW02']);
handler = HW02();


% get constants
const = handler.CONST;

% disable figure display
set(0,'DefaultFigureVisible','off');

% verbose-output
const.VERBOSE = 1;

% test scripts as well
% const.TESTSCRIPTS = 0; % not working a.t.m.

% compute and store results from reference implementation
handler.loadRefImpl();

% create CSV file
handler.createSummaryCSV();

%%%%%%%%%%%%%
%  Testing  %
%%%%%%%%%%%%%

for submissionNr=1:length(const.MATNRDIRS)
    % set student project path
    handler.projDir = fullfile(const.SUBMDIR, ...
        const.MATNRDIRS(submissionNr).name);
    % add student-MatNr(submissionNr) to CSV file
    handler.addCSV('\n%s;', const.MATNRDIRS(submissionNr).name);
    
    handler.submissionNr = submissionNr;
    
    handler.checkReportFile();
    
    % set all routine states true
    handler.revalidateRoutineStates();
		
    for partNr=1:const.HWTOTALPARTS
        handler.partNr = partNr;
        handler.run();
    end
    
    %%%%%%%%%%%%%%%%%%%%
    %  Create Summary  %
    %%%%%%%%%%%%%%%%%%%%
    
    handler.createSummarySpecific();
    
    handler.resetCtx();
end

% merge all summaries into one doc file
handler.mergeSummaries();

clear ans const handler partNr j submissionNr;