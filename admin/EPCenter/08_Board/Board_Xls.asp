<%@Language="VBScript" CODEPAGE="949"%>
<!-- #include virtual="/_Global/lta_object.asp" -->
<!-- #include virtual="/_Global/lta_function.asp" -->
<!-- #include virtual="/_Global/lta_const.asp" -->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<%
	upath = "D:\Fine\UpFile\Upload"
	IG_SITE = "Truepo"
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
	
	Set xlDb = Server.CreateObject("ADODB.Connection")
	'xlDb.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=G:\_drama\wwwAdmin\UpFile\Upload\"&FileName&"; Extended Properties=Excel 8.0;"
	xlDb.Open  "Provider=Microsoft.ACE.OLEDB.12.0; Data Source=G:\_drama\wwwAdmin\UpFile\Upload\"&FileName&"; Extended Properties='Excel 12.0;HDR=YES;IMEX=1'" 



	qSelect = "Select * From [Sheet1$] "
	Set oRs = Server.CreateObject("ADODB.RecordSet")
	oRs.Open qSelect, xlDb
	ccnt = 0

	Set tRs = Server.CreateObject("ADODB.RecordSet")

	Set clsObj = new clsObject
	Set DBc = clsObj.Get_DB_Connection(LTA)

	'DBc.BeginTrans
	
	If Not oRs.EOF Then
		oRs.MoveFirst
		Do While Not oRs.EOF
			'response.write oRs(4)
		If oRs(3) <> "" And oRs(2) <> "" Then

		content_body = ReplaceContents(oRs(4))
		content_body = replace(content_body,"\n"," ")

		


        '오전이라는 글자의 위치가 존재한다면
		If instr(oRs(2),"오전")>0 Then 
			xls_time = "YYYY-MM-DD AM HH:MI:SS" 
		Else 
			xls_time = "YYYY-MM-DD PM HH:MI:SS"
		End If 

		If oRs(1) <> "" Then
			hits_cnt = oRs(1)
		Else
			hits_cnt = 0
		End If 
		
			SQL = "INSERT INTO Board_Free (BF_IDX, BF_Title, BF_Contents, BF_Writer, BF_PW, BF_HITS, BF_Level, BF_SITE, BF_REGDATE) VALUES (?, empty_clob(), ?, '1111', ?, 0, 'parao24',CAST('"&oRs(2)&" ', '"&xls_time&"') )"
			
		Dim tCmd : Set tCmd = Server.CreateObject("ADODB.Command")
			With tCmd
			.ActiveConnection = DBc
			.CommandType = adCmdText
			.CommandText = SQL
			.Parameters.Append .CreateParameter("BF_Title", adVarchar, adParamInput, 500, oRs(3))
			.Parameters.Append .CreateParameter("BF_Writer", adVarchar, adParamInput, 20, oRs(0))
			.Parameters.Append .CreateParameter("BF_HITS", adNumeric, adParamInput, , hits_cnt)

			.Execute , , adExecuteNoRecords
			End With
		Set tCmd = Nothing

		If Not content_body = "" Then 
			gSql = "UPDATE Board_Free SET BF_Contents = ? WHERE BF_IDX = ? "
			Dim gCmd : Set gCmd = Server.CreateObject("ADODB.Command")
				With gCmd
				.ActiveConnection = DBc
				.CommandType = adCmdText
				.CommandText = gSql
				.Parameters.Append .CreateParameter("content_body", adLongVarWChar, adParamInput, Len(content_body)*2, content_body)	
				.Parameters.Append .CreateParameter("content_number", adNumeric, adParamInput, , content_number)
				.Execute , , adExecuteNoRecords
			End With
			Set gCmd = Nothing 
		End If 


	ElseIf oRs(4) <> "" And oRs(2) <> "" Then

		content_body = ReplaceContents(oRs(4))
		content_body = replace(content_body," ","\n")


		If instr(oRs(2),"오전")>0 Then 
			xls_time = "YYYY-MM-DD AM HH:MI:SS" 
		Else 
			xls_time = "YYYY-MM-DD PM HH:MI:SS"
		End If 
		
		SQL = "INSERT INTO BOARD_FREE_REPLY ( BFR_IDX, BF_IDX, BFR_CONTENTS, BFR_WRITER, BFR_REGDATE ) VALUES ( ?, ?, ?, CAST('"&oRs(2)&" ', '"&xls_time&"'))"

		
		If oRs(0) <> "" Then
			r_writer = oRs(0)	
		Else	
			r_writer = "관리자"
		End If 
		Dim jCmd : Set jCmd = Server.CreateObject("ADODB.Command")
			With jCmd
			.ActiveConnection = DBc
			.CommandType = adCmdText
			.CommandText = SQL

			.Parameters.Append .CreateParameter("BF_IDX", adNumeric, adParamInput, , content_number)
			.Parameters.Append .CreateParameter("BF_CONTENTS", adVarchar, adParamInput, 2000, oRs(4))
			.Parameters.Append .CreateParameter("BF_Writer", adVarchar, adParamInput, 20, r_writer)


			.Execute , , adExecuteNoRecords
			End With
		Set jCmd = Nothing

	End If 

	oRs.MoveNext        
	Loop
	
	End If 
	
	SQL = "select count(*) as cnt from board_free where bf_site = 'parao24'"
	Set gRs = DbCon.Execute (SQL)
		totalCnt = CDbl(gRs("cnt"))
	gRs.close
	Set gRs = nothing


	For i = 1 To  totalCnt

		Sql = " select count(*) as cnt from board_free_reply where bf_idx = "&i
		Set gRs = DbCon.Execute (SQL)
			Cnt = gRs("cnt")
		gRs.close
		Set gRs = Nothing
	
		Sql = "update board_free set bf_replycnt = "& Cnt & " where bf_idx = "& i
		DbCon.Execute (SQL)

	Next 
'	If Err.Number = 0 Then 
'		DBc.CommitTrans
'	Else
'		DBc.RollbackTrans
'	End If 

	Set tRs = Nothing 

	Set DBc = Nothing 
	clsObj.Get_DB_DisConnection()
	Set Fup = Nothing 
	Set clsObj = Nothing 

	Set xlDb = Nothing

%>
<script>//alert('등록되었습니다.');location.href="/EPCenter/08_Board/Board_List.asp";</script> 