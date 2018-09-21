%calculate wavespeeds for cBathy & linear theors over the altimeters

AltNames={'Alt03' 'Alt04' 'Alt05'};

for i=2%1:length(AltNames)
    
    eval(['Alt=' AltNames{i} ';'])
    
    %interpolate altimeter data onto cBathy time
    for t=1:length(Alt.cBathy.time)
        [tdiff,ind]=min(abs(Alt.time-Alt.cBathy.time(t)));
        if tdiff<(1./24)
            Alt.ZcBathyT(t)=Alt.seafloorLoc(ind);
        else
            Alt.ZcBathyT(t)=nan;
        end
    end
    
    %calculate depth errors
    Alt.obsKFError=Alt.cBathy.depthKF-Alt.ZcBathyT';
    Alt.obsfCError=Alt.cBathy.depthfC-Alt.ZcBathyT';
    
    %calculate speeds from fdependent wavenumbers and frequencies
    Alt.cBathy.speeds=2*pi*Alt.cBathy.fB./Alt.cBathy.k;
    Alt.cBathy.speeds( Alt.cBathy.speeds>20)=nan;
    Alt.cBathy.speeds( Alt.cBathy.speeds<0)=nan;
    [M,N]=size(Alt.cBathy.speeds);
    
    %calculate linear theory speeds from survey for each frequency bin
    Alt.linspeeds=nan(size( Alt.cBathy.speeds));
    for m=1:M
        for n=1:N
            [~,~,Alt.linspeeds(m,n)] = dispersion (Alt.cBathy.fB(m,n),-Alt.ZcBathyT(m),0);
            
        end
    end
    
    %compute weighted average for both linear wave theory and obsereved
    %speeds
    Alt.linspeedWtAvg=nansum(Alt.cBathy.lam1.*Alt.cBathy.skill.*Alt.linspeeds,2)./nansum(Alt.cBathy.lam1.*Alt.cBathy.skill,2);
    Alt.cBathy.speedWtAvg=nansum(Alt.cBathy.lam1.*Alt.cBathy.skill.*Alt.cBathy.speeds,2)./nansum(Alt.cBathy.lam1.*Alt.cBathy.skill,2);
    Alt.cBathy.speedWtAvg(Alt.cBathy.speedWtAvg>20)=nan;
    Alt.cBathy.speedWtAvg(Alt.cBathy.speedWtAvg<0)=nan;
    
    eval([AltNames{i} '=Alt;']);
    clear Alt
    
end