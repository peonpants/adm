<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include file="../_Sql/LoginSql.class.asp"-->
<%
	LoginID = Trim(REQUEST("AdminID"))
	LoginPW = Trim(REQUEST("AdminPW"))
	strIP = Request.ServerVariables("REMOTE_ADDR")

    '######### DB Connect                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	

    '#### ������ ���� ������ ����
	'Call dfLoginSql.GetINFO_ADMIN(dfDBConn.Conn, LoginID,strIP)

	Call dfLoginSql.GetINFO_ADMIN(dfDBConn.Conn, LoginID)
	
    '#### ������ ���� üũ
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
	Else
	
		'IPCNT = trim(dfLoginSql.RsOne("CNT"))

		'IF cStr(dfLoginSql.RsOne("CNT")) <>  "1" Then 
	
		'	With Response
		'	.write "<script language='javascript'>" & vbCrLf
		'	.write "alert('���� �����ǰ� �ƴմϴ�.');" & vbcrlf
		'	.write "history.back();" & vbCrLf
		'	.write "</script>"
		'	.end
		'End With
	      
		'		response.End 
		'ELSE
	    '### �������� �α���
			IA_PW = trim(dfLoginSql.RsOne("IA_PW"))
			IF (cStr(dfLoginSql.RsOne("IA_LEVEL")) =  "1") then
			
			ELSE
			  ' IF (cStr(dfLoginSql.RsOne("IA_LEVEL")) <>  "2") Then
	%>
			<script type="text/javascript">
			alert("�������� ���ٹٶ��ϴ�.");
			history.back();
			</script>
	<%      
				response.End  
			 ' End IF
			End IF
        'END IF
		IF IA_PW = LoginPW THEN

            AdminInfo = dfLoginSql.RsOne("IA_ID") & "|" & dfLoginSql.RsOne("IA_LEVEL") & "|" & dfLoginSql.RsOne("IA_SITE") & "|" & dfLoginSql.RsOne("IA_GROUP") & "|" & Request.ServerVariables("REMOTE_ADDR")
            
            Set CAPIUtil = Server.CreateObject("CAPICOM.Utilities")
            AdminInfo = CAPIUtil.Base64Encode(AdminInfo) 
            Set CAPIUtil = Nothing
            
			With Response
				.Cookies("AdminID")	= dfLoginSql.RsOne("IA_ID")
				.Cookies("AdminLevel") = dfLoginSql.RsOne("IA_LEVEL")
				.Cookies("JOBSITE")	= dfLoginSql.RsOne("IA_SITE")
				.Cookies("GROUP")	= dfLoginSql.RsOne("IA_GROUP")
				.Cookies("AdminID2")	= AdminInfo
			End With
			Call dfLoginSql.insertCHK_ADMIN(dfDBConn.Conn, LoginID, dfRequest.GetRemoteAddr(),1)			
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