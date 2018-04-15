<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/08_Board/_Sql/boardSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
		BF_Idx = Trim(REQUEST("BF_Idx"))
		BFR_Idx = Trim(REQUEST("BFR_Idx"))
		BFR_Writer = Trim(REQUEST("BFR_Writer")) 
		BFR_Contents = Trim(REQUEST("BFR_Contents"&BFR_Idx)) 
		BFR_REGDATE = Trim(REQUEST("BFR_REGDATE")) 

		'response.write BFR_REGDATE
        IF BFR_REGDATE = "" Then
            BFR_REGDATE = dfStringUtil.GetFullDate(now())
        End IF     

        '######### 디비 연결                    ################	
        dfDBConn.SetConn = Application("DBConnString")
	    dfDBConn.Connect()	
    	
	    '######### 정보 입력                 ################	

	    rtnVal =  dfboardSql.updateBoard_FreeReply(dfDBConn.Conn, BFR_WRITER, BFR_CONTENTS, BFR_REGDATE, BFR_Idx)
		
        If rtnVal  then
		    With Response
			    .Write "<script>" & vbcrlf
			    .Write r & vbcrlf
			    .Write "top.ViewFrm.location.href='board_view.asp?BF_Idx="&BF_Idx&"'; " & vbcrlf
			    .Write "</script>"
			    .END
		    End With
		end IF
%>
