<!-- #include file="../../_Common/Config/CommonCS.asp"-->
<%

Dim UploadPath1
Dim UploadPath2
Dim FormFile
Dim UploadPathThumbnail
Dim FilePath
Dim FileType

HostPath1 = "D:\UpFile\League\"
HostPath2 = "d:\_drama\www\UpFile\League\"
		
FilePath = right("0" & second(now), 2) & _
	right("0" & minute(now), 2) & _
	right("0" & hour(now), 2) & _
	right("0" & day(now) , 2) & _
	right("0" & month(now) , 2) & _
	right("000" & year(now)  , 4)
	
	dim xup
	set xup = Server.CreateObject("UpDownExpress.FileUpload")
	xup.InitControl

	for each xattach in xup.Attachments
	
		FileName =  xattach.fileName 
		FileExt = right(FileName, 3)
		If Not UCase(FileExt) = "JPG" And Not UCase(FileExt) = "GIF" then
				With Response
					.write "<script language='javascript'>"  & vbCrLf
					.write "alert('jpg,gif 파일만 등록가능 합니다.');"  & vbCrLf
					.write "history.back(-1);"  & vbCrLf
					.write "</script>" & vbCrLf
					.End
				End With
		End If 
		
		FileName = "Icon_" & FilePath & "." & FileExt		

		xattach.SaveFile "D:\UpFile\League\" & FileName,false ', true '파일을 저장한다.
		'xattach.SaveFile "d:\_dev\www\_Html\UpFile\League\" & FileName,False
	next

	set xup = Nothing
		
%>
<HTML>
<BODY>
<script language="javascript" type="text/javascript">
    parent.document.getElementById('uploadImgName').value = "<%= FileName %>"; 
    try
    {
        parent.document.getElementById('uploadImage').src = "/UpFile/League/<%= FileName %>"; 
        parent.document.getElementById('uploadImage').style.display = "block" ;
    }catch(e){alert(e.description);}
      
</script>
</BODY>
</HTML>
<%
set objImage = nothing
Set uploadform =nothing
%>

