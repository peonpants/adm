<%@Language="VBScript" CODEPAGE="949"%>
<!-- #include virtual="/_Global/lta_object.asp" -->
<!-- #include virtual="/_Global/lta_function.asp" -->
<!-- #include virtual="/_Global/lta_const.asp" -->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual='/_Global/amount.asp' -->
<%
	dim xup
	set xup = Server.CreateObject("UpDownExpress.FileUpload")
	xup.InitControl

	IG_SITE = "All"

HostPath = "D:\_drama\DevilAdmin\UpFile\Upload\"
FilePath = right("0" & second(now), 2) & _
	right("0" & minute(now), 2) & _
	right("0" & hour(now), 2) & _
	right("0" & day(now) , 2) & _
	right("0" & month(now) , 2) & _
	right("000" & year(now)  , 4)
	
	for each xattach in xup.Attachments
		FileName =  xattach.fileName 
		'response.write filename
		'response.end
		FileExt = right(FileName, 3)
		If Not UCase(FileExt) = "XLS"  then
				With Response
					.write "<script language='javascript'>"  & vbCrLf
					.write "alert('xls 파일만 등록가능 합니다.');"  & vbCrLf
					.write "history.back(-1);"  & vbCrLf
					.write "</script>" & vbCrLf
					.End
				End With
		End If 
		FileName = FilePath
		FileName = "result_" & FileName & "." & FileExt
		
		xattach.SaveFile "D:\_drama\DevilAdmin\UpFile\Upload\" & FileName,false ', true '파일을 저장한다.
	next

	set xup = Nothing


	Set clsObj = new clsObject
	Set DBc = clsObj.Get_DB_Connection(LTA)
	
	Set xlDb = Server.CreateObject("ADODB.Connection")
	xlDb.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=D:\_drama\DevilAdmin\UpFile\Upload\"&FileName&"; Extended Properties=Excel 8.0;"
	qSelect = "Select * From [드림$] "
	Set oRs = Server.CreateObject("ADODB.RecordSet")
	oRs.Open qSelect, xlDb


	If Not oRs.EOF Then
		oRs.MoveFirst
		Do While Not oRs.EOF 
		If oRs(0) <> "" then
		Set tRs = Server.CreateObject("ADODB.RecordSet")
	
	GPC_PHONE = Trim(oRs(3))
	GPC_ID= Trim(oRs(0))
	GPC_SITE= Trim(oRs(8))

	a = Split(GPC_PHONE,"-")(0)&Split(GPC_PHONE,"-")(1)&Split(GPC_PHONE,"-")(2)
    a01 = Mid(a,4,1)
    a02 = Mid(a,8,1)
    a03 = Mid(a,2,1)
    a04 = Mid(a,7,1)
    a05 = Mid(a,3,1)
    a06 = Mid(a,5,1)
    a07 = Mid(a,9,1)
    a08 = Mid(a,1,1)
    a09 = Mid(a,10,1)
    a10 = Mid(a,6,1)
    a11 = Mid(a,11,1)

    a = encode(a01 & a02 & a03 & a04 & a05 & a06 & a07 & a08 & a09 & a10 & a11,3)
	SQL = "INSERT INTO G_PHONE_CK (  GPC_PHONE, GPC_ID, GPC_SITE, GPC_YN) VALUES (  '"&a&"', '"&GPC_ID&"', '"&GPC_SITE&"', 1 )"

	response.write SQL	
	response.write "<br>"
	DBc.Execute (SQL)

	End If 
	oRs.MoveNext        
	Loop
	
	End If 

	Set xlDb2 = Server.CreateObject("ADODB.Connection")
	xlDb2.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=G:\_drama\wwwAdmin\UpFile\Upload\"&FileName&"; Extended Properties=Excel 8.0;"
	qSelect2 = "Select * From [라이프$] "
	Set oRs2 = Server.CreateObject("ADODB.RecordSet")
	oRs2.Open qSelect2, xlDb2


	If Not oRs2.EOF Then
		oRs2.MoveFirst
		Do While Not oRs2.EOF 
		If oRs2(0) <> "" then

	Set tRs = Server.CreateObject("ADODB.RecordSet")
	
	GPC_PHONE = Trim(oRs2(3))
	GPC_ID= Trim(oRs2(0))
	GPC_SITE= Trim(oRs2(8))

	a = Split(GPC_PHONE,"-")(0)&Split(GPC_PHONE,"-")(1)&Split(GPC_PHONE,"-")(2)
a01 = Mid(a,4,1)
a02 = Mid(a,8,1)
a03 = Mid(a,2,1)
a04 = Mid(a,7,1)
a05 = Mid(a,3,1)
a06 = Mid(a,5,1)
a07 = Mid(a,9,1)
a08 = Mid(a,1,1)
a09 = Mid(a,10,1)
a10 = Mid(a,6,1)
a11 = Mid(a,11,1)

a = encode(a01 & a02 & a03 & a04 & a05 & a06 & a07 & a08 & a09 & a10 & a11,3)

	SQL = "INSERT INTO G_PHONE_CK (  GPC_PHONE, GPC_ID, GPC_SITE, GPC_YN) VALUES ( '"&a&"', '"&GPC_ID&"', '"&GPC_SITE&"', 1 )"

	response.write SQL	
	response.write "<br>"
	DBc.Execute (SQL)
	End If 
	oRs2.MoveNext        
	Loop
	
	End If 

	Set tRs = Nothing 

	Set DBc = Nothing 
	clsObj.Get_DB_DisConnection()
	Set Fup = Nothing 
	Set clsObj = Nothing 

	Set xlDb = Nothing
	Set xlDb2 = Nothing
	Set xlDb3 = Nothing

%>
