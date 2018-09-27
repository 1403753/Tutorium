function [r, msg] = checkFilesPart3(obj)
    r = 1;
    msg = '';
    
    if ~exist(fullfile(obj.projDir, 'part3.m'), 'file')
        str = ' ''part3.m''';
        obj.ctx(obj.partNr).addText(strcat('    !', str, ' missing\n')); r = 0;
        msg = [msg ' (''part3.m'') '];
    end
    if ~exist(fullfile(obj.projDir, 'linSolve.m'), 'file')
        str = ' ''linSolve.m''';
        obj.ctx(obj.partNr).addText(strcat('    !', str, ' missing\n')); r = 0; obj.linSolve = 0;
        msg = [msg str];
    end
    
    if ~r
        if ~isempty(dir('*.m')) && length(dir('*.m')) > 7
            r = 2;
        end
    end
end