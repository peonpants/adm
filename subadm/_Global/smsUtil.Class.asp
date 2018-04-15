<!--#include file="functions.asp"-->
<!--#include file="ASocket.inc"-->
<%
    Dim smsVariant    
    Dim sms
    
 

	'*******************************************************************************************************************
	'파일명	: sms.asp
	'함수정의
	'	GetMsgLen()							메세지 전체 길이를 계산하는 함수
	'	MakeQuery()							발송 쿼리를 만드는 함수
	'	Submit()								실제 데이터 전송 함수
	'	ErrorNum(str, Max, Gubun)		입력된 데이터의 무결성을 체크하는 함수
	'	StrLenByte(str)						입력된 데이터의 Byte를 계산하는 함수
	'	AsciiConf(char)						ASCII 값을 가지고 Byte를 추출하는 함수
	'	WaitForData( o )						소켓을 이용하여 이벤트를 발생 했을경우 서버로 부터 리턴되는 메세지를 Catch하기 위한 함수
	'	HanCount(str)							발송될 메세지 내용 중 한글의 갯수를 세는 함수
	'	CommError(ErrNum)				오류 번호에 따른 오류 메세지 리턴 함수
	'																																				- Made by Gabia Inc.
	'*******************************************************************************************************************


    
    Public Function sendSms( cTranphone,  cTranmsg)
   
	    set smsVariant = New MVariant
	    Set sms = Server.CreateObject("Intrafoundation.TCPClient")    		

	    smsVariant.smsServer = "sms.gabia.com"					' 서버 주소 또는 IP
        smsVariant.smsPort = "5000"										' 연결 포트
        smsVariant.smsTimeout = 10										' 연결 TimeOut 설정
        smsVariant.smsStatus = "1"											' 전송상태설정
        smsVariant.sms_key = "GS"											' SMS 키값설정
	    smsVariant.cTranid = "tjdgus12"							' SMS 사용자 ID
        smsVariant.cTranpasswd = "tjdgus2726"						' SMS 사용자 암호
        smsVariant.cTranphone = cTranphone			' 받는사람 핸드폰 번호
        smsVariant.cTrancallback = "000-0000-0000"	' 보내는 사람 핸드폰 번호
        smsVariant.cTrandate = "0"											' 보낼 날짜 (값이 '0' 일경우 지금당장보내는것, 그 외에 예약 발송일 경우 날짜 패턴은 YYYY-MM-DD HH:MM:SS 이다)
        smsVariant.cTranmsg = cTranmsg		' 보낼 메세지
	    smsVariant.smsEndOfCommand = chr(10)					' 종료문자

	    
	    sms.Clear()

	    sms.Open smsVariant.smsServer, smsVariant.smsPort			' 서버에 연결 - 소켓을 이용하여 이벤트를 발생 시켰을경우 해당 이벤트에 대한 메세지는 .LastError 메소드로 확인 할 수 있다.
	    sms.Timeout = smsVariant.smsTimeout

	    If sms.Connected = 1 Then			' 연결이 성공 했을 경우
		    Call Submit			' 서버에 전송하는 함수 호출

		    smsVariant.ReturnMSG = sms.Recv			' 리턴 메세지 저장
		    'response.write smsVariant.ReturnMSG & "<br>"

		    Err_Message = CommError(smsVariant.ReturnMSG)		' 리턴 메세지로 에러 메세지를 추출

		    sms.Close		' 소켓 연결 해제

		    set sms = nothing		' SMS 소켓 개체 초기화
		    set smsVariant = nothing		' 클래스 초기화

		    sendSms =  Err_Message
	    end if
    End Function	    

%>