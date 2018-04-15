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
    ' SP�� �����ϰ�, RecordSet�� ��ȯ�Ѵ�.
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
    ' SQL Query�� �����ϰ�, RecordSet�� ��ȯ�Ѵ�.
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
    ' SP�� �����Ѵ�.(RecordSet ��ȯ����)
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
    ' SP�� �����Ѵ�.(RecordSet ��ȯ����)
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
    ' Ʈ������� �����ϰ�, Connetion ��ü�� ��ȯ�Ѵ�.
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
    ' Ȱ��ȭ�� Ʈ������� Ŀ���Ѵ�.
    '---------------------------------------------------
    Public Sub CommitTrans(connectionObj)
      If Not connectionObj Is Nothing Then
        connectionObj.CommitTrans
        connectionObj.Close
        Set ConnectionObj = Nothing
      End If
    End Sub

    '---------------------------------------------------
    ' Ȱ��ȭ�� Ʈ������� �ѹ��Ѵ�.
    '---------------------------------------------------
    Public Sub RollbackTrans(connectionObj)
      If Not connectionObj Is Nothing Then
        connectionObj.RollbackTrans
        connectionObj.Close
        Set ConnectionObj = Nothing
      End If
    End Sub

    '---------------------------------------------------
    ' �迭�� �Ű������� �����.
    '---------------------------------------------------
    Public Function MakeParam(PName,PType,PDirection,PSize,PValue)
      MakeParam = Array(PName, PType, PDirection, PSize, PValue)
    End Function

    '---------------------------------------------------
    ' �Ű����� �迭 ������ ������ �̸��� �Ű����� ���� ��ȯ�Ѵ�.
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
    'Array�� �Ѱܿ��� �Ķ���͸� Parsing �Ͽ� Parameter ��ü��
    '�����Ͽ� Command ��ü�� �߰��Ѵ�.
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
                    
                    '### �Ǽ�Ÿ�Զ����� �߰���
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