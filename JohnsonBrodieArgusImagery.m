%Make Study Site/Storm Impact Figure for Brad

%% Get the data we need
%first some argus imagery
timex0921 = load('Z:\argus\argus02b\2015\cx\264_Sep.21\1442844001.Mon.Sep.21_14_00_01.GMT.2015.argus02b.cx.timex.merge.mat');
timex0925 = load('Z:\argus\argus02b\2015\cx\268_Sep.25\1443214801.Fri.Sep.25_21_00_01.GMT.2015.argus02b.cx.timex.merge.mat');
timex0930 = load('Z:\argus\argus02b\2015\cx\273_Sep.30\1443645001.Wed.Sep.30_20_30_01.GMT.2015.argus02b.cx.timex.merge.mat');
timex1003 = load('Z:\argus\argus02b\2015\cx\276_Oct.03\1443904201.Sat.Oct.03_20_30_01.GMT.2015.argus02b.cx.timex.merge.mat');
timex1008 = load('Z:\argus\argus02b\2015\cx\281_Oct.08\1444323601.Thu.Oct.08_17_00_01.GMT.2015.argus02b.cx.timex.merge.mat');

%CLARIS DEMs
claris0610=loadDEM_samegrid('Y:\data\CLARIS\FRF_morphology_surveys\20151009_FRF20km_and_KHtoAvalon\20150610_FRF20km_propextents_FRFcoords_CLEANED_CORRECT.txt', 43:0.25:133, -80:0.25:1050);
claris1009=loadDEM_samegrid('Y:\data\CLARIS\FRF_morphology_surveys\20151009_FRF20km_and_KHtoAvalon\20151009_FRF20km_propextents_FRFcoords_CLEANED_CORRECT.txt', 43:0.25:133, -80:0.25:1050);

%Dune Lidar Profiles
load('D:\Kate\Dropbox\OceanSciences2018\oceanSciencesWorkingMatFiles.mat', 'joaquinData')

%Dune/Pier Lidar DEMs
load('D:\Kate\Dropbox\4Brad\Joaquin_Lidar_Dune_Erosion_4Brad.mat')
%grid the first scan to the same grid as the Claris Survey
duneLidarDEMCLARS = griddata(DEMdat25cm.xs,DEMdat25cm.as',DEMdat25cm.data(:,:,1),claris0610.xs,claris0610.as');

%Survey Data
survey_Sep15=importdata('D:\Kate\Dropbox\BathyDuck\Survey\FRF_BD_20150915_1116_NAVD88_LARC_GPS_UTC_grid_latlon.txt');
xSurvey_Sep15=unique(survey_Sep15(:,4));
ySurvey_Sep15=unique(survey_Sep15(:,5));
[xGRD_Sep15,yGRD_Sep15]=meshgrid(xSurvey_Sep15,ySurvey_Sep15);
zSurveyGRD_Sep15=reshape(survey_Sep15(:,3),length(xSurvey_Sep15),length(ySurvey_Sep15))';

survey_Oct01=importdata('D:\Kate\Dropbox\BathyDuck\Survey\FRF_BD_20151001_0001_NAVD88_CRAB_GPS_UTC_v20151001_grid_latlon.txt');
xSurvey_Oct01=unique(survey_Oct01(:,4));
ySurvey_Oct01=unique(survey_Oct01(:,5));
[xGRD_Oct01,yGRD_Oct01]=meshgrid(xSurvey_Oct01,ySurvey_Oct01);
zSurveyGRD_Oct01=reshape(survey_Oct01(:,3),length(xSurvey_Oct01),length(ySurvey_Oct01))';

survey_Oct08=importdata('D:\Kate\Dropbox\BathyDuck\Survey\FRF_BD_20151008_0002_NAVD88_CRAB_GPS_UTC_v20151009_grid_latlon.txt');
xSurvey_Oct08=unique(survey_Oct08(:,4));
ySurvey_Oct08=unique(survey_Oct08(:,5));
[xGRD_Oct08,yGRD_Oct08]=meshgrid(xSurvey_Oct08,ySurvey_Oct08);
zSurveyGRD_Oct08=reshape(survey_Oct08(:,3),length(xSurvey_Oct08),length(ySurvey_Oct08))';

%grid 15 Sep Survey to 08 Oct Survey to show elevation changes
zSurveyGRD_Sep15onOct08grd = griddata(xSurvey_Sep15',ySurvey_Sep15,zSurveyGRD_Sep15,xSurvey_Oct08',ySurvey_Oct08);

%Gauges
xp150.x = 150;
xp150.y = 940;
xp200.x = 200;
xp250.y = 940;

%% Make Some Figures

