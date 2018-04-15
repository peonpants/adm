<%@Language="VBScript" CODEPAGE="949"%>
<!-- #include virtual="/_Global/lta_object.asp" -->
<!-- #include virtual="/_Global/lta_function.asp" -->
<!-- #include virtual="/_Global/lta_const.asp" -->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	upath = "D:\Fine\UpFile\Upload"
	
	Set uploadform = Server.CreateObject("DEXT.FileUpload") 
	uploadform.DefaultPath = upath
	
	If Trim(uploadform("xls")) <> "" then
		Set fs =  server.CreateObject("Scripting.FileSystemObject")
		
		FileName = uploadform("xls")
		FileSize = uploadform("xls").Filelen
		
		If Lcase(Right(FileName,3)) = "xls" then
			If FileSize = 0 then
				With Response
					.write "<script language='javascript'>"  & vbCrLf
					.write "alert('등록된 파일이 0byte 입니다. 다시 파일을 입력해주세요');"  & vbCrLf
					.write "</script>" & vbCrLf
					.End
				End With
			End if 
				
		else	
			With Response
				.write "<script language='javascript'>"  & vbCrLf
				.write "alert('확장자 xls 만 등록이 가능합니다.');"  & vbCrLf
				.write "</script>" & vbCrLf
				.End
			End With
		End if
		
		FileExt = right(FileName, 3)
		
		FileName = "XLS_" & replace(date(),"-", "") & "." & FileExt
		uploadform("xls").SaveAs(FileName)
		set fs = Nothing
	Else
		FileName = ""
	End if
	
	Set clsObj = new clsObject
	Set DBc = clsObj.Get_DB_Connection(LTA)
	
	Set xlDb = Server.CreateObject("ADODB.Connection")
	xlDb.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source="&upath&"\"&FileName&"; Extended Properties=Excel 8.0;"
	qSelect = "Select * From [승무패$] "
	Set oRs = Server.CreateObject("ADODB.RecordSet")
	oRs.Open qSelect, xlDb


	If Not oRs.EOF Then
		oRs.MoveFirst
		Do While Not oRs.EOF 
		If oRs(0) <> "" then
	Set tRs = Server.CreateObject("ADODB.RecordSet")
	

	SQL1  = "SELECT RL_IDX, RL_SPORTS, RL_LEAGUE, RL_IMAGE FROM Ref_League WHERE RL_CODE = '" & oRs(2) & "' "
	tRS.Open SQL1, DBc,adOpenStatic, adLockReadOnly, adCmdText
	
	response.write SQL1&"<br>"

	RL_IDX		= tRS(0)
	SRS_Sports	= tRS(1)
	RL_LEAGUE	= tRS(2)
	RL_IMAGE	= tRS(3)

	tRS.Close
	Set tRS = Nothing
	If InStr(oRs(1),"오전") > 0 Then
		IG_StartTime = "CAST('"&oRs(0)&" "&oRs(1)&"','yyyy-mm-dd AM hh:MI:SS') "
	Else
		IG_StartTime = "CAST('"&oRs(0)&" "&oRs(1)&"','yyyy-mm-dd PM hh:MI:SS') "
	End If 

	'IG_StartTime	= SYear & "-" & SMonth & "-" & SDay & " " & SHour & ":" & SMinute & ":00"
	IG_HANDICAP		= 0
	IG_Team1		= oRs(3)
	IG_Team2		= oRs(6)
	IG_TEAM1BENEFIT = oRs(4)
	IG_DRAWBENEFIT	= oRs(5)
	IG_TEAM2BENEFIT = oRs(7)
	IG_TYPE			= 0
	IG_Memo			= ""			

	SQL = "INSERT INTO INFO_GAME ( RL_Idx, RL_Sports, RL_League, RL_Image, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, "
	SQL = SQL & "IG_Type, IG_VSPoint, IG_Memo, IG_SITE) VALUES ( "
	SQL = SQL & RL_Idx & ", '"
	SQL = SQL & SRS_Sports & "', '"
	SQL = SQL & RL_LEAGUE & "', '"
	SQL = SQL & RL_IMAGE & "', "
	SQL = SQL & IG_StartTime & ", '"
	SQL = SQL & IG_Team1 & "', '"
	SQL = SQL & IG_Team2 & "', "
	SQL = SQL & IG_Handicap & ", "
	SQL = SQL & Cdbl(IG_Team1Benefit) & ", "
	If IG_DRAWBENEFIT <> "" And  IG_DRAWBENEFIT <> Null Then 
	SQL = SQL & Cdbl(IG_DrawBenefit) & ", "
	Else
	SQL = SQL & "0, "
	End If 
	SQL = SQL & Cdbl(IG_Team2Benefit) & ", '"
	SQL = SQL & IG_Type & "', "
	SQL = SQL & Cdbl(IG_VSPoint) & ", '"
	SQL = SQL & IG_Memo & "', '"& IG_SITE &"') "
	response.write SQL
	DBc.Execute (SQL)
	End If 
	oRs.MoveNext        
	Loop
	
	End If 

	Set xlDb2 = Server.CreateObject("ADODB.Connection")
	xlDb2.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source="&upath&"\"&FileName&"; Extended Properties=Excel 8.0;"
	qSelect2 = "Select * From [핸디캡$] "
	Set oRs2 = Server.CreateObject("ADODB.RecordSet")
	oRs2.Open qSelect2, xlDb2


	If Not oRs2.EOF Then
		oRs2.MoveFirst
		Do While Not oRs2.EOF 
		If oRs2(0) <> "" then
	Set tRs = Server.CreateObject("ADODB.RecordSet")
	
	Set clsObj = new clsObject
	Set DBc = clsObj.Get_DB_Connection(LTA)
	
	SQL1  = "SELECT RL_IDX, RL_SPORTS, RL_LEAGUE, RL_IMAGE FROM Ref_League WHERE RL_CODE = '" & oRs2(2) & "' "
	tRS.Open SQL1, DBc,adOpenStatic, adLockReadOnly, adCmdText
	
	RL_IDX		= tRS(0)
	SRS_Sports	= tRS(1)
	RL_LEAGUE	= tRS(2)
	RL_IMAGE	= tRS(3)

	tRS.Close
	Set tRS = Nothing
	If InStr(oRs2(1),"오전") > 0 Then
		IG_StartTime = "CAST('"&oRs2(0)&" "&oRs2(1)&"','yyyy-mm-dd AM hh:MI:SS') "
	Else
		IG_StartTime = "CAST('"&oRs2(0)&" "&oRs2(1)&"','yyyy-mm-dd PM hh:MI:SS') "
	End If 

	If oRs2(7) = "원정팀" Then
		IG_HANDICAP = -oRs2(8)
	Else 
		IG_HANDICAP = oRs2(8)
	End If 

	IG_Team1		= oRs2(3)
	IG_Team2		= oRs2(5)	
	IG_TEAM1BENEFIT = oRs2(4)
	IG_DRAWBENEFIT	= 0
	IG_TEAM2BENEFIT = oRs2(6)
	IG_TYPE			= 1
	IG_Memo			= ""

		SQL = "INSERT INTO INFO_GAME ( RL_Idx, RL_Sports, RL_League, RL_Image, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, "
		SQL = SQL & "IG_Type, IG_VSPoint, IG_Memo, IG_SITE) VALUES ( "
		SQL = SQL & RL_Idx & ", '"
		SQL = SQL & SRS_Sports & "', '"
		SQL = SQL & RL_League & "', '"
		SQL = SQL & RL_IMAGE & "', "
		SQL = SQL & IG_StartTime & ", '"
		SQL = SQL & IG_Team1 & "', '"
		SQL = SQL & IG_Team2 & "', "
		SQL = SQL & IG_Handicap & ", "
		SQL = SQL & Cdbl(IG_Team1Benefit) & ", "
		SQL = SQL & Cdbl(IG_DrawBenefit) & ", "
		SQL = SQL & Cdbl(IG_Team2Benefit) & ", '"
		SQL = SQL & IG_Type & "', "
		SQL = SQL & Cdbl(IG_VSPoint) & ", '"
		SQL = SQL & IG_Memo & "', '"& IG_SITE &"') "
		DBc.Execute (SQL)
		response.write sQL
		response.write "<br>"
		End If 
	oRs2.MoveNext        
	Loop
	
	End If 

