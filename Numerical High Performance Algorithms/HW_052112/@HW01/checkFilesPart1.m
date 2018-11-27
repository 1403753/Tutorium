function [r, msg] = checkFilesPart1(obj)
    r = 1;
    msg = '';
    if ~exist(fullfile(obj.projDir, 'assignment1.m'), 'file')
        str = ' ''assignment1.m''';
        obj.ctx(obj.partNr).addText(strcat('    !', str, ' missing\n')); r = 0;
        msg = [msg ' (''assignment1.m'') '];
    end
    if ~exist(fullfile(obj.projDir, 'plu.m'), 'file')
        str = ' ''plu.m''';
        obj.ctx(obj.partNr).addText(strcat('    !', str, ' missing\n')); r = 0; obj.plu = 0;
        msg = [msg str];
    end
    if ~exist(fullfile(obj.projDir, 'uplu.m'), 'file')
        str = ' ''uplu.m''';
        obj.ctx(obj.partNr).addText(strcat('    !', str, ' missing\n')); r = 0; obj.uplu = 0;
        msg = [msg str];
    end
    if ~exist(fullfile(obj.projDir, 'pluStats.m'), 'file')
        str = ' ''pluStats.m''';
        obj.ctx(obj.partNr).addText(strcat('    !', str, ' missing\n')); r = 0; obj.pluStats = 0;
        msg = [msg str];
    end
    if ~exist(fullfile(obj.projDir, 'upluStats.m'), 'file')
        str = ' ''upluStats.m''';
        obj.ctx(obj.partNr).addText(strcat('    !', str, ' missing\n')); r = 0; obj.upluStats = 0;
        msg = [msg str];
    end
    
    if ~r
        if ~isempty(dir('*.m')) && length(dir('*.m')) > 4
            r = 2; %enough filetypes found, but wrong labels
        end
    end
end