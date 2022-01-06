clear
clc 

loadData = load('dataBase.mat'); % This loads the data matrix produced from massDataExtractor.m
dataBaseCopy = loadData.dataBase;
img = imread('CIExy1931.bmp');
testMatrix = dataBaseCopy{3,2};

%{
    T  represents the  matrix  of  the  reference measurement. S is the 
    sensor signal matrix, and K is the transformation matrix K is used to
    transform the measured sensor into XYZ color space T is the Xn,Yn,Zn of
    known XYZ measurements from a spectrometer, S consists of ADC values 
    from the MCDC04.

    I am assuming that these values are all sample values.
%}

XYZ455 = [15327, 4000, 88192]; %455 nm
XYZ465 = [487, 64, 2599];      %465 nm
XYZ510 = [250, 26, 1196];      %510 nm

T(:,1) = XYZ455;
T(:,2) = XYZ465;
T(:,3) = XYZ510;

ADC1 = [65535, 65535, 65535];
ADC2 = [46519, 65535, 65535];
ADC3 = [16812, 65535, 34332];

S(:,1) = ADC1;
S(:,2) = ADC2;
S(:,3) = ADC3;

%Transformation Matrix
K = (T*S')/(S*S');

%sample1 = [46832, 65535, 65535];
%sample2 = [22384, 65535, 37448];
sample3 = [265535, 65535, 65535];

XYZAdj1 = K*sample3';

min_x = 0;
max_x = .8;
min_y = 0;
max_y = .9;

figure(1)
xlabel('x');
ylabel('y');
axis([min_x max_x min_y max_y]);
imagesc([min_x max_x], [min_y max_y], flipud(img));

for i = 1:length(dataBaseCopy)
    figure(i)
    xlabel('x');
    ylabel('y');
    axis([min_x max_x min_y max_y]);
    imagesc([min_x max_x], [min_y max_y], flipud(img));
    
    EL_ADJ_1(i,:) = K*EL_1(i,:)';
    
    xx_1(i) = EL_ADJ_1(i,1)/(EL_ADJ_1(i,1)+EL_ADJ_1(i,2)+EL_ADJ_1(i,3));
    yy_1(i) = EL_ADJ_1(i,2)/(EL_ADJ_1(i,1)+EL_ADJ_1(i,2)+EL_ADJ_1(i,3));
    
    %imagesc([min_x max_x], [min_y max_y], flipud(img));
    hold on
    plot(xx_1(i),yy_1(i),'r-o','linewidth',1.5)
    %plot(.3,.3,'ro','linewidth',1.5)
    set(gca,'ydir','normal');

    hold off
    
end