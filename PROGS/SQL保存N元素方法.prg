*!*	��SQL-Select���N��Ԫ�ص����е��㷨����
*!*	Ŀ�ģ��õ�N��Ԫ�����еĲ�ͬ���н���ͽ����

*!*	��7��Ԫ��Ϊ������������
*!*	׼����������
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

*!*	7��ȫ����
SELECT T1.Num+T2.Num+T3.Num+T4.Num+T5.Num+T6.Num+T7.Num as pl ;
	FROM T1 T1,T1 T2,T1 T3,T1 T4,T1 T5,T1 T6,T1 T7 ;
	WHERE T1.nCode+T2.nCode+T3.nCode+T4.nCode+T5.nCode+T6.nCode+T7.nCode=127 ;
	ORDER BY pl INTO CURSOR R1
?'7��ȫ������Ϊ��',RECCOUNT()

*!*	7ȡ3������
SELECT T1.Num+T2.Num+T3.Num as pl ;
	FROM T1 T1,T1 T2,T1 T3 ;
	WHERE cc(T1.nCode+T2.nCode+T3.nCode) == '111' ;
	ORDER BY pl INTO CURSOR R2
?'7ȡ3��������Ϊ��',RECCOUNT()

FUNCTION cc 
LPARAMETERS vv
	cStr=''
	DO WHILE vv>0
		cStr=STR(MOD(vv,2),1)+cStr
		vv=INT(vv/2)
	ENDDO 
	RETURN CHRTRAN(cStr,'0','')
ENDFUNC
