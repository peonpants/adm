<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	P_Type = Trim(REQUEST("P_Type"))
	P_SUB		= Trim(REQUEST("P_SUB"))
	P_SITE		= Trim(REQUEST("P_SITE"))
	P_CONTENTS		= Trim(REQUEST("P_CONTENTS"))
	P_WIDTH		= Trim(REQUEST("P_WIDTH"))
	P_HEIGHT		= Trim(REQUEST("P_HEIGHT"))
	P_TOP		= Trim(REQUEST("P_TOP"))
	P_LEFT		= Trim(REQUEST("P_LEFT"))
	P_YN		= Trim(REQUEST("P_YN"))
	p_idx		= Trim(REQUEST("p_idx"))
'	SQL = " SELECT P_SITE FROM POPOP02 WHERE P_SITE='"&P_SITE&"'"
'	Set RS = DbCon.Execute(SQL)
'	If Not rs.eof Then
'		With Response
'			.Write "<script>" & vbcrlf
'			.Write "alert('"&P_SITE&"의 팝업이 이미 등록되어 있습니다.'); history.back(-1);" & vbcrlf
'			.Write "</script>"
'			.END
'		End With
'	response.End 
'	End If 
'	RS.close
'	Set rs = nothing
	If P_Type = "Ins" then
		SQL = " INSERT INTO POPOP02 (  P_SUB, P_CONTENTS, P_WIDTH, P_HEIGHT, P_TOP, P_LEFT, P_SITE, P_YN) VALUES ( '"&P_SUB&"', '"&P_CONTENTS&"', '"&P_WIDTH&"', '"&P_HEIGHT&"', '"&P_TOP&"', '"&P_LEFT&"', '"&P_SITE&"', '"&P_YN&"') "
		DbCon.Execute(SQL)
	
		With Response
			.Write "<script>" & vbcrlf
			.Write "alert('등록되었습니다.'); location.href='Pop_insert.asp';" & vbcrlf
			.Write "</script>"
			.END
		End With
	elseIf P_Type = "Del" Then
		SQL = "delete from popop02 where p_idx = "&p_idx
		DbCon.Execute(SQL)
		With Response
			.Write "<script>" & vbcrlf
			.Write "alert('삭제되었습니다.'); location.href='Pop_insert.asp';" & vbcrlf
			.Write "</script>"
			.END
		End With
	ElseIf P_Type = "Mo" Then
		sql = "UPDATE POPOP02 SET "
    sql = sql & "   P_SUB      = '"&P_SUB&"', "
    sql = sql & "   P_CONTENTS = '"&P_CONTENTS&"', "
    sql = sql & "   P_WIDTH    = '"&P_WIDTH&"',"
    sql = sql & "   P_HEIGHT   = '"&P_HEIGHT&"',"
    sql = sql & "   P_TOP      = '"&P_TOP&"', "
    sql = sql & "   P_LEFT     = '"&P_LEFT&"', "
    sql = sql & "   P_SITE     = '"&P_SITE&"', "
    sql = sql & "   P_YN       = '"&P_YN&"' where p_idx = "&p_idx
		DbCon.Execute(SQL)
		'response.write sql
		'response.end
		With Response
			.Write "<script>" & vbcrlf
			.Write "alert('수정되었습니다.'); location.href='Pop_insert.asp';" & vbcrlf
			.Write "</script>"
			.END
		End With
	End If 
	DbCon.Close
	Set DbCon=Nothing

%>