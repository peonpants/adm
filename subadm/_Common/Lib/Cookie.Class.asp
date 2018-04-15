<%

Class Cookie
	Private Sub Class_initialize 
	End Sub
				
	' Ŭ���� �Ҹ��� 
	Private Sub Class_terminate ()
	End Sub	

	Public Function HostName()
		Dim serverName, arrDomain 
		serverName = Request.ServerVariables("HTTP_X_FORWARDED_SERVER")
		IF serverName = "" Then
		    serverName = Request.ServerVariables("server_name")
		End IF
		arrDomain = Split(serverName, ".")
		hostName = arrDomain(0)
	End Function

'//��Ű�� �б�	
	Public Function GetCookie(ByVal cookieName)
			GetCookie = Request.Cookies(cookieName)
	End Function	
	
'//��Ű�� ����
	Public Function SetCookie(ByVal cookieName, ByVal cookieValue, ByVal expireDay)
	    serverName = Request.ServerVariables("HTTP_X_FORWARDED_SERVER")
		IF serverName = "" Then
		    serverName = Request.ServerVariables("server_name")
		End IF
			
		Response.Cookies(cookieName)			= cookieValue
		Response.Cookies(cookieName).Domain		= serverName
		If expireDay <> 0 Then
			Response.Cookies(cookieName).Expires	= DateAdd("d", expireDay, Now())
		End If
	End Function

'//��Ű���� �б�
	Public Function GetDictionaryCookie(ByVal dictionaryName, ByVal cookieName)
			GetDictionaryCookie = Request.Cookies(dictionaryName)(cookieName)
	End Function	
	
'//��Ű���� ����
	Public Sub SetDictionaryCookie(ByVal dictionaryName, ByVal cookieName,  ByVal cookieValue, ByVal expireDay)	
	
	    serverName = Request.ServerVariables("HTTP_X_FORWARDED_SERVER")
		IF serverName = "" Then
		    serverName = Request.ServerVariables("server_name")
		End IF
			
		Response.Cookies(dictionaryName)(cookieName)	= cookieValue
		Response.Cookies(dictionaryName).Domain		= serverName
		If expireDay <> 0 Then
			Response.Cookies(dictionaryName).Expires	= DateAdd("d", expireDay, Now())
		End If
	End Sub
End Class

Dim dfCookie
Set dfCookie = new Cookie

%>