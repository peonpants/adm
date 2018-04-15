<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
    
	mode  = dfRequest("mode")
    ipNum1  = dfRequest("ipNum1")
    ipNum2  = dfRequest("ipNum2")
    ipNum3  = dfRequest("ipNum3")
    ipNum4  = dfRequest("ipNum4")
    ipNum5  = dfRequest("ipNum5")

    BIP			=	ipNum1 & "." & ipNum2  & "." & ipNum3  & "." & ipNum4
    
    IF mode = "add"  Then
        if ipNum5 = "" Then
	        SQLSTR = "INSERT INTO BLOCK_IP ( BlockIP, BlockDate)"
	        SQLSTR = SQLSTR& " VALUES ( '"& BIP &"', getdate())"
	        DbCon.execute(SQLSTR)

	        With Response
		        .Write "<script language=javascript>" & vbCrLf
		        .Write "alert('단일 아이피가 차단되었습니다.');" & vbCrLf
		        .Write "location.href='Block_Ip.asp?page="&PAGE&"&sStartDate="&sStartDate&"&sEndDate="&sEndDate&"&Search="&Search&"&Find="&Find&"';" & vbCrLf
		        .Write "</script>" & vbCrLf
	        End With
        Else
            For i = ipNum4 to ipNum5
                BIP			=	ipNum1 & "." & ipNum2  & "." & ipNum3  & "." & i        
	            SQLSTR = "INSERT INTO BLOCK_IP ( BlockIP, BlockDate)"
	            SQLSTR = SQLSTR& " VALUES ( '"& BIP &"', getdate())"
	            DbCon.execute(SQLSTR)    	                        
            Next	        

	        With Response
		        .Write "<script language=javascript>" & vbCrLf
		        .Write "alert('연속 된 아이피가 차단되었습니다.');" & vbCrLf
		        .Write "location.href='Block_Ip.asp?page="&PAGE&"&sStartDate="&sStartDate&"&sEndDate="&sEndDate&"&Search="&Search&"&Find="&Find&"';" & vbCrLf
		        .Write "</script>" & vbCrLf
	        End With
	                    
        End IF
    Else mode = "del"  
        SEQ  = dfRequest("SEQ")
        SQLSTR = "DELETE BLOCK_IP WHERE SEQ = '"& SEQ &"'" 

		DbCon.execute(SQLSTR)

		With Response
			.Write "<script language=javascript>" & vbCrLf
			.Write "alert('아이피가 차단 해제되었습니다.');" & vbCrLf
			.Write "location.href='Block_Ip.asp?page="&PAGE&"&sStartDate="&sStartDate&"&sEndDate="&sEndDate&"&Search="&Search&"&Find="&Find&"';" & vbCrLf
			.Write "</script>" & vbCrLf
		End With		    
    End IF
	DbCon.Close
	Set DbCon=Nothing	
%>