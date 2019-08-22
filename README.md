# MatrixRain
Matrix (the movie) rain command line progress bar for Matlab

Pass the percentage of progress in each cycle of a loop. The 'done' value is between 0 and 1.

% example:

for iCal = 1:1000 
  
  % myCalculaiont(xx) 
  
  pause(0.05) 
  
  matrixRain(iCal/1000) 

end
