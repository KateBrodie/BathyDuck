%compare predicted speed given the water depth by linear theory to the
%observed wave speed in fdependent results from cBathy

argusFolder='D:\Kate\Dropbox\BathyDuck\Survey\ArgusDataProducts';
%argusFolder='D:\Kate\Dropbox\BathyDuck\Survey\Argus1130dataproducts'
surveyFolder='D:\Kate\Dropbox\BathyDuck\Survey';

cBathyFiles=dir([argusFolder '\*cBathy.mat']);
surveyFiles=dir([surveyFolder '\*grid*.txt']);
timexFiles=dir([argusFolder '\*timex*.mat']);
timeseriesFiles=dir([argusFolder '\*mBW*.mat']);

for i=1:length(cBathyFiles)
    %load cBathy file
    load([argusFolder '\' cBathyFiles(i).name]);

    %load survey file
    survey=importdata([surveyFolder '\' surveyFiles(i).name]);
    xSurvey=unique(survey(:,4));
    ySurvey=unique(survey(:,5));
    [xGRD,yGRD]=meshgrid(xSurvey,ySurvey);
    zSurveyGRD=reshape(survey(:,3),length(xSurvey),length(ySurvey))';
    
    %get date from survey filename
    ind=find(surveyFiles(i).name=='_');
    date=surveyFiles(i).name(ind(2)+1:ind(3)-1);
    
    %grid survey Data onto cBathy grid
    %********trim DOMAIN to < 300m???????????????????
    [xmGRD,ymGRD]=meshgrid(bathy.xm(2:28),bathy.ym);
    surveycBathyGRD=interp2(xGRD,yGRD, zSurveyGRD,xmGRD,ymGRD);
    
    %calculate observed Phase 2 and Phase 3 errors
    phase2ObsErrors=-bathy.fCombined.h(:,2:28)-surveycBathyGRD;
    phase3ObsErrors=-bathy.runningAverage.h(:,2:28)-surveycBathyGRD;
    phase2ObsErrors=phase2ObsErrors(:);
    phase3ObsErrors=phase3ObsErrors(:);
    phase3ObsErrors(abs(phase2ObsErrors)>20)=nan;
    phase2ObsErrors(abs(phase3ObsErrors)>20)=nan;
    biasPhase2(i)=nanmean(phase2ObsErrors(:));
    biasPhase3(i)=nanmean(phase3ObsErrors(:));
    rmsePhase2(i)=rms(phase2ObsErrors(~isnan(phase2ObsErrors)));
    rmsePhase3(i)=rms(phase3ObsErrors(~isnan(phase3ObsErrors)))
    
    phase2PredError=bathy.fCombined.hErr(:,2:28);
    phase3PredError=bathy.runningAverage.hErr(:,2:28);
    phase2PredError(phase2PredError>20)=nan;
    phase3PredError(phase3PredError>20)=nan;
    
    LMphase2Obs300m(i).linfit=fitlm(phase2PredError(:),abs(phase2ObsErrors(:)));
    LMphase3Obs300m(i).linfit=fitlm(phase3PredError(:),abs(phase3ObsErrors(:)));
     
    %plot phase 2
    figure(1);
    subplot(4,2,i)
    plot(phase2PredError(:),abs(phase2ObsErrors(:)),'b.')
    xlim([0 10]);ylim([0 10])
    title({[date];['R^2 = ' sprintf('%.2f',LMphase2Obs300m(i).linfit.Rsquared.Ordinary)]})

    
    %plot phase 3
    figure(2);
    subplot(4,2,i)
    plot(phase3PredError(:),abs(phase3ObsErrors(:)),'b.')
    xlim([0 1]);ylim([0 10])
     title({[date];['R^2 = ' sprintf('%.2f',LMphase3Obs300m(i).linfit.Rsquared.Ordinary)]})

    
end

