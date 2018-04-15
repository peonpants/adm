<%

	Class boardSql
	
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
	
	

             
        '##### 자유게시판 리스트    ######################
       
		Public Function RetrieveBoard_Free(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, sBF_LEVEL)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveBoard_Free"
						
			mDBMng.SetParamInt 	            1,	page
			mDBMng.SetParamInt 	            2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate								
            mDBMng.SetParamInt 	            7,	sBF_LEVEL		
            
            RetrieveBoard_Free = mDBMng.Patch (pConn)
			
					
		End Function    

             
        '##### 자유게시판 입력    ######################
       
		Public Function InsertBoard_Free(ByRef pConn, BF_TITLE, BF_CONTENTS, BF_WRITER, BF_PW, BF_HITS, BF_LEVEL, BF_SITE, BF_REGDATE, IB_IDX)
                
			mDBMng.StoredProc = "dbo.UP_IntertBoard_Free"
						
			mDBMng.SetParamVarWChar 	    1,	BF_TITLE
			mDBMng.SetParamVarWChar 	    2,	BF_CONTENTS							
			mDBMng.SetParamVarWChar 	    3,	BF_WRITER
			mDBMng.SetParamVarWChar 	    4,	BF_PW
			mDBMng.SetParamInt       	    5,	BF_HITS
			mDBMng.SetParamInt       	    6,	BF_LEVEL
			mDBMng.SetParamVarWChar 	    7,	BF_SITE								
			mDBMng.SetParamDate      	    8,	BF_REGDATE						
			mDBMng.SetParamVarWChar      	9,	IB_IDX
	

            InsertBoard_Free = mDBMng.Execute (pConn)
					
		End Function  
		
        '##### 자유게시판 수정    ######################
       
		Public Function updateBoard_Free(ByRef pConn, BF_TITLE, BF_CONTENTS, BF_WRITER, BF_HITS, BF_LEVEL, BF_SITE, BF_REGDATE, BF_IDX, IB_IDX)
                
			mDBMng.StoredProc = "dbo.UP_UpdateBoard_Free"
						
			mDBMng.SetParamVarWChar 	    1,	BF_TITLE
			mDBMng.SetParamVarWChar 	    2,	BF_CONTENTS							
			mDBMng.SetParamVarWChar 	    3,	BF_WRITER
			mDBMng.SetParamInt       	    4,	BF_HITS
			mDBMng.SetParamInt       	    5,	BF_LEVEL
			mDBMng.SetParamVarWChar 	    6,	BF_SITE	
			mDBMng.SetParamDate      	    7,	BF_REGDATE							
			mDBMng.SetParamInt      	    8,	BF_IDX						
			mDBMng.SetParamVarWChar      	9,	IB_IDX
	

            updateBoard_Free = mDBMng.Execute (pConn)
					
		End Function   
		
		'##### 댓글 수정    ######################
       
		Public Function updateBoard_FreeReply(ByRef pConn, BFR_WRITER, BFR_CONTENTS, BFR_REGDATE, BFR_IDX)
                
			mDBMng.StoredProc = "dbo.UP_UpdateBoard_FreeReply"
						
			mDBMng.SetParamVarWChar 	    1,	BFR_WRITER
			mDBMng.SetParamVarWChar 	    2,	BFR_CONTENTS							
			mDBMng.SetParamDate      	    3,	BFR_REGDATE							
			mDBMng.SetParamInt      	    4,	BFR_IDX
	

            updateBoard_FreeReply = mDBMng.Execute (pConn)
					
		End Function   
				
	    Public Function insertBoard_disable(ByRef pConn, BFR_WRITER)
                
			mDBMng.Query = "insert into BOARD_FREE_DISABLE (BFR_WRITER) values (?)"
						
			mDBMng.SetParamVarWChar 	    1,	BFR_WRITER
	
            insertBoard_disable = mDBMng.Execute (pConn)
					
		End Function   

	    Public Function deleteBoard_disable(ByRef pConn, BFR_WRITER)
                
			mDBMng.Query = "delete from BOARD_FREE_DISABLE where BFR_WRITER = ? "
						
			mDBMng.SetParamVarWChar 	    1,	BFR_WRITER
	
            deleteBoard_disable = mDBMng.Execute (pConn)
					
		End Function   
				
							
	End Class
			
    Dim dfboardSql
    Set dfboardSql = new boardSql
%>
