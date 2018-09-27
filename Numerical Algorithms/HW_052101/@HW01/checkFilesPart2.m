function [r, msg] = checkFilesPart2(obj)
    r = 1;
    msg = '';
    
    if ~exist(fullfile(obj.projDir, 'part2.m'), 'file')
        str = ' ''part2.m''';
        obj.ctx(obj.partNr).addText(strcat('    !', str, ' missing\n')); r = 0;
        msg = [msg ' (''part2.m'') '];
    end
    if ~exist(fullfile(obj.projDir, 'solveL.m'), 'file')
        str = ' ''solveL.m''';
        obj.ctx(obj.partNr).addText(strcat('    !', str, ' missing\n')); r = 0; obj.solveL = 0;
        msg = [msg str];
    end
    if ~exist(fullfile(obj.projDir, 'solveU.m'), 'file')
        str = ' ''solveU.m''';
        obj.ctx(obj.partNr).addText(strcat('    !', str, ' missing\n')); r = 0; obj.solveU = 0;
        msg = [msg str];
    end
    
    if ~r
        if ~isempty(dir('*.m')) && length(dir('*.m')) > 7
            r = 2;
        end
    end
end