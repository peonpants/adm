<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include file="../_Sql/LoginSql.class.asp"-->
<%
	LoginID = Trim(REQUEST("AdminID"))
	LoginPW = Trim(REQUEST("AdminPW"))

    '######### DB Connect                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	

    '#### 관리자 정보 가지고 오기
	Call dfLoginSql.GetINFO_ADMIN(dfDBConn.Conn, LoginID)
	
    '#### 관리자 정보 체크
	IA_STATUS = trim(dfLoginSql.RsOne("IA_STATUS"))
	
	If IA_STATUS = 0 Then
		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('입력하신 아이디는 보류상태입니다\n고객센터에 문의하세요');" & vbcrlf
			.write "history.back();" & vbCrLf
			.write "</script>"
			.end
		End With
	End IF

    '### 비정상적인 로그인
	IF dfLoginSql.RsCount = 0  THEN
	    '#### 접속 로그 남기기
	    Call dfLoginSql.insertCHK_ADMIN(dfDBConn.Conn, LoginID, dfRequest.GetRemoteAddr(),0)
    		
		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('입력하신 아이디가 존재하지 않습니다.');" & vbcrlf
			.write "history.back();" & vbCrLf
			.write "</script>"
			.end
		End With
	ELSE
	    '### 정상적인 로그인
		IA_PW = trim(dfLoginSql.RsOne("IA_PW"))
		IF IA_PW = LoginPW THEN
		            		
	        '#### 접속 로그 남기기
	        Call dfLoginSql.insertCHK_ADMIN(dfDBConn.Conn, LoginID, dfRequest.GetRemoteAddr(),1)		
			SESSION("rAdminID")	= dfLoginSql.RsOne("IA_ID")				
			SESSION("rAdminLevel")	= 1
			SESSION("rJOBSITE")	= dfLoginSql.RsOne("IA_SITE")
		ELSE
		    '### 비밀번호 오류
	            '#### 접속 로그 남기기
	            Call dfLoginSql.insertCHK_ADMIN(dfDBConn.Conn, LoginID, dfRequest.GetRemoteAddr(),0)		    
			With Response
				.write "<script language='javascript'>" & vbCrLf
				.write "alert('관리자 비밀번호를 확인하세요.');" & vbcrlf
				.write "history.back();" & vbCrLf
				.write "</script>"
				.end
			End With
		END IF
	END IF

%>