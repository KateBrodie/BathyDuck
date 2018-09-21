kFTHREDDS='http://134.164.129.55/thredds/dodsC/cmtb/waveModels/STWAVE/CB/Local-Field/Local-Field.ncml';
kFThreshTHREDDS = 'http://134.164.129.55/thredds/dodsC/cmtb/projects/STWAVE/CBThresh_0/Local-Field/Local-Field.ncml';
oldData = 'http://bones/thredds/dodsC/FRF/projects/bathyduck/data/cbathy_old/cbathy.ncml';
%surveyTHREDDS = 'http://134.164.129.55/thredds/dodsC/cmtb/waveModels/STWAVE/CBHP/Local-Field/Local-Field.ncml';

%% get Altimeter long cBathy Time Series at Altimeter Locations
load('D:\Kate\GitHub\BathyDuck\altimeterData4Spike1.mat')

xm=ncread([kFTHREDDS],'xFRF');
ym=ncread([kFTHREDDS],'yFRF');

AltNames={'Alt03' 'Alt04' 'Alt05'};
%bathyNames={'kF' 'kFThresh' 'survey'};

for i=1:length(AltNames)
    eval(['xAlt=' AltNames{i} '.x;']);%row
    eval(['yAlt=' AltNames{i} '.y;']);%col
    
  
    [~,ind_x]=min(abs(xm-xAlt));
    [~,ind_y]=min(abs(ym-yAlt));
    
    disp(['reading time'])
    timeKF=ncread([kFTHREDDS],'time');
    timeKFT=ncread([kFThreshTHREDDS],'time');
    %convert epoch to matlab datenum
    timeKF=timeKF./(60*60*24) + datenum(1970,1,1);
    timeKFT=timeKFT./(60*60*24) + datenum(1970,1,1);
    %convert lat/lon to frf
    %[~,~,~,~,y,x]=frfCoord(lon,lat);
    
    cBathyKF.time=timeKF;
    cBathyKFT.time=timeKFT;
    
    disp(['reading depthKH & error'])
    cBathyKF.depthKF=reshape(ncread([kFTHREDDS],'bathymetry',[ind_x, ind_y, 1],[1,1,length(timeKF)]),length(timeKF),1);
    cBathyKF.depthKF(cBathyKF.depthKF<-999)=nan;
    cBathyKF.info = 'for spikes paper';
    cBathyKFT.depthKF=reshape(ncread([kFThreshTHREDDS],'bathymetry',[ind_x, ind_y, 1],[1,1,length(timeKFT)]),length(timeKFT),1);
    cBathyKFT.depthKF(cBathyKFT.depthKF<-999)=nan;
    cBathyKFT.info = 'for spikes paper';
    
%     cBathy.depthKFError=reshape(ncread([chlTHREDDS 'cbathy/cbathy.ncml'],'depthKFError',[ind_x, ind_y, 1],[1,1,length(time)]),length(time),1);
%     cBathy.depthKFError(cBathy.depthKFError<-999)=nan;
%     disp(['reading depthfC & error'])
%     cBathy.depthfC=reshape(ncread([chlTHREDDS 'cbathy/cbathy.ncml'],'depthfC',[ind_x, ind_y, 1],[1,1,length(time)]),length(time),1);
%     cBathy.depthfC(cBathy.depthfC<-999)=nan;
%     cBathy.depthErrorfC=reshape(ncread([chlTHREDDS 'cbathy/cbathy.ncml'],'depthErrorfC',[ind_x, ind_y, 1],[1,1,length(time)]),length(time),1);
%     cBathy.depthErrorfC(cBathy.depthErrorfC<-999)=nan;
%     disp(['reading fB'])
%     cBathy.fB=reshape(ncread([chlTHREDDS 'cbathy/cbathy.ncml'],'fB',[1, ind_x, ind_y, 1],[4, 1,1,length(time)]),4,length(time))';
%     cBathy.fB(cBathy.fB<-999)=nan;
%     disp(['reading k'])
%     cBathy.k=reshape(ncread([chlTHREDDS 'cbathy/cbathy.ncml'],'k',[1, ind_x, ind_y, 1],[4, 1,1,length(time)]),4,length(time))';
%     cBathy.k(cBathy.k<-999)=nan;
%     disp(['reading skill'])
%     cBathy.skill=reshape(ncread([chlTHREDDS 'cbathy/cbathy.ncml'],'skill',[1, ind_x, ind_y, 1],[4, 1,1,length(time)]),4,length(time))';
%     cBathy.skill(cBathy.skill<-999)=nan;
%     disp(['reading lam1'])
%     cBathy.lam1=reshape(ncread([chlTHREDDS 'cbathy/cbathy.ncml'],'lam1',[1, ind_x, ind_y, 1],[4, 1,1,length(time)]),4,length(time))';
%     cBathy.lam1(cBathy.lam1<-999)=nan;
%     disp(['reading Kalman Filter Parameters'])
%     cBathy.PKF=reshape(ncread([chlTHREDDS 'cbathy/cbathy.ncml'],'PKF',[ind_x, ind_y, 1],[1,1,length(time)]),length(time),1);
%     cBathy.PKF(cBathy.PKF<-999)=nan;
%     cBathy.QKF=reshape(ncread([chlTHREDDS 'cbathy/cbathy.ncml'],'QKF',[ind_x, ind_y, 1],[1,1,length(time)]),length(time),1);
%     cBathy.QKF(cBathy.QKF<-999)=nan;
%     cBathy.KKF=reshape(ncread([chlTHREDDS 'cbathy/cbathy.ncml'],'KKF',[ind_x, ind_y, 1],[1,1,length(time)]),length(time),1);
%     cBathy.KKF(cBathy.KKF<-999)=nan;
 
    eval([AltNames{i} '.cBathyKF=cBathyKF;']);
    eval([AltNames{i} '.cBathyKFT=cBathyKFT;']);
    
%     eval([AltNames{i} '.cBathy.PKF=cBathy.PKF;']);
%     eval([AltNames{i} '.cBathy.QKF=cBathy.QKF']);
%     eval([AltNames{i} '.cBathy.KKF=cBathy.KKF']);
    
    
    clear time cBathy
end

save altimeterData4Spike1.mat Alt*
clearvars -except Alt*
