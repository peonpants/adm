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
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->

<%
	
	IBC_IDX			=	REQUEST("IBC_IDX")	
	FLAG		=	REQUEST("FLAG")	
    hid_data	=	REQUEST("hid_data")
    if  hid_data <> "" then
    IBC_CONTENTS=hid_data
    end if

	IF FLAG = "ADDC" THEN
       
		SQLSTR = "INSERT INTO INFO_BOARD_CONTENTS (IBC_CONTENTS, IBC_TYPE)"
		SQLSTR = SQLSTR& " VALUES ('"& IBC_CONTENTS &"','0')"
        'response.Write(SQLSTR&"구분"&hid_data)
		DbCon.execute(SQLSTR)

		With Response
			.Write "<script language=javascript>" & vbCrLf
			.Write "alert('코멘트가 추가되었습니다.');" & vbCrLf
			.Write "location.href='board_contents_List.asp';" & vbCrLf
			.Write "</script>" & vbCrLf
		End With

	ElseIF FLAG = "ADDH" THEN
       
		SQLSTR = "INSERT INTO INFO_BOARD_CONTENTS (,IBC_CONTENTS, IBC_TYPE)"
		SQLSTR = SQLSTR& " VALUES ('"& IBC_CONTENTS &"','1')"
        'response.Write(SQLSTR&"구분"&hid_data)
		DbCon.execute(SQLSTR)

		With Response
			.Write "<script language=javascript>" & vbCrLf
			.Write "alert('코멘트가 추가되었습니다.');" & vbCrLf
			.Write "location.href='board_contents_List.asp';" & vbCrLf
			.Write "</script>" & vbCrLf
		End With
		
	ELSEIF FLAG = "ADDS" THEN
       
		SQLSTR = "INSERT INTO INFO_BOARD_CONTENTS (IBC_CONTENTS, IBC_TYPE)"
		SQLSTR = SQLSTR& " VALUES ('"& IBC_CONTENTS &"','2')"
        'response.Write(SQLSTR&"구분"&hid_data)
		DbCon.execute(SQLSTR)

		With Response
			.Write "<script language=javascript>" & vbCrLf
			.Write "alert('코멘트가 추가되었습니다.');" & vbCrLf
			.Write "location.href='board_contents_List.asp';" & vbCrLf
			.Write "</script>" & vbCrLf
		End With

	ELSEIF FLAG = "DEL" THEN
    
		SQLSTR = "DELETE INFO_BOARD_CONTENTS WHERE IBC_IDX = '"& IBC_IDX &"'" 

		DbCon.execute(SQLSTR)

		With Response
			.Write "<script language=javascript>" & vbCrLf
			.Write "alert('해당 코멘트가 삭제되었습니다.');" & vbCrLf
			.Write "location.href='board_contents_List.asp';" & vbCrLf
			.Write "</script>" & vbCrLf
		End With
    
	END IF

	DbCon.Close
	Set DbCon=Nothing	%>