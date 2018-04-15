<%@Language="VBScript" CODEPAGE="949"%>
<!-- #include virtual="/_Global/lta_object.asp" -->
<!-- #include virtual="/_Global/lta_function.asp" -->
<!-- #include virtual="/_Global/lta_const.asp" -->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp" --->

<%
  IG_SITE = REQUEST("IG_SITE")

	dim xup
	set xup = Server.CreateObject("UpDownExpress.FileUpload")
	xup.InitControl

	'IG_SITE = "All"
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

		'response.write filename
		'response.end

		xattach.SaveFile HostPath & FileName ,false ', true '파일을 저장한다.
	next

	set xup = Nothing


	Set clsObj = new clsObject
	Set DBc = clsObj.Get_DB_Connection(LTA)
	
	Set xlDb = Server.CreateObject("ADODB.Connection")
	xlDb.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=D:\_drama\DevilAdmin\UpFile\"&FileName&"; Extended Properties=Excel 8.0;"
'	qSelect = "Select * From [승무패$] "
	qSelect = "Select * From [승무패$] "
	Set oRs = Server.CreateObject("ADODB.RecordSet")
	oRs.Open qSelect, xlDb

	If Not oRs.EOF Then
		
		Do While Not oRs.EOF 

		
		If oRs(0) <> "" AND oRs(1) <> "" AND oRs(2) <> "" then
		
            IG_StartTime = Trim(oRs(0))
            IG_LEAGUE = Trim(oRs(1))	        
	        IG_Team1 = Replace( Trim(oRs(2)), "'", "&#039;" )
	        IG_TEAM1BENEFIT = Trim(oRs(3))
	        IG_DRAWBENEFIT	= Trim(oRs(4))
	        IG_TEAM2BENEFIT = Trim(oRs(5))
	        IG_Team2 = Replace( Trim(oRs(6)), "'", "&#039;" )

            IG_TEAM1BET_CNT = 0
            IG_TEAM2BET_CNT = 0        

	        
	        IG_HANDICAP		= 0
	        IG_TYPE			= 0
	        IG_Memo			= ""	
	        		
	        Set tRs = Server.CreateObject("ADODB.RecordSet")
        	

	        SQL1  = "SELECT RL_IDX, RL_SPORTS, RL_LEAGUE, RL_IMAGE FROM Ref_League WHERE RL_LEAGUE = '" & IG_LEAGUE & "' "
	        tRS.Open SQL1, DBc,adOpenStatic, adLockReadOnly, adCmdText

		    L_NAME = oRs(2)
		    IF tRs.EOF THEN
			    With Response
				    .write "<script language='javascript'>"  & vbCrLf
				    .WRITE "alert('승무패 등록에러 : 리그명 [" & L_NAME & "] 를 리그목록에서 찾을 수 없습니다.');" & vbcrlf
				    .write "history.back(-1);"  & vbCrLf
				    .write "</script>" & vbCrLf
				    .End
			    End With
		    END IF

	        RL_IDX		= tRS(0)
	        SRS_Sports	= tRS(1)
	        RL_LEAGUE	= tRS(2)
	        RL_IMAGE	= tRS(3)

	        tRS.Close
	        Set tRS = Nothing

            IG_StartTime =  cDate(IG_StartTime)
	                    				
            IG_StartTime = right("000" & year(IG_StartTime)  , 4) & "-" & _		    
            right("0" & month(IG_StartTime) , 2) & "-" & _
            right("0" & day(IG_StartTime) , 2) & " " & _
            right("0" & hour(IG_StartTime), 2) & ":" & _
            right("0" & minute(IG_StartTime), 2) & ":00"			
           


          	IF Trim(IG_Team1Benefit) = "" Or isNull(IG_Team1Benefit) Then IG_Team1Benefit = 1     
          	IF Trim(IG_Team2Benefit) = "" Or isNull(IG_Team2Benefit) Then IG_Team2Benefit = 1  
          	IF Trim(IG_VSPoint) = ""  Or isNull(IG_VSPoint)     Then IG_VSPoint = 0  
          	IF Trim(IG_DrawBenefit) = ""  Or isNull(IG_DrawBenefit) Then IG_DrawBenefit = 0 
          	
	        IF IG_DRAWBENEFIT = 0 Then
	            IG_TEAM1BET_CNT = 0
	            IG_TEAM2BET_CNT = 0
	            IG_DRAWBET_CNT  = 0
            Else
                Randomize 
                num = Int((8*Rnd))            
                IG_DRAWBET_CNT = num
	        End IF
	                  	
	        SQL = "INSERT INTO INFO_GAME ( RL_Idx, RL_Sports, RL_League, RL_Image, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_TEAM1BET_CNT, IG_DRAWBET_CNT, IG_TEAM2BET_CNT, "
	        SQL = SQL & "IG_Type, IG_VSPoint, IG_Memo, IG_SITE) VALUES ( "
	        SQL = SQL & RL_Idx & ", '"
	        SQL = SQL & SRS_Sports & "', '"
	        SQL = SQL & RL_LEAGUE & "', '"
	        SQL = SQL & RL_IMAGE & "', '"
	        SQL = SQL & IG_StartTime & "', '"
	        SQL = SQL & IG_Team1 & "', '"
	        SQL = SQL & IG_Team2 & "', "
	        SQL = SQL & IG_Handicap & ", "
	        SQL = SQL & Cdbl(IG_Team1Benefit) & ", "
	        'response.write IG_DRAWBENEFIT&"<br>"

	        If IG_DRAWBENEFIT <> "" And UCASE(IG_DRAWBENEFIT) <> "X"  then
	            SQL = SQL & Cdbl(IG_DrawBenefit) & ", "
	        Else
	            SQL = SQL & "0, "
	        End If 
        	
	        SQL = SQL & Cdbl(IG_Team2Benefit) & ", "
	        SQL = SQL & Cdbl(IG_TEAM1BET_CNT) & ", "
	        SQL = SQL & Cdbl(IG_DRAWBET_CNT) & ", "
	        SQL = SQL & Cdbl(IG_TEAM2BET_CNT) & ", '"
	        SQL = SQL & IG_Type & "', "
	        SQL = SQL & Cdbl(IG_VSPoint) & ", '"
	        SQL = SQL & IG_Memo & "', '"& IG_SITE &"') "
	        'response.write SQL	
	        'response.write "<br>"
            
    	
	        DBc.Execute (SQL)
	    End If 
	    oRs.MoveNext        
	    Loop
	
	End If 

           
            
	Set xlDb2 = Server.CreateObject("ADODB.Connection")
'	xlDb2.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=D:\UpFile\Upload\"&FileName&"; Extended Properties=Excel 8.0;"
	xlDb2.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=D:\_drama\DevilAdmin\UpFile\"&FileName&"; Extended Properties=Excel 8.0;"
	qSelect2 = "Select * From [핸디캡$] "
	Set oRs2 = Server.CreateObject("ADODB.RecordSet")
	oRs2.Open qSelect2, xlDb2


	If Not oRs2.EOF Then
		
		Do While Not oRs2.EOF 
		If oRs2(0) <> "" then
		
            IG_StartTime = Trim(oRs2(0))
            IG_LEAGUE = Trim(oRs2(1))	        
	        IG_Team1 = Replace( Trim(oRs2(2)), "'", "&#039;" )
	        IG_TEAM1BENEFIT = Trim(oRs2(3))
	        IG_Handicap	= Trim(oRs2(4))
	        IG_TEAM2BENEFIT = Trim(oRs2(5))
	        IG_Team2 = Replace( Trim(oRs2(6)), "'", "&#039;" )
	        IF oRs2(7) <> "" Then
	            I7_IDX = Trim(oRs2(7))
            End IF	            
	        		
	        Set tRs = Server.CreateObject("ADODB.RecordSet")
        	
	        Set clsObj = new clsObject
	        Set DBc = clsObj.Get_DB_Connection(LTA)
        	
	        SQL1  = "SELECT RL_IDX, RL_SPORTS, RL_LEAGUE, RL_IMAGE FROM Ref_League WHERE RL_LEAGUE = '" & IG_LEAGUE & "' "
	        tRS.Open SQL1, DBc,adOpenStatic, adLockReadOnly, adCmdText


		    IF tRs.EOF THEN
			    With Response
				    .write "<script language='javascript'>"  & vbCrLf
				    .WRITE "alert('핸디캡 등록에러 : 리그명 [" & IG_LEAGUE & "] 를 리그목록에서 찾을 수 없습니다.');" & vbcrlf
				    .write "history.back(-1);"  & vbCrLf
				    .write "</script>" & vbCrLf
				    .End
			    End With
		    END IF
        	
	        RL_IDX		= tRS(0)
	        SRS_Sports	= tRS(1)
	        RL_LEAGUE	= tRS(2)
	        RL_IMAGE	= tRS(3)

	        tRS.Close
	        Set tRS = Nothing

            IG_StartTime =  cDate(IG_StartTime)
	                    				
            IG_StartTime = right("000" & year(IG_StartTime)  , 4) & "-" & _		    
            right("0" & month(IG_StartTime) , 2) & "-" & _
            right("0" & day(IG_StartTime) , 2) & " " & _
            right("0" & hour(IG_StartTime), 2) & ":" & _
            right("0" & minute(IG_StartTime), 2) & ":00"	
            
            'IG_HANDICAP = oRs2(8)		        
	        IG_DRAWBENEFIT	= 0
	        IG_TYPE			= 1
	        IG_Memo			= ""

          	IF Trim(IG_Team1Benefit) = "" Or isNull(IG_Team1Benefit) Then IG_Team1Benefit = 1     
          	IF Trim(IG_Team2Benefit) = "" Or isNull(IG_Team2Benefit) Then IG_Team2Benefit = 1  
          	IF Trim(IG_VSPoint) = ""  Or isNull(IG_VSPoint)     Then IG_VSPoint = 1  
          	IF Trim(IG_DrawBenefit) = ""  Or isNull(IG_DrawBenefit) Then IG_DrawBenefit = 1 
          	
	        IF IG_DRAWBENEFIT = 0 Then
                Randomize 
                num1 = Int((10*Rnd))    
                        
                Randomize 
                num2 = Int((10*Rnd))                            
                	        
	            IG_TEAM1BET_CNT = num1
	            IG_TEAM2BET_CNT = num2
	            IG_DRAWBET_CNT  = 0

	        End IF
	                  	
		    SQL = "INSERT INTO INFO_GAME ( RL_Idx, RL_Sports, RL_League, RL_Image, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_TEAM1BET_CNT, IG_DRAWBET_CNT, IG_TEAM2BET_CNT, "
		    SQL = SQL & "IG_Type, I7_IDX, IG_VSPoint, IG_Memo, IG_SITE) VALUES ( "
		    SQL = SQL & RL_Idx & ", '"
		    SQL = SQL & SRS_Sports & "', '"
		    SQL = SQL & RL_League & "', '"
		    SQL = SQL & RL_IMAGE & "', '"
		    SQL = SQL & IG_StartTime & "', '"
		    SQL = SQL & IG_Team1 & "', '"
		    SQL = SQL & IG_Team2 & "', "
		    SQL = SQL & IG_Handicap & ", "
		    SQL = SQL & Cdbl(IG_Team1Benefit) & ", "
		    SQL = SQL & Cdbl(IG_DrawBenefit) & ", "
		    SQL = SQL & Cdbl(IG_Team2Benefit) & ", "
	        SQL = SQL & Cdbl(IG_TEAM1BET_CNT) & ", "
	        SQL = SQL & Cdbl(IG_DRAWBET_CNT) & ", "
	        SQL = SQL & Cdbl(IG_TEAM2BET_CNT) & ", '"		    
		    SQL = SQL & IG_Type & "','"
		    SQL = SQL & I7_IDX & "', "
		    SQL = SQL & Cdbl(IG_VSPoint) & ", '"
		    SQL = SQL & IG_Memo & "', '"& IG_SITE &"') "
		    'response.write sQL
		    'response.write "<br>"
		    

		    DBc.Execute (SQL)

		End If 
	oRs2.MoveNext        
	Loop
	
	End If 

'---
	Set xlDb3 = Server.CreateObject("ADODB.Connection")
'	xlDb3.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=D:\UpFile\Upload\"&FileName&"; Extended Properties=Excel 8.0;"
	xlDb3.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=D:\_drama\DevilAdmin\UpFile\"&FileName&"; Extended Properties=Excel 8.0;"
	qSelect3 = "Select * From [오버언더$] "
	Set oRs3 = Server.CreateObject("ADODB.RecordSet")
	oRs3.Open qSelect3, xlDb3


	If Not oRs3.EOF Then
		
		Do While Not oRs3.EOF 
		
		If oRs3(0) <> "" AND oRs3(6) <> ""  Then

            IG_StartTime = Trim(oRs3(0))
            IG_LEAGUE = Trim(oRs3(1))	        
	        IG_Team1 = Replace( Trim(oRs3(2)), "'", "&#039;" )
	        IG_TEAM1BENEFIT = Trim(oRs3(3))
	        IG_Handicap	= Trim(oRs3(4))
	        IG_TEAM2BENEFIT = Trim(oRs3(5))
	        IG_Team2 = Replace( Trim(oRs3(6)), "'", "&#039;" )
	        IF oRs3(7) <> "" Then
	            I7_IDX = Trim(oRs3(7))
            End IF	            	        

	        Set tRs = Server.CreateObject("ADODB.RecordSet")
        	
	        Set clsObj = new clsObject
	        Set DBc = clsObj.Get_DB_Connection(LTA)
        	
	        SQL1  = "SELECT RL_IDX, RL_SPORTS, RL_LEAGUE, RL_IMAGE FROM Ref_League WHERE RL_LEAGUE = '" & IG_LEAGUE & "' "
	        tRS.Open SQL1, DBc,adOpenStatic, adLockReadOnly, adCmdText


		    IF tRs.EOF THEN
			    With Response
				    .write "<script language='javascript'>"  & vbCrLf
				    .WRITE "alert('오버언더 등록에러 : 리그명 [" & IG_LEAGUE & "] 를 리그목록에서 찾을 수 없습니다.');" & vbcrlf
				    .write "history.back(-1);"  & vbCrLf
				    .write "</script>" & vbCrLf
				    .End
			    End With
		    END IF

	        RL_IDX		= tRS(0)
	        SRS_Sports	= tRS(1)
	        RL_LEAGUE	= tRS(2)
	        RL_IMAGE	= tRS(3)

	        tRS.Close
	        Set tRS = Nothing


            IG_StartTime =  cDate(IG_StartTime)
	
            IG_StartTime = right("000" & year(IG_StartTime)  , 4) & "-" & _		    
            right("0" & month(IG_StartTime) , 2) & "-" & _
            right("0" & day(IG_StartTime) , 2) & " " & _
            right("0" & hour(IG_StartTime), 2) & ":" & _
            right("0" & minute(IG_StartTime), 2) & ":00"	
            
	        IG_TYPE			= 2
	        IG_Memo			= ""
            IG_DRAWBENEFIT	= 0
            
          	IF Trim(IG_Team1Benefit) = "" Or isNull(IG_Team1Benefit) Then IG_Team1Benefit = 1     
          	IF Trim(IG_Team2Benefit) = "" Or isNull(IG_Team2Benefit) Then IG_Team2Benefit = 1  
          	IF Trim(IG_VSPoint) = ""  Or isNull(IG_VSPoint)     Then IG_VSPoint = 1  
          	IF Trim(IG_DrawBenefit) = ""  Or isNull(IG_DrawBenefit) Then IG_DrawBenefit = 1 
          	IF Trim(IG_HANDICAP) = ""  Or isNull(IG_HANDICAP) Then IG_HANDICAP = 1 
          	
	        IF IG_DRAWBENEFIT = 0 Then
                Randomize 
                num1 = Int((10*Rnd))    
                        
                Randomize 
                num2 = Int((10*Rnd))                            
                	        
	            IG_TEAM1BET_CNT = num1
	            IG_TEAM2BET_CNT = num2
	            IG_DRAWBET_CNT  = 0

	        End IF
	                  	
		    SQL = "INSERT INTO INFO_GAME (RL_Idx, RL_Sports, RL_League, RL_Image, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_TEAM1BET_CNT, IG_DRAWBET_CNT, IG_TEAM2BET_CNT, "
		    SQL = SQL & "IG_Type, I7_IDX,  IG_VSPoint, IG_Memo, IG_SITE) VALUES ( "
		    SQL = SQL & RL_Idx & ", '"
		    SQL = SQL & SRS_Sports & "', '"
		    SQL = SQL & RL_League & "', '"
		    SQL = SQL & RL_IMAGE & "', '"
		    SQL = SQL & IG_StartTime & "', '"
		    SQL = SQL & IG_Team1 & "', '"
		    SQL = SQL & IG_Team2 & "', "
		    SQL = SQL & IG_Handicap & ", "
		    SQL = SQL & Cdbl(IG_Team1Benefit) & ", "
		    SQL = SQL & Cdbl(IG_DrawBenefit) & ", "
		    SQL = SQL & Cdbl(IG_Team2Benefit) & ", "
	        SQL = SQL & Cdbl(IG_TEAM1BET_CNT) & ", "
	        SQL = SQL & Cdbl(IG_DRAWBET_CNT) & ", "
	        SQL = SQL & Cdbl(IG_TEAM2BET_CNT) & ", '"			    
		    SQL = SQL & IG_Type & "', '"
		    SQL = SQL & I7_IDX & "', "
		    SQL = SQL & Cdbl(IG_VSPoint) & ", '"		    
		    SQL = SQL & IG_Memo & "', '"& IG_SITE &"') "
		    'response.write sQL
		    'response.write "<br><br><br>"

		    DBc.Execute (SQL)
    		
		    'response.write "<br>"
		    'response.end
				
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
<script>
alert('등록되었습니다.');
location.href="/EPCenter/04_Game/List.asp";
</script>