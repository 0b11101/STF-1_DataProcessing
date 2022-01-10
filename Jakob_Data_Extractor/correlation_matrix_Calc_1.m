clear
clc
%reading the color matching functions  
% data = csvread('ciexyz31_1.csv');
% wavelength = data(:,1);
% redCMF = data(:,2);
% greenCMF = data(:,3);
% blueCMF = data(:,4);
% 
% hold on
% plot(wavelength,blueCMF);
% plot(wavelength,redCMF);
% plot(wavelength,greenCMF);
% hold off

%This version contains notes on the original

loadData = load('dataBase.mat'); % This loads the data matrix produced from massDataExtractor.m
dataBaseCopy = loadData.dataBase;
img = imread('CIExy1931.bmp');

EL_1 = xlsread('LOCC_EL_1.xlsx');
EL_2 = xlsread('LOCC_EL_2.xlsx');
EL_3 = xlsread('LOCC_EL_3.xlsx');
EL_4 = xlsread('LOCC_EL_4.xlsx');

XYZ455 = [15327, 4000, 88192];
XYZ465 = [487, 64, 2599];
XYZ510 = [250, 26, 1196];

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
%sample1 = [22384, 65535, 37448];
sample1 = [265535, 65535, 65535];

XYZAdj1 = K*sample1';

min_x = 0;
max_x = .8;
min_y = 0;
max_y = .9;

figure(1)
xlabel('x');
ylabel('y');
axis([min_x max_x min_y max_y]);
imagesc([min_x max_x], [min_y max_y], flipud(img));


for i = 1:length(EL_1)
    
    EL_ADJ_1(i,:) = K*EL_1(i,:)';
    
    xx_1(i) = EL_ADJ_1(i,1)/(EL_ADJ_1(i,1)+EL_ADJ_1(i,2)+EL_ADJ_1(i,3));
    yy_1(i) = EL_ADJ_1(i,2)/(EL_ADJ_1(i,1)+EL_ADJ_1(i,2)+EL_ADJ_1(i,3));
    
    %imagesc([min_x max_x], [min_y max_y], flipud(img));
    hold on
    plot(xx_1(i),yy_1(i),'r-o','linewidth',1.5)
    %plot(.3,.3,'ro','linewidth',1.5)
    set(gca,'ydir','normal'); %This corrects the graph

    hold off
    
end

figure(2)
xlabel('x');
ylabel('y');
axis([min_x max_x min_y max_y]);
imagesc([min_x max_x], [min_y max_y], flipud(img));


for i = 1:length(EL_2)
    
    EL_ADJ_2(i,:) = K*EL_2(i,:)';
    
    xx_2(i) = EL_ADJ_2(i,1)/(EL_ADJ_2(i,1)+EL_ADJ_2(i,2)+EL_ADJ_2(i,3));
    yy_2(i) = EL_ADJ_2(i,2)/(EL_ADJ_2(i,1)+EL_ADJ_2(i,2)+EL_ADJ_2(i,3));
    
    %imagesc([min_x max_x], [min_y max_y], flipud(img));
    hold on
    plot(xx_2(i),yy_2(i),'r-o','linewidth',1.5)
    %plot(.3,.3,'ro','linewidth',1.5)
    set(gca,'ydir','normal');

    hold off
    
end

figure(3)
xlabel('x');
ylabel('y');
axis([min_x max_x min_y max_y]);
imagesc([min_x max_x], [min_y max_y], flipud(img));


for i = 1:length(EL_3)
    
    EL_ADJ_3(i,:) = K*EL_3(i,:)';
    
    xx_3(i) = EL_ADJ_3(i,1)/(EL_ADJ_3(i,1)+EL_ADJ_3(i,2)+EL_ADJ_3(i,3));
    yy_3(i) = EL_ADJ_3(i,2)/(EL_ADJ_3(i,1)+EL_ADJ_3(i,2)+EL_ADJ_3(i,3));
    
    %imagesc([min_x max_x], [min_y max_y], flipud(img));
    hold on
    plot(xx_3(i),yy_3(i),'r-o','linewidth',1.5)
    %plot(.3,.3,'ro','linewidth',1.5)
    set(gca,'ydir','normal');

    hold off
    
end

figure(4)
xlabel('x');
ylabel('y');
axis([min_x max_x min_y max_y]);
imagesc([min_x max_x], [min_y max_y], flipud(img));


for i = 1:length(EL_4)
    
    EL_ADJ_4(i,:) = K*EL_4(i,:)';
    
    xx_4(i) = EL_ADJ_4(i,1)/(EL_ADJ_4(i,1)+EL_ADJ_4(i,2)+EL_ADJ_4(i,3));
    yy_4(i) = EL_ADJ_4(i,2)/(EL_ADJ_4(i,1)+EL_ADJ_4(i,2)+EL_ADJ_4(i,3));
    
    %imagesc([min_x max_x], [min_y max_y], flipud(img));
    hold on
    plot(xx_1(i),yy_1(i),'r-o','linewidth',1.5)
    %plot(.3,.3,'ro','linewidth',1.5)
    set(gca,'ydir','normal');

    hold off
    
end

EL_Y(:,1)=EL_ADJ_1(:,2);
EL_Y(:,2)=EL_ADJ_2(:,2);
EL_Y(:,3)=EL_ADJ_3(:,2);
EL_Y(:,4)=EL_ADJ_4(:,2);

figure(5)
boxplot(EL_Y);
% xx = XYZAdj1(1,:)/(XYZAdj1(1,:)+XYZAdj1(2,:)+XYZAdj1(3,:));
% yy = XYZAdj1(2,:)/(XYZAdj1(1,:)+XYZAdj1(2,:)+XYZAdj1(3,:));
% Y = XYZAdj1(2,:);

EL_Y_NORM = EL_Y/5296; %5296 = max value

hold on
boxplot(EL_Y_NORM);
xlabel('Normalized Light Output (a.u.)');
ylabel('Trial Number');
hold off
