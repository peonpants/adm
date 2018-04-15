<%@Language="VBScript" CODEPAGE="949"%>
<!-- #include virtual="/_Global/lta_object.asp" -->
<!-- #include virtual="/_Global/lta_function.asp" -->
<!-- #include virtual="/_Global/lta_const.asp" -->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
  IG_SITE = REQUEST("IG_SITE")

	dim xup
        set xup = Server.CreateObject("UpDownExpress.FileUpload")
	xup.InitControl

	'IG_SITE = "All"
'    HostPath = "D:\UpFile\Upload\"
    HostPath = "D:\_drama\DevilAdmin\UpFile\"
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
		FileName = "game_" & FileName & "." & FileExt
        
        

		xattach.SaveFile HostPath & FileName ,false ', true '파일을 저장한다.
	next

	set xup = Nothing

	Set clsObj = new clsObject
	Set DBc = clsObj.Get_DB_Connection(LTA)
	
	Set xlDb = Server.CreateObject("ADODB.Connection")
	xlDb.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=D:\_drama\DevilAdmin\UpFile\"&FileName&"; Extended Properties=Excel 8.0;"
	qSelect = "Select * From [승무패$] "
	Set oRs = Server.CreateObject("ADODB.RecordSet")
	oRs.Open qSelect, xlDb

	If Not oRs.EOF Then
		oRs.MoveFirst
		Do While Not oRs.EOF 
        
	
		If oRs(0) <> "" And oRs(1) <> "" then
            
            IG_StartTime = Trim(oRs(0))
            IG_LEAGUE = Trim(oRs(1))	        
	        IG_Team1 = Replace( Trim(oRs(2)), "'", "&#039;" )
	        IG_TEAM1BENEFIT = Trim(oRs(3))
	        IG_DRAWBENEFIT	= Trim(oRs(4))
	        IG_Team2 = Replace( Trim(oRs(5)), "'", "&#039;" )
	        IG_TEAM2BENEFIT = Trim(oRs(6))
	        IG_HANDICAP		= 0
	        IG_TYPE			= 0
	        IG_Memo			= ""	
	        		
	        Set tRs = Server.CreateObject("ADODB.RecordSet")
        	

	        SQL1  = "SELECT RL_IDX, RL_SPORTS, RL_LEAGUE, RL_IMAGE FROM Ref_League WHERE RL_LEAGUE = '" & IG_LEAGUE & "' "
	        tRS.Open SQL1, DBc,adOpenStatic, adLockReadOnly, adCmdText

		    IF tRs.EOF THEN
			    With Response
				    .WRITE "등록에러 : 리그명 [" & IG_LEAGUE & "] 를 리그목록에서 찾을 수 없습니다.<br>" & vbcrlf
			    End With
		    END IF


	        tRS.Close
	        Set tRS = Nothing
		
           


	    End If 
	    oRs.MoveNext        
	    Loop
	
	End If 

           
            
	Set xlDb2 = Server.CreateObject("ADODB.Connection")
	xlDb2.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=D:\_drama\DevilAdmin\UpFile\"&FileName&"; Extended Properties=Excel 8.0;"
	qSelect2 = "Select * From [핸디캡$] "
	Set oRs2 = Server.CreateObject("ADODB.RecordSet")
	oRs2.Open qSelect2, xlDb2


	If Not oRs2.EOF Then
		oRs2.MoveFirst
		Do While Not oRs2.EOF 
		If oRs2(0) <> "" OR oRs2(1) <> "" then
		
            IG_StartTime = Trim(oRs2(0))
            IG_LEAGUE = Trim(oRs2(1))	        
	        IG_Team1 = Replace( Trim(oRs2(2)), "'", "&#039;" )
	        IG_TEAM1BENEFIT = Trim(oRs2(3))
	        IG_DRAWBENEFIT	= Trim(oRs2(4))
	        IG_Team2 = Replace( Trim(oRs2(5)), "'", "&#039;" )
	        IG_TEAM2BENEFIT = Trim(oRs2(6))
	        		
	        Set tRs = Server.CreateObject("ADODB.RecordSet")
        	
	        Set clsObj = new clsObject
	        Set DBc = clsObj.Get_DB_Connection(LTA)
        	
	        SQL1  = "SELECT RL_IDX, RL_SPORTS, RL_LEAGUE, RL_IMAGE FROM Ref_League WHERE RL_LEAGUE = '" & IG_LEAGUE & "' "
	        tRS.Open SQL1, DBc,adOpenStatic, adLockReadOnly, adCmdText


		    IF tRs.EOF THEN
			    With Response
			        With Response
				        .WRITE "등록에러 : 리그명 [" & IG_LEAGUE & "] 를 리그목록에서 찾을 수 없습니다.<br>" & vbcrlf
			        End With
			    End With
		    END IF
        	

	        tRS.Close
	        Set tRS = Nothing
	        

		End If 
	oRs2.MoveNext        
	Loop
	
	End If 


	Set xlDb3 = Server.CreateObject("ADODB.Connection")
	xlDb3.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=D:\_drama\DevilAdmin\UpFile\"&FileName&"; Extended Properties=Excel 8.0;"
	qSelect3 = "Select * From [오버언더$] "
	Set oRs3 = Server.CreateObject("ADODB.RecordSet")
	oRs3.Open qSelect3, xlDb3


	If Not oRs3.EOF Then
		oRs3.MoveFirst
		Do While Not oRs3.EOF 
		
		If oRs3(0) <> "" OR oRs3(1) <> "" then


            IG_StartTime = Trim(oRs3(0))
            IG_LEAGUE = Trim(oRs3(1))	        
	        IG_Team1 = Replace( Trim(oRs3(2)), "'", "&#039;" )
	        IG_TEAM1BENEFIT = Trim(oRs3(3))
	        IG_DRAWBENEFIT	= Trim(oRs3(4))
	        IG_Team2 = Replace( Trim(oRs3(5)), "'", "&#039;" )
	        IG_TEAM2BENEFIT = Trim(oRs3(6))
	        
	        Set tRs = Server.CreateObject("ADODB.RecordSet")
        	
	        Set clsObj = new clsObject
	        Set DBc = clsObj.Get_DB_Connection(LTA)
        	
	        SQL1  = "SELECT RL_IDX, RL_SPORTS, RL_LEAGUE, RL_IMAGE FROM Ref_League WHERE RL_LEAGUE = '" & IG_LEAGUE & "' "
	        tRS.Open SQL1, DBc,adOpenStatic, adLockReadOnly, adCmdText


		    IF tRs.EOF THEN
			    With Response
			        With Response
				        .WRITE "등록에러 : 리그명 [" & IG_LEAGUE & "] 를 리그목록에서 찾을 수 없습니다.<br>" & vbcrlf
			        End With
			    End With
		    END IF
				
		End If 		
	oRs3.MoveNext        
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
