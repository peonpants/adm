<!--#include file="functions.asp"-->
<!--#include file="ASocket.inc"-->
<%
    Dim smsVariant    
    Dim sms
    
 

	'*******************************************************************************************************************
	'���ϸ�	: sms.asp
	'�Լ�����
	'	GetMsgLen()							�޼��� ��ü ���̸� ����ϴ� �Լ�
	'	MakeQuery()							�߼� ������ ����� �Լ�
	'	Submit()								���� ������ ���� �Լ�
	'	ErrorNum(str, Max, Gubun)		�Էµ� �������� ���Ἲ�� üũ�ϴ� �Լ�
	'	StrLenByte(str)						�Էµ� �������� Byte�� ����ϴ� �Լ�
	'	AsciiConf(char)						ASCII ���� ������ Byte�� �����ϴ� �Լ�
	'	WaitForData( o )						������ �̿��Ͽ� �̺�Ʈ�� �߻� ������� ������ ���� ���ϵǴ� �޼����� Catch�ϱ� ���� �Լ�
	'	HanCount(str)							�߼۵� �޼��� ���� �� �ѱ��� ������ ���� �Լ�
	'	CommError(ErrNum)				���� ��ȣ�� ���� ���� �޼��� ���� �Լ�
	'																																				- Made by Gabia Inc.
	'*******************************************************************************************************************


    
    Public Function sendSms( cTranphone,  cTranmsg)
   
	    set smsVariant = New MVariant
	    Set sms = Server.CreateObject("Intrafoundation.TCPClient")    		

	    smsVariant.smsServer = "sms.gabia.com"					' ���� �ּ� �Ǵ� IP
        smsVariant.smsPort = "5000"										' ���� ��Ʈ
        smsVariant.smsTimeout = 10										' ���� TimeOut ����
        smsVariant.smsStatus = "1"											' ���ۻ��¼���
        smsVariant.sms_key = "GS"											' SMS Ű������
	    smsVariant.cTranid = "tjdgus12"							' SMS ����� ID
        smsVariant.cTranpasswd = "tjdgus2726"						' SMS ����� ��ȣ
        smsVariant.cTranphone = cTranphone			' �޴»�� �ڵ��� ��ȣ
        smsVariant.cTrancallback = "000-0000-0000"	' ������ ��� �ڵ��� ��ȣ
        smsVariant.cTrandate = "0"											' ���� ��¥ (���� '0' �ϰ�� ���ݴ��庸���°�, �� �ܿ� ���� �߼��� ��� ��¥ ������ YYYY-MM-DD HH:MM:SS �̴�)
        smsVariant.cTranmsg = cTranmsg		' ���� �޼���
	    smsVariant.smsEndOfCommand = chr(10)					' ���Ṯ��

	    
	    sms.Clear()

	    sms.Open smsVariant.smsServer, smsVariant.smsPort			' ������ ���� - ������ �̿��Ͽ� �̺�Ʈ�� �߻� ��������� �ش� �̺�Ʈ�� ���� �޼����� .LastError �޼ҵ�� Ȯ�� �� �� �ִ�.
	    sms.Timeout = smsVariant.smsTimeout

	    If sms.Connected = 1 Then			' ������ ���� ���� ���
		    Call Submit			' ������ �����ϴ� �Լ� ȣ��

		    smsVariant.ReturnMSG = sms.Recv			' ���� �޼��� ����
		    'response.write smsVariant.ReturnMSG & "<br>"

		    Err_Message = CommError(smsVariant.ReturnMSG)		' ���� �޼����� ���� �޼����� ����

		    sms.Close		' ���� ���� ����

		    set sms = nothing		' SMS ���� ��ü �ʱ�ȭ
		    set smsVariant = nothing		' Ŭ���� �ʱ�ȭ

		    sendSms =  Err_Message
	    end if
    End Function	    

%>