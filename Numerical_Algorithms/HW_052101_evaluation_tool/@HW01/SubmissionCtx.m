%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      METHODS:     %                  description:                   %
% ----------------- % ----------------------------------------------- %
%  Context          %  class-constructor                              %
%  addText          %                                                 %
%  clearText        %                                                 %
%  setText          %                                                 %
%                   %                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef SubmissionCtx < handle
    properties (Access = private)
        text
    end
    
    methods
        
        function obj = SubmissionCtx()
            obj.text = '';
        end
        
        function addText(obj, string, varargin)
            if ~ischar(string) && ~isstring(string)
                error('Context.addText: input must be char/string');
            end
            if nargin == 2
                obj.text = [obj.text string];
            elseif nargin > 2
                obj.text = [obj.text sprintf(string, varargin{:})];
            end
        end
        
        function addErrMsg(obj, err)
            msg = strrep(err.message, '\', '/');
						msg = strrep(msg, ';', ',');
            obj.addText("ERRMSG: \"%s\".  ", msg);
        end
        
        function r = getText(obj)
            r = obj.text;
        end
        
    end
end