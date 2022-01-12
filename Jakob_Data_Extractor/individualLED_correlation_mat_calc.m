clc
clear 
%% Draft for ploting one LED per graph
img = imread('CIExy1931.bmp');

loadData = load('dataBase_exp2.mat'); % This loads the data matrix produced 
                                      % from massDataExtractor.m                       
exp2_dataBaseCopy = loadData.dataBase_exp2;

XYZ455 = [15327, 4000, 88192]; %455 nm
XYZ465 = [487, 64, 2599];      %465 nm
XYZ510 = [250, 26, 1196];      %510 nm

T(:,1) = XYZ455;
T(:,2) = XYZ465;
T(:,3) = XYZ510;

min_x = 0;
max_x = .8;  
min_y = 0;
max_y = .9;

xx_values = zeros(24,length(exp2_dataBaseCopy));
yy_values = zeros(24,length(exp2_dataBaseCopy));

% loop control logic
% 1. choose LED e.g. 1
% 2. loop through files 1 to end graphing all LED 1 points

numberOfLEDs = 24;
for c = 2 : numberOfLEDs+1 % plus 1 since dataBase has offset
    
   figure(c-1)
   xlabel('x');
   ylabel('y');
   axis([min_x max_x min_y max_y]);
   imagesc([min_x max_x], [min_y max_y], flipud(img));     
    for a = 1 : length(exp2_dataBaseCopy)
       currentDataSet = exp2_dataBaseCopy{a,2};   

       %2  3  4
       %5  6  7
       %8  9  10
       %11 12 13
       %Three cases mod(c-1,3)=0; mod(c,3)=0; mod(c+1,3) = 0
       if(mod(c+1,3) == 0) %e.g. LEDs 2,5,8,11
           ADC1 = [str2double(currentDataSet{c,8}),...
                   str2double(currentDataSet{c,9}),...
                   str2double(currentDataSet{c,10})];

           ADC2 = [str2double(currentDataSet{c+1,8}),...
                   str2double(currentDataSet{c+1,9}),...
                   str2double(currentDataSet{c+1,10})];

           ADC3 = [str2double(currentDataSet{c+2,8}),...
                   str2double(currentDataSet{c+2,9}),...
                   str2double(currentDataSet{c+2,10})];

       elseif(mod(c,3) == 0) %e.g. LEDs 3,6,9,12
           ADC1 = [str2double(currentDataSet{c-1,8}),...
                   str2double(currentDataSet{c-1,9}),...
                   str2double(currentDataSet{c-1,10})];

           ADC2 = [str2double(currentDataSet{c,8}),...
                   str2double(currentDataSet{c,9}),...
                   str2double(currentDataSet{c,10})];

           ADC3 = [str2double(currentDataSet{c+1,8}),...
                   str2double(currentDataSet{c+1,9}),...
                   str2double(currentDataSet{c+1,10})];
       elseif(mod(c-1,3) == 0) % e.g. LEDs 4,7,10,13
           ADC1 = [str2double(currentDataSet{c-2,8}),...
                   str2double(currentDataSet{c-2,9}),...
                   str2double(currentDataSet{c-2,10})];

           ADC2 = [str2double(currentDataSet{c-1,8}),...
                   str2double(currentDataSet{c-1,9}),...
                   str2double(currentDataSet{c-1,10})];

           ADC3 = [str2double(currentDataSet{c,8}),...
                   str2double(currentDataSet{c,9}),...
                   str2double(currentDataSet{c,10})];
       end
       S(:,1) = ADC1;
       S(:,2) = ADC2;
       S(:,3) = ADC3;

       K = (T*S')/(S*S');
       %converts data into numbers
       EL_xyz = currentDataSet(c,3:5);
       EL_xyz = sprintf('%s*',EL_xyz{:});
       EL_xyz = sscanf(EL_xyz, '%d*');

       EL_adj(c,:) = K*EL_xyz;
       xx(c) = EL_adj(c,1)/(EL_adj(c,1)+EL_adj(c,2)+EL_adj(c,3));
       yy(c) = EL_adj(c,2)/(EL_adj(c,1)+EL_adj(c,2)+EL_adj(c,3));

       hold on
       plot(xx(c),yy(c),'r-o','linewidth',1.5)
       set(gca,'ydir','normal');
       hold off

%        xx_values(:,a) = xx';
%        yy_values(:,a) = yy';
    end
end