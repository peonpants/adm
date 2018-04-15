<%	
	Class MVariant			' 각종 정보를 저장하는 클래스 선언
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

	Function GetMsgLen()		' 메세지 전체 길이를 계산하는 함수
		GetMsgLen = StrLenByte(smsVariant.cTranid) + StrLenByte(smsVariant.cTranpasswd) + StrLenByte(smsVariant.cTranphone) + StrLenByte(smsVariant.cTrancallback) + StrLenByte(smsVariant.smsStatus) + StrLenByte(smsVariant.cTrandate) + StrLenByte(smsVariant.cTranmsg) + 1
	End Function

	Function MakeQuery()		' 발송 쿼리를 만드는 함수
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

	Function Submit()		' 실제 데이터 전송 함수
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
			'response.write "전송된 메세지->" & Query & "<br>"
		End IF
	End Function

	Function ErrorNum(str, Max, Gubun)		' 입력된 데이터의 무결성을 체크하는 함수
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

	Function StrLenByte(str)		' 입력된 데이터의 Byte를 계산하는 함수
		digit = 0

		for i=1 to len(str)
			tmp_str = mid(str, i, 1)
			digit = cInt(digit) + cInt(AsciiConf(tmp_str))
		next
		StrLenByte = digit
	End Function

	Function AsciiConf(char)		' ASCII 값을 가지고 Byte를 추출하는 함수
		IF asc(char) >= 0 then
			AsciiConf = 1
		ElseIF asc(char) < 0 then
			AsciiConf = 2
		End IF
	End Function

	Function WaitForData( o )		' 소켓을 이용하여 이벤트를 발생 했을경우 서버로 부터 리턴되는 메세지를 Catch하기 위한 함수
		nRetr = 0
		Do While nRetr < 5 and o.HasData = False
			o.Sleep 2000
			nRetr = nRetr + 1
		Loop
	End Function
	
	Function HanCount(str)		' 발송될 메세지 내용 중 한글의 갯수를 세는 함수
		tmp_cnt = 0
		for i=1 to len(str)
			tmp_str = mid(str, i, 1)

			IF asc(tmp_str) < 0 then
				tmp_cnt = tmp_cnt + 1
			End IF
		next

		HanCount = tmp_cnt
	End Function

	Function CommError(ErrNum)		' 오류 번호에 따른 오류 메세지 리턴 함수
		Select Case ErrNum
			Case SMS_RETURN_SUCCESS
				CommError = "전송성공"
			Case SMS_FAULT_DATA
				CommError = "데이터 형식 오류"
			Case SMS_TIMEOUT
				CommError = "데이터 전송 Time Out"
			Case SMS_HEAD_ERROR
				CommError = "SMS 헤더 에러"
			Case SMS_LENGTH_ERROR
				CommError = "전송 전체길이 체크 오류"
			Case SMS_SEND_STATUS_ERROR
				CommError = "전송상태값 오류"
			Case SMS_TIME_ERROR
				CommError = "전송시간 오류"
			Case SMS_LOGIN_ERROR
				CommError = "SMS발송 권한인증 오류"
			Case SMS_CANNOT_SEND
				CommError = "메세지 발송건수가 0"
			Case SMS_DB_INSERT_ERROR
				CommError = "DB Insert 오류"
			Case SMS_SEND_COUNT_MINUS
				CommError = "메세지 발송 건수가 0보다 작음"
			Case SMS_CLIENT_IP_ERROR
				CommError = "서버에 없는 Client IP"
			Case SMS_ID_LENGTH_ERROR
				CommError = "인증 ID길이 오류 (최대 20Byte)"
			Case SMS_PASS_LENGTH_ERROR
				CommError = "인증 암호길이 오류 (최대 20Byte)"
			Case SMS_RECVTEL_LENGTH_ERROR
				CommError = "수신자 핸드폰번호 길이 오류 (최대 15Byte)"
			Case SMS_SENDTEL_LENGTH_ERROR
				CommError = "발신자 핸드폰번호 길이 오류 (최대 15Byte)"
			Case SMS_RESERVE_TIME_ERROR
				CommError = "예약발송 시간형태 오류"
			Case SMS_SENDMSG_LENGTH_ERROR
				CommError = "전송 메세지 길이 오류 (최대 80Byte)"
			Case SMS_SENDTOTAL_LENGTH_ERROR
				CommError = "전송 데이터 길이 오류 (최대 170Byte)"
		End Select
	End Function
%>