%%%%%%%%%%%%%
%  How to:  %
%%%%%%%%%%%%%

1. Place submissions for assignment 1 in folder 'Abgaben_HW01'.
	- Each submission should fulfill the requirements from the prerequisites sheet.
	- Five submission examples reside already in the submission folder and can be tested and deleted afterwards.

2. Adjust the size of the input matrix in the Config.m file.
  - You might want to activate verbose output as well for monitoring the evaluation process.

3. Execute the file HW_052101.m (you must be in the same work (root) directory as this file).
	- This will generate a CSV result file.

%%%%%%%%%%%%%%%%%%%%%%%%%%
%  CSV file description  %
%%%%%%%%%%%%%%%%%%%%%%%%%%

- The first two columns provide an index, the matnr. and last name of the student.
- The third row comprises notes that were generated during the evaluation process and will indicate if files are
  missing or not working properly, or if the output has the right format (there is no information about the correctness of the result).
- Columns 4 - 6 resp. D - E contain PART I results (i.e., the relative residual R and the reference residual from the reference implementation for comparison).
- Columns 7 - 15 resp. G - O present results from the solveL resp. solveU routines from PART II. At first the relative residual for solveL and its reference
  and then the relative forward error for solveL and its reference. The same applies for U in the successive columns.
- Columns 16 - 20 resp. P - T address PART III (i.e., the relative residual and its reference and the relative forward error and its reference for the linSolve
  routine.
- Column 21 resp. U of the header contains the problem size n. Although, the interface tests for all routines comprise quick tests for n = 2:10, it is recommended
  to start with a small value and remove submissions that cause errors. After that you may choose a large (prime) number eventually.
	
%%%%%%%%%%%%%%%%%%%%%%%%
%  BUGS and QUESTIONS  %
%%%%%%%%%%%%%%%%%%%%%%%%

If you encounter problems or have questions please contact: robert.ernstbrunner@univie.ac.at

If the application does not work, make sure you are in the root directory and try 'clear all' or restart Octave (v.4.4 or higher) altogether.
