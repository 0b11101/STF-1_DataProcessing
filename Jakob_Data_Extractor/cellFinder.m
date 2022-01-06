%Read specific cells and check if there are multiple to read 
    %{
    1. Check if B1 reads Packet
    2. Check if B2 through B10 reads CSEE_EXP2_TLM_T
    2edit. IF BN READS NULL THEN EXIT LOOP
    2a.If Bx is true check if cell Nx is longer than 20
    2ai.If so start parce and put in matrix 
    2b. else if check if Qx is longer than 20
    2bi. start parce 
    2c. else if check if Sx is longer than 20
    2ci. start parce
    3. Add new row and repeat
%}
clear
clc

fileName = '/Users/jakobloverde/Documents/Fall_2021/STF-1/experiment 1 and 2 data/exp 2/2020_06_10_07_22_05_CSEE_exp2_tlm_t.csv';
correction = readtable(fileName,'Delimiter', ',');
dataFinder(fileName);

function [dataString] = dataFinder(fileToCheck)
    %{ 
      Function checks to see how many rows contain data 
      then takes the data from the last column in the correlated
      rows to convert into a string array
    %}

    dataSet = readtable(fileToCheck,'Delimiter', ',');
    check_EXP2 = 'CSEE_EXP2_TLM_T';

    fileType = string(dataSet{1,2});

    rowDataCounter = 0;

    % This is to check if the file is from exp 2 and how many rows of 
    % data there are
    if (strcmp(check_EXP2, fileType) == 1)
        for i = 1 : size(dataSet,1)
            if (strcmp(check_EXP2, string(dataSet{i,2})))
                rowDataCounter = rowDataCounter + 1;
            end
        end

    else disp('Wrong file!')

    end

    dataString = strings(rowDataCounter,1);
    %data is always in the last column
    
    for i = 1 : rowDataCounter
        dataString(i, 1) = dataSet{i, size(dataSet,2)};
    end

end 



