<%
    Server.ScriptTimeout = "180"
    
	IF SESSION("rAdminID") = "" OR SESSION("rAdminLevel") <> 1 OR SESSION("rJOBSITE") = "" THEN 
	    Session.Abandon
		With Response
			.write "<script language='javascript'>"  & vbCrLf
			.write "alert('관리자만 로그인 할 수 있습니다.');"  & vbCrLf
			.write "top.location.href='/';" & vbCrLf
			.write "</script>" & vbCrLf
			.End
		End With
	END IF
	
	JOBSITE = Session("rJOBSITE")
%>
