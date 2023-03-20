%   FTN_pixel_to_wavelength_calibration.m
%
%   Modified from: Princeton_calibration_1.m   
%
%   an m file to look at the wavelength calibration of Phantom 7.3 with
%   image intenssifier 1
%   Data from Princeton, Jan 2011.   Using file
%   F:\Princeton\19jan2011\cal1.cine to get a good wavelength calibration
%   for the setup at Princeton.  
%
%  Look in sparc6 page 149 for notes
%
%   Feb 2011,  McHarg
%   Mar 2011,  Chun
%   May 2016,  Chun (calibration for Falcon Telescopes)
%
close all
clear all
;
dir_name='C:\Users\C21Erik.Jensen\Desktop\490 matlab';
% filein=276;
% fileout=200;
filein=21;
fileout=21;
i=filein;
%A1=fitsread([dir_name,d(i).name],'fit');
%A1=fitsread('Alhena1grating1.fit');
%A1=fitsread('Procyon1grating_0.100secs_00010390.fit');
%A1=fitsread('SAO 59570grating_0.100secs_00010348.fit');
A1=fitsread('HD4004grating_10.000secs_00010411.fit');
%A1=fitsread('HD 47761grating_10.000secs_00010368.fit');
%A1=fitsread('Sirius2grating_0.010secs_00010382.fit');
%A1=fitsread('Siriusgrating_0.010secs_00010375.fit');
%A1=fitsread('Alhena (HD 47105) A0IV 20110316-2.fit');
file_size=size(A1);
%
%   first get the average spectra over this range. 
%
A_save=zeros(file_size(1),file_size(2),filein-fileout+1);
count=0;
for i=filein:-1:fileout
    count=count+1;

    %A=fitsread('Alhena1grating1.fit');
    %A=fitsread('Procyon1grating_0.100secs_00010390.fit');
    %A=fitsread('SAO 59570grating_0.100secs_00010348.fit');
    A=fitsread('HD4004grating_10.000secs_00010411.fit');
    %A=fitsread('HD 47761grating_10.000secs_00010368.fit');
    %A=fitsread('Sirius2grating_0.010secs_00010382.fit');
    %A=fitsread('Siriusgrating_0.010secs_00010375.fit');
    %A=fitsread('Alhena (HD 47105) A0IV 20110316-2.fit');
    A_save(:,:,count)=A;
end
A_mean=mean(A_save,3);
imagesc(A_mean)
axis image
%
%    this rotates the image.  Use data cursor on the image in Figure 1 to
%    get the row and col number you need to rotate to.
%
%   NOTE: If you use imread (line 41) then the rows/cols are okay as shown
%   below, otherwise if you use fitsread, then Matlab switches the rows and
%   columns and you need to switch them accordingly.
%

