*!*	用SQL-Select解决N个元素的排列的算法问题
*!*	目的：得到N个元素所有的不同排列结果和结果数

*!*	以7个元素为例，代码如下
*!*	准备测试数据
CLEAR
CLOSE DATABASES

CREATE CURSOR T1(Num C(1),nCode I)
INSERT INTO T1 VALUES ('A',1)
INSERT INTO T1 VALUES ('B',2)
INSERT INTO T1 VALUES ('C',4)
INSERT INTO T1 VALUES ('D',8)
INSERT INTO T1 VALUES ('E',16)
INSERT INTO T1 VALUES ('F',32)
INSERT INTO T1 VALUES ('G',64)

*!*	7的全排列
SELECT T1.Num+T2.Num+T3.Num+T4.Num+T5.Num+T6.Num+T7.Num as pl ;
	FROM T1 T1,T1 T2,T1 T3,T1 T4,T1 T5,T1 T6,T1 T7 ;
	WHERE T1.nCode+T2.nCode+T3.nCode+T4.nCode+T5.nCode+T6.nCode+T7.nCode=127 ;
	ORDER BY pl INTO CURSOR R1
?'7的全排列数为：',RECCOUNT()

*!*	7取3的排列
SELECT T1.Num+T2.Num+T3.Num as pl ;
	FROM T1 T1,T1 T2,T1 T3 ;
	WHERE cc(T1.nCode+T2.nCode+T3.nCode) == '111' ;
	ORDER BY pl INTO CURSOR R2
?'7取3的排列数为：',RECCOUNT()

FUNCTION cc 
LPARAMETERS vv
	cStr=''
	DO WHILE vv>0
		cStr=STR(MOD(vv,2),1)+cStr
		vv=INT(vv/2)
	ENDDO 
	RETURN CHRTRAN(cStr,'0','')
ENDFUNC
