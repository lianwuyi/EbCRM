RELEASE c����,c��ʾ
PUBLIC  c����,c��ʾ

*** ����ǰ���쵽�����ѡ�
IF c���� - DATE() < 3  && ��ǰ������ʾ���ڡ�
   c���� = "��Ebcrm �������ѡ�"
   c��ʾ = "�������"+ALLTRIM(STR(c���� - DATE()))+"����ڣ�;
   Ϊ����������ʹ�ã��뼰ʱ�빩Ӧ����ϵ��"+CHR(13)+c����֧��
   DO ..\progs\popwindows.prg
ENDIF
