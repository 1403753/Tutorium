classdef Config < handle
    properties
        
				N										% the dimension of the nxn input matrices (adjust in constructor)
        VERBOSE             % bool: print more output to console
        
        %filenames
        CSVFILENAME         % name of csv file
        CSVHEADER           % header of csv file
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
						obj.N           = 503;
            obj.SUBMDIR     = strcat(obj.ROOT, '\Abgaben');
            allFiles        = dir(fullfile(obj.SUBMDIR, 'a*'));
            obj.MATNRDIRS   = allFiles([allFiles.isdir]);
            obj.VERBOSE     = 0; % default
        end
    end
end