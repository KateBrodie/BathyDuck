function [xoSandBar, xoSandBarErr, ySandBar] = sandbarGaussFit(I,xM,yM,xoSandBarOld,gaussFiltWidth,iPlot,saveFig,figName)
% identify cross-shore location of the vegetation line on the dune
% Inputs
% I - grayscale image to digitize off of...usually imean
% xM - FRF cross-shore coordinates of image
% yM - FRF along-shore coordinates of image
% xoRunupOld - vector of FRF cross-shore coordinates of the prior time's
%sandbar position
% iPlot - 'On' or 'Off' ##plot flag, iplot = 1 plot, else no plot
% saveFig - saves the figure or not
%
%%written by Meg Palmsten, NRL for dune vegetation
%%edited by Kate Brodie, FRF for max runup line

%get first guess if isn't there
if isempty(xoSandBarOld)
    f=figure;
    imagesc(yM,xM,I)
    [yoSandBarDig,xoSandBarDig] = ginput(); % digitize the dune veg line
    %check to make sure there are no duplicate points in y
    [yoSandBarDig,uniqueIND,~]=unique(yoSandBarDig);
    xoSandBarDig=xoSandBarDig(uniqueIND);
    xoSandBarOld = interp1(yoSandBarDig, xoSandBarDig, yM,'linear','extrap');
    close(f)
end


% define a Gaussian function
 fun = @(beta,xShore)beta(1)*exp(-(xShore).^2/beta(2));
 %create a gaussian filter
    for ii = 1:size(I,2)
    gaussWindow(:,ii) = fun([1 gaussFiltWidth],xM-xoSandBarOld(ii));
    end

IWindowed = I.*gaussWindow;

% use a lowest cost path algorithm to find the minimum path through the
% filtered image, this should detect the sandbar crest
IWindowed(isnan(IWindowed))=0;
[Y2,iSandBar]=shortestPathStep2(-IWindowed,1);

% step through each along shore position and fit an Gaussian to the
% convolved image to try and get an error estimate
for ii = 1:size(IWindowed,2)
    % find the digitized dune line
    [IHxMax] = IWindowed(iSandBar(ii),ii);
    
    % make a guess at a coeffient
    if exist('coefEst')
        betaInitial = coefEst(ii-1,2);
        if betaInitial < 0.5 || betaInitial>200;
            betaInitial = 50;  %SB  This prevents solution from artifically locking up in a narrow gaussian width
        end
    else
        betaInitial = 50;
    end
    try
        coefEst(ii,:) = nlinfit(xM-xM(iSandBar(ii)),IWindowed(:,ii),fun,[IHxMax,betaInitial]);
    catch % try decreasing by a factor of 10 of the previous value
        try
            coefEst(ii,:) = nlinfit(xM-xM(iSandBar(ii)),IWindowed(:,ii),fun,[IHxMax,betaInitial/10]);
        catch % try increasing by a factor of 10 of the previous value
            try
                coefEst(ii,:) = nlinfit(xM-xM(iSandBar(ii)),IWindowed(:,ii),fun,[IHxMax,betaInitial.*10]);
            catch
                try
                coefEst(ii,:) = nlinfit(xM-xM(iSandBar(ii)),IWindowed(:,ii),fun,[IHxMax,betaInitial/100]);
                catch
                try
                    % try increasing by a factor of 10 of the previous value
                coefEst(ii,:) = nlinfit(xM-xM(iSandBar(ii)),IWindowed(:,ii),fun,[IHxMax,betaInitial.*100]);
                catch % if none of these work, just give up and make error = 20
                    try
                        coefEst(ii,:) = [coefEst(ii-1,1) 20];
                    catch
                        coefEst(ii,:) = [60 60];
                    end
                end
                end
            end
        end
    end
end

% find crosshore position of vegetation line
xoSandBar = xM(iSandBar);
xoSandBarErr = coefEst(:,2);
ySandBar = yM;

% constrain error 
xoSandBarErr(xoSandBarErr <1) = 1;
xoSandBarErr(xoSandBarErr >60) = 60;

% plot results

if strcmp(iPlot,'On')||strcmp(iPlot,'Off')
    fig=figure('Visible', iPlot);
    subplot(3,1,1)
    imagesc(yM,xM,I); colormap 'gray'
    hold on
    plot(yM,xoSandBar)
   %ylim([50 150])
    %title(datestr(epoch2Matlab(time)))  % There is no 'time'
    colormap gray
    grid on
    
    subplot(3,1,2)
    imagesc(yM,xM,IWindowed); colormap 'gray'
    hold on
    plot(yM,xoSandBar)
    plot(yM,xoSandBarOld,'m')
    %ylim([50 150])
    subplot(3,1,3)
    imagesc(yM,xM,IWindowed); colormap 'gray'
    hold on
    plot(yM,xoSandBar)
    plot(yM,xoSandBarOld,'m')
    %ylim([50 150])
    if saveFig==1
        print(fig, figName, '-dpng')
    end
    close(fig)
    %    pause
end
end

 