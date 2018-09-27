%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      METHODS:     %                  description:                   %
% ----------------- % ----------------------------------------------- %
%  Context          %  class-constructor                              %
%  addText          %                                                 %
%  clearText        %                                                 %
%  setText          %                                                 %
%                   %                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef SummaryCtx < handle
    properties (Access = private)
        text
    end
    
    methods
        
        function obj = SummaryCtx()
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
        
        function addErrMsg(obj, ME)
            msg = strrep(ME.message, '\', '/');
            obj.addText(  ' o~~~~~~~~~~~~~ start err msg ~~~~~~~~~~~~~o\n %s', msg);
            obj.addText('\n o~~~~~~~~~~~~~~ end err msg ~~~~~~~~~~~~~~o\n\n');
        end
        
        function r = getText(obj)
            r = obj.text;
        end
        
    end
end