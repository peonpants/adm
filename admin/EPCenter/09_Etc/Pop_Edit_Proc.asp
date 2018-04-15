<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	'팝업 추가시 SITE 코드 확인 (세개) 사용중이면 1
	Set uploadform = Server.CreateObject("DEXT.FileUpload") 
	'uploadform.DefaultPath = "D:\ss"
	'uploadform.DefaultPath = "E:\작업소스\Other Web\Eproto\UpFile\Temp"
	uploadform.DefaultPath = "D:\I-win\UpFile\Upload"
	FileSizeX = Trim(uploadform("FileSizeX"))
	FileSizeY = Trim(uploadform("FileSizeY"))
	Map1 = Trim(uploadform("Map1"))
	Map2 = Trim(uploadform("Map2"))
	PSITE = Trim(uploadform("PSITE"))
	
	If Trim(uploadform("Photo")) <> "" then
		'///////////////////////////////////////////이미지 업로드.....////////////////////////////////////////
		Set fs =  server.CreateObject("Scripting.FileSystemObject")
		
		FileName = uploadform("Photo")
		FileSize = uploadform("Photo").Filelen
		
		If Lcase(Right(FileName,3)) = "jpg" or Lcase(Right(FileName,3)) = "gif" then
			If FileSize = 0 then
				With Response
					.write "<script language='javascript'>"  & vbCrLf
					.write "alert('등록된 파일이 0byte 입니다. 다시 파일을 입력해주세요');"  & vbCrLf
					.write "</script>" & vbCrLf
					.End
				End With
			elseif FileSize >  2096000 then
				With Response
					.Write "<script language=javascript>" & vbCrLf
					.Write "alert('1M 이상의 파일은 업로드하실 수 없습니다.');" & vbCrLf
					.Write "</script>" & vbCrLf
					.end
				End With
			End if 
				
		else	
			With Response
				.write "<script language='javascript'>"  & vbCrLf
				.write "alert('확장자 gif / jpg 만 등록이 가능합니다.');"  & vbCrLf
				.write "</script>" & vbCrLf
				.End
			End With
		End if
		
		FileExt = right(FileName, 3)

		FileName = "Pop_" & replace(date(),"-", "") & "." & FileExt
		uploadform("Photo").SaveAs(Server.MapPath("/UpFile/PopUp") & "/" & FileName)
		set fs = Nothing
	Else
		FileName = ""
	End if
	
	IF FileName <> "" THEN
		UPDSQL = "UPDATE PopUp SET FileName='" & FileName & "', FileSizeX=" & FileSizeX & ", FileSizeY=" & FileSizeY & ", Map1=" & Map1 & ", Map2=" & Map2 & " WHERE PSITE = '"& PSITE &"'"
		DbCon.execute(UPDSQL)
	ELSE
		UPDSQL = "UPDATE PopUp SET FileSizeX=" & FileSizeX & ", FileSizeY=" & FileSizeY & ", Map1=" & Map1 & ", Map2=" & Map2 & " WHERE PSITE = '"& PSITE &"'"
		DbCon.execute(UPDSQL)
	END IF
	
	'response.write UPDSQL
	'response.end
	DbCon.Close
	Set DbCon=Nothing

	Response.redirect "Pop_View.asp"
%>