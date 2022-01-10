clear
clc
% for y = 2 : 25
%     if(mod(y+1,3) == 0)
%         disp('worked');
%     end
%     disp(y);
% end 
img = imread('CIExy1931.bmp');

% loadData = load('dataBase.mat'); % This loads the data matrix produced from massDataExtractor.m
% dataBaseCopy = loadData.dataBase;
% 
% testMatrix = dataBaseCopy{90,2};

%{
    T  represents the  matrix  of  the  reference measurement. S is the 
    sensor signal matrix, and K is the transformation matrix K is used to
    transform the measured sensor into XYZ color space T is the Xn,Yn,Zn of
    known XYZ measurements from a spectrometer, S consists of ADC values 
    from the MCDC04.

    I am assuming that these values are all sample values.
%}

% 
% XYZ455 = [15327, 4000, 88192]; %455 nm
% XYZ465 = [487, 64, 2599];      %465 nm
% XYZ510 = [250, 26, 1196];      %510 nm
% 
% T(:,1) = XYZ455;
% T(:,2) = XYZ465;
% T(:,3) = XYZ510;
% 
% ADC1 = [str2double(testMatrix{5,8}), str2double(testMatrix{5,9}),...
%     str2double(testMatrix{5,10})];
% ADC2 = [str2double(testMatrix{6,8}), str2double(testMatrix{6,9}), str2double(testMatrix{6,10})];
% ADC3 = [str2double(testMatrix{7,8}), str2double(testMatrix{7,9}), str2double(testMatrix{7,10})];
% 
% S(:,1) = ADC1;
% S(:,2) = ADC2;
% S(:,3) = ADC3;

%Transformation Matrix
% K = (T*S')/(S*S');

%sample1 = [46832, 65535, 65535];
%sample2 = [22384, 65535, 37448];
% sample3 = [str2double(testMatrix{5,3}), str2double(testMatrix{5,4}), str2double(testMatrix{5,5})];

min_x = 0;
max_x = .8;
min_y = 0;
max_y = .9;

figure(1)
xlabel('x');
ylabel('y');
axis([min_x max_x min_y max_y]);
imagesc([min_x max_x], [min_y max_y], flipud(img));

% EL_ADJ_1(1,:) = K*sample3';
% xx_1 = EL_ADJ_1(1,1)/(EL_ADJ_1(1,1)+EL_ADJ_1(1,2)+EL_ADJ_1(1,3));
% yy_1 = EL_ADJ_1(1,2)/(EL_ADJ_1(1,1)+EL_ADJ_1(1,2)+EL_ADJ_1(1,3));
a = .01;
b = .01;
% for x = 1 : 10
%     a = a + .00001;
%     for y = 1 : 10
%         b = b + .01;
%         hold on
%         plot(b,a,'r-o','linewidth',1.5)
%         set(gca,'ydir','normal'); 
%         hold off
%     end 
%    
% end 

hold on
plot(.143,.032,'r-o','linewidth',1.5)
set(gca,'ydir','normal'); 
hold off

% EL_Y(:,1)=EL_ADJ_1(:,2);
% EL_Y_NORM = EL_Y/5296;