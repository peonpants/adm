<%

Class Cookie
	Private Sub Class_initialize 
	End Sub
				
	' Ŭ���� �Ҹ��� 
	Private Sub Class_terminate ()
	End Sub	

	Public Function HostName()
		Dim serverName, arrDomain 
		serverName = Request.ServerVariables("SERVER_NAME")
		arrDomain = Split(serverName, ".")
		hostName = arrDomain(0)
	End Function

'//��Ű�� �б�	
	Public Function GetCookie(ByVal cookieName)
			GetCookie = Request.Cookies(cookieName)
	End Function	
	
'//��Ű�� ����
	Public Function SetCookie(ByVal cookieName, ByVal cookieValue, ByVal expireDay)
		Response.Cookies(cookieName)			= cookieValue
		Response.Cookies(cookieName).Domain		= Request.ServerVariables("SERVER_NAME")
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
		Response.Cookies(dictionaryName)(cookieName)	= cookieValue
		Response.Cookies(dictionaryName).Domain		= Request.ServerVariables("SERVER_NAME")
		If expireDay <> 0 Then
			Response.Cookies(dictionaryName).Expires	= DateAdd("d", expireDay, Now())
		End If
	End Sub
End Class

Dim dfCookie
Set dfCookie = new Cookie

%>