%load cool colormap
load \\134.164.129.44\Documents\TRIDENT_SPECTRE_2018\FINAL_PRODUCT_DATA\X8_FLIGHT4_APX_NOGCP\DEM_BATHYMETRY\colormapOceanBlueToGreen.mat

f1 = figure;
h1 = subplot(1,3,1);
image(timex0921.x,timex0921.y,permute(timex0921.Ip,[2 1 3]));hold on
set(gca,'YDir','normal','Color','k');
[c,h]=contour(xGRD_Sep15,yGRD_Sep15,zSurveyGRD_Sep15,[-8:1:4]);colormap(jet);caxis([-7 7])
clabel(c,h,'LabelSpacing',100,'Color','w','FontWeight','bold')
plot([150 200 600],[940 940 940],'r.','MarkerSize',30)
xlim(h1,[0 625]);ylim(h1,[400 1100]);
axis normal
title({'A) 21 Sep 2015 Imagery';'15 Sep 2015 Survey'})
ylabel('FRF Alongshore (m)')

% h2 = subplot(1,4,2);
% image(timex0925.x,timex0925.y,permute(timex0925.Ip,[2 1 3]));hold on
% set(gca,'YDir','normal','Color','k');
% plot([150 200 600],[940 940 940],'r.','MarkerSize',30)
% xlim(h2,[0 625]);ylim(h2,[400 1100]);
% axis normal
% title('25 Sep 2015')

h3 = subplot(1,3,2);
image(timex1003.x,timex1003.y,permute(timex1003.Ip,[2 1 3]));hold on
set(gca,'YDir','normal','Color','k');
[c,h]=contour(xGRD_Oct01,yGRD_Oct01,zSurveyGRD_Oct01,[-8:1:4]);colormap(jet);caxis([-7 7])
clabel(c,h,'LabelSpacing',100,'Color','w','FontWeight','bold')
[c,h]=contour(xGRD_Oct08,yGRD_Oct08,zSurveyGRD_Oct08,[-8:1:4],':','linewidth',1.5);colormap(jet);caxis([-7 7])
clabel(c,h,'LabelSpacing',100,'Color','w','FontWeight','bold')
plot([150 200 600],[940 940 940],'r.','MarkerSize',30)
xlim(h3,[0 625]);ylim(h3,[400 1100]);
axis normal
title({'B) 03 Oct 2015 Imagery';'01 & 08 Oct 2015 Survey'})
xlabel('FRF Cross-Shore (m)')

h4 = subplot(1,3,3);
image(timex1008.x,timex1008.y,permute(timex1008.Ip,[2 1 3]));hold on
set(gca,'YDir','normal','Color','k');
[c,h]=contour(xGRD_Oct08,yGRD_Oct08,zSurveyGRD_Oct08,[-8:1:4]);colormap(jet);caxis([-7 7])
clabel(c,h,'LabelSpacing',100,'Color','w','FontWeight','bold')
plot([150 200 600],[940 940 940],'r.','MarkerSize',30)
xlim(h4,[0 625]);ylim(h4,[400 1100]);
axis normal
title('C)08 Oct 2015 Imagery & Survey')

f2 = figure;
subplot(1,4,1)
image(timex0921.x,timex0921.y,permute(timex0921.Ip,[2 1 3]));hold on
set(gca,'YDir','normal','Color','k');
pcolor(xGRD_Sep15,yGRD_Sep15,zSurveyGRD_Sep15);shading flat; colormap(jet);caxis([-7 2])

subplot(1,4,2)
image(timex1008.x,timex1008.y,permute(timex1008.Ip,[2 1 3]));hold on
set(gca,'YDir','normal','Color','k');
pcolor(xGRD_Oct08,yGRD_Oct08,zSurveyGRD_Oct08);shading flat; colormap(jet);caxis([-7 2])

subplot(1,4,3)
image(timex1008.x,timex1008.y,permute(timex1008.Ip,[2 1 3]));hold on
set(gca,'YDir','normal','Color','k');
pcolor(xGRD_Oct08,yGRD_Oct08,zSurveyGRD_Oct08-zSurveyGRD_Sep15onOct08grd);shading flat; colormap(cmapBathyChange);caxis([-2 2])

subplot(1,4,4)
image(timex1008.x,timex1008.y,permute(timex1008.Ip,[2 1 3]));hold on
set(gca,'YDir','normal','Color','k');
%pcolor(claris0610.xs,claris0610.as,claris1009.data-claris0610.data);shading flat;colormap(cmapDuneChange);caxis([-6 1]);
pcolor(claris0610.xs,claris0610.as,claris1009.data-duneLidarDEMCLARS);
shading flat;colormap(cmapDuneChange);caxis([-6 1]);
