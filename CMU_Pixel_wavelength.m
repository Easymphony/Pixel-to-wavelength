
close all;
Wolf = [ 434,479,506,552,586; 468.6 541.1 580.8 656.0 711.5];
Wolf(1,:) = Wolf(1,:)-138;
Sirius = [418,452,560,625;434.047,486.13,656.29,777];
Sirius(1,:) = Sirius(1,:)-143;
SAO59570 = [409,442,550,617; 434.05,486.13,656.29,777];
SAO59570(1,:)=SAO59570(1,:)-133;
Alhena = [416,448,557,620;434.047,486.13,656.29,777];
Alhena(1,:)=Alhena(1,:)-141;
compiled=[Wolf,Sirius,SAO59570,Alhena];
Alhena=Alhena';
Wolf=Wolf';
SAO59570=SAO59570';
Sirius=Sirius';
compiled=compiled';

x=[200:1:600];

%Sirius
f=fit(Sirius(:,1),Sirius(:,2),'poly1')
figure(1)
y=f.p1.*x+f.p2;
plot(x,y,'k','linewidth',3)
hold on
plot(Sirius(:,1),Sirius(:,2),'k.','MarkerSize',40)
ax=gca;
ax.FontSize=16;
axis tight
title('Sirius Pixel-to-Wavelength','FontSize',16)
xlabel('\Delta Pixels','FontSize',16)
ylabel('Wavelength (nm)','FontSize',16)
text(250,900,['\lambda = ',num2str(f.p1),'\DeltaPixels - ',num2str(abs(f.p2))],'FontSize',16)

%Alhena
f=fit(Alhena(:,1),Alhena(:,2),'poly1')
figure(2)
y=f.p1.*x+f.p2;
plot(x,y,'k','linewidth',3)
hold on
plot(Alhena(:,1),Alhena(:,2),'k.','MarkerSize',40)
ax=gca;
ax.FontSize=16;
axis tight
title('Alhena Pixel-to-Wavelength','FontSize',16)
xlabel('\Delta Pixels','FontSize',16)
ylabel('Wavelength (nm)','FontSize',16)
text(250,900,['\lambda = ',num2str(f.p1),'\DeltaPixels - ',num2str(abs(f.p2))],'FontSize',16)

%SAO
f=fit(SAO59570(:,1),SAO59570(:,2),'poly1')
figure(3)
y=f.p1.*x+f.p2;
plot(x,y,'k','linewidth',3)
hold on
plot(SAO59570(:,1),SAO59570(:,2),'k.','MarkerSize',40)
ax=gca;
ax.FontSize=16;
axis tight
title('SAO59570 Pixel-to-Wavelength','FontSize',16)
xlabel('\Delta Pixels','FontSize',16)
ylabel('Wavelength (nm)','FontSize',16)
text(250,900,['\lambda = ',num2str(f.p1),'\DeltaPixels - ',num2str(abs(f.p2))],'FontSize',16)

%Wolf
f=fit(Wolf(:,1),Wolf(:,2),'poly1')
figure(4)
y=f.p1.*x+f.p2;
plot(x,y,'k','linewidth',3)
hold on
plot(Wolf(:,1),Wolf(:,2),'k.','MarkerSize',40)
ax=gca;
ax.FontSize=16;
axis tight
title('Wolf-Rayet Pixel-to-Wavelength','FontSize',16)
xlabel('\Delta Pixels','FontSize',16)
ylabel('Wavelength (nm)','FontSize',16)
text(250,900,['\lambda = ',num2str(f.p1),'\DeltaPixels - ',num2str(abs(f.p2))],'FontSize',16)
%compiled
f=fit(compiled(:,1),compiled(:,2),'poly1')
figure(5)
y=f.p1.*x+f.p2;
plot(x,y,'k','linewidth',3)
hold on
plot(compiled(:,1),compiled(:,2),'k.','MarkerSize',30)
ax=gca;
ax.FontSize=16;
axis tight
title('CMU Compiled Pixel-to-Wavelength','FontSize',16)
xlabel('\DeltaPixels','FontSize',16)
ylabel('Wavelength (nm)','FontSize',16)
text(250,900,['\lambda = ',num2str(f.p1),'\DeltaPixels - ',num2str(abs(f.p2))],'FontSize',16)

