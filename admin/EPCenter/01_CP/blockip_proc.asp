<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%	
	mode  = Request("mode")
	ip1 = Trim(REQUEST("ip1"))
	ip2 = Trim(REQUEST("ip2"))
	ip3 = Trim(REQUEST("ip3"))
    ip4 = Trim(REQUEST("ip4"))

	strIP = request.ServerVariables( "REMOTE_ADDR" )
	
	BIP			=	ip1 & "." & ip2  & "." & ip3  & "." & ip4

    
    IF mode = "add"  Then
        
		SQLSTR = "INSERT INTO INFO_ADMINIP ( IAI_IP,IAI_REG_IP,IAI_DELYN,IAI_REGDATE)"
		SQLSTR = SQLSTR& " VALUES ('"& BIP &"','"&strIP&"','N',getdate())"
		DbCon.execute(SQLSTR)

		With Response
			.Write "<script language=javascript>" & vbCrLf
			.Write "alert('아이피가 추가되었습니다.');" & vbCrLf
			.Write "location.href='blockip.asp';" & vbCrLf
			.Write "</script>" & vbCrLf
		End With
       
    Else mode = "del"  
        SEQ  = dfRequest("SEQ")

		SQLSTR = "update INFO_ADMINIP set IAI_DELYN='Y' WHERE IAI_IDX = '"& SEQ &"'" 

		DbCon.execute(SQLSTR)

		With Response
			.Write "<script language=javascript>" & vbCrLf
			.Write "alert('아이피가 차단 되었습니다.');" & vbCrLf
			.Write "location.href='blockip.asp';" & vbCrLf
			.Write "</script>" & vbCrLf
		End With		    
    End IF
	DbCon.Close
	Set DbCon=Nothing	
%>