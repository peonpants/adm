<%

	Class customerSql
	
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
	
	

             
        '##### 고객센터  리스트    ######################
       
		Public Function RetrieveBoard_Customer(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, BC_Type)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveBoard_Customer"
			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
            mDBMng.SetParamInt 	    7,	BC_Type

            RetrieveBoard_Customer = mDBMng.Patch (pConn)
					
		End Function

		'##### 쪽지확인여부 리스트    ######################
       
		Public Function RetrieveBoard_MemoCustomer(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, BC_Type)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveBoard_MemoCustomer"
			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
            mDBMng.SetParamInt 	    7,	BC_Type

            RetrieveBoard_MemoCustomer = mDBMng.Patch (pConn)
					
		End Function
		
		'##### 고객센터  삭제리스트    ######################
       
		Public Function RetrieveBoard_DelCustomer(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, BC_Type)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveBoard_Customer_Log"
			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
            mDBMng.SetParamInt 	    7,	BC_Type

            RetrieveBoard_DelCustomer = mDBMng.Patch (pConn)
					
		End Function


        '##### 고객센터  리스트    ######################
       
		Public Function RetrieveBOARD_CUSTOMER_TEMPLATE(ByRef pConn)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveBOARD_CUSTOMER_TEMPLATE	"
			
            RetrieveBOARD_CUSTOMER_TEMPLATE = mDBMng.Patch (pConn)
					
		End Function    

		Public Function InsertBOARD_CUSTOMER_TEMPLATE(ByRef pConn, BCT_TITLE, BCT_CONTENTS)
                
			mDBMng.StoredProc = "dbo.UP_InsertBOARD_CUSTOMER_TEMPLATE	"
			
			mDBMng.SetParamVarWChar 	    1,	BCT_TITLE
			mDBMng.SetParamVarWChar 	    2,	BCT_CONTENTS	
						
            InsertBOARD_CUSTOMER_TEMPLATE = mDBMng.Execute (pConn)
					
		End Function    

		Public Function GetBOARD_CUSTOMER_TEMPLATE(ByRef pConn, BCT_IDX)
                
			mDBMng.StoredProc = "dbo.UP_GetBOARD_CUSTOMER_TEMPLATE	"
			
			mDBMng.SetParamInt 	    1,	BCT_IDX
			
            GetBOARD_CUSTOMER_TEMPLATE = mDBMng.Patch (pConn)
					
		End Function    
				
		Public Function UpdateBOARD_CUSTOMER_TEMPLATE(ByRef pConn, BCT_TITLE, BCT_CONTENTS, BCT_IDX)
                
			mDBMng.StoredProc = "dbo.UP_UpdateBOARD_CUSTOMER_TEMPLATE	"
			
			mDBMng.SetParamVarWChar 	    1,	BCT_TITLE
			mDBMng.SetParamVarWChar 	    2,	BCT_CONTENTS	
			mDBMng.SetParamInt 	            3,	BCT_IDX
						
            UpdateBOARD_CUSTOMER_TEMPLATE = mDBMng.Execute (pConn)
					
		End Function   
						
		



	End Class
			
    Dim dfcustomerSql
    Set dfcustomerSql = new customerSql
%>
