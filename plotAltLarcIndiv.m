for i=1:length(allAltNames)
    
   figure
    
    eval(['t=compAltSurvey.' allAltNames{i} '.tLARC;']);
    eval(['z=compAltSurvey.' allAltNames{i} '.zLARC;']);
    eval(['alt=compAltSurvey.' allAltNames{i} '.zInstAlt;']);
    z(isnan(alt))=nan;
    
    if ismember(i,1:3)
        eval(['time=' allAltNames{i} '.time;']);
        eval(['seafloorLoc=' allAltNames{i} '.elevKF;']);
        plot(time,seafloorLoc,'.','markersize',6,'color',colors(i,:));  
    else
        eval(['time=' allAltNames{i} '.time;']);
        eval(['seafloorLoc=' allAltNames{i} '.seafloorLoc;']);
        plot(time,seafloorLoc,'.','markersize',6,'color',colors(i,:));   
    end
    hold on
    plot(t,z,'o','markerfacecolor',colors(i,:),'markersize',10,'markeredgecolor','k')
    
    title([allAltNames{i} ' BathyDuck Elevations Through Time'],'fontsize',14)
    xlabel('Time (Days)','fontsize',14)
    ylabel('Elevation (m, NAVD88)','fontsize',14)
    datetick('x','mmm-dd','keeplimits')
    ylim([nanmean(seafloorLoc)-1 nanmean(seafloorLoc)+1.5])
    set(gca,'fontsize',14)
    
    legend('Altimeter','LARC','Location','southwest')
    
    saveas(gcf,['D:\Kate\Dropbox\BathyDuck\Plots\' allAltNames{i} '_BathyDuck_AltLARCcomp.fig']);
    saveas(gcf,['D:\Kate\Dropbox\BathyDuck\Plots\' allAltNames{i} '_BathyDuck_AltLARCcomp.png']);

end