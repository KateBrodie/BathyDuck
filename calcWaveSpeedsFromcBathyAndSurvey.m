function [linspeeds,speeds,linspeedWtAvg,speedWtAvg,fBSurveyGRD,kSurveyGRD,skillSurveyGRD,lam1SurveyGRD]=calcWaveSpeedsFromcBathyAndSurvey(bathy,xGRD,yGRD,zSurveyGRD) 
%grid cBathy Data onto survey grid
[xmGRD,ymGRD]=meshgrid(bathy.xm,bathy.ym);
[~,~,P]=size(bathy.fDependent.k);

for i=1:P
    kSurveyGRD(:,:,i)=interp2(xmGRD,ymGRD,bathy.fDependent.k(:,:,i),xGRD,yGRD);
    fBSurveyGRD(:,:,i)=interp2(xmGRD,ymGRD,bathy.fDependent.fB(:,:,i),xGRD,yGRD,'nearest');
    skillSurveyGRD(:,:,i)=interp2(xmGRD,ymGRD,bathy.fDependent.skill(:,:,i),xGRD,yGRD);
    lam1SurveyGRD(:,:,i)=interp2(xmGRD,ymGRD,bathy.fDependent.lam1(:,:,i),xGRD,yGRD);
end

%calculate speeds from fdependent wavenumbers and frequencies
speeds=2*pi*fBSurveyGRD./kSurveyGRD;
speeds(speeds>20)=nan;
speeds(speeds<0)=nan;
[M,N,P]=size(speeds);

%calculate linear theory speeds from survey for each frequency bin
linspeeds=nan(size(speeds));
for m=1:M
    for n=1:N
        for p=1:P
            [~,~,linspeeds(m,n,p)] = dispersion (fBSurveyGRD(m,n,p),-zSurveyGRD(m,n),0);
        end
    end
end

%compute weighted average for both linear wave theory and obsereved
%speeds
linspeedWtAvg=nansum(lam1SurveyGRD.*skillSurveyGRD.*linspeeds,3)./nansum(lam1SurveyGRD.*skillSurveyGRD,3);
speedWtAvg=nansum(lam1SurveyGRD.*skillSurveyGRD.*speeds,3)./nansum(lam1SurveyGRD.*skillSurveyGRD,3);
speedWtAvg(speedWtAvg>20)=nan;
speedWtAvg(speedWtAvg<0)=nan;

end