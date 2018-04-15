<%	
	Class MVariant			' ���� ������ �����ϴ� Ŭ���� ����
		Dim smsServer
		Dim smsPort
		Dim smsTimeout
		Dim smsStatus
		Dim sms_key
		Dim smsEndOfCommand
		Dim cTranid
		Dim cTranpasswd
		Dim cTranphone
		Dim cTrancallback
		Dim cTrandate
		Dim cTranmsg
		Dim ReturnMSG
		Dim SockError
		Dim Connection
		Dim HanCnt
	End Class

	Function GetMsgLen()		' �޼��� ��ü ���̸� ����ϴ� �Լ�
		GetMsgLen = StrLenByte(smsVariant.cTranid) + StrLenByte(smsVariant.cTranpasswd) + StrLenByte(smsVariant.cTranphone) + StrLenByte(smsVariant.cTrancallback) + StrLenByte(smsVariant.smsStatus) + StrLenByte(smsVariant.cTrandate) + StrLenByte(smsVariant.cTranmsg) + 1
	End Function

	Function MakeQuery()		' �߼� ������ ����� �Լ�
		Dim tmpQuery
		Dim TotalLen
		Dim ErrorKey
		
		TotalLen = GetMsgLen
		
		If ErrorNum(smsVariant.cTranid, 20, "cTranid") Then
			ErrorKey = True
		ElseIf ErrorNum(smsVariant.cTranpasswd, 20, "cTranpasswd") Then
			ErrorKey = True
		ElseIf ErrorNum(smsVariant.cTranphone, 15, "cTranphone") Then
			ErrorKey = True
		ElseIf ErrorNum(smsVariant.cTrancallback, 15, "cTrancallback") Then
			ErrorKey = True
		ElseIf ErrorNum(smsVariant.cTrandate, 19, "cTrandate") Then
			ErrorKey = True
		ElseIf ErrorNum(smsVariant.cTranmsg, 80, "cTranmsg") Then
			ErrorKey = True
		ElseIf ErrorNum(smsVariant.cTranid & smsVariant.cTranpasswd & smsVariant.cTranphone & smsVariant.cTrancallback & smsVariant.smsStatus & smsVariant.cTrandate & smsVariant.cTranmsg, 170, "TotalLen") Then
			ErrorKey = True
		End If
		
		If ErrorKey = True Then
			Exit Function
		Else
			tmpQuery = smsVariant.sms_key & ","
			tmpQuery = tmpQuery & TotalLen & ","
			tmpQuery = tmpQuery & smsVariant.cTranid & ","
			tmpQuery = tmpQuery & smsVariant.cTranpasswd & ","
			tmpQuery = tmpQuery & smsVariant.cTranphone & ","
			tmpQuery = tmpQuery & smsVariant.cTrancallback & ","
			tmpQuery = tmpQuery & smsVariant.smsStatus & ","
			tmpQuery = tmpQuery & smsVariant.cTrandate & ","
			tmpQuery = tmpQuery & trim(smsVariant.cTranmsg)

			MakeQuery = tmpQuery
		End If
	End Function

	Function Submit()		' ���� ������ ���� �Լ�
		Dim Query
		Query = MakeQuery()

		IF IsNull(Query) OR Query = "" Then
			IF CInt(smsVariant.ReturnMSG) > 700 Then
				response.write CommError(smsVariant.ReturnMSG)
				response.end
			End IF
		ELSE
			Query = trim(Query) & smsVariant.smsEndOfCommand

			sms.Send(Query)
			'response.write "���۵� �޼���->" & Query & "<br>"
		End IF
	End Function

	Function ErrorNum(str, Max, Gubun)		' �Էµ� �������� ���Ἲ�� üũ�ϴ� �Լ�
		Dim ErrorKey
		
		If StrLenByte(str) > Max Then
			ErrorKey = True
		End If
		
		If ErrorKey = True Then
			Select Case Gubun
				Case "cTranid"
					smsVariant.ReturnMSG = "701"
				Case "cTranpasswd"
					smsVariant.ReturnMSG = "702"
				Case "cTranphone"
					smsVariant.ReturnMSG = "703"
				Case "cTrancallback"
					smsVariant.ReturnMSG = "704"
				Case "cTrandate"
					smsVariant.ReturnMSG = "705"
				Case "cTranmsg"
					smsVariant.ReturnMSG = "706"
				Case "TotalLen"
					smsVariant.ReturnMSG = "707"
			End Select
		End If
		
		ErrorNum = ErrorKey
	End Function

	Function StrLenByte(str)		' �Էµ� �������� Byte�� ����ϴ� �Լ�
		digit = 0

		for i=1 to len(str)
			tmp_str = mid(str, i, 1)
			digit = cInt(digit) + cInt(AsciiConf(tmp_str))
		next
		StrLenByte = digit
	End Function

	Function AsciiConf(char)		' ASCII ���� ������ Byte�� �����ϴ� �Լ�
		IF asc(char) >= 0 then
			AsciiConf = 1
		ElseIF asc(char) < 0 then
			AsciiConf = 2
		End IF
	End Function

	Function WaitForData( o )		' ������ �̿��Ͽ� �̺�Ʈ�� �߻� ������� ������ ���� ���ϵǴ� �޼����� Catch�ϱ� ���� �Լ�
		nRetr = 0
		Do While nRetr < 5 and o.HasData = False
			o.Sleep 2000
			nRetr = nRetr + 1
		Loop
	End Function
	
	Function HanCount(str)		' �߼۵� �޼��� ���� �� �ѱ��� ������ ���� �Լ�
		tmp_cnt = 0
		for i=1 to len(str)
			tmp_str = mid(str, i, 1)

			IF asc(tmp_str) < 0 then
				tmp_cnt = tmp_cnt + 1
			End IF
		next

		HanCount = tmp_cnt
	End Function

	Function CommError(ErrNum)		' ���� ��ȣ�� ���� ���� �޼��� ���� �Լ�
		Select Case ErrNum
			Case SMS_RETURN_SUCCESS
				CommError = "���ۼ���"
			Case SMS_FAULT_DATA
				CommError = "������ ���� ����"
			Case SMS_TIMEOUT
				CommError = "������ ���� Time Out"
			Case SMS_HEAD_ERROR
				CommError = "SMS ��� ����"
			Case SMS_LENGTH_ERROR
				CommError = "���� ��ü���� üũ ����"
			Case SMS_SEND_STATUS_ERROR
				CommError = "���ۻ��°� ����"
			Case SMS_TIME_ERROR
				CommError = "���۽ð� ����"
			Case SMS_LOGIN_ERROR
				CommError = "SMS�߼� �������� ����"
			Case SMS_CANNOT_SEND
				CommError = "�޼��� �߼۰Ǽ��� 0"
			Case SMS_DB_INSERT_ERROR
				CommError = "DB Insert ����"
			Case SMS_SEND_COUNT_MINUS
				CommError = "�޼��� �߼� �Ǽ��� 0���� ����"
			Case SMS_CLIENT_IP_ERROR
				CommError = "������ ���� Client IP"
			Case SMS_ID_LENGTH_ERROR
				CommError = "���� ID���� ���� (�ִ� 20Byte)"
			Case SMS_PASS_LENGTH_ERROR
				CommError = "���� ��ȣ���� ���� (�ִ� 20Byte)"
			Case SMS_RECVTEL_LENGTH_ERROR
				CommError = "������ �ڵ�����ȣ ���� ���� (�ִ� 15Byte)"
			Case SMS_SENDTEL_LENGTH_ERROR
				CommError = "�߽��� �ڵ�����ȣ ���� ���� (�ִ� 15Byte)"
			Case SMS_RESERVE_TIME_ERROR
				CommError = "����߼� �ð����� ����"
			Case SMS_SENDMSG_LENGTH_ERROR
				CommError = "���� �޼��� ���� ���� (�ִ� 80Byte)"
			Case SMS_SENDTOTAL_LENGTH_ERROR
				CommError = "���� ������ ���� ���� (�ִ� 170Byte)"
		End Select
	End Function
%>