*------------------------------------------------ 
*在 Windows 2000/XP 下添加/删除自定义纸张的示例代码 
*调用方法：addpaper("自定义纸名",纸的宽度,纸的长度)     单位为0.1毫米 
*返回值：如果添加成功则返回一个大于0的数值，这就是添加纸的id号. 
Lpara lcformname,lnWidth,lnLength 
Local lcformname,lnWidth,lnLength,oldalias ,lcstr,lcprinter,lcport 
If pcount()<3 
 *msg("参数缺少！") 
 Return -1 
Endif 
lnLength=lnLength*100 
lnWidth=lnWidth*100 
Clea Dlls 
Set Safety Off 
oldalias = Alias() 
Create Table killyou Free (dummy cdbuf(1)) 
Create Report killyou From killyou.Dbf 
Use killyou.frx Alias killyou 
lcstr = Expr 
If Empty(lcstr) 
 Use In killyou 
 Delete File killyou.frx 
 Delete File killyou.frt 
 Delete File killyou.Dbf 
 If !Empty(oldalias) 
  Select (oldalias) 
 Endif 
 *msg("你的系统中没有安装打印机！") 
 Return -2 
Endif 
Store Memlines(Expr) To gnnumlines 
lcprinter = "" 
lcport    = "" 
For gncount = 1 To gnnumlines 
 If At("DEVICE=",Mline(Expr,gncount))<>0 
  lcprinter = Substr(Mline(Expr,gncount),8) 
 Endif 
 If At("OUTPUT",Mline(Expr,gncount))<>0 
  lcport = Substr(Mline(Expr,gncount),8) 
 Endif 
Next 
If Empty(lcport) 
 Use In killyou 
 Delete File killyou.frx 
 Delete File killyou.frt 
 Delete File killyou.Dbf 
 If !Empty(oldalias) 
  Select (oldalias) 
 Endif 
 *msg("当前打印机不是本地打印机！") 
 Return -3 
Endif 
Use In killyou 
Delete File killyou.frx 
Delete File killyou.frt 
Delete File killyou.Dbf 
*---------------------------------------------------------------- 
Declare Integer OpenPrinter In WinSpool.Drv As WS_OpenPrinter ; 
 string pPrinterName, ; 
 integer @phPrinter, ; 
 string pDefault 
Declare Integer DocumentProperties In WinSpool.Drv ; 
 integer, ; 
 integer, ; 
 string, ; 
 string, ; 
 string, ; 
 integer 
Declare Integer ClosePrinter In WinSpool.Drv As WS_ClosePrinter ; 
 integer hPrinter 
Declare Integer EnumForms In WinSpool.Drv ; 
 Integer, ; 
 Integer, ; 
 String @, ; 
 Integer , ; 
 Integer @, ; 
 Integer @ 
Declare Integer AddForm In WinSpool.Drv ; 
 integer, ; 
 integer, ; 
 string 
Declare Integer DeleteForm In WinSpool.Drv ; 
 integer, ; 
 string 
Declare Long CreateDC In gdi32.Dll ; 
 string @cDriver, ; 
 string @cDevice, ; 
 string cOutput, ; 
 string cInitData 
Declare Long DeleteDC In gdi32.Dll ; 
 declare Long ResetDC In gdi32.Dll ; 
 integer, ; 
 string 
Declare RtlMoveMemory In kernel32 As CopyMemory; 
 string @ Destination,; 
 integer Source,; 
 integer nLength 
Declare Integer lstrcpy In kernel32.Dll ; 
 integer lpString1, String @lpString2 
Declare Integer GetForm In WinSpool.drv ; 
 integer,; 
 string, ; 
 integer,; 
 string, ; 
 integer,; 
 integer 
Declare Integer SetForm In WinSpool.drv ; 
 integer,; 
 string,; 
 integer,; 
 string 
oheap = Createobj("Heap") 
*---------------------------------------------------- 
revalue = getprintersettings(lcprinter,lcformname,lnWidth,lnLength) 
Clear Dlls 
Return revalue 
*---------------------------------------------------- 
Function getprintersettings 
 Lpara lcprinter,lcformname,lnLength,lnWidth 
 Local lcprinter,lcformname,lnLength,lnWidth,hprinter ,nsize ,bytesneeded ,numforms, formname,retval  
 Local nstringbase , ns,bc,temp 
 hprinter = 0 
 nsize = 0 
 bytesneeded = 0 
 numforms = 0 
 If ws_openprinter(lcprinter, @hprinter, 0) <> 0 Then 
  formname=lcformname + Chr(0) + Chr(0) 
