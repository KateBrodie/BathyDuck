function larcData=gridLarcData(larcData,xgrid,ygrid)
    
    F=scatteredInterpolant(larcData.x,larcData.y,larcData.z,'natural','none');
    larcData.Zgrid=F(xgrid,ygrid);
    larcData.scatteredIntZ=F;
    F.Values=larcData.date;
    larcData.scatteredIntT=F;
    larcData.Tgrid=F(xgrid,ygrid);
    larcData.xgrid=xgrid;
    larcData.ygrid=ygrid;

end