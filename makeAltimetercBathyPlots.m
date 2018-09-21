%plot Altimeter vs. cBathy comparison Plots
%need: Alt03, Alt04, Alt05 structures

%Figure 1: plot cBathy vs Altimeter scatter plots colored by wave height in
%17m

f=figure(1);
clf
fsz = 14; % fontsize
set(0,'DefaultAxesFontSize',fsz);
set(0,'DefaultTextFontSize',fsz);
set(0,'DefaultLineLineWidth',2);

ax1=axes('Position',[0.1 0.72 0.4 0.25]);
scatter(-Alt03.cBathy.depthfC,Alt03.ZcBathyT,15,Alt03.waveHs17m,'filled');
colormap('jet')
xlim([-7 -1]);ylim([-5 -1])
hold on
plot([-7 -1],[-7 -1],'k:')
title('Inner Surf - g150')
set(ax1,'XTickLabel','')

ax2=axes('Position',[0.56 0.72 0.4 0.25]);
scatter(-Alt03.cBathy.depthKF,Alt03.ZcBathyT,15,Alt03.waveHs17m,'filled');
colormap('jet')
xlim([-7 -1]);ylim([-5 -1])
hold on
plot([-7 -1],[-7 -1],'k:')
title('Inner Surf - g150')
set(ax2,'XTickLabel','')
set(ax2,'YTickLabel','')

ax3=axes('Position',[0.1 0.44 0.4 0.25]);
scatter(-Alt04.cBathy.depthfC,Alt04.ZcBathyT,15,Alt04.waveHs17m,'filled');
colormap('jet')
xlim([-7 -1]);ylim([-5 -1])
hold on
plot([-7 -1],[-7 -1],'k:')
title('Mid Surf - g200')
set(ax3,'XTickLabel','')
ylabel('Altimeter (m)')

ax4=axes('Position',[0.56 0.44 0.4 0.25]);
scatter(-Alt04.cBathy.depthKF,Alt04.ZcBathyT,15,Alt04.waveHs17m,'filled');
colormap('jet')
xlim([-7 -1]);ylim([-5 -1])
hold on
plot([-7 -1],[-7 -1],'k:')
title('Mid Surf - g200')
set(ax4,'XTickLabel','')
set(ax4,'YTickLabel','')

ax5=axes('Position',[0.1 0.16 0.4 0.25]);
scatter(-Alt05.cBathy.depthfC,Alt05.ZcBathyT,15,Alt05.waveHs17m,'filled');
colormap('jet')
xlim([-7 -1]);ylim([-5 -1])
hold on
plot([-7 -1],[-7 -1],'k:')
title('Outer Surf - g300')
xlabel('cBathy Phase 2 (m)')

ax6=axes('Position',[0.56 0.16 0.4 0.25]);
scatter(-Alt05.cBathy.depthKF,Alt05.ZcBathyT,15,Alt05.waveHs17m,'filled');
colormap('jet')
xlim([-7 -1]);ylim([-5 -1])
hold on
plot([-7 -1],[-7 -1],'k:')
title('Outer Surf - g300')
set(ax6,'YTickLabel','')
xlabel('cBathy Phase 3 (m)')

c=colorbar('Location','southoutside');
c.Position=[0.2 0.06 0.6 0.025];
c.Label.String='Wave Height (m)';

%Figure 2: plot cBathy & Altimeter Histograms

%Figure 3: plot cBathy predicted errors vs. observed errors colored by wave
%height

f=figure(2);
clf
fsz = 14; % fontsize
set(0,'DefaultAxesFontSize',fsz);
set(0,'DefaultTextFontSize',fsz);
set(0,'DefaultLineLineWidth',2);