'---
	Set xlDb3 = Server.CreateObject("ADODB.Connection")
	xlDb3.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source="&upath&"\"&FileName&"; Extended Properties=Excel 8.0;"
	qSelect3 = "Select * From [오버언더$] "
	Set oRs3 = Server.CreateObject("ADODB.RecordSet")
	oRs3.Open qSelect3, xlDb3


	If Not oRs3.EOF Then
		oRs3.MoveFirst
		Do While Not oRs3.EOF 
		
		If oRs3(0) <> "" Then

		response.write oRs3(0)&"||"

	Set tRs = Server.CreateObject("ADODB.RecordSet")
	
	Set clsObj = new clsObject
	Set DBc = clsObj.Get_DB_Connection(LTA)
	
	SQL1  = "SELECT RL_IDX, RL_SPORTS, RL_LEAGUE, RL_IMAGE FROM Ref_League WHERE RL_CODE = '" & oRs3(2) & "' "
	tRS.Open SQL1, DBc,adOpenStatic, adLockReadOnly, adCmdText
	
	RL_IDX		= tRS(0)
	SRS_Sports	= tRS(1)
	RL_LEAGUE	= tRS(2)
	RL_IMAGE	= tRS(3)

	tRS.Close
	Set tRS = Nothing
	If InStr(oRs3(1),"오전") > 0 Then
		IG_StartTime = "CAST('"&oRs3(0)&" "&oRs3(1)&"','yyyy-mm-dd AM hh:MI:SS') "
	Else
		IG_StartTime = "CAST('"&oRs3(0)&" "&oRs3(1)&"','yyyy-mm-dd PM hh:MI:SS') "
	End If 

	a = oRs3(3)
	b = oRs3(6)
	anum = ""
	astr = ""
	bnum = ""
	bstr = ""
	For i =0 To Len(a)
		If IsNumeric(Mid(a,i+1,1)) Or Mid(a,i+1,1) = "." Then
			anum = anum & Mid(a,i+1,1)
		else 
			astr = astr	& Mid(a,i+1,1)
		End If
		
	Next 

	For i =0 To Len(b)
		If IsNumeric(Mid(b,i+1,1)) Or Mid(b,i+1,1) = "." Then
			bnum = bnum & Mid(b,i+1,1)
		else 
			bstr = bstr	& Mid(b,i+1,1)
		End If
		
	Next 

	
	IG_Team1		= astr
	IG_Team2		= bstr	
	IG_HANDICAP		= anum
	IG_TEAM1BENEFIT = oRs3(4)
	IG_DRAWBENEFIT	= 0
	IG_TEAM2BENEFIT = oRs3(7)
	IG_TYPE			= 2
	IG_Memo			= ""

		SQL = "INSERT INTO INFO_GAME ( RL_Idx, RL_Sports, RL_League, RL_Image, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, "
		SQL = SQL & "IG_Type, IG_VSPoint, IG_Memo, IG_SITE) VALUES ( "
		SQL = SQL & RL_Idx & ", '"
		SQL = SQL & SRS_Sports & "', '"
		SQL = SQL & RL_League & "', '"
		SQL = SQL & RL_IMAGE & "', "
		SQL = SQL & IG_StartTime & ", '"
		SQL = SQL & IG_Team1 & "', '"
		SQL = SQL & IG_Team2 & "', "
		SQL = SQL & IG_Handicap & ", "
		SQL = SQL & Cdbl(IG_Team1Benefit) & ", "
		SQL = SQL & Cdbl(IG_DrawBenefit) & ", "
		SQL = SQL & Cdbl(IG_Team2Benefit) & ", '"
		SQL = SQL & IG_Type & "', "
		SQL = SQL & Cdbl(IG_VSPoint) & ", '"
		SQL = SQL & IG_Memo & "', '"& IG_SITE &"') "
		'response.write sQL
		DBc.Execute (SQL)
		
		'response.write "<br>"
		'response.end
				
		End If 		
	oRs3.MoveNext        
	Loop
	
	End If 





	
	'If Err.Number = 0 Then 
	'	DBc.CommitTrans
	'Else
	'	DBc.RollbackTrans
	'End If 

	Set tRs = Nothing 

	Set DBc = Nothing 
	clsObj.Get_DB_DisConnection()
	Set Fup = Nothing 
	Set clsObj = Nothing 

	Set xlDb = Nothing
	Set xlDb2 = Nothing
	Set xlDb3 = Nothing

%>
<script>alert('등록되었습니다.');location.href="/EPCenter/04_Game/List.asp";</script>