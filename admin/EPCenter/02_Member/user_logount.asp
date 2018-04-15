<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<%
    '### 디비 관련 클래스(Command) 호출

    Mode 			= Trim(REQUEST("Mode"))
	IU_ID			= Trim(REQUEST("IU_ID"))
	IF Mode = "user" Then
        IF IU_ID <> "" Then
	        SQL = "UPDATE INFO_USER SET "
	        SQL = SQL & "IU_LOGOUT = 1 "
	        SQL = SQL & " WHERE IU_ID = '"& IU_ID & "'"	
            DbCon.execute(SQL)   
			
	        SQL = "DELETE From realtime_log  "
	        SQL = SQL & " WHERE IU_ID = '"& IU_ID & "'"	
            DbCon.execute(SQL)  
        End IF
    ElseIF Mode = "all" Then

     
        SQL = "DELETE From realtime_log  "
        
            DbCon.execute(SQL)   
    End IF    	

	DbCon.Close
	Set DbCon=Nothing
%>
	<script>
		alert("회원이 로그아웃되었습니다.");
		location.href="nowMem.asp";
	</script>

