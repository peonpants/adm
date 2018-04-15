<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<%	
	Page		= Trim(dfRequest("Page"))
	SFlag		= Trim(dfRequest("SFlag"))
	IG_IDX		= Trim(dfRequest("IG_IDX"))
	SRS_Sports	= Trim(dfRequest("SRS_Sports"))
	SRL_League	= Trim(dfRequest("SRL_League"))
	IG_Score1	= Trim(dfRequest("IG_Score1"))
	IG_Score2	= Trim(dfRequest("IG_Score2"))
	IG_Cancel	= Trim(dfRequest("IG_Cancel"))
    
    
   '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    IF cStr(IG_Cancel) = "1" Then
        Call dfgameSql.ExecGameResultStep1(dfDBConn.Conn,  IG_IDX, 0, 0, 2, 0)
	    %>
	    <script type="text/javascript">
	        alert("���� ��� ��������ϴ�.");		
	        location.href = "ResultGame_Step2.asp?IG_IDX=<%= IG_IDX %>"	        
        </script>
	    <%
	    response.end			    
    End IF    	
	'######### ���� ���� �󼼸� �ҷ���                 ################	    
	Call dfgameSql.GetInfo_Game(dfDBConn.Conn,  IG_IDX)
	
	IF dfgameSql.RsCount <> 0 Then
	    IG_HANDICAP		= dfgameSql.RsOne("IG_HANDICAP")
	    IG_TEAM1BENEFIT	= dfgameSql.RsOne("IG_TEAM1BENEFIT")
	    IG_DRAWBENEFIT	= dfgameSql.RsOne("IG_DRAWBENEFIT")
	    IG_TEAM2BENEFIT	= dfgameSql.RsOne("IG_TEAM2BENEFIT")
	    IG_TYPE			= dfgameSql.RsOne("IG_TYPE")
    End IF
	
	IF IG_HANDICAP = "0" THEN
		Score1 = IG_Score1
	ELSE
		IF IG_TYPE = "2" THEN 
			Score1 = IG_Score1
		ELSE 
			Score1 = Cdbl(IG_Score1) + Cdbl(IG_HANDICAP)
		END IF
	END IF
	
	Score2 = IG_Score2


	'2 �������
	'1 �ڵ�ĸ
	'0 ������
	IF IG_TYPE = "2" THEN 
		IF Cdbl(IG_HANDICAP) < Cdbl(Cdbl(Score1) + Cdbl(Score2)) THEN 
			WinTeam = 1
		ElseIf Cdbl(IG_HANDICAP) = Cdbl(Cdbl(Score1) + Cdbl(Score2)) THEN 
		    
		    Call dfgameSql.ExecGameResultStep1(dfDBConn.Conn,  IG_IDX, IG_Score1, IG_Score2, 3, 0)
			%>
			<script type="text/javascript">
			    alert("���� ��Ư ��������ϴ�.");	
			    location.href = "ResultGame_Step2.asp?IG_IDX=<%= IG_IDX %>"	        		    
            </script>
			<%
			response.end
		Else 
			WinTeam = 2
		END IF
	ELSE
		IF Cdbl(Score1) > Cdbl(Score2) THEN
			WinTeam = 1
		ELSEIF Cdbl(Score1) < Cdbl(Score2) THEN
			WinTeam = 2
		ElseIf Cdbl(Score1) = Cdbl(Score2) And IG_TYPE = "1"  THEN
		    '���� Ư�� 
		    Call dfgameSql.ExecGameResultStep1(dfDBConn.Conn,  IG_IDX, IG_Score1, IG_Score2, 3, 0)
			%>
			<script type="text/javascript">
			    alert("���� ��Ư ��������ϴ�.");	
			    location.href = "ResultGame_Step2.asp?IG_IDX=<%= IG_IDX %>"	        	        
            </script>
			<%
			response.end
		ElseIf Cdbl(Score1) = Cdbl(Score2) And IG_DRAWBENEFIT = "0"  THEN
		    '���� Ư�� 
		    Call dfgameSql.ExecGameResultStep1(dfDBConn.Conn,  IG_IDX, IG_Score1, IG_Score2, 3, 0)
			%>
			<script type="text/javascript">
			    alert("���� ��Ư ��������ϴ�.");			        
			    location.href = "ResultGame_Step2.asp?IG_IDX=<%= IG_IDX %>"	        
            </script>
			<%
			response.end			
		Else 
			WinTeam = 0
		END IF
	END IF 
	
    Call dfgameSql.ExecGameResultStep1(dfDBConn.Conn,  IG_IDX, IG_Score1, IG_Score2, 1, WinTeam)
%>
<script type="text/javascript">
    alert("���� ��� ����Ǿ����ϴ�.");
    location.href = "ResultGame_Step2.asp?IG_IDX=<%= IG_IDX %>"	        
</script>
