<%

Class Cookie
	Private Sub Class_initialize 
	End Sub
				
	' 클래스 소멸자 
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

'//쿠키값 읽기	
	Public Function GetCookie(ByVal cookieName)
			GetCookie = Request.Cookies(cookieName)
	End Function	
	
'//쿠키값 쓰기
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

'//쿠키사전 읽기
	Public Function GetDictionaryCookie(ByVal dictionaryName, ByVal cookieName)
			GetDictionaryCookie = Request.Cookies(dictionaryName)(cookieName)
	End Function	
	
'//쿠키사전 쓰기
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