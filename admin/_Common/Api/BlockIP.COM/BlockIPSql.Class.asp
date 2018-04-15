<%
	Class blockIPSql
	
       Private mDbMng       
		Private Sub Class_initialize ()
			set mDbMng	= New DBCmdSql
		End Sub
	
		Private Sub Class_terminate ()
			set mDbMng	= nothing
		End Sub
	
		Public Function RsAll 
			RsAll = mDBMng.mResultSet
		End Function
	
		
		Public Function RsOne ( pColum )
			IF IsObject(mDBMng.mResultSet) then 
				RsOne = mDBMng.mResultSet(0)(pColum)
			ELSE
				RsOne = null
			END IF
		End Function
	
		Public default property get Rs ( pIdx, pColum )
	
			if IsObject(mDBMng.mResultSet)  then
				Rs = mDBMng.mResultSet(pIdx)(pColum)
			else 
				Rs = null
			end if
				
		End property
	
		Public property get RsCount ()
			RsCount = mDBMng.mResultSet.Count
		End property
			
		Public Function Row ( pIdx )
			set Row = mDBMng.mResultSet(pIdx)
		End Function
	
		Public Function Debug()
			mDBMng.Debug()
		End Function
		
		
		Public Sub SetTable( pTableName ) 
			mTableName = pTableName
		End Sub
											
		Public Function RetrieveBlock_IP(ByRef pConn , CP_IP)		
		    
			mDBMng.StoredProc = "dbo.UP_RetrieveBlock_IP"					
			'mDBMng.SetParamInt 	    1,	CP_IP
			mDBMng.SetParamVarWChar 	    1,	CP_IP
            'debug
            RetrieveBlock_IP = mDBMng.Patch (pConn)
		End Function     

        Public Function ErrorMsg()
        
        End Function			
							
	End Class
	
    Dim dfBlockIPSql
    Set dfBlockIPSql = new blockIPSql
    
	CI_IP = REQUEST("REMOTE_ADDR")
   
    Dim dfBlockDBConn
    Set dfBlockDBConn = new DBConn

    
       
    '######### DB Connect                    ################	
    dfBlockDBConn.SetConn = Application("DBConnString")
	dfBlockDBConn.Connect()	

    
	Call dfBlockIPSql.RetrieveBlock_IP(dfBlockDBConn.Conn, CI_IP)
	
    IF dfBlockIPSql.RsCount <> 0 Then
        With Response
		    .Write "<script language=javascript>" & vbCrLf
		    .Write "alert('서비스 접속이 차단된 아이피입니다. 관리자에게 문의하세요.');" & vbCrLf
		    .Write "self.close();" & vbCrLf
		    .Write "</script>" & vbCrLf    
			.end		    
		End With		    
        
    End iF
    
    Set dfBlockDBConn = Nothing        
    Set dfBlockDBConn = Nothing
%>