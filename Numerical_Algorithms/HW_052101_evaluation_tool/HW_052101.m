%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     HW_052101                      %
%                                                    %
%  Ideally, only the desired hw-object               %
%  (i.e. HW01, HW02, etc.) at the beginning must     %
%  be set.                                           %
%                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%
%  Initialization  %
%%%%%%%%%%%%%%%%%%%%

% add root to search path
rootdir = pwd;
addpath(rootdir);

% adjust HW-object
hwdir = '\@HW01';
addpath([rootdir hwdir]);
hw = HW01();

% get constants
const = hw.CONST;

% disable figure display
set(0,'DefaultFigureVisible','off');

% compute and store results from reference implementation
hw.loadRefImpl();

% create CSV file
hw.createCSV();

%%%%%%%%%%%%%%%%
%  Evaluation  %
%%%%%%%%%%%%%%%%

for submissionNr=1:length(const.MATNRDIRS)
    
    % set student project path
    hw.projDir = fullfile(const.SUBMDIR, ...
        const.MATNRDIRS(submissionNr).name);
    
    hw.submissionNr = submissionNr;
    
    % set all routine states true
    hw.revalidateRoutineStates();
    
    hw.run();
end

rmpath(rootdir);
rmpath([rootdir hwdir]);

clear ans const hw partNr j submissionNr hwdir rootdir functions;
