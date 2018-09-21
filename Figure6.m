%figure 6
%load Figure6Data.mat
load('D:\Kate\Dropbox\BathyDuck\MatFiles\Figure6Data.mat')

Figure6Data.Alt03depth=Figure6Data.Alt03depth+-0.18;
Figure6Data.Alt04depth=Figure6Data.Alt04depth+-0.015;
Figure6Data.Alt05depth=Figure6Data.Alt05depth+-0.08;

f=figure(6);clf
fsz = 12; % fontsize
set(0,'DefaultAxesFontSize',fsz);
set(0,'DefaultTextFontSize',fsz);
set(0,'DefaultLineLineWidth',2.5);

 %Outer Surf Altimer
 ax1=axes('Position',[0.1 .8 0.8 0.16]);
 C3=plot(ax1,Figure6Data.CB05time,Figure6Data.CB05depth,'b'); hold on 
 A3=plot(ax1,Figure6Data.Alt05time,Figure6Data.Alt05depth,'color',[1 0 0]);
 %A3=plot(gca,Figure6Data.Alt05time,Figure6Data.Alt05depth,'color',[1 0
 %0]);%plots adjusted cBathy
 hold on
 datetick('x')
 set(ax1,'XTickLabel','')
 %ylabel({'Elevation'; '(m, NAVD88)'})
 %title('Outer Surf - 300 m')
 %grid on 
 ylim([-7 -2])
 xlim([7.36238e+05  7.36574e+05])
 legend([A3,C3],'Altimeter','cBathy','Location','southeast')
 annotation(f,'textbox',...
    [0.870125 0.933275462962963 0.0310285087719299 0.0338078703703706],...
    'String',{'A'},...
    'LineStyle','none',...
    'FontSize',12,...
    'FontName','Arial',...
    'FitBoxToText','off');
 
 %Mid-Surf Altimeter
 ax2=axes('Position',[0.1 .62 0.8 0.16]);
 C4=plot(ax2,Figure6Data.CB04time,Figure6Data.CB04depth,'b');hold on 
 A4=plot(ax2,Figure6Data.Alt04time,Figure6Data.Alt04depth,'color',[1 0 0]);
 hold on
 datetick('x')
 set(ax2,'XTickLabel','')
 ylabel({'Elevation (m, NAVD88)'})
 ylim([-6 -1])
 xlim([7.36238e+05  7.36574e+05])
 annotation(f,'textbox',...
    [0.870125 0.753275462962963 0.0310285087719299 0.0338078703703706],...
    'String',{'B'},...
    'LineStyle','none',...
    'FontSize',12,...
    'FontName','Arial',...
    'FitBoxToText','off');
 
 %Inner-Surf Altimeter
 ax3=axes('Position',[0.1 .44 0.8 0.16]);
 C5=plot(ax3,Figure6Data.CB03time,Figure6Data.CB03depth,'b'); hold on 
 A5=plot(ax3,Figure6Data.Alt03time,Figure6Data.Alt03depth,'color',[1 0 0]);
 A5=plot(gca,Figure6Data.Alt03time,Figure6Data.Alt03depth,'color',[1 0 0]);
 hold on
 datetick('x')
 %title('Inner Surf - 150 m')
 %ylabel({'Elevation'; '(m, NAVD88)'})
 ylim([-6 -1])
 xlim([7.36238e+05  7.36574e+05])
  set(ax3,'XTickLabel','')
   annotation(f,'textbox',...
    [0.870125 0.573275462962963 0.0310285087719299 0.0338078703703706],...
    'String',{'C'},...
    'LineStyle','none',...
    'FontSize',12,...
    'FontName','Arial',...
    'FitBoxToText','off');
 
 
 %Wave Height
 ax4=axes('Position',[0.1 .26 0.8 0.16]);
 plot(ax4,Figure6Data.wTime,Figure6Data.wHeight,'k')
 %title('Wave Height')
 ylabel(ax4,'Hs_{17m} (m)')
 datetick('x')
 set(ax4,'YTick',[0 1 2 3 4 5],'XTickLabel','')
 ylim([0 5])
    annotation(f,'textbox',...
    [0.870125 0.393275462962963 0.0310285087719299 0.0338078703703706],...
    'String',{'D'},...
    'LineStyle','none',...
    'FontSize',12,...
    'FontName','Arial',...
    'FitBoxToText','off');
 
 %Timex Timestack
 ax5=axes('Position',[0.1 .08 0.8 0.16]);
 pcolor(ax5,timexDate,xTimex,timexStackBW2DeSpiked);shading flat;hold on
 colormap('gray')
 plot(ax5,[timexDate(1) timexDate(end)],[150 150],'r:');
 plot(ax5,[timexDate(1) timexDate(end)],[200 200],'r:');
 plot(ax5,[timexDate(1) timexDate(end)],[300 300],'r:');
 plot(ax5,timexDate,xoSandBar2NaN,'k','linewidth',2);
 xlim([7.36238e+05  7.36574e+05])
 ylim([50 400])
 %title('Timex Intensity')
 datetick('x','keeplimits')
 ylabel('Cross-Shore (m)')
    annotation(f,'textbox',...
    [0.870125 0.213275462962963 0.0310285087719299 0.0338078703703706],...
    'String',{'E'},...
    'LineStyle','none',...
    'FontSize',12,...
    'FontName','Arial',...
    'FitBoxToText','off');
 
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