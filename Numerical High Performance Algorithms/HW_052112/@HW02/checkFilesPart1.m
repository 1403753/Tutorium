function [r, msg] = checkFilesPart1(obj)
    r = 1;
    msg = '';
    if ~exist(fullfile(obj.projDir, 'assignment2.m'), 'file')
        str = ' ''assignment2.m''';
        obj.ctx(obj.partNr).addText(strcat('    !', str, ' missing\n')); r = 0;
        msg = [msg ' (''assignment2.m'') '];
    end
    if ~exist(fullfile(obj.projDir, 'invit.m'), 'file')
        str = ' ''invit.m''';
        obj.ctx(obj.partNr).addText(strcat('    !', str, ' missing\n')); r = 0; obj.invit = 0;
        msg = [msg str];
    end
    if ~exist(fullfile(obj.projDir, 'rqi.m'), 'file')
        str = ' ''rqi.m''';
        obj.ctx(obj.partNr).addText(strcat('    !', str, ' missing\n')); r = 0; obj.rqi = 0;
        msg = [msg str];
    end
    if ~exist(fullfile(obj.projDir, 'rqi_k.m'), 'file')
        str = ' ''rqi_k.m''';
        obj.ctx(obj.partNr).addText(strcat('    !', str, ' missing\n')); r = 0; obj.rqi_k = 0;
        msg = [msg str];
    end
    
    if ~r
        if ~isempty(dir('*.m')) && length(dir('*.m')) > 3
            r = 2; %enough filetypes found, but wrong labels
        end
    end
end