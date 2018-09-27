function [r, msg] = checkFilesPart1(obj)
    r = 1;
    msg = '';
    
    if ~exist(fullfile(obj.projDir, 'part1.m'), 'file')
        str = ' ''part1.m''';
        obj.ctx(obj.partNr).addText(strcat('    !', str, ' missing\n')); r = 0;
        msg = [msg ' (''part1.m'') '];
    end
    if ~exist(fullfile(obj.projDir, 'plu.m'), 'file')
        str = ' ''plu.m''';
        obj.ctx(obj.partNr).addText(strcat('    !', str, ' missing\n')); r = 0; obj.plu = 0;
        msg = [msg str];
    end
    if ~exist(fullfile(obj.projDir, 'accuracy.m'), 'file')
        str = ' ''accuracy.m''';
        obj.ctx(obj.partNr).addText(strcat('    !', str, ' missing\n')); r = 0; obj.accuracy = 0;
        msg = [msg str];
    end
    
    if ~r
        if ~isempty(dir('*.m')) && length(dir('*.m')) > 7
            r = 2;
        end
    end
end