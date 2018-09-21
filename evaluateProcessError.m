load('D:\Kate\Dropbox\BathyDuck\MatFiles\Altimeter_cBathy_Structures_Updated.mat')

%calculate observed Q
Alt05.ZcBathyTinterp=interp1nan(Alt05.cBathy.time,Alt05.ZcBathyT,Alt05.cBathy.time);
Alt05.seafloorVariance2cBathy=[0 diff(Alt05.ZcBathyTinterp').^2];

Alt04.ZcBathyTinterp=interp1nan(Alt04.cBathy.time,Alt04.ZcBathyT,Alt04.cBathy.time);
Alt04.seafloorVariance2cBathy=[0 diff(Alt04.ZcBathyTinterp').^2];

Alt03.ZcBathyTinterp=interp1nan(Alt03.cBathy.time,Alt03.ZcBathyT,Alt03.cBathy.time);
Alt03.seafloorVariance2cBathy=[0 diff(Alt03.ZcBathyTinterp').^2];

figure;
plot(Alt03.seafloorVariance2cBathy,Alt03.cBathy.QKF,'b.','markersize',10); hold on
plot(Alt04.seafloorVariance2cBathy,Alt04.cBathy.QKF,'r.','markersize',10)
plot(Alt05.seafloorVariance2cBathy,Alt05.cBathy.QKF,'g.','markersize',10)
legend('Inner Altimeter','Middle Altimeter','Outer Altimeter')
xlabel('Observed Seafloor Variance (m^2)')
ylabel('cBathy Predicted Seafloor Variance (m^2)')

figure;
subplot(3,1,1)
plot(Alt03.cBathy.time,Alt03.cBathy.QKF,'ro');hold on
plot(Alt03.cBathy.time,Alt03.seafloorVariance2cBathy,'bo')
set(gca,'XTickLabel',[])
title('Inner Altimeter')

subplot(3,1,2)
plot(Alt04.cBathy.time,Alt04.cBathy.QKF,'ro');hold on
plot(Alt04.cBathy.time,Alt04.seafloorVariance2cBathy,'bo')
set(gca,'XTickLabel',[])
ylabel('Seafloor Variance (m^2)')
title('Middle Altimeter')

subplot(3,1,3)
plot(Alt05.cBathy.time,Alt05.cBathy.QKF,'ro');hold on
plot(Alt05.cBathy.time,Alt05.seafloorVariance2cBathy,'bo')
datetick('x','mmm')
title('Outer Altimeter')