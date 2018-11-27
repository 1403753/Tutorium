classdef Config < handle
    properties
        
        HWTOTALPARTS        % total amount of homework parts per student
        VERBOSE             % bool: print more output to console
        TESTSCRIPTS         % bool: test scripts as well
        
        %filenames
        CSVFILENAME         % name of csv file
        CSVHEADER           % header of csv file
        SUMMARYPOSTFIX      % postfix of specific exercise analysis report
        SUMMARYDOC          % name of merged summary document
        HWPARTNAME          % prefix of homework part name
        INPUTFNAME          % test input file name
        
        %directories
        ROOT                % path to root directory
        SUBMDIR             % path to student submissions
        MATNRDIRS           % array with student submission directories
        SUMMARYDIR		      % path to summaries directory
        INPUTDIR            % path to test input files
        REFIMPLDIR          % path to reference implementation
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  submission location:  <ROOT>/<SUBMDIR>/<MATNRDIRS>/*  %
    %  summary location:     <ROOT>/<SUMMARYDIR>/*           %
    %  test input location:  <ROOT>/<@HW*>/<INPUTDIR>/*      %
    %  ref. impl. location:  <ROOT>/<@HW*>/<REFIMPLDIR>/*    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    methods
        function obj = Config()
            if ~exist('obj.ROOT', 'dir')
                obj.ROOT = pwd;
            end
            obj.SUBMDIR     = strcat(obj.ROOT, '\Abgaben');
            allFiles        = dir(fullfile(obj.SUBMDIR, "a*"));
            obj.MATNRDIRS   = allFiles([allFiles.isdir]);
            obj.TESTSCRIPTS = 0; % default, not working a.t.m.
            obj.VERBOSE     = 0; % default
        end
    end
end