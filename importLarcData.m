function [larcData]=importLarcData(filename)
    data=importdata(filename);
    
    larcData.profNum=data.data(:,1);
    larcData.x=data.data(:,7);
    larcData.y=data.data(:,8);
    larcData.z=data.data(:,9);
    day=num2str(data.data(:,11));
    time=num2str(data.data(:,12)); 
    larcData.date=datenum(str2num(day(:,1:4)),str2num(day(:,5:6)),...
        str2num(day(:,7:8)),str2num(time(:,1:2)),str2num(time(:,3:4)),...
        str2num(time(:,5:6)));
    

end