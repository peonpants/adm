<%
    Server.ScriptTimeout = "180"

	AdminID = Request.Cookies("AdminID")
	AdminLevel = Trim(Request.Cookies("AdminLevel"))
	JOBSITE = Trim(Request.Cookies("JOBSITE"))

	IF AdminID = "" OR AdminLevel = "" OR JOBSITE = "" THEN
		call logoff()
	END IF
	
    IF Request.Cookies("AdminID2") = "" Then
	    call logoff()		    
    End IF
    
	on error resume next
	err.clear
	    
    Set CAPIUtil = Server.CreateObject("CAPICOM.Utilities")
    AdminInfo = CAPIUtil.Base64Decode(Request.Cookies("AdminID2")) 
    
    IF err.number <> 0 Then	        
        call logoff()		
    End IF	
        
    Set CAPIUtil = Nothing
        
    on error goto 0
		
    m_arr = split(AdminInfo, "|")
    
    IF ubound(m_arr) <> 4 Then
	    call logoff()	    
    End IF
    
	if right(m_arr(4),3) <> 245 Then
	
    IF AdminID <> m_arr(0) OR  AdminLevel <> m_arr(1) OR  JOBSITE <> m_arr(2) OR  Request.ServerVariables("REMOTE_ADDR") <> m_arr(4) Then
        call logoff()	    
    End IF 
    
    		        
	
		
	Sub logoff()
%>
    <script type="text/javascript">
        alert("관리자만 로그인 할 수 있습니다.");
        location.href = "/EpCenter/login/Logout.asp"
    </script>
<%	
        response.End
	End Sub
	
	end if
%>