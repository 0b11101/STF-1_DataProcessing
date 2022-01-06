clear
clc

test = '00000005000300F2010A0000000500020001000005000300F1015640C600CE07C00402000006000300F201000000000500030003000005000300F1012F39A600A006250404000006000300F101AC4E9A001506830305000006000400F2013052B600B906400406000006000400F201985DAF009806400407000006000300F101A84D4200BB026E0108010001000500F1016E5AFFFFFFFFFFFF090A005C001800F1014448FFFFFFFFFFFF0A0B0058001A00F2010A000000010004000B000001000300F2018A48FFFFFFFFFFFF0C00000D000B00F20100000000090008000D000009000800F2018C4633AFFFFFFFFF0E00000D000B00F101A84DFFFFFFFFFFFF0F00000D000B00F101BE50FFFFFFFFFFFF1000000D000B00F1013449CA015A0CD8071100000B000900F201485368019F0913061200000A000900F101BC48A301F00A1F071300000A000900F10184444D01B1083E051400000A000900F2010A0000000900080015000009000800F20136474FB2FFFFFFFF1600000C000B00F2017A4EFFFFFFFFFFFF1700000D000B00F1012E6DD79EFFFFFFFF';
converter(test);

parcedMatrix = cellstr(reshape(test,34,[])');

%% Takes a string a hex string that fits the data structure of exp 1 and places the values in the correct slot in a matrix
    %  1. Reshapes the data into arrays of length 17
    %  2. Gets the data from a single row and breaks into list of chars
    %  stored in the variable 'data'
    %  3. Converts the hex data into decimal data and stores them in the
    %  correct position according to the data structure for exp 2
    %  THIS FUNCTION ASSUMES YOU HAVE THE CELL DATA ALREADY SELECTED DOES
    %  NOT GET THE DATA
function [tinyMatrix] = converter(hexidicmalString)
    
    %% Parses string into different arrays of length 17
        % answer: 
        % https://www.mathworks.com/matlabcentral/answers/109411-split-string-into-3-letter-each
    
    tinyMatrix = zeros(16, 9);
    parcedMatrix = cellstr(reshape(hexidicmalString,34,[])');

    %% Covert individual arrays into a decimal value then store into a matrix
        % LED is 1 Byte, ADC Readings 3*2 bytes(X,Y,Z) [2,3], Voltage is 2 bytes[4,5], Current 2
        % bytes[6,7], SECOND ADC readings 3*2 bytes (X,Y,Z)[8,9]
        % every row will have 9 columns hence zeros(16,9)
    
    for row = 1 : size(parcedMatrix, 1) %This indexes 
        indexModifier = 2;
        %ROW was never being updated!
        data = cellstr(reshape(char(parcedMatrix(row)), 2,[])');
        %reshapes the current row into a string array with 2 bytes
        %the data is not 1 byte it is 2 bytes
        for column = 1 : 9 %every 17 bytes make a new row 
            %fist column is LED number, etc... with only 9
            %1st ADC readings
            if(column == 1)
                hexString = data(1,column);
                hexConversion = hex2dec(hexString);
                test = dec2hex(hexConversion);
                fprintf(test);
                tinyMatrix(row, 1) = hexConversion;
           
            end
            if(column >= 2)
                hexString = strcat(data(indexModifier),data(indexModifier+1)); %need to concatenate two character
                hexConversion = hex2dec(hexString);
                tinyMatrix(row, column) = hexConversion;
                indexModifier = indexModifier+2;
                %indexModifier only needs to be updated here since it is
                %only used here
               
            end 
        end 
    end 
    
    %% Adding headers
    headers = {'LED Number', 'x1', 'y1', 'z1', 'Voltage', 'Current', 'x2','y2','z2'};
    tinyMatrix = [headers; num2cell(tinyMatrix); headers];
     
    
end 