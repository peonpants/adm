<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	'�˾� �߰��� SITE �ڵ� Ȯ�� (����) ������̸� 1
	Set uploadform = Server.CreateObject("DEXT.FileUpload") 
	'uploadform.DefaultPath = "D:\ss"
	'uploadform.DefaultPath = "E:\�۾��ҽ�\Other Web\Eproto\UpFile\Temp"
	uploadform.DefaultPath = "D:\I-win\UpFile\Upload"
	FileSizeX = Trim(uploadform("FileSizeX"))
	FileSizeY = Trim(uploadform("FileSizeY"))
	Map1 = Trim(uploadform("Map1"))
	Map2 = Trim(uploadform("Map2"))
	PSITE = Trim(uploadform("PSITE"))
	
	If Trim(uploadform("Photo")) <> "" then
		'///////////////////////////////////////////�̹��� ���ε�.....////////////////////////////////////////
		Set fs =  server.CreateObject("Scripting.FileSystemObject")
		
		FileName = uploadform("Photo")
		FileSize = uploadform("Photo").Filelen
		
		If Lcase(Right(FileName,3)) = "jpg" or Lcase(Right(FileName,3)) = "gif" then
			If FileSize = 0 then
				With Response
					.write "<script language='javascript'>"  & vbCrLf
					.write "alert('��ϵ� ������ 0byte �Դϴ�. �ٽ� ������ �Է����ּ���');"  & vbCrLf
					.write "</script>" & vbCrLf
					.End
				End With
			elseif FileSize >  2096000 then
				With Response
					.Write "<script language=javascript>" & vbCrLf
					.Write "alert('1M �̻��� ������ ���ε��Ͻ� �� �����ϴ�.');" & vbCrLf
					.Write "</script>" & vbCrLf
					.end
				End With
			End if 
				
		else	
			With Response
				.write "<script language='javascript'>"  & vbCrLf
				.write "alert('Ȯ���� gif / jpg �� ����� �����մϴ�.');"  & vbCrLf
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