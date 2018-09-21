%Replicates Figure 5 from Brodie et al. 2018 for Bak et al. 
%load('D:\Kate\Dropbox\BathyDuck\FinalAltimeterData4THREDDS_SpikeData.mat')
%load('D:\Kate\GitHub\BathyDuck\altimeterData4Spike1.mat')

%trim data to time of interest (01 Oct 2015 to 01 Sep 2016)
%Alt05
Alt05.timeTrim=Alt05.time(Alt05.time>datenum(2015,10,1) & Alt05.time<datenum(2016,9,1));
Alt05.zTrim = Alt05.seafloorLoc(Alt05.time>datenum(2015,10,1) & Alt05.time<datenum(2016,9,1));
[~,ind]=unique(Alt05.timeTrim,'stable');
Alt05.zTrim = Alt05.zTrim(ind);
Alt05.timeTrim = Alt05.timeTrim(ind);

Alt05.cBathyKF.depthTrim = Alt05.cBathyKF.depthKF(Alt05.cBathyKF.time>datenum(2015,10,1) & Alt05.cBathyKF.time<datenum(2016,9,1));
Alt05.cBathyKF.time = Alt05.cBathyKF.time(Alt05.cBathyKF.time>datenum(2015,10,1) & Alt05.cBathyKF.time<datenum(2016,9,1));
Alt05.cBathyKFT.depthTrim = Alt05.cBathyKFT.depthKF(Alt05.cBathyKFT.time>datenum(2015,10,1) & Alt05.cBathyKFT.time<datenum(2016,9,1));
Alt05.cBathyKFT.time = Alt05.cBathyKFT.time(Alt05.cBathyKFT.time>datenum(2015,10,1) & Alt05.cBathyKFT.time<datenum(2016,9,1));

%Alt04
Alt04.zTrim = Alt04.seafloorLoc(Alt04.time>datenum(2015,10,1) & Alt04.time<datenum(2016,9,1));
Alt04.timeTrim = Alt04.time(Alt04.time>datenum(2015,10,1) & Alt04.time<datenum(2016,9,1));
[~,ind]=unique(Alt04.timeTrim,'stable');
Alt04.zTrim = Alt04.zTrim(ind);
Alt04.timeTrim = Alt04.timeTrim(ind);

Alt04.cBathyKF.depthTrim = Alt04.cBathyKF.depthKF(Alt04.cBathyKF.time>datenum(2015,10,1) & Alt04.cBathyKF.time<datenum(2016,9,1));
Alt04.cBathyKF.time = Alt04.cBathyKF.time(Alt04.cBathyKF.time>datenum(2015,10,1) & Alt04.cBathyKF.time<datenum(2016,9,1));
Alt04.cBathyKFT.depthTrim = Alt04.cBathyKFT.depthKF(Alt04.cBathyKFT.time>datenum(2015,10,1) & Alt04.cBathyKFT.time<datenum(2016,9,1));
Alt04.cBathyKFT.time = Alt04.cBathyKFT.time(Alt04.cBathyKFT.time>datenum(2015,10,1) & Alt04.cBathyKFT.time<datenum(2016,9,1));

%Alt03
Alt03.zTrim = Alt03.seafloorLoc(Alt03.time>datenum(2015,10,1) & Alt03.time<datenum(2016,9,1));
Alt03.timeTrim = Alt03.time(Alt03.time>datenum(2015,10,1) & Alt03.time<datenum(2016,9,1));
[~,ind]=unique(Alt03.timeTrim,'stable');
Alt03.zTrim = Alt03.zTrim(ind);
Alt03.timeTrim = Alt03.timeTrim(ind);

Alt03.cBathyKF.depthTrim = Alt03.cBathyKF.depthKF(Alt03.cBathyKF.time>datenum(2015,10,1) & Alt03.cBathyKF.time<datenum(2016,9,1));
Alt03.cBathyKF.time = Alt03.cBathyKF.time(Alt03.cBathyKF.time>datenum(2015,10,1) & Alt03.cBathyKF.time<datenum(2016,9,1));
Alt03.cBathyKFT.depthTrim = Alt03.cBathyKFT.depthKF(Alt03.cBathyKFT.time>datenum(2015,10,1) & Alt03.cBathyKFT.time<datenum(2016,9,1));
Alt03.cBathyKFT.time = Alt03.cBathyKFT.time(Alt03.cBathyKFT.time>datenum(2015,10,1) & Alt03.cBathyKFT.time<datenum(2016,9,1));

%interpolate altimeter data to cBathy times
Alt05.ZcBathyKF = interp1 (Alt05.timeTrim,Alt05.zTrim,Alt05.cBathyKF.time);
Alt05.ZcBathyKFT = interp1 (Alt05.timeTrim,Alt05.zTrim,Alt05.cBathyKFT.time);
Alt04.ZcBathyKF = interp1 (Alt04.timeTrim,Alt04.zTrim,Alt04.cBathyKF.time);
Alt04.ZcBathyKFT = interp1 (Alt04.timeTrim,Alt04.zTrim,Alt04.cBathyKFT.time);
Alt03.ZcBathyKF = interp1 (Alt03.timeTrim,Alt03.zTrim,Alt03.cBathyKF.time);
Alt03.ZcBathyKFT = interp1 (Alt03.timeTrim,Alt03.zTrim,Alt03.cBathyKFT.time);

%calculate statistics
Alt05.cBathyKF.bias = nanmean(abs(-Alt05.cBathyKF.depthTrim-Alt05.ZcBathyKF));
Alt05.cBathyKF.nonNanData = find(~isnan(Alt05.ZcBathyKF) & ~isnan(Alt05.cBathyKF.depthTrim));
Alt05.cBathyKF.rmse = sqrt(nansum((-Alt05.cBathyKF.depthTrim-Alt05.ZcBathyKF).^2)./length(Alt05.cBathyKF.nonNanData));
Alt05.cBathyKFT.bias = nanmean(abs(-Alt05.cBathyKFT.depthTrim-Alt05.ZcBathyKFT));
Alt05.cBathyKFT.nonNanData = find(~isnan(Alt05.ZcBathyKFT) & ~isnan(Alt05.cBathyKFT.depthTrim));
Alt05.cBathyKFT.rmse = sqrt(nansum((-Alt05.cBathyKFT.depthTrim-Alt05.ZcBathyKFT).^2)./length(Alt05.cBathyKFT.nonNanData));

Alt04.cBathyKF.bias = nanmean(abs(-Alt04.cBathyKF.depthTrim-Alt04.ZcBathyKF));
Alt04.cBathyKF.nonNanData = find(~isnan(Alt04.ZcBathyKF) & ~isnan(Alt04.cBathyKF.depthTrim));
Alt04.cBathyKF.rmse = sqrt(nansum((-Alt04.cBathyKF.depthTrim-Alt04.ZcBathyKF).^2)./length(Alt04.cBathyKF.nonNanData));
Alt04.cBathyKFT.bias = nanmean(abs(-Alt04.cBathyKFT.depthTrim-Alt04.ZcBathyKFT));
Alt04.cBathyKFT.nonNanData = find(~isnan(Alt04.ZcBathyKFT) & ~isnan(Alt04.cBathyKFT.depthTrim));
Alt04.cBathyKFT.rmse = sqrt(nansum((-Alt04.cBathyKFT.depthTrim-Alt04.ZcBathyKFT).^2)./length(Alt04.cBathyKFT.nonNanData));

Alt03.cBathyKF.bias = nanmean(abs(-Alt03.cBathyKF.depthTrim-Alt03.ZcBathyKF));
Alt03.cBathyKF.nonNanData = find(~isnan(Alt03.ZcBathyKF) & ~isnan(Alt03.cBathyKF.depthTrim));
Alt03.cBathyKF.rmse = sqrt(nansum((-Alt03.cBathyKF.depthTrim-Alt03.ZcBathyKF).^2)./length(Alt03.cBathyKF.nonNanData));
Alt03.cBathyKFT.bias = nanmean(abs(-Alt03.cBathyKFT.depthTrim-Alt03.ZcBathyKFT));
Alt03.cBathyKFT.nonNanData = find(~isnan(Alt03.ZcBathyKFT) & ~isnan(Alt03.cBathyKFT.depthTrim));
Alt03.cBathyKFT.rmse = sqrt(nansum((-Alt03.cBathyKFT.depthTrim-Alt03.ZcBathyKFT).^2)./length(Alt03.cBathyKFT.nonNanData));

%write variables for spike
altimeter300m.cBKF = -Alt05.cBathyKF.depthTrim;
altimeter300m.cBKFT = -Alt05.cBathyKFT.depthTrim;
altimeter300m.cBKFTime = Alt05.cBathyKF.time;
altimeter300m.cBKFTTime = Alt05.cBathyKFT.time;
altimeter300m.altZcBKF = Alt05.ZcBathyKF;
altimeter300m.altZcBKFT = Alt05.ZcBathyKFT;
altimeter300m.altZ = Alt05.zTrim;
altimeter300m.altTime = Alt05.timeTrim;
altimeter300m.residKF = -Alt05.cBathyKF.depthTrim-Alt05.ZcBathyKF;
altimeter300m.residKFT = -Alt05.cBathyKFT.depthTrim-Alt05.ZcBathyKFT;

altimeter200m.cBKF = -Alt04.cBathyKF.depthTrim;
altimeter200m.cBKFT = -Alt04.cBathyKFT.depthTrim;
altimeter200m.cBKFTime = Alt04.cBathyKF.time;
altimeter200m.cBKFTTime = Alt04.cBathyKFT.time;
altimeter200m.altZcBKF = Alt04.ZcBathyKF;
altimeter200m.altZcBKFT = Alt04.ZcBathyKFT;
altimeter200m.altZ = Alt04.zTrim;
altimeter200m.altTime = Alt04.timeTrim;
altimeter200m.residKF = -Alt04.cBathyKF.depthTrim-Alt04.ZcBathyKF;
altimeter200m.residKFT = -Alt04.cBathyKFT.depthTrim-Alt04.ZcBathyKFT;

altimeter150m.cBKF = -Alt03.cBathyKF.depthTrim;
altimeter150m.cBKFT = -Alt03.cBathyKFT.depthTrim;
altimeter150m.cBKFTime = Alt03.cBathyKF.time;
altimeter150m.cBKFTTime = Alt03.cBathyKFT.time;
altimeter150m.altZcBKF = Alt03.ZcBathyKF;
altimeter150m.altZcBKFT = Alt03.ZcBathyKFT;
altimeter150m.altZ = Alt03.zTrim;
altimeter150m.altTime = Alt03.timeTrim;
altimeter150m.residKF = -Alt03.cBathyKF.depthTrim-Alt03.ZcBathyKF;
altimeter150m.residKFT = -Alt03.cBathyKFT.depthTrim-Alt03.ZcBathyKFT;

save altimeterData4Spike.mat altimeter*


%load other figure Data
load('D:\Kate\Dropbox\BathyDuck\MatFiles\Figure6Data.mat')
load('D:\Kate\Dropbox\BathyDuck\MatFiles\Altimeter_cBathy_Structures.mat', 'timexDate')
load('D:\Kate\Dropbox\BathyDuck\MatFiles\Altimeter_cBathy_Structures.mat', 'timexStackBW2DeSpiked')
load('D:\Kate\Dropbox\BathyDuck\MatFiles\Altimeter_cBathy_Structures.mat', 'xoSandBar2NaN')
load('D:\Kate\Dropbox\BathyDuck\BathyDuckArgusLongTSplay_nov2016.mat', 'xTimex')
w26m = load('D:\Kate\Dropbox\BathyDuck\w26m.mat', 'epochtime','Hs');
w17m = load('D:\Kate\Dropbox\BathyDuck\w17m.mat', 'epochtime','Hs');
w17m.time = w17m.epochtime./(60*60*24) + datenum(1970,1,1);
w26m.time = w26m.epochtime./(60*60*24) + datenum(1970,1,1);

% f=figure(5);clf
% fsz = 12; % fontsize
% set(0,'DefaultAxesFontSize',fsz);
% set(0,'DefaultTextFontSize',fsz);
% set(0,'DefaultLineLineWidth',2.5);
% 
% 
%  %Outer Surf Altimer
%  ax1=axes('Position',[0.1 .8 0.8 0.16]);
%  C5=plot(ax1,Alt05.cBathyKF.time,-Alt05.cBathyKF.depthTrim,'c'); hold on
%  CT5=plot(ax1,Alt05.cBathyKFT.time,-Alt05.cBathyKFT.depthTrim,'color',[1 .59 .13]); 
%  A5=plot(ax1,Alt05.timeTrim,Alt05.zTrim,'b');
%  datetick('x')
%  set(ax1,'XTickLabel','','YTick',[-5 -4 -3 -2])
%  %ylabel({'Elevation'; '(m, NAVD88)'})
%  %title('Outer Surf - 300 m')
%  %grid on 
%  ylim([-6 -2])
%  xlim([7.36238e+05  7.36574e+05])
%  legend([A5,C5,CT5],'Altimeter','cBKF','cBKF-T','Location','southeast')
%  annotation(f,'textbox',...
%     [0.870125 0.933275462962963 0.0310285087719299 0.0338078703703706],...
%     'String',{'A'},...
%     'LineStyle','none',...
%     'FontSize',12,...
%     'FontName','Arial',...
%     'FitBoxToText','off');
%  
%  %Mid-Surf Altimeter
%  ax2=axes('Position',[0.1 .62 0.8 0.16]);
%  C4=plot(ax2,Alt04.cBathyKF.time,-Alt04.cBathyKF.depthTrim,'c'); hold on
%  CT4=plot(ax2,Alt04.cBathyKFT.time,-Alt04.cBathyKFT.depthTrim,'color',[1 .59 .13]); 
%  A4=plot(ax2,Alt04.timeTrim,Alt04.zTrim,'b');
%   hold on
%  datetick('x')
%  set(ax2,'XTickLabel','','YTick',[-4 -3 -2 -1])
%  ylabel({'Elevation (m, NAVD88)'})
%  ylim([-5 -1])
%  xlim([7.36238e+05  7.36574e+05])
%  annotation(f,'textbox',...
%     [0.870125 0.753275462962963 0.0310285087719299 0.0338078703703706],...
%     'String',{'B'},...
%     'LineStyle','none',...
%     'FontSize',12,...
%     'FontName','Arial',...
%     'FitBoxToText','off');
%  
%  %Inner-Surf Altimeter
%  ax3=axes('Position',[0.1 .44 0.8 0.16]);
%  C3=plot(ax3,Alt03.cBathyKF.time,-Alt03.cBathyKF.depthTrim,'c'); hold on
%  CT3=plot(ax3,Alt03.cBathyKFT.time,-Alt03.cBathyKFT.depthTrim,'color',[1 .59 .13]); 
%  A3=plot(ax3,Alt03.timeTrim,Alt03.zTrim,'b');
%   hold on
%  datetick('x')
%  %title('Inner Surf - 150 m')
%  %ylabel({'Elevation'; '(m, NAVD88)'})
%  ylim([-5 -1])
%  xlim([7.36238e+05  7.36574e+05])
%   set(ax3,'XTickLabel','','YTick',[-4 -3 -2 -1])
%    annotation(f,'textbox',...
%     [0.870125 0.573275462962963 0.0310285087719299 0.0338078703703706],...
%     'String',{'C'},...
%     'LineStyle','none',...
%     'FontSize',12,...
%     'FontName','Arial',...
%     'FitBoxToText','off');
%  
%  
%  %Wave Height
%  ax4=axes('Position',[0.1 .26 0.8 0.16]);
%  %plot(ax4,Figure6Data.wTime,Figure6Data.wHeight,'k')
%  %title('Wave Height')
%  plot(ax4,w26m.time,w26m.Hs,'k.');hold on
%  plot(ax4,w17m.time,w17m.Hs,'k.');
%  xlim([7.36238e+05  7.36574e+05])
%  ylabel(ax4,'Hs (m)')
%  datetick('x')
%  set(ax4,'YTick',[1 2 3 4 5],'XTickLabel','')
%  ylim([0 5])
%     annotation(f,'textbox',...
%     [0.870125 0.393275462962963 0.0310285087719299 0.0338078703703706],...
%     'String',{'D'},...
%     'LineStyle','none',...
%     'FontSize',12,...
%     'FontName','Arial',...
%     'FitBoxToText','off');
%  
%  %Timex Timestack
%  ax5=axes('Position',[0.1 .08 0.8 0.16]);
%  pcolor(ax5,timexDate,xTimex,timexStackBW2DeSpiked);shading flat;hold on
%  colormap('gray')
%  plot(ax5,[timexDate(1) timexDate(end)],[150 150],'b:');
%  plot(ax5,[timexDate(1) timexDate(end)],[200 200],'b:');
%  plot(ax5,[timexDate(1) timexDate(end)],[300 300],'b:');
%  plot(ax5,timexDate,xoSandBar2NaN,'k','linewidth',2);
%  xlim([7.36238e+05  7.36574e+05])
%  ylim([50 400])
%  %title('Timex Intensity')
%  datetick('x','keeplimits')
%  ylabel('Cross-Shore (m)')
%     annotation(f,'textbox',...
%     [0.870125 0.213275462962963 0.0310285087719299 0.0338078703703706],...
%     'String',{'E'},...
%     'LineStyle','none',...
%     'FontSize',12,...
%     'FontName','Arial',...
%     'FitBoxToText','off');
%  
%  %subplot(5,1,3)
% 
%  hold on 
%  C3=plot(ax3,Figure6Data.CB05time,Figure6Data.CB05depth,'b');
%  A3=plot(ax3,Figure6Data.Alt05time,Figure6Data.Alt05depth,'color',[1 0 0]);
%  hold on
%  datetick('x')
%  set(ax3,'XTickLabel','')
%  %ylabel({'Elevation'; '(m, NAVD88)'})
%  title('Outer Surf - 300 m')
%  grid on 
%  ylim([-7 -2])
%  xlim([7.36238e+05  7.36574e+05])
%  legend([A3,C3],'Altimeter','cBathy','Location','southeast')
%  
%  %subplot(5,1,4)
%  ax4=axes('Position',[0.1 .26 0.8 0.14]);
%  
% 
%  %legend([A4,C4],'g03','cBathy','Location','southeast')
%  
%  
%  %subplot(5,1,5)
%  
% 
%  hold on 
%  C5=plot(ax5,Figure6Data.CB03time,Figure6Data.CB03depth,'b');
%  A5=plot(ax5,Figure6Data.Alt03time,Figure6Data.Alt03depth,'color',[1 0 0]);
%  hold on
%  datetick('x')
%  title('Inner Surf - 150 m')
%  %ylabel({'Elevation'; '(m, NAVD88)'})
%  xlabel('Time')
%  grid on 
%  ylim([-6 -1])
%  xlim([7.36238e+05  7.36574e+05])
%  %legend([A5,C5],'g05','cBathy','Location','southeast')