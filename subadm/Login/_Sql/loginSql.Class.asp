<%

	Class LoginSql
	
		public mUserID	
		public mDBMng
        
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
	
	

             
        '##### Insert Admin Login Log     ######################
        
        Public Function insertCHK_ADMIN(ByRef pConn, IA_ID , AD_IP,isLogin)
			mDBMng.StoredProc = "dbo.UP_insertCHK_ADMIN"
    
			mDBMng.SetParamVarWChar	1,	IA_ID            			
			mDBMng.SetParamVarWChar	2,	AD_IP            		
			mDBMng.SetParamInt	3,	isLogin
     		    			
			insertCHK_ADMIN = mDBMng.Execute ( pConn )
			
        End Function 
             
        '##### Get Admin Info     ######################
            
		Public Function GetINFO_ADMIN(ByRef pConn, IA_ID)
                
			mDBMng.StoredProc = "dbo.UP_GetINFO_ADMIN"
			
			mDBMng.SetParamVarWChar  	1,	IA_ID	
					
            GetINFO_ADMIN = mDBMng.Patch (pConn)
					
		End Function    
 							
	End Class
			
    Dim dfLoginSql
    Set dfLoginSql = new LoginSql
%>