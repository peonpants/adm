<%
   	Class clsDBHelper
		Private DefaultConnString
		Private DefaultConnection
		
		private sub Class_Initialize()
			'DefaultConnString = 
			DefaultConnString = Application("DBConnString") 
			Set DefaultConnection = Nothing
		End Sub

    '---------------------------------------------------
    ' SP를 실행하고, RecordSet을 반환한다.
    '---------------------------------------------------
    Public Function ExecSPReturnRS(spName, params, connectionString)
      If IsObject(connectionString) Then
        If connectionString is Nothing Then
          If DefaultConnection is Nothing Then
            Set DefaultConnection = CreateObject("ADODB.Connection")
            DefaultConnection.Open DefaultConnString        
          End If      
          Set connectionString = DefaultConnection
        End If
      End If
      
	    Set rs = CreateObject("ADODB.RecordSet")
	    Set cmd = CreateObject("ADODB.Command")

	    cmd.ActiveConnection = connectionString
	    cmd.CommandText = spName
	    cmd.CommandType = adCmdStoredProc
	    Set cmd = collectParams(cmd, params)
	    'cmd.Parameters.Refresh

	    rs.CursorLocation = adUseClient
	    rs.Open cmd, ,adOpenStatic, adLockReadOnly
    	
	    For zz = 0 To cmd.Parameters.Count - 1	  
	      If cmd.Parameters(zz).Direction = adParamOutput OR cmd.Parameters(zz).Direction = adParamInputOutput OR cmd.Parameters(zz).Direction = adParamReturnValue Then
	        If IsObject(params) Then	    
	          If params is Nothing Then
	            Exit For	        
	          End If	      
	        Else
	          params(zz)(4) = cmd.Parameters(zz).Value
	        End If
	      End If
	    Next	

	    Set cmd.ActiveConnection = Nothing
	    Set cmd = Nothing
	    Set rs.ActiveConnection = Nothing

	    Set ExecSPReturnRS = rs
    End Function

    '---------------------------------------------------
    ' SQL Query를 실행하고, RecordSet을 반환한다.
    '---------------------------------------------------
    Public Function ExecSQLReturnRS(strSQL, params, connectionString)
      If IsObject(connectionString) Then
        If connectionString is Nothing Then
          If DefaultConnection is Nothing Then
            Set DefaultConnection = CreateObject("ADODB.Connection")
            DefaultConnection.Open DefaultConnString        
          End If      
          Set connectionString = DefaultConnection
        End If
      End If
      
	    Set rs = CreateObject("ADODB.RecordSet")
	    Set cmd = CreateObject("ADODB.Command")

	    cmd.ActiveConnection = connectionString
	    cmd.CommandText = strSQL
	    cmd.CommandType = adCmdText

	    Set cmd = collectParams(cmd, params)	
    	
	    rs.CursorLocation = adUseClient
	    rs.Open cmd, , adOpenStatic, adLockReadOnly
    	
	    Set cmd.ActiveConnection = Nothing
	    Set cmd = Nothing
	    Set rs.ActiveConnection = Nothing
    	
	    Set ExecSQLReturnRS = rs
    End Function

    '---------------------------------------------------
    ' SP를 실행한다.(RecordSet 반환없음)
    '---------------------------------------------------
    Public Sub ExecSP(strSP,params,connectionString)
      If IsObject(connectionString) Then
        If connectionString is Nothing Then
          If DefaultConnection is Nothing Then
            Set DefaultConnection = CreateObject("ADODB.Connection")
            DefaultConnection.Open DefaultConnString        
          End If      
          Set connectionString = DefaultConnection
        End If
      End If
      
	    Set cmd = CreateObject("ADODB.Command")

	    cmd.ActiveConnection = connectionString
      cmd.CommandText = strSP
      cmd.CommandType = adCmdStoredProc
	    Set cmd = collectParams(cmd, params)

	    cmd.Execute , , adExecuteNoRecords
	    
	    For zz = 0 To cmd.Parameters.Count - 1	  
	      If cmd.Parameters(zz).Direction = adParamOutput OR cmd.Parameters(zz).Direction = adParamInputOutput OR cmd.Parameters(zz).Direction = adParamReturnValue Then
	        If IsObject(params) Then	    
	          If params is Nothing Then
	            Exit For	        
	          End If	      
	        Else
	          params(zz)(4) = cmd.Parameters(zz).Value
	        End If
	      End If
	    Next	

	    Set cmd.ActiveConnection = Nothing
	    Set cmd = Nothing
    End Sub

    '---------------------------------------------------
    ' SP를 실행한다.(RecordSet 반환없음)
    '---------------------------------------------------
    Public Sub ExecSQL(strSQL,params,connectionString)      
      If IsObject(connectionString) Then
        If connectionString is Nothing Then
          If DefaultConnection is Nothing Then
            Set DefaultConnection = CreateObject("ADODB.Connection")
            DefaultConnection.Open DefaultConnString        
          End If      
          Set connectionString = DefaultConnection
        End If
      End If
      
	    Set cmd = CreateObject("ADODB.Command")

	    cmd.ActiveConnection = connectionString
	    cmd.CommandText = strSQL
	    cmd.CommandType = adCmdText
	    Set cmd = collectParams(cmd, params)

	    cmd.Execute , , adExecuteNoRecords

	    Set cmd.ActiveConnection = Nothing
	    Set cmd = Nothing
    End Sub

    '---------------------------------------------------
    ' 트랜잭션을 시작하고, Connetion 개체를 반환한다.
    '---------------------------------------------------
    Public Function BeginTrans(connectionString)
      If IsObject(connectionString) Then
        If connectionString is Nothing Then
          connectionString = DefaultConnString
        End If
      End If

      Set conn = Server.CreateObject("ADODB.Connection")
      conn.Open connectionString
      conn.BeginTrans
      Set BeginTrans = conn
    End Function

    '---------------------------------------------------
    ' 활성화된 트랜잭션을 커밋한다.
    '---------------------------------------------------
    Public Sub CommitTrans(connectionObj)
      If Not connectionObj Is Nothing Then
        connectionObj.CommitTrans
        connectionObj.Close
        Set ConnectionObj = Nothing
      End If
    End Sub

    '---------------------------------------------------
    ' 활성화된 트랜잭션을 롤백한다.
    '---------------------------------------------------
    Public Sub RollbackTrans(connectionObj)
      If Not connectionObj Is Nothing Then
        connectionObj.RollbackTrans
        connectionObj.Close
        Set ConnectionObj = Nothing
      End If
    End Sub

    '---------------------------------------------------
    ' 배열로 매개변수를 만든다.
    '---------------------------------------------------
    Public Function MakeParam(PName,PType,PDirection,PSize,PValue)
      MakeParam = Array(PName, PType, PDirection, PSize, PValue)
    End Function

    '---------------------------------------------------
    ' 매개변수 배열 내에서 지정된 이름의 매개변수 값을 반환한다.
    '---------------------------------------------------		
    Public Function GetValue(params, paramName)
      For Each param in params
        If param(0) = paramName Then
          GetValue = param(4)
          Exit Function
        End If
      Next
    End Function

    Public Sub Dispose
		if (Not DefaultConnection is Nothing) Then 
			if (DefaultConnection.State = adStateOpen) Then DefaultConnection.Close
			Set DefaultConnection = Nothing
		End if
    End Sub

    '---------------------------------------------------------------------------
    'Array로 넘겨오는 파라메터를 Parsing 하여 Parameter 객체를
    '생성하여 Command 객체에 추가한다.
    '---------------------------------------------------------------------------
    Private Function collectParams(cmd,argparams)
	    If VarType(argparams) = 8192 or VarType(argparams) = 8204 or VarType(argparams) = 8209 then 
		    params = argparams
		    For zz = LBound(params) To UBound(params)
			    l = LBound(params(zz))
			    u = UBound(params(zz))
			    ' Check for nulls.
			    If u - l = 4 Then
    				
				    If VarType(params(zz)(4)) = vbString Then
					    If params(zz)(4) = "" Then
						    v = Null
					    Else
						    v = params(zz)(4)
					    End If
				    Else
					    v = params(zz)(4)
				    End If
				    
                    cmd.Parameters.Append cmd.CreateParameter(params(zz)(0), params(zz)(1), params(zz)(2), params(zz)(3), v)				    
                    
                    '### 실수타입때문에 추가함
                    'If params(zz)(1) = "adDecimal" Then
                    '     cmd.Parameters.Scale = 18
                    '     cmd.Parameters.NumericPrecision = 4  				    			         
				    'End If
			    End If
		    Next
							
		    Set collectParams = cmd
		    Exit Function
	    Else
		    Set collectParams = cmd
	    End If
    End Function

	End Class
%>
<%  
    Response.Expires = 0

    with response 
        .expires=-1 
        .addheader "pragma","no-cache" 
        .addheader "cache-control","no-cache" 
    end with 
%>