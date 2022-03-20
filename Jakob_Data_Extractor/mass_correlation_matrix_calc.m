clear
clc

%{
output values of the MCDC04 are found using:
X = ∫380-780*L_(e,Ω,λ)(λ)X(λ)dλ
Y = ∫380-780*L_(e,Ω,λ)(λ)Y(λ)dλ
Z = ∫380-780*L_(e,Ω,λ)(λ)Z(λ)dλ

We can get all of the above above values find the peak of the that
then find the the max of each of those values
[ X sensor ]      [ x adc ]
[ Y sensor ]= K * [ y adc ]
[ Z sensor ]      [ z adc ]

where X, Y, and Z sensor are the CIE system values as corrected by the 
transformation matrix.

%}

% xyz_primaries = rgb2xyz([1 0 0]);
% xyzMag = sum(xyz_primaries,2);
% x_primary = xyz_primaries(:,1)./xyzMag;
% y_primary = xyz_primaries(:,2)./xyzMag;

%{
D65 corresponds roughly to the average midday light in Western 
Europe/Northern Europe (comprising both direct sunlight and the light 
diffused by a clear sky), hence it is also called a daylight illuminant.
%}
% wp = whitepoint('D65');
% wpMag = sum(wp,2);
% x_whitepoint = wp(:,1)./wpMag;
% y_whitepoint = wp(:,2)./wpMag;
% 
% plotChromaticity
% hold on
% scatter(x_whitepoint,y_whitepoint,36,'red')
% scatter(x_primary,y_primary,36,'black')
% plot([x_primary; x_primary],[y_primary; y_primary],'k')
% hold off


img = imread('CIExy1931.bmp');

loadData = load('dataBase_exp2.mat'); % This loads the data matrix produced 
                                 % from massDataExtractor.m
                                 
dataBaseCopy = loadData.dataBase_exp2;
%{
    T  represents the  matrix  of  the  reference measurement. S is the 
    sensor signal matrix, and K is the transformation matrix K is used to
    transform the measured sensor into XYZ color space T is the Xn,Yn,Zn of
    known XYZ measurements from a spectrometer, S consists of ADC values 
    from the MCDC04.

    I am assuming that these values are all sample values.
%}
%% Start of processing each LED based on date
 % Todo: plot one graph for each LED and document the shifting if any
XYZ455 = [15327, 4000, 88192]; %455 nm a rho value of what is produced here is close to 455
XYZ465 = [487, 64, 2599];      %465 nm
XYZ510 = [250, 26, 1196];      %510 nm

T(:,1) = XYZ455;
T(:,2) = XYZ465;
T(:,3) = XYZ510;

min_x = 0;
max_x = .8;  
min_y = 0;
max_y = .9;

xx_values = zeros(24,length(dataBaseCopy));
yy_values = zeros(24,length(dataBaseCopy));

rho = sqrt((xx_values.^2)+(yy_values.^2));

for a = 1 : length(dataBaseCopy)
   currentDataSet = dataBaseCopy{a,2};
    
   figure(a)
   xlabel('x');
   ylabel('y');
   axis([min_x max_x min_y max_y]);
   imagesc([min_x max_x], [min_y max_y], flipud(img));
   for b = 2 : (length(currentDataSet) - 1) % starts and 2 and ends at 
                                              % length-1 bc of headings
                                              % divided by three since ADC1
                                              % 2 and 3 are being            
       b_1 = b+1;
       b_2 = b+2;
      
       if(mod(b_1,3) == 0) %Resets the sensor signal mat values "S" every 3
            % 8,9,10 look like dark current values
           ADC1 = [str2double(currentDataSet{b,8}),...
                   str2double(currentDataSet{b,9}),...
                   str2double(currentDataSet{b,10})];

           ADC2 = [str2double(currentDataSet{b_1,8}),...
                   str2double(currentDataSet{b_1,9}),...
                   str2double(currentDataSet{b_1,10})];

           ADC3 = [str2double(currentDataSet{b_2,8}),...
                   str2double(currentDataSet{b_2,9}),...
                   str2double(currentDataSet{b_2,10})];
       end 
       S(:,1) = ADC1;
       S(:,2) = ADC2;
       S(:,3) = ADC3;
       
       K = (T*S')/(S*S');
       %converts data into numbers
       EL_xyz = currentDataSet(b,3:5);
       EL_xyz = sprintf('%s*',EL_xyz{:});
       EL_xyz = sscanf(EL_xyz, '%d*');
       
       EL_adj(b-1,:) = K*EL_xyz;
       xx(b-1) = EL_adj(b-1,1)/(EL_adj(b-1,1)+EL_adj(b-1,2)+EL_adj(b-1,3));
       yy(b-1) = EL_adj(b-1,2)/(EL_adj(b-1,1)+EL_adj(b-1,2)+EL_adj(b-1,3));
       
       hold on
       plot(xx(b-1),yy(b-1),'r-o','linewidth',1.5)
       set(gca,'ydir','normal');
       hold off
      
   end
   xx_values(:,a) = xx';
   yy_values(:,a) = yy';
end