chlTHREDDS='http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/';

%% get Altimeter long time-series data

AltNames={'Alt03' 'Alt04' 'Alt05'};

for i=1:length(AltNames)
    lat=ncread([chlTHREDDS AltNames{i} '/' AltNames{i} '.ncml'],'lat');
    lon=ncread([chlTHREDDS AltNames{i} '/' AltNames{i} '.ncml'],'lon');
    time=ncread([chlTHREDDS AltNames{i} '/' AltNames{i} '.ncml'],'time');
    %convert epoch to matlab datenum
    time=time./(60*60*24) + datenum(1970,1,1);
    %convert lat/lon to frf
    [~,~,~,~,y,x]=frfCoord(lon,lat);
    
    seafloorLoc=ncread([chlTHREDDS AltNames{i} '/' AltNames{i} '.ncml'],'elevKF');
 
    eval([AltNames{i} '.x=x;']);
    eval([AltNames{i} '.y=y;']);
    eval([AltNames{i} '.time=time;']);
    eval([AltNames{i} '.seafloorLoc=seafloorLoc;']);
    clear lat lon time seafloorLoc
end