<%

	Class etcSql
	
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
	
	

             
       

		'##### 플래쉬 게임 등록.    ######################
		Public Function InsertInfo_flashGame(ByRef pConn, IF_TITLE, IF_IMAGE, IF_SWF)
                
			mDBMng.StoredProc = "dbo.UP_InsertInfo_flashGame"       			
			mDBMng.SetParamVarWChar	    1,	IF_TITLE            		
			mDBMng.SetParamVarWChar	    2,	IF_IMAGE       
			mDBMng.SetParamVarWChar	    3,	IF_SWF       

										
            InsertInfo_flashGame = mDBMng.Execute (pConn)
					
		End Function   				 
		
		'##### 게임 정보를 삭제.    ######################		
		Public Function deleteInfo_flashGame(ByRef pConn, if_idx)
                
			mDBMng.StoredProc = "dbo.UP_deleteInfo_flashGame"
			mDBMng.SetParamInt	1,	if_idx            			
										
            deleteInfo_flashGame = mDBMng.Execute (pConn)
					
		End Function    	 							
		
        '##### 사이트 정보를 불러온다.    ######################
            
		Public Function RetrieveInfo_flashGame(ByRef pConn, pPage, pPageSize)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_flashGame"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize
										
            RetrieveInfo_flashGame = mDBMng.Patch (pConn)
					
		End Function  		
		
		'##### 회원 접속 로그 카운트    ######################
		
		Public Function GetINFO_FlashGAme(ByRef pConn, IF_IDX)
                
			mDBMng.StoredProc = "dbo.UP_GetINFO_FlashGAme"
            mDBMng.SetParamInt 	    1,	IF_IDX
            
            GetINFO_FlashGAme = mDBMng.Patch (pConn)
					
		End Function  		

		 	
														
	End Class
			
    Dim dfetcSql
    Set dfetcSql = new etcSql
%>