% Alhena (switch rows and columns for fitsread
% row_pt4=435;  
% row_zero=446;
% col_pt4=629;
% col_zero=126;

%procyon
%row_pt4=395;  
%row_zero=404;
%col_pt4=564;
%col_zero=148;

%SAO59570
% row_pt4=480;  
% row_zero=487;
% col_pt4=515;
% col_zero=126;

%hd 4004
% row_pt4=581;  
% row_zero=591;
% col_pt4=573;
% col_zero=123;

%hd 47761
%row_pt4=400;  
%row_zero=411;
%col_pt4=639;
%col_zero=172;

%sirius2
%row_pt4=430;  
%row_zero=419;
%col_pt4=407;
%col_zero=847;

%sirius
row_pt4=395;  
row_zero=404;
col_pt4=511;
col_zero=133;

%test
%row_pt4=668;  
%row_zero=79;
%col_pt4=483;
%col_zero=484;

del_row=row_pt4-row_zero;
del_col=col_pt4-col_zero;

rot_ang=atand(del_row/del_col)+90;
A_rot=imrotate(A_mean,rot_ang,'bilinear');

%sirius2
% rot_ang=atand(del_row/del_col)-90;
% A_rot=imrotate(A_mean,rot_ang,'bilinear');

figure(2)
Check=0;
Check_2=0;
while Check==0 || Check_2==0
[V I] = max(A_rot(:));
[Row Column]=ind2sub(size(A_rot),I);
for ii = Row-1:Row+1
    if abs(A_rot(ii, Column))<abs(A_rot(Row,Column))+1000 && abs(A_rot(ii, Column))>abs(A_rot(Row,Column))-1000
        Check=1;
    else
        Check=0;
        break
    end
end
for jj = Column-1:Column+1
    if abs(A_rot(Row, jj))<abs(A_rot(Row,Column))+1000 && abs(A_rot(ii, Column))>abs(A_rot(Row,Column))-1000
        Check_2=1;
    else
        Check_2=0;
        break
    end
end
if Check==0 || Check_2==0
A_rot(Row,Column)=(A_rot(Row+1,Column)+A_rot(Row-1,Column)+A_rot(Row,Column+1)+A_rot(Row,Column-1))/4;
end
end
%A_clip=A_rot;
% A_clip=A_rot(400:500,250:500);   %  

%all clips
A_clip=A_rot(Row-30:Row+30,1:1024);
% hd 47761
%Row=610;

A_clip=A_rot(Row-30:Row+30,1:1024);
imagesc(A_rot);
figure(3)
imagesc(A_clip);
axis image
% A_clip_row=47;    % use data cursor on figure above to get the row number you want to average about to get spectra.  
A_clip_row=30;    % (alhena,sao,hd4004,sirius2)use data cursor on figure above to get the row number you want to average about to get spectra. 
%A_clip_row=37; %hd 47761
%A_clip_row=31; %sirius
%wave_intensity=mean(A_clip(A_clip_row-5:A_clip_row+5,:));
wave_intensity=mean(A_clip(A_clip_row-1:A_clip_row+1,:));
figure(4)
x_index=[1:length(wave_intensity)];  % make an x axis to fit to
%p=polyfit(x_index,wave_intensity,2);
%f=polyval(p,x_index);
%wave_cal=detrend(wave_intensity);
wave_cal=wave_intensity;
plot(x_index,wave_cal)
%
%   now fit to a 5 guassian and get the centers and the calibration
%       USE if DATA is clear

x_fit=x_index;
%fresult = fit(x_fit',wave_intensity','gauss5');
%fresult = fit(x_fit',wave_cal','gauss4');
%yfit=fresult(x_fit);
%[w,i]=max(wave_intensity);
%centers=sort([fresult.b1,fresult.b2,fresult.b3,fresult.b4,fresult.b5]);
%centers=sort([fresult.b1,fresult.b2,fresult.b3, fresult.b4]);

%alhena
%centers=[141,416,448,557,620];
%Sao 59570
%centers=[133,409,442,550,617];
%HD4004
centers=[138,434,479,506,552,586];
%Sirius
%centers=[143,418,452,560,625]

offset=centers(1);
wave_x_fit=centers-centers(1);% these are the pixels of the peaks with zeorth order at 0
wave_y_fit=[0,468.6,541.1,580.8,656.0,711.5];  %(hd4004) these are the wavelengths of these pixels
%wave_y_fit=[0,434.05,486.13,656.29,777];  %(Sao)these are the wavelengths of these pixels
%wave_y_fit=[0,434.047,486.13,656.29,777]; % (alhena) these are the wavelengths of these pixels
%wave_y_fit=[0,434.047,486.13,656.29,777]; % (Sirius) these are the wavelengths of these pixels
CMU_wavefit=fit(wave_x_fit(2:end)',wave_y_fit(2:end)','poly1')
figure(5)
subplot(2,1,1)
plot(x_fit,wave_cal,'.-k')
ax=gca;
ax.FontSize=20;
axis tight
xlabel('Pixels','FontSize', 30)
ylabel('Intensity (arb.)','FontSize', 30)

subplot(2,1,2)
plot(x_index,CMU_wavefit(x_index),'-b','LineWidth',3)

hold on
plot(wave_x_fit,wave_y_fit,'k.','MarkerSize',30);
test_str={'y(x)=p1*x^2 + p2*x + p3','Coefficients (with 95% confidence bounds):','p1 =   0.0001224  (-0.0001211, 0.000366)','p2 =       2.528  (2.474, 2.582)','p3 =     0.01018  (-2.467, 2.487)'};
%text(15,700,test_str)
ax=gca;
ax.FontSize=20;
axis tight
ylabel('Wavelength (nm)','FontSize', 25)
xlabel('\DeltaPixels','FontSize', 25)

%
%   now get the pixels for entire row
%
pixel_x=x_fit-centers(1);
% x_nm=princeton_wavefit(pixel_x)';
x_nm=pixel_x*CMU_wavefit.p1+CMU_wavefit.p2;
%x_nm=pixel_x*1.662-24;% using other fit equation
figure(6)
subplot(2,1,1)
plot(pixel_x,wave_cal,'-k.')
ax=gca;
ax.FontSize=20;
axis tight
xlabel('\DeltaPixels','FontSize', 30)
ylabel('Intensity (arb.)','FontSize', 30)

xline(centers(1)-offset);
xline(centers(2)-offset);
xline(centers(3)-offset);
xline(centers(4)-offset);
xline(centers(5)-offset);
xline(centers(6)-offset);
subplot(2,1,2)
plot(x_nm,wave_cal,'-b.')
xline(wave_y_fit(1));
xline(wave_y_fit(2));
xline(wave_y_fit(3));
xline(wave_y_fit(4));
xline(wave_y_fit(5));
xline(wave_y_fit(6));
ax=gca;
ax.FontSize=20;
axis tight
xlabel('Wavelength (nm)','FontSize', 30)
ylabel('Intensity (arb.)','FontSize', 30)

% save 'princeton_wave1'

