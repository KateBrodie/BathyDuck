%% Compare bottom elevation values

allAltNames={'Alt03' 'Alt04' 'Alt05' 'p04' 'p11' 'p12' 'p13' 'p14' 'p22' 'p23' 'p24'};

%first extract data at corresponding times
for i=1:length(allAltNames)
    %get necessary variables
    eval(['x=' allAltNames{i} '.x;']);
    eval(['y=' allAltNames{i} '.y;']);
    eval(['time=' allAltNames{i} '.time;']);
    if ismember(i,1:3)
        eval(['z=' allAltNames{i} '.elevKF;']);
    else
        eval(['z=' allAltNames{i} '.seafloorLoc;']);
    end
    
    %extract LARC Survey elevations & time at altimeter x,y,s
    for l=1:length(larcData.surveyDates)
        %get scattered interpolant
        zLARC(l)=larcData.data{l}.scatteredIntZ(x,y);
        tLARC(l)=larcData.data{l}.scatteredIntT(x,y);
        [~,d]=dsearchn([x y],[larcData.data{l}.x larcData.data{l}.y]);
        dist2LARCpt(l)=min(d);
    end
    dist2LARCpt(isnan(zLARC))=nan;
    eval(['compAltSurvey.' allAltNames{i} '.zLARC=zLARC;']);
    eval(['compAltSurvey.' allAltNames{i} '.tLARC=tLARC;']);
    eval(['compAltSurvey.' allAltNames{i} '.dist2LARCpt=dist2LARCpt;']);
    
    %extract Altimeter elevations at Larc times 
    
    %first instantaneous altimeter elevation when the LARC was nearby
    zInstAlt=interp1(time,z,tLARC);
    
    %1hr average (30 minutes either side) & 24 hr average (12 hours either
    %side)
    for l=1:length(larcData.surveyDates)
        ind1hr=find(abs(time-tLARC(l))<=(30./60./24));
        z1hrAlt(l)=nanmean(z(ind1hr));
        ind24hr=find(abs(time-tLARC(l))<=(12/24));
        z24hrAlt(l)=nanmean(z(ind24hr));        
        clear ind1hr ind24hr 
    end
    
    eval(['compAltSurvey.' allAltNames{i} '.zInstAlt=zInstAlt;']);
    eval(['compAltSurvey.' allAltNames{i} '.z1hrAlt=z1hrAlt;']);
    eval(['compAltSurvey.' allAltNames{i} '.z24hrAlt=z24hrAlt;']);
    
    clear seafloorLoc time tLARC x y z zLARC ind1hr ind24hr z1hrAlt z24hrAlt zInstAlt d dist2LARCpt
end

%% Plot Comparisons &Calculate Statistics
figure
colormap(jet)
for i=1:length(allAltNames)

%get vars out of structure for each altimeter
eval(['zLARC=compAltSurvey.' allAltNames{i} '.zLARC;']);
eval(['zInstAlt=compAltSurvey.' allAltNames{i} '.zInstAlt;']);
eval(['z1hrAlt=compAltSurvey.' allAltNames{i} '.z1hrAlt;']);
eval(['z24hrAlt=compAltSurvey.' allAltNames{i} '.z24hrAlt;']);
eval(['dist2LARCpt=compAltSurvey.' allAltNames{i} '.dist2LARCpt;']);

if i==1
    zLARCAll=zLARC;
    zInstAltAll=zInstAlt;
    z1hrAltAll=z1hrAlt;
    z24hrAltAll=z24hrAlt;
    distAll=dist2LARCpt;
else
    zLARCAll=[zLARCAll zLARC];
    zInstAltAll=[zInstAltAll zInstAlt];
    z1hrAltAll=[z1hrAltAll z1hrAlt];
    distAll=[distAll dist2LARCpt];
    z24hrAltAll=[z24hrAltAll z24hrAlt];
end

colors=[0 0 0; 112/256 138/256 144/256; 0.82 0.83 0.78; colorsBS];

%calcualte statistics
LMinst=fitlm(zLARCAll,zInstAltAll);
LM1hr=fitlm(zLARCAll,z1hrAltAll);
LM24hr=fitlm(zLARCAll,z24hrAltAll);


subplot(1,3,1)
axis equal
plot(zLARC,zInstAlt,'*','color',colors(i,:))
hold on
%scatter(zLARCAll,zInstAltAll,15,distAll,'o','filled');hold on
plot([-5 0],[-5 0],'k')
xlim([-5 0]);ylim([-5 0]);
ylabel('Altimeter Elevation (m, NAVD88)','fontsize',14)
title({'Instantaneous Altimeter Average';['RMSE = ' sprintf('%.2f',LMinst.RMSE)]},'fontsize',14)
set(gca,'fontsize',14);

subplot(1,3,2)
axis equal
plot(zLARC,z1hrAlt,'*','color',colors(i,:))
hold on
%scatter(zLARCAll,z1hrAltAll,15,distAll,'o','filled'); hold on
plot([-5 0],[-5 0],'k')
xlim([-5 0]);ylim([-5 0]);
xlabel('LARC Elevation (m, NAVD88)','fontsize',14)
title({'1 Hr Altimeter Average';['RMSE = ' sprintf('%.2f',LM1hr.RMSE)]},'fontsize',14)
set(gca,'fontsize',14);

subplot(1,3,3)
axis equal
plot(zLARC,z1hrAlt,'*','color',colors(i,:))
hold on
%scatter(zLARCAll,z24hrAltAll,15,distAll,'o','filled'); hold on

xlim([-5 0]);ylim([-5 0]);
title({'24 Hr Altimeter Average';['RMSE = ' sprintf('%.2f',LM24hr.RMSE)]},'fontsize',14)
set(gca,'fontsize',14);
legend(allAltNames)
if i==length(allAltNames)
    plot([-5 0],[-5 0],'k')
end
end


