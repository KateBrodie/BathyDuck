function timeOut = netcdfTime2Matlab(timeIn)
    timeOut = timeIn/(3600*24) + datenum(1970,1,1);

end