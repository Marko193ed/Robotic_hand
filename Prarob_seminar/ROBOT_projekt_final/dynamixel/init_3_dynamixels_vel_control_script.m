
%%
Ts = 0.1;
%myDxl = slDxl('COM3', 57600);
myDxl = slDxl(Port, 4000000);
myDxl.findDxls()
myDxl

for DXL_ID = [1:3]
    write1ByteTxRx(myDxl.PortNum, str2num(myDxl.ProtocalVer), DXL_ID, 11, 1);
    write1ByteTxRx(myDxl.PortNum, str2num(myDxl.ProtocalVer), DXL_ID, 68, 1);
    myDxl.doEnableTorque(DXL_ID);
end

assignin("base", "myDxl", myDxl)%izbriši ako ne radi
