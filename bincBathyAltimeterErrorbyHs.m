%%cBathy Bathy Duck Paper REview plots

load('D:\Kate\Dropbox\BathyDuck\MatFiles\Altimeter_cBathy_Structures_Updated.mat')

%% APply Altimeter offset correction
Alt03.ZcBathyT=Alt03.ZcBathyT+(-0.18);
Alt04.ZcBathyT=Alt04.ZcBathyT+(-0.015);
Alt05.ZcBathyT=Alt05.ZcBathyT+(-0.08);

%% bin cBathy-Altimeter errors by wave height

%interp wave data to cBathy time
waveHscBathyTime=interp1(waveHstime,waveHs,Alt03.cBathy.time);
% 
% %first find time-indices for wave height bins:
% bins=[0:0.25:5];
% 
% for i=1:length(bins)-1
%     ind=find(waveHscBathyTime>=bins(i) & waveHscBathyTime<bins(i+1));
%     indsWaveBins{i}=ind;
%     timesWaveBins{i}=Alt03.cBathy.time(ind);
% end
% 
% %double check we have the best altimeter record & calculate errors
% 
Alt05.ZcBathyTinterp=interp1nan(Alt05.cBathy.time,Alt05.ZcBathyT,Alt05.cBathy.time);
Alt04.ZcBathyTinterp=interp1nan(Alt04.cBathy.time,Alt04.ZcBathyT,Alt04.cBathy.time);
Alt03.ZcBathyTinterp=interp1nan(Alt03.cBathy.time,Alt03.ZcBathyT,Alt03.cBathy.time);

%alt03

% indNaN=find(isnan(Alt03.ZcBathyT));
% for i=1:length(indNaN)
%     %go back to original seafloor time-series and double check there's no
%     %good data within 15 minutes of the cBathy time
%     time=Alt03.cBathy.time(indNaN(i));
%     indHalfHour=find(Alt03.time>=(time-(15/60/24)) & Alt03.time<=(time+(15/60/24)));
%     Alt03.ZcBathyT(indNaN(i))=nanmean(Alt03.seafloorLoc(indHalfHour));
% end

for i=1:length(indsWaveBins)
    %errorWaveBinsAlt03{i}=-Alt03.cBathy.depthKF(indsWaveBins{i})-Alt03.ZcBathyTinterp(indsWaveBins{i});
    depthfC=-Alt03.cBathy.depthfC(indsWaveBins{i});
    altDepth=Alt03.ZcBathyTinterp(indsWaveBins{i});
    indGood=find(depthfC<0 & depthfC>-20);
    depthfC=depthfC(indGood);
    altDepth=altDepth(indGood);
    errorWaveBinsAlt03fC{i}=depthfC-altDepth;
    %errorWaveBinsAlt03{i}=-Alt03.cBathy.depthfC(indsWaveBins{i})-Alt03.ZcBathyTinterp(indsWaveBins{i});
    %depthWaveBinsAlt03{i}=Alt03.ZcBathyT(indsWaveBins{i})';
    goodData=errorWaveBinsAlt03{i};
    goodData=goodData(~isnan(goodData));
    numErrorDataPtsAlt03fC(i)=length(goodData);
    rmseWaveBinsAlt03fC(i)=sqrt(sum(goodData.^2)./length(goodData));
    biasWaveBinsAlt03fC(i)=mean(goodData);
end

%alt04
% indNaN=find(isnan(Alt04.ZcBathyT));
% for i=1:length(indNaN)
%     %go back to original seafloor time-series and double check there's no
%     %good data within 15 minutes of the cBathy time
%     time=Alt04.cBathy.time(indNaN(i));
%     indHalfHour=find(Alt04.time>=(time-(15/60/24)) & Alt04.time<=(time+(15/60/24)));
%     Alt04.ZcBathyT(indNaN(i))=nanmean(Alt04.seafloorLoc(indHalfHour));
% end

for i=1:length(indsWaveBins)
    %errorWaveBinsAlt04{i}=-Alt04.cBathy.depthKF(indsWaveBins{i})-Alt04.ZcBathyTinterp(indsWaveBins{i});
    %depthWaveBinsAlt04{i}=Alt04.ZcBathyT(indsWaveBins{i})';
    depthfC=-Alt04.cBathy.depthfC(indsWaveBins{i});
    altDepth=Alt04.ZcBathyTinterp(indsWaveBins{i});
    indGood=find(depthfC<0 & depthfC>-20);
    depthfC=depthfC(indGood);
    altDepth=altDepth(indGood);
    errorWaveBinsAlt04fC{i}=depthfC-altDepth;
    goodData=errorWaveBinsAlt04{i};
    goodData=goodData(~isnan(goodData));
%     numErrorDataPtsAlt04(i)=length(goodData);
%     rmseWaveBinsAlt04(i)=sqrt(sum(goodData.^2)./length(goodData));
    numErrorDataPtsAlt04fC(i)=length(goodData);
    rmseWaveBinsAlt04fC(i)=sqrt(sum(goodData.^2)./length(goodData));
    biasWaveBinsAlt04fC(i)=mean(goodData);
end

%alt05
% indNaN=find(isnan(Alt05.ZcBathyT));
% for i=1:length(indNaN)
%     %go back to original seafloor time-series and double check there's no
%     %good data within 15 minutes of the cBathy time
%     time=Alt05.cBathy.time(indNaN(i));
%     indHalfHour=find(Alt05.time>=(time-(15/60/24)) & Alt05.time<=(time+(15/60/24)));
%     Alt05.ZcBathyT(indNaN(i))=nanmean(Alt05.seafloorLoc(indHalfHour));
% end

for i=1:length(indsWaveBins)
%     errorWaveBinsAlt05{i}=-Alt05.cBathy.depthKF(indsWaveBins{i})-Alt05.ZcBathyTinterp(indsWaveBins{i});
%     depthWaveBinsAlt05{i}=Alt05.ZcBathyT(indsWaveBins{i})';
    depthfC=-Alt05.cBathy.depthfC(indsWaveBins{i});
    altDepth=Alt05.ZcBathyTinterp(indsWaveBins{i});
    indGood=find(depthfC<0 & depthfC>-20);
    depthfC=depthfC(indGood);
    altDepth=altDepth(indGood);
    errorWaveBinsAlt05fC{i}=depthfC-altDepth;
    goodData=errorWaveBinsAlt05{i};
    goodData=goodData(~isnan(goodData));
%     numErrorDataPtsAlt05(i)=length(goodData);
%     rmseWaveBinsAlt05(i)=sqrt(sum(goodData.^2)./length(goodData));
    numErrorDataPtsAlt05fC(i)=length(goodData);
    rmseWaveBinsAlt05fC(i)=sqrt(sum(goodData.^2)./length(goodData));
    biasWaveBinsAlt05fC(i)=mean(goodData);
end

%Remove bad data

numPtsAll=[numErrorDataPtsAlt03' numErrorDataPtsAlt04' numErrorDataPtsAlt05'];

% figure;
% subplot(2,1,1)
% % plot(bins(2:end)-0.25/2,rmseWaveBinsAlt03,'b.','markersize',15)
% % hold on
% % plot(bins(2:end)-0.25/2,rmseWaveBinsAlt04,'r.','markersize',15)
% % plot(bins(2:end)-0.25/2,rmseWaveBinsAlt05,'g.','markersize',15)
% % set(gca,'fontsize',14)
% % legend('Inner Altimeter','Middle Altimeter','Outer Altimeter')
% % ylabel('RMSE (m)')
% h=scatter(bins(2:end)-0.25/2,rmseWaveBinsAlt03,numErrorDataPtsAlt03,'b');
% hold on
% h1=scatter(bins(2:end)-0.25/2,rmseWaveBinsAlt04,numErrorDataPtsAlt04,'r');
% h2=scatter(bins(2:end)-0.25/2,rmseWaveBinsAlt05,numErrorDataPtsAlt05,'g');
% ylabel('RMSE (m)')
% title('marker size scales with number of observations')
% legend([h; h1; h2],{'Inner Altimeter';'Middle Altimeter';'Outer Altimeter'})
% 
% subplot(2,1,2)
% bar(bins(2:end)-0.25/2,numPtsAll)
% xlim([0 5])
% set(gca,'fontsize',14)
% xlabel('Wave Height Bin Center')
% ylabel('# of Observations')

for i=1:20;
%alldata=[errorWaveBinsAlt03{i}; errorWaveBinsAlt04{i}; errorWaveBinsAlt05{i};];
alldata=[errorWaveBinsAlt03fC{i}; errorWaveBinsAlt04fC{i}; errorWaveBinsAlt05fC{i};];
alldata=alldata(~isnan(alldata));
rmseWaveBinsALLfC(i)=rms(alldata);
biasWaveBinsALLfC(i)=mean(alldata);
numPtsWaveBinsALLfC(i)=length(alldata);
end

figure;
subplot(5,1,1:3)
[AX,H1,H2]=plotyy(waveBins(2:end)-0.125,rmseWaveBinsALL,waveBins(2:end)-0.125,biasWaveBinsALL);hold(AX(1),'on');hold(AX(2),'on')
plot(AX(1),waveBins(2:end)-0.125,rmseWaveBinsALLfC,'b.:','MarkerSize',30)
plot(AX(2),waveBins(2:end)-0.125,biasWaveBinsALLfC,'mo:','MarkerSize',8)
set(AX(1),'XTickLabel',[]);
set(AX(2),'XTickLabel',[])
ylabel(AX(1),'RMSE (m)');
ylabel(AX(2),'Bias (m)');
set(H1,'LineStyle',':','Marker','.','MarkerSize',30);
set(H2,'LineStyle',':','Marker','o','MarkerSize',8);
xlim(AX(1),[0 5]);
xlim(AX(2),[0 5]);
ylim(AX(1),[0 8]);
ylim(AX(2),[-8 0.5]);
set(AX(2),'YTick',[-8:2:1]);
set(AX(1),'YTick',[0:2:8]);

ax1=axes('Position',[0.1300 0.13 0.3875 0.25]);
bar(bins(2:12)-0.25/2,[numErrorDataPtsAlt03(1:11)' numErrorDataPtsAlt04(1:11)' numErrorDataPtsAlt05(1:11)'])
xlim([0 2.75])
set(gca,'fontsize',14)
xlabel('H_s (m)')
ylabel('# of Observations')

ax2=axes('Position',[0.5175 0.13 0.3875 0.25]);
bar(bins(13:end)-0.25/2,[numErrorDataPtsAlt03(12:end)' numErrorDataPtsAlt04(12:end)' numErrorDataPtsAlt05(12:end)'])
xlim([2.75 5])
set(gca,'XTickLabel',[3 4 5])
set(gca,'YTick',[20 40 60 80])
set(gca,'fontsize',14)
xlabel('H_s (m)')
legend('Inner','Middle','Outer')


%% Grid RMSE by depth & wave height bins
%can't calculate RMSE until you know which data goes into which bins so use
%roundgridavg to save a cell array of cBathy-altimeter error pairs, then calculate RMSE for
%each bin (actually just tell roundgridfun to do this using the function
%input

allAlt=[Alt03.ZcBathyTinterp; Alt04.ZcBathyTinterp; Alt05.ZcBathyTinterp];
allAltSource=[ones(length(Alt03.ZcBathyTinterp),1).*3; ones(length(Alt04.ZcBathyTinterp),1).*4; ones(length(Alt05.ZcBathyTinterp),1).*5];
allcBathyKF=[-Alt03.cBathy.depthKF; -Alt04.cBathy.depthKF; -Alt05.cBathy.depthKF];
allcBathyfC=[-Alt03.cBathy.depthfC; -Alt04.cBathy.depthfC; -Alt05.cBathy.depthfC];
allcBathyfC(allcBathyfC>0)=nan;allcBathyfC(allcBathyfC<-20)=nan;
allcBathyCIKF=[Alt03.cBathy.depthKFError; Alt04.cBathy.depthKFError; Alt05.cBathy.depthKFError];
allcBathyCIfC=[Alt03.cBathy.depthErrorfC; Alt04.cBathy.depthErrorfC; Alt05.cBathy.depthErrorfC];
allcBathyCIfC(allcBathyCIfC<0)=nan;
allcBathyCIfC(allcBathyCIfC>10)=nan;
allErrorsKF=allcBathyKF-allAlt;
allErrorsfC=allcBathyfC-allAlt;
allWaveHs=[waveHscBathyTime; waveHscBathyTime; waveHscBathyTime];

%clean up any nans
goodData=intersect(find(~isnan(allAlt)),find(~isnan(allWaveHs)));%only altimeters or waveHs should have NaNs;
allAlt=allAlt(goodData);
allAltSource=allAltSource(goodData);
allcBathyKF=allcBathyKF(goodData);
allErrorsKF=allErrorsKF(goodData);
allErrorsfC=allErrorsfC(goodData);
allWaveHs=allWaveHs(goodData);
allcBathyCIKF=allcBathyCIKF(goodData);
allcBathyCIfC=allcBathyCIfC(goodData);

%define grid
[waveGrid,depthGrid]=meshgrid([0:0.25:5],[-4.75:0.25:-1.5]);

% %grid & calc RMSE roundgridfun didn't work????? 
%  [RMSEgrd,numpts]=roundgridfun(allWaveHs,allAlt,allErrors,waveGrid,depthGrid,@rms);
%  [BIASgrd,numpts]=roundgridfun(allWaveHs,allAlt,allErrors,waveGrid,depthGrid,@mean);
%  numptsDisplay=numpts;numptsDisplay(numpts<1)=NaN;
% 
%  figure;
% subplot(1,3,1)
% pcolor(waveGrid,depthGrid,RMSEgrd);shading interp;colormap('jet');hold on
% caxis([0 2.5])
% xlabel('Wave Height (m)')
% ylabel('Elevation (m)')
% c=colorbar;c.Label.String='RMSE (m)';c.Label.Rotation=270;c.Label.VerticalAlignment='Bottom';
% plot([0 5],-[0 5/0.78],'k')
% legend('RMSE','\gamma = 0.78')
% 
% subplot(1,3,2)
% pcolor(waveGrid,depthGrid,BIASgrd);shading interp;colormap('jet');hold on
% caxis([-3 1])
% xlabel('Wave Height (m)')
% set(gca,'YTickLabel',[])
% c=colorbar;c.Label.String='BIAS (m)';c.Label.Rotation=270;c.Label.VerticalAlignment='Bottom';
% plot([0 5],-[0 5/0.78],'k')
% legend('BIAS','\gamma = 0.78')
% 
% subplot(1,3,3)
% pcolor(waveGrid,depthGrid,numptsDisplay);shading interp;colormap('jet');hold on
% xlabel('Wave Height (m)')
% set(gca,'YTickLabel',[])
% c=colorbar;c.Label.String='# of Observations';c.Label.Rotation=270;c.Label.VerticalAlignment='Bottom';
% plot([0 5],-[0 5/0.78],'k')
% legend('# of Observations','\gamma = 0.78')
% caxis([0 100])
% 
% figure;
% pcolor(waveGrid,depthGrid,numpts);shading flat;colormap('jet');hold on


%% Evaluate observed errors relative to CI for each depth vs wave height bin
waveBins=[0:0.25:5];
depthBins=[-4.75:0.25:-1.5];

%using variables made above find the indices that meet the criteria, and
%compare errors to confidence intervals
[M,N]=size(waveGrid);
percentCIGoodGridKF=nan(M,N);
percentCIGoodGridfC=nan(M,N);
numPtsGridKF=nan(M,N);
numPtsGridfC=nan(M,N);
rmseGridKF=nan(M,N);
biasGridKF=nan(M,N);
rmseGridfC=nan(M,N);
biasGridfC=nan(M,N);

for m=1:M
    for n=1:N
        indWaves=find(allWaveHs>=(waveBins(n)-0.125) & allWaveHs<(waveBins(n)+0.125)); 
        indDepths=find(allAlt>=(depthBins(m)-0.125) & allAlt<(depthBins(m)+0.125));
        
        ind=intersect(indWaves,indDepths);
        
        if~isempty(ind)
        errorsKF=allErrorsKF(ind);
        errorsfC=allErrorsfC(ind);
        numPtsGridKF(m,n)=sum(~isnan(errorsKF));
        numPtsGridfC(m,n)=sum(~isnan(errorsfC));
        rmseGridKF(m,n)=rms(errorsKF(~isnan(errorsKF)));
        biasGridKF(m,n)=mean(errorsKF(~isnan(errorsKF)));
        rmseGridfC(m,n)=rms(errorsfC(~isnan(errorsfC)));
        biasGridfC(m,n)=mean(errorsfC(~isnan(errorsfC)));
        
        %evaluate confidence interval
        binary=abs(errorsKF)<(allcBathyCIKF(ind).*7);
        percentCIGoodGridKF(m,n)=sum(binary)./length(~isnan(binary));
        binary2=abs(errorsfC)<(allcBathyCIfC(ind));
        percentCIGoodGridfC(m,n)=sum(binary2)./length(~isnan(binary2));
        end
        
        clear errors ind binary*
    
    end
end

%% Plot Figure
f=figure('Units','centimeters','Position',[15 15 19 12]);
%[axg,axh] = axgrid(3,3,0.025,0.025,0.1,0.9,0.07,0.9);

%axg(1);
ax1=axes('Position',[0.08 0.71 0.22 0.25]);
pcolor(waveGrid,depthGrid,rmseGridfC);shading interp;colormap('jet');hold on
caxis([0 3])
set(gca,'XTickLabel',[])
%ylabel('Elevation (m)')
%c=colorbar;c.Label.String='RMSE (m)';c.Label.Rotation=270;c.Label.VerticalAlignment='Bottom';
plot([0 5],-[0 5/0.78],'k')
%legend('RMSE','\gamma = 0.78')
xlim([0 4.25])

%axg(2);
ax2=axes('Position',[0.32 0.71 0.22 0.25]);
pcolor(waveGrid,depthGrid,rmseGridKF);shading interp;colormap('jet');hold on;plot([0 5],-[0 5/0.78],'k')
caxis([0 3])
%xlabel('Wave Height (m)')
xlim([0 4.25])
set(ax2,'XTick',[0 1 2 3 4],'XTickLabel',[],'YTickLabel',[])
c=colorbar;c.Label.String='RMSE (m)';c.Label.Rotation=270;c.Label.VerticalAlignment='Bottom';c.Position=[0.55 0.71 0.02 0.25];
%[hc,hax] = bigcolorbarax(axg(2), 0.03, 0.02, 'RMSE (m)');
%legend('RMSE','\gamma = 0.78')

%axg(3)
ax3=axes('Position',[0.73 0.71 0.22 0.25]);
plot(ax3,waveBins(2:end)-0.125,rmseWaveBinsALL,'b.','markersize',20);hold(ax3,'on')
plot(ax3,waveBins(2:end)-0.125,rmseWaveBinsALLfC,'r.','markersize',20);
xlim(ax3,[0 4.5]);
set(ax3,'XTickLabel',[],'YTick',[0:2:6]);
ylim(ax3,[0 7])
ylabel('RMSE (m)')

%axg(4);
ax4=axes('Position',[0.08 0.425 0.22 0.25]);
pcolor(ax4,waveGrid,depthGrid,biasGridfC);shading interp;colormap('jet');hold on
caxis([-3 1])
%xlabel('Wave Height (m)')
set(ax4,'XTickLabel',[],'XTick',[0 1 2 3 4])
ylabel('Altimeter Elevation (m)')
%c=colorbar;c.Label.String='BIAS (m)';c.Label.Rotation=270;c.Label.VerticalAlignment='Bottom';
plot([0 5],-[0 5/0.78],'k')
%legend('BIAS','\gamma = 0.78')
xlim([0 4.25])

%axg(5);
ax5=axes('Position',[0.32 0.425 0.22 0.25]);
pcolor(waveGrid,depthGrid,biasGridKF);shading interp;colormap('jet');hold on
caxis([-3 1])
set(ax5,'XTickLabel',[],'YTickLabel',[])
c=colorbar;c.Label.String='Bias (m)';c.Label.Rotation=270;c.Label.VerticalAlignment='Bottom';c.Position=[0.55 0.425 0.02 0.25];
plot([0 5],-[0 5/0.78],'k')
%legend('BIAS','\gamma = 0.78')
%[hc,hax] = bigcolorbarax(axg(6), 0.03, 0.02, 'BIAS (m)');
xlim([0 4.25])

%axg(6)
ax6=axes('Position',[0.73 0.425 0.22 0.25]);
plot(ax6,waveBins(2:end)-0.125,biasWaveBinsALL,'b.','markersize',20);hold(ax6,'on')
plot(ax6,waveBins(2:end)-0.125,biasWaveBinsALLfC,'r.','markersize',20);
xlim(ax6,[0 4.5]);
set(ax6,'XTickLabel',[]);
ylim(ax6,[-6 0.5])
ylabel('Bias (m)')

%axg(7);
ax7=axes('Position',[0.08 0.145 0.22 0.25]);
pcolor(waveGrid,depthGrid,percentCIGoodGridfC);shading interp;colormap('jet');hold on
caxis([0 1])
set(ax7,'XTick',[0 1 2 3 4]);
xlabel('H_s (m)')
%ylabel('Elevation (m)')
%c=colorbar;c.Label.String='% time E_{P3} < \epsilon_{P3}';c.Label.Rotation=270;c.Label.VerticalAlignment='Bottom';
plot([0 5],-[0 5/0.78],'k')
%legend('CI accuracy','\gamma = 0.78')
xlim([0 4.25])

%axg(8);
ax8=axes('Position',[0.32 0.145 0.22 0.25]);
hold off
pcolor(waveGrid,depthGrid,percentCIGoodGridKF);shading interp;colormap('jet');hold on
caxis([0 1])
set(ax8,'XTick',[0 1 2 3 4],'YTickLabel',[])
xlabel('H_s (m)')
c=colorbar;c.Label.String='% time E_{P3} < \epsilon_{P3}';c.Label.Rotation=270;c.Label.VerticalAlignment='Bottom';c.Position=[0.55 0.145 0.02 0.25];
plot([0 5],-[0 5/0.78],'k')
%legend('CI accuracy','\gamma = 0.78')
%[hc,hax] = bigcolorbarax(axg(10), 0.03, 0.02, '% time E_{P3} < \epsilon_{P3}');
xlim([0 4.25])
%set(axg(10),'XTick',[0 1 2 3 4]);

% add bias & RMSE synthesis plots

%axg(9)
ax9=axes('Position',[0.73 0.145 0.22 0.25]);
bar(ax9,bins(2:end)-0.25/2,[numErrorDataPtsAlt03' numErrorDataPtsAlt04' numErrorDataPtsAlt05']);shading flat
set(ax9,'XTick',[0 1 2 3 4],'YScale','log','YTick',[0 1 10 100 1000],'YTickLabel',[0 1 10 10^2 10^3])
xlim(ax9,[0 4.5]);ylim([1 2500])
xlabel(ax9,'H_s (m)')
ylabel(ax9,'# of Observations')

% add scatter plot of altimeter data

% axg([3 4 7 8 11 12]);
% ax1=gca;
% set(ax1,'Position',[0.6 0.1 0.3 0.8]);
f1=figure('Units','centimeters','Position',[15 15 9.5 12]);
mt={'o';'+';'d'};
hold off
for i=3:1:5
scatter(allAlt(allAltSource==i),allcBathyKF(allAltSource==i),10,allWaveHs(allAltSource==i),mt{i-2});hold on
end
plot([-5 -1.5],[-5 -1.5],'k')
xlabel('Altimeter Elevation (m)')
ylabel('$\mathbf{\bar{h}_k (m)}$','Interpreter','latex')
xlim([-5 -1.5]);ylim([-7 -1.5]);
colormap('jet')
c=colorbar(gca,'SouthOutside');c.Label.String='Wave Height (m)';c.Label.VerticalAlignment='Bottom';
legend('Inner','Middle','Outer')

f2=figure('Units','centimeters','Position',[15 15 9.5 12]);
mt={'o';'+';'d'};
hold off
for i=3:1:5
scatter(allAlt(allAltSource==i),allcBathyKF(allAltSource==i),10,allWaveHs(allAltSource==i)./-allAlt(allAltSource==i),mt{i-2});hold on
end
plot([-5 -1.5],[-5 -1.5],'k')
xlabel('Altimeter Elevation (m)')
ylabel('$\mathbf{\bar{h}_k (m)}$','Interpreter','latex')
xlim([-5 -1.5]);ylim([-7 -1.5]);
colormap('jet')
c=colorbar(gca,'SouthOutside');c.Label.String='H/h';c.Label.VerticalAlignment='Bottom';
legend('Inner','Middle','Outer')

%subplot(2,4,8)
%subplot(4,2,8)
% axg(8);
% pcolor(waveGrid,depthGrid,numPtsGridKF);shading interp;colormap('jet');hold on
% xlabel('Wave Height (m)')
% set(gca,'YTickLabel',[])
% %c=colorbar;c.Label.String='# of Observations';c.Label.Rotation=270;c.Label.VerticalAlignment='Bottom';
% plot([0 5],-[0 5/0.78],'k')
% %legend('# of Phase 3 Solutions','\gamma = 0.78')
% caxis([0 100])
% [hc,hax] = bigcolorbarax(axg(8), 0.05, 0.1, '# of Observations');

