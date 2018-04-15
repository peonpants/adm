<%
Class InjectionUtil

	Private IsTrue 

	Private Sub Class_initialize ()
	End Sub	
	
	Private Sub Class_terminate ()
	End Sub

	'-------------------------------------------
	' Injection Code
	'-------------------------------------------
	Public Function ReplaceString(ByVal pStr)

		pStr		= Trim(pStr)
		pStr		= Replace(pStr,"'","''")
		'pStr		= Replace(pStr,"""","""""")
		pStr		= Replace(pStr,"<","&lt;")
		pStr		= Replace(pStr,">","&gt;")
		pStr		= Replace(pStr,"--","&#45;&#45;")		

		ReplaceString	=  pStr
 
	End Function

End Class%>