ax1=axes('Position',[0.1 0.72 0.4 0.25]);
scatter(Alt03.cBathy.depthErrorfC,abs(-Alt03.cBathy.depthfC-Alt03.ZcBathyT'),15,Alt03.waveHs17m,'filled');
colormap('jet')
xlim([0 3]);ylim([0 3])
hold on
plot([0 3],[0 3],'k:')
title('Inner Surf - g150')
set(ax1,'XTickLabel','')

ax2=axes('Position',[0.56 0.72 0.4 0.25]);
scatter(Alt03.cBathy.depthKFError*7,abs(-Alt03.cBathy.depthKF-Alt03.ZcBathyT'),15,Alt03.waveHs17m,'filled');
colormap('jet')
xlim([0 3]);ylim([0 3])
hold on
plot([0 3],[0 3],'k:')
title('Inner Surf - g150')
set(ax2,'XTickLabel','')
set(ax2,'YTickLabel','')

ax3=axes('Position',[0.1 0.44 0.4 0.25]);
scatter(Alt04.cBathy.depthErrorfC,abs(-Alt04.cBathy.depthfC-Alt04.ZcBathyT'),15,Alt04.waveHs17m,'filled');
colormap('jet')
xlim([0 3]);ylim([0 3])
hold on
plot([0 3],[0 3],'k:')
title('Mid Surf - g200')
set(ax3,'XTickLabel','')
ylabel('Observed Error:  |z_{cBathy} - z_{altimeter}| (m)')

ax4=axes('Position',[0.56 0.44 0.4 0.25]);
scatter(Alt04.cBathy.depthKFError.*7,abs(-Alt04.cBathy.depthKF-Alt04.ZcBathyT'),15,Alt04.waveHs17m,'filled');
colormap('jet')
xlim([0 3]);ylim([0 3])
hold on
plot([0 3],[0 3],'k:')
title('Mid Surf - g200')
set(ax4,'XTickLabel','')
set(ax4,'YTickLabel','')

ax5=axes('Position',[0.1 0.16 0.4 0.25]);
scatter(Alt05.cBathy.depthErrorfC,abs(-Alt05.cBathy.depthfC-Alt05.ZcBathyT'),15,Alt05.waveHs17m,'filled');
colormap('jet')
xlim([0 3]);ylim([0 3])
hold on
plot([0 3],[0 3],'k:')
title('Outer Surf - g300')
xlabel('cBathy Phase 2 Errors (m)')

ax6=axes('Position',[0.56 0.16 0.4 0.25]);
scatter(Alt05.cBathy.depthKFError.*7,abs(-Alt05.cBathy.depthKF-Alt05.ZcBathyT'),15,Alt05.waveHs17m,'filled');
colormap('jet')
xlim([0 3]);ylim([0 3])
hold on
plot([0 3],[0 3],'k:')
title('Outer Surf - g300')
set(ax6,'YTickLabel','')
xlabel('cBathy Phase 3 Errors *7 (m)')

c=colorbar('Location','southoutside');
c.Position=[0.2 0.06 0.6 0.025];
c.Label.String='Wave Height (m)';

%Figure 4: plot waveheight vs observed errors for inner and outer altimeter

f=figure(4);
clf
fsz = 14; % fontsize
set(0,'DefaultAxesFontSize',fsz);
set(0,'DefaultTextFontSize',fsz);
set(0,'DefaultLineLineWidth',2);

ax1=axes('Position',[0.11 0.55 0.8 0.4]);
plot(Alt03.waveHs17m,abs(-Alt03.cBathy.depthKF-Alt03.ZcBathyT'),'b.')
xlim([0 5]);ylim([0 3])
% plot(Alt03.waveHs17m,-Alt03.cBathy.depthKF-Alt03.ZcBathyT','b.')
% xlim([0 5]);ylim([-3 3])
title('Inner Surf - g150')
set(ax1,'XTickLabel','')

ax2=axes('Position',[0.11 0.10 0.8 0.4]);
plot(Alt05.waveHs17m,abs(-Alt05.cBathy.depthKF-Alt05.ZcBathyT'),'b.')
xlim([0 5]);ylim([0 3])
% plot(Alt05.waveHs17m,-Alt05.cBathy.depthKF-Alt05.ZcBathyT','b.')
% xlim([0 5]);ylim([-3 3])
title('Outer Surf - g300')
xlabel('Hs_{17m} (m)')
ylabel('Observed Error:  |z_{cBathy} - z_{altimeter}| (m)')
%ylabel('Observed Error:  z_{cBathy} - z_{altimeter} (m)')

%Figure 4: plot waveheight vs observed too depp errors for inner and outer 
%altimeter

Alt03errors=(-Alt03.cBathy.depthKF)-Alt03.ZcBathyT';
Alt05errors=(-Alt05.cBathy.depthKF)-Alt05.ZcBathyT';

%Alt03errors(Alt03errors>0)=nan;
%Alt05errors(Alt05errors>0)=nan;

f=figure(5);
clf
fsz = 14; % fontsize
set(0,'DefaultAxesFontSize',fsz);
set(0,'DefaultTextFontSize',fsz);
set(0,'DefaultLineLineWidth',2);

ax1=axes('Position',[0.11 0.55 0.8 0.4]);
plot(Alt03.waveHs17m,Alt03errors,'b.')
xlim([0 5]);ylim([-3 0])
% plot(Alt03.waveHs17m,-Alt03.cBathy.depthKF-Alt03.ZcBathyT','b.')
% xlim([0 5]);ylim([-3 3])
title('Inner Surf - g150')
set(ax1,'XTickLabel','')

ax2=axes('Position',[0.11 0.10 0.8 0.4]);
plot(Alt05.waveHs17m,Alt05errors,'b.')
xlim([0 5]);ylim([-3 0])
% plot(Alt05.waveHs17m,-Alt05.cBathy.depthKF-Alt05.ZcBathyT','b.')
% xlim([0 5]);ylim([-3 3])
title('Outer Surf - g300')
xlabel('Hs_{17m} (m)')
ylabel('Observed Deep Errors:  z_{cBathy} - z_{altimeter} (m)')
%ylabel('Observed Error:  z_{cBathy} - z_{altimeter} (m)')

