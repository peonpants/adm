<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Set uploadform = Server.CreateObject("DEXT.FileUpload") 
	uploadform.DefaultPath = "E:\Eproto\UpFile\Temp"
	'uploadform.DefaultPath = "E:\�۾��ҽ�\Other Web\Eproto\UpFile\Temp"
	
	RL_Idx = Trim(uploadform("RL_Idx"))
	RL_League = Trim(uploadform("RL_League"))
	
	If Trim(uploadform("RL_Image")) <> "" then
		'///////////////////////////////////////////�̹��� ���ε�.....////////////////////////////////////////
		Set fs =  server.CreateObject("Scripting.FileSystemObject")
		
		FileName = uploadform("RL_Image")
		FileSize = uploadform("RL_Image").Filelen
		
		If Lcase(Right(FileName,3)) = "jpg" or Lcase(Right(FileName,3)) = "gif" then
			If FileSize = 0 then
				With Response
					.write "<script language='javascript'>"  & vbCrLf
					.write "alert('��ϵ� ������ 0byte �Դϴ�. �ٽ� ������ �Է����ּ���');"  & vbCrLf
					.write "</script>" & vbCrLf
					.End
				End With
			elseif FileSize >  1024000 then
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
		
		s1 = split(FileName, ".")
		
		FileExt = s1(1)
		FileName = replace(RL_League, " ", "_")
		FileName = "Icon_" & FileName & "." & FileExt
		
		uploadform("RL_Image").SaveAs(Server.MapPath("/UpFile/League") & "/" & FileName)
		set fs = Nothing
	End if

	'// DB �Է�......
	If Trim(uploadform("RL_Image")) <> "" then
		UpdSql1 = " Update Ref_League set RL_Image='" & FileName & "', RL_League='" & RL_League & "' where RL_Idx=" & RL_Idx
		UpdSql2 = " Update Info_Game set RL_Image='" & FileName & "', RL_League='" & RL_League & "' where RL_Idx=" & RL_Idx
	Else
		UpdSql1 = " Update Ref_League set RL_League='" & RL_League & "' where RL_Idx=" & RL_Idx
		UpdSql2 = " Update Info_Game set RL_League='" & RL_League & "' where RL_Idx=" & RL_Idx
	End if
		
	DbCon.Execute (UpdSql1)
	DbCon.Execute (UpdSql2)

	DbCon.Close
	Set DbCon=Nothing
%>

<script>
	alert("���� ������ �Ϸ�Ǿ����ϴ�.");
	location.href="View.asp?RL_Idx=<%=RL_Idx%>";
</script>



