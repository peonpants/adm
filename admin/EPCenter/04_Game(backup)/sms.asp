<!-- #include virtual="/_Global/functions.asp" -->
<!-- #include virtual="/_Global/ASocket.inc" -->
<%
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

	Dim smsVariant
	Set smsVariant = New MVariant			' Ŭ���� ����

	smsVariant.smsServer = "sms.gabia.com"					' ���� �ּ� �Ǵ� IP
    smsVariant.smsPort = "5000"										' ���� ��Ʈ
    smsVariant.smsTimeout = 10										' ���� TimeOut ����
    smsVariant.smsStatus = "1"											' ���ۻ��¼���
    smsVariant.sms_key = "GS"											' SMS Ű������
	smsVariant.cTranid = "lohas"							' SMS ����� ID
    smsVariant.cTranpasswd = "43708"						' SMS ����� ��ȣ
    smsVariant.cTranphone = request("cTranphone")			' �޴»�� �ڵ��� ��ȣ
    smsVariant.cTrancallback = request("cTrancallback")		' ������ ��� �ڵ��� ��ȣ
    smsVariant.cTrandate = "0"											' ���� ��¥ (���� '0' �ϰ�� ���ݴ��庸���°�, �� �ܿ� ���� �߼��� ��� ��¥ ������ YYYY-MM-DD HH:MM:SS �̴�)
    smsVariant.cTranmsg = trim(request("cTranmsg"))		' ���� �޼���
	smsVariant.smsEndOfCommand = chr(10)					' ���Ṯ��

	Set sms = Server.CreateObject("Intrafoundation.TCPClient")
	sms.Clear()

	sms.Open smsVariant.smsServer, smsVariant.smsPort			' ������ ���� - ������ �̿��Ͽ� �̺�Ʈ�� �߻� ��������� �ش� �̺�Ʈ�� ���� �޼����� .LastError �޼ҵ�� Ȯ�� �� �� �ִ�.
	sms.Timeout = smsVariant.smsTimeout

	If sms.Connected = 1 Then			' ������ ���� ���� ���
		Call Submit			' ������ �����ϴ� �Լ� ȣ��

		smsVariant.ReturnMSG = sms.Recv			' ���� �޼��� ����
		response.write smsVariant.ReturnMSG & "<br>"

		Err_Message = CommError(smsVariant.ReturnMSG)		' ���� �޼����� ���� �޼����� ����

		sms.Close		' ���� ���� ����

		set sms = nothing		' SMS ���� ��ü �ʱ�ȭ
		set smsVariant = nothing		' Ŭ���� �ʱ�ȭ

		response.write Err_Message
	end if
%>