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
	
	

             
        '##### 대문게시판 리스트    ######################
       
		Public Function RetrieveBoard_GATE(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveBoard_GATE"
						
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate								

            RetrieveBoard_GATE = mDBMng.Patch (pConn)
			
					
		End Function    

             
        '##### 대문게시판 입력    ######################
       
		Public Function InsertBoard_Gate(ByRef pConn, BF_TITLE, BF_CONTENTS,  BF_WRITER, BF_PW, BF_LEVEL, BF_SITE, BF_REGDATE)
                
			mDBMng.StoredProc = "dbo.UP_IntertBoard_Gate"
						
			mDBMng.SetParamVarWChar 	    1,	BF_TITLE
			mDBMng.SetParamVarWChar 	    2,	BF_CONTENTS							
			mDBMng.SetParamVarWChar 	    3,	BF_WRITER
			mDBMng.SetParamVarWChar 	    4,	BF_PW
			mDBMng.SetParamInt       	    5,	BF_LEVEL
			mDBMng.SetParamVarWChar 	    6,	BF_SITE								
			mDBMng.SetParamDate      	    7,	BF_REGDATE
	

            InsertBoard_Gate = mDBMng.Execute (pConn)
					
		End Function  
		
        '##### 대문게시판 수정    ######################
       
		Public Function updateBoard_Gate(ByRef pConn, BF_TITLE, BF_CONTENTS,  BF_WRITER, BF_LEVEL, BF_SITE, BF_REGDATE, BF_IDX)
                
			mDBMng.StoredProc = "dbo.UP_UpdateBoard_Gate"
						
			mDBMng.SetParamVarWChar 	    1,	BF_TITLE
			mDBMng.SetParamVarWChar 	    2,	BF_CONTENTS							
			mDBMng.SetParamVarWChar 	    3,	BF_WRITER
			mDBMng.SetParamInt       	    4,	BF_LEVEL
			mDBMng.SetParamVarWChar 	    5,	BF_SITE	
			mDBMng.SetParamDate      	    6,	BF_REGDATE							
			mDBMng.SetParamInt      	    7,	BF_IDX
	

            updateBoard_Gate = mDBMng.Execute (pConn)
					
		End Function   
					
	End Class
			
    Dim dfboardSql
    Set dfboardSql = new boardSql
%>
