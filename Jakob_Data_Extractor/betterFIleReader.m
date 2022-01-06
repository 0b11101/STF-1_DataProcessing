%% This function will be able to read the files from the one folder and 
% search for any file with in that folder or its subfolders that contain
% "_exp_"

%% Notes

%% TODO update the file finder to find _exp2_ so a zip can be downloaded of all
%  the data.
% Possible solution:
% https://www.mathworks.com/matlabcentral/answers/376906-find-specific-files-based-on-sections-of-file-name
% Get a list of all files in the folder, and its subfolders, with the desired file name pattern.
% filePattern = fullfile(myFolder, '**/*.png'); % Change to whatever pattern you need.

%% Serial File Reader
%{
TODO: Find out how to extract all of the data all at once instead of
doing the brute force that was done before. 

soln: 
https://matlab.fandom.com/wiki/FAQ#How_can_I_process_a_sequence_of_files.3F
https://www.mathworks.com/help/matlab/ref/matlab.io.datastore.dsfilereader-class.html
https://www.mathworks.com/help/matlab/ref/matlab.io.datastore.fileset.html
https://www.mathworks.com/help/matlab/ref/matlab.io.datastore.filedatastore.html
%}
clc
clear

myFolder = '/Users/jakobloverde/Documents/MATLAB/STF-1/allData';
filePattern = fullfile(myFolder, '**/*_exp2_*.csv');
theFiles = dir(filePattern);

for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
end 


   
   
   
   
   
   
   
   
   
   