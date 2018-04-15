<%

	Class LeagueSql
	
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
	
	

             
        '##### 包府磊 其捞瘤 立加 肺弊    ######################
       
		Public Function RetrieveRef_League(ByRef pConn, page, pageSize, Find, RL_Sports)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveRef_League"
			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Find
			mDBMng.SetParamVarWChar 	    4,	RL_Sports

            RetrieveRef_League = mDBMng.Patch (pConn)
					
		End Function    
						
	End Class
			
    Dim dfLeagueSql
    Set dfLeagueSql = new LeagueSql
%>
