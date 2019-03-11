RELEASE c标题,c提示
PUBLIC  c标题,c提示

*** 【提前三天到期提醒】
IF c到期 - DATE() < 3  && 提前三天提示到期。
   c标题 = "【Ebcrm 到期提醒】"
   c提示 = "软件将在"+ALLTRIM(STR(c到期 - DATE()))+"天后到期，;
   为了您的正常使用，请及时与供应商联系！"+CHR(13)+c技术支持
   DO ..\progs\popwindows.prg
ENDIF
