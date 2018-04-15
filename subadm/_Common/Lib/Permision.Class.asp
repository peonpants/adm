<%

Class Permision
	Private Sub Class_initialize 
	End Sub
				
	
	Private Sub Class_terminate ()
	End Sub	
    

    Public Sub  chkPermision(level)
    
        IF cInt(SESSION("userLevel")) < cInt(level) Then
%>
    <script language="javascript" type="text/javascript">
        alert("권한이 부족합니다.");
        //history.back();
    </script>
<%        
            Response.End
        End IF
    End Sub


    Public Sub  chkPermisionAdmin(level)
    
        IF cInt(SESSION("userLevel")) < cInt(level) Then
%>
    <script language="javascript" type="text/javascript">
        alert("권한이 부족합니다.");
        location.href = "<%= SITE_LOGIN_URL %>";
    </script>
<%        
            Response.End
        End IF
    End Sub
    
End Class

Dim dfPermision
Set dfPermision = New Permision
%>