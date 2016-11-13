%BathyDuck - compare LARC and Altimeter Data

%% Directories for where data is
larcDir='D:\Kate\Dropbox\BathyDuck\Survey\';
altDir='D:\Kate\Dropbox\BathyDuck\altimeter\';
chlTHREDDS='http://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/';

%% load FRF altimeter data
%note: Alt03 (150,940); Alt04 (200,940); Alt05 (200,940)
%note: renamed & combined Pat's original monthly structures to Alt03, 
%Alt04,Alt05 and added an FRF location x,y field
load([altDir 'FRFAltimeter.mat'])

%% get Britt & Steve altimeter data from CHL THREDDS
%use p04,p11,p12,p13,p14,p22,p23,p24
%note: p21 had no altimeter data
%note: altimeters 13,14,24 tipped over; B&S corrected for tilt using RPY
%from ADVs. stopped processing when tipped more than 30 degrees (limit of
%measurement by ADV)

varNames={'p04' 'p11' 'p12' 'p13' 'p14' 'p22' 'p23' 'p24'};

for i=1:length(varNames)
    x=ncread([chlTHREDDS 'BathyDuck-ocean_bathy_' varNames{i} '_201510.nc'],'xloc');
    y=ncread([chlTHREDDS 'BathyDuck-ocean_bathy_' varNames{i} '_201510.nc'],'yloc');
    time=ncread([chlTHREDDS 'BathyDuck-ocean_bathy_' varNames{i} '_201510.nc'],'time');
    %convert epoch to matlab datenum
    time=time./(60*60*24) + datenum(1970,1,1);
    seafloorLoc=ncread([chlTHREDDS 'BathyDuck-ocean_bathy_' varNames{i} '_201510.nc'],'seafloorLocation');
%     if i==2%data at p11 are positive????
%         seafloorLoc=-seafloorLoc;
%     end   
    eval([varNames{i} '.x=x;']);
    eval([varNames{i} '.y=y;']);
    eval([varNames{i} '.time=time;']);
    eval([varNames{i} '.seafloorLoc=seafloorLoc;']);
    clear x y time bottomLoc
end

%% plot altimeter data
figure
plot(Alt03.time,Alt03.elevKF,'k.','markersize',6);hold all
plot(Alt04.time,Alt04.elevKF,'.','markersize',6,'color',[112/256 138/256 144/256]);
plot(Alt05.time,Alt05.elevKF,'.','markersize',6,'color',[0.82 0.83 0.78]);
colorsBS=jet(length(varNames));
for i=1:length(varNames)
    eval(['time=' varNames{i} '.time;']);
    eval(['seafloorLoc=' varNames{i} '.seafloorLoc;']);
    plot(time,seafloorLoc,'.','markersize',6,'color',colorsBS(i,:));
end
title('BathyDuck Altimeter Elevations Through Time','fontsize',14)
xlabel('Time (Days)','fontsize',14)
ylabel('Elevation (m, NAVD88)','fontsize',14)
datetick('x','mmm-dd','keeplimits')
set(gca,'fontsize',14)
legend({'Alt03' 'Alt04' 'Alt05' varNames{1:end}})

%% Get LARC Data
larcFiles=dir([larcDir '*.csv']);
for i=1:length(larcFiles)
    larcData.surveyDates(i)=datenum(larcFiles(i).name(8:15),'yyyymmdd');
    [larcData.data{i}]=importLarcData([larcDir larcFiles(i).name]);
    [xgrid,ygrid]=meshgrid(0:3:400,600:3:1000);
    larcData.data{i}=gridLarcData(larcData.data{i},xgrid,ygrid);
end

%% Plot LARC Data
figure
for i=1:length(larcFiles)
subplot(3,3,i)
pcolor(xgrid,ygrid,larcData.data{i}.Zgrid);shading flat
hold on;plot(larcData.data{i}.x,larcData.data{i}.y,'k.')
for j=1:length(varNames)
    eval(['x=' varNames{j} '.x;']);
    eval(['y=' varNames{j} '.y;']);
    plot(x,y,'m*');
end
plot(Alt03.x,Alt03.y,'m*');
plot(Alt04.x,Alt04.y,'m*');
plot(Alt05.x,Alt05.y,'m*');
colormap('jet');caxis([-5.5 0]);
title(datestr(larcData.surveyDates(i)))
if i==2
    title({'BathyDuck Surveys';datestr(larcData.surveyDates(i))});
end
if i==8
    xlabel('FRF Cross-Shore Coordinate (m)');
end
if i==4
    ylabel('FRF Alongshore Coordinate (m)');
end
if i==6
    colorbar
end
end



