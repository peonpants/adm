<%

Class RequestUtil 


	Public Default Function Value( pName )
	
		Set Value = request( pName ) 
	End Function
	
	
	Public Function ValueInit( pName, pInitVal )
		Dim fVal
		
		fVal = request( pName ) 
		If  IsNull( request(fVal) ) or Len(fVal) = 0  Then
			ValueInit = pInitVal
		Else
			ValueInit = fVal
		End If
	End Function
	
	Public Function ValueSplit( pName, pWord )
		
		Dim fVal
		fVal = request( pName ) 
		
		If IsNull( fVal )  Then
			ValueSplit = nothing
		Else
		
			Response.Write fVal &"--"& pWord 
			ValueSplit = Split( fVal, pWord ) 
			
		End If
	End Function
		
    Public Function GetRemoteAddr() 
    
    	GetRemoteAddr = Request.ServerVariables("REMOTE_ADDR")
    
    End Function
	
    Public Function GetScriptName()
        	GetScriptName = Request.ServerVariables("SCRIPT_NAME")
    End Function
	
    Public Function GetReferer()
        	GetReferer = Request.ServerVariables("HTTP_REFERER")
    End Function
    
    Public Function GetUrl()
        	GetUrl = Request.ServerVariables("URL")
    End Function
    
    
    Public Function GetQuery()
        	GetQuery = Request.ServerVariables("QUERY_STRING" )
    End Function
    
     
    Public Function GetFullUrl()
        	GetFullUrl = Request.ServerVariables("URL" ) & "?"& Request.ServerVariables("QUERY_STRING" )
    End Function
    
	Public Function Debug(  )
		
		response.Write( "======= Request Debug ==================<br>" )
		response.Write (" REMOTE_ADDR ::"&Request.Servervariables("REMOTE_ADDR")&"<br>")
		Dim key

		for each key in request.QueryString
			response.Write( key & "=>" & request(key) &"<br>" )
		next 
	
		
		for each key in request.Form
			response.Write( key & "=>" & request(key) &"<br>" )
		next 
		
		response.Write( "======= Request Debug ==================<br>" )
		
	End Function
    

    
End Class

Dim dfRequest 
set dfRequest = new RequestUtil

%>
