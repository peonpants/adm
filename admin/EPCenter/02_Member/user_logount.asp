<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<%
    '### ��� ���� Ŭ����(Command) ȣ��

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
		alert("ȸ���� �α׾ƿ��Ǿ����ϴ�.");
		location.href="nowMem.asp";
	</script>

