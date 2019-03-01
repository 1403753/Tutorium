function checkFiles(obj)
    missing = 0;
    if ~exist(fullfile(obj.projDir, 'assignment1.m'), 'file')
        obj.submission(obj.submissionNr).ctx.addText("assignment1.m file missing.  "); obj.assignment1 = 0; missing = 1;
    end
    if ~exist(fullfile(obj.projDir, 'plu.m'), 'file')
        obj.submission(obj.submissionNr).ctx.addText("plu.m file missing.  "); obj.plu = 0; missing = 1;
    end
    if ~exist(fullfile(obj.projDir, 'accuracy.m'), 'file')
        obj.submission(obj.submissionNr).ctx.addText("accuracy.m file missing.  "); obj.accuracy = 0; missing = 1;
    end
    if ~exist(fullfile(obj.projDir, 'solveU.m'), 'file')
        obj.submission(obj.submissionNr).ctx.addText("solveU.m file missing.  "); obj.solveU = 0; missing = 1;
    end
    if ~exist(fullfile(obj.projDir, 'solveL.m'), 'file')
        obj.submission(obj.submissionNr).ctx.addText("solveL.m file missing.  "); obj.solveL = 0; missing = 1;
    end
    if ~exist(fullfile(obj.projDir, 'linSolve.m'), 'file')
        obj.submission(obj.submissionNr).ctx.addText("linSolve.m file missing.  "); obj.linSolve = 0; missing = 1;
    end
    
    if missing
      if ~isempty(dir('*.m')) && length(dir('*.m')) > 6
        obj.submission(obj.submissionNr).ctx.addText("Enough m-files found, maybe wrong labels? ");
      end
    end
end