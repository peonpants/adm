<%
    Server.ScriptTimeout = "180"
    
	IF SESSION("rAdminID") = "" OR SESSION("rAdminLevel") <> 1 OR SESSION("rJOBSITE") = "" THEN 
	    Session.Abandon
		With Response
			.write "<script language='javascript'>"  & vbCrLf
			.write "alert('�����ڸ� �α��� �� �� �ֽ��ϴ�.');"  & vbCrLf
			.write "top.location.href='/';" & vbCrLf
			.write "</script>" & vbCrLf
			.End
		End With
	END IF
	
	JOBSITE = Session("rJOBSITE")
%>
