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

    '#### ������ ���� ������ ����
	Call dfLoginSql.GetINFO_ADMIN(dfDBConn.Conn, LoginID)
	
    '#### ������ ���� üũ
	IA_STATUS = trim(dfLoginSql.RsOne("IA_STATUS"))
	
	If IA_STATUS = 0 Then
		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('�Է��Ͻ� ���̵�� ���������Դϴ�\n�����Ϳ� �����ϼ���');" & vbcrlf
			.write "history.back();" & vbCrLf
			.write "</script>"
			.end
		End With
	End IF

    '### ���������� �α���
	IF dfLoginSql.RsCount = 0  THEN
	    '#### ���� �α� �����
	    Call dfLoginSql.insertCHK_ADMIN(dfDBConn.Conn, LoginID, dfRequest.GetRemoteAddr(),0)
    		
		With Response
			.write "<script language='javascript'>" & vbCrLf
			.write "alert('�Է��Ͻ� ���̵� �������� �ʽ��ϴ�.');" & vbcrlf
			.write "history.back();" & vbCrLf
			.write "</script>"
			.end
		End With
	ELSE
	    '### �������� �α���
		IA_PW = trim(dfLoginSql.RsOne("IA_PW"))
		IF IA_PW = LoginPW THEN
		            		
	        '#### ���� �α� �����
	        Call dfLoginSql.insertCHK_ADMIN(dfDBConn.Conn, LoginID, dfRequest.GetRemoteAddr(),1)		
			SESSION("rAdminID")	= dfLoginSql.RsOne("IA_ID")				
			SESSION("rAdminLevel")	= 1
			SESSION("rJOBSITE")	= dfLoginSql.RsOne("IA_SITE")
		ELSE
		    '### ��й�ȣ ����
	            '#### ���� �α� �����
	            Call dfLoginSql.insertCHK_ADMIN(dfDBConn.Conn, LoginID, dfRequest.GetRemoteAddr(),0)		    
			With Response
				.write "<script language='javascript'>" & vbCrLf
				.write "alert('������ ��й�ȣ�� Ȯ���ϼ���.');" & vbcrlf
				.write "history.back();" & vbCrLf
				.write "</script>"
				.end
			End With
		END IF
	END IF

%>