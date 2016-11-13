%% plot altimeter & larc data at each gauge location through time
figure

colors=[0 0 0; 112/256 138/256 144/256; 0.82 0.83 0.78; colorsBS];
plot(Alt03.time,Alt03.elevKF,'k.','markersize',6);hold all
plot(Alt04.time,Alt04.elevKF,'.','markersize',6,'color',colors(2,:));
plot(Alt05.time,Alt05.elevKF,'.','markersize',6,'color',colors(3,:));

for i=1:length(varNames)
    eval(['time=' varNames{i} '.time;']);
    eval(['seafloorLoc=' varNames{i} '.seafloorLoc;']);
    plot(time,seafloorLoc,'.','markersize',6,'color',colors(i+3,:));
end

hold on
for j=1:length(allAltNames)
    eval(['t=compAltSurvey.' allAltNames{j} '.tLARC;']);
    eval(['z=compAltSurvey.' allAltNames{j} '.zLARC;']);
    eval(['alt=compAltSurvey.' allAltNames{j} '.zInstAlt;']);
    z(isnan(alt))=nan;
    plot(t,z,'o','markerfacecolor',colors(j,:),'markersize',10,'markeredgecolor','k')
end

title('BathyDuck Elevations Through Time','fontsize',14)
xlabel('Time (Days)','fontsize',14)
ylabel('Elevation (m, NAVD88)','fontsize',14)
datetick('x','mmm-dd','keeplimits')
set(gca,'fontsize',14)
legend(allAltNames)