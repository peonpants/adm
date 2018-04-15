<%

	Class accountSql
	
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
	
	

       

		
        '##### 충전 정보 리스트    ######################
       
		Public Function RetrieveCharge_List(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveCharge_List"
			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site

            RetrieveCharge_List = mDBMng.Patch (pConn)
					
		End Function    

		'##### 충전 정보 리스트    ######################
       
		Public Function RetrieveCharge_List_New(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site, ICGTYPE)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveCharge_List_New"
			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site
			mDBMng.SetParamInt 	    8,	ICGTYPE

            RetrieveCharge_List_New = mDBMng.Patch (pConn)
					
		End Function    
		
		'##### 충전 삭제로그 리스트    ######################
       
		Public Function RetrieveCharge_delList(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveCharge_delList"
			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site

            RetrieveCharge_delList = mDBMng.Patch (pConn)
					
		End Function    
		
        '##### 환전 정보 리스트    ######################
       
		Public Function RetrieveExchange_List(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveExchange_List"
			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site

            RetrieveExchange_List = mDBMng.Patch (pConn)
					
		End Function   
		
		'##### 환전 삭제로그 리스트    ######################
       
		Public Function RetrieveExchange_DelList(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveExchange_DelList"
			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site

            RetrieveExchange_DelList = mDBMng.Patch (pConn)
					
		End Function 


	
        '##### 환전 정보 리스트    ######################
       
		Public Function RetrieveLog_CashInOut(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveLog_CashInOut"
			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site

            RetrieveLog_CashInOut = mDBMng.Patch (pConn)
					
		End Function    
						
        '##### 환전 정보 리스트    ######################
       
		Public Function RetrieveLog_AdminCashInOut(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveLog_AdminCashInOut"
			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site

            RetrieveLog_AdminCashInOut = mDBMng.Patch (pConn)
					
		End Function   
		
		'##### 정산 리스트    ######################
       
		Public Function RetrieveLog_AdjustByDay(ByRef pConn, page, pageSize, sStartDate, sEndDate, site)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveLog_AdjustByDay"
			
			
			mDBMng.SetParamInt 	            1,	page
			mDBMng.SetParamInt 	            2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	sStartDate
			mDBMng.SetParamVarWChar 	    4,	sEndDate
			mDBMng.SetParamVarWChar 	    5,	site


            RetrieveLog_AdjustByDay = mDBMng.Patch (pConn)
					
		End Function    
						
		'##### 정산 리스트(New)    ######################
       
		Public Function RetrieveLog_AdjustByDay1(ByRef pConn, page, pageSize, sStartDate, sEndDate, site)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveLog_AdjustByDay1"
			
			
			mDBMng.SetParamInt 	            1,	page
			mDBMng.SetParamInt 	            2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	sStartDate
			mDBMng.SetParamVarWChar 	    4,	sEndDate
			mDBMng.SetParamVarWChar 	    5,	site


            RetrieveLog_AdjustByDay1 = mDBMng.Patch (pConn)
					
		End Function    
						
						
		'##### 포인트 충전    ######################
       
		Public Function insertLOG_POINT(ByRef pConn, LP_ID, LP_TYPE, LP_POINT, LP_COMMENTS, LP_CONTENTS1)
                
			mDBMng.StoredProc = "dbo.UP_insertLOG_POINT"
			
			
			mDBMng.SetParamVarWChar 	    1,	LP_ID
			mDBMng.SetParamInt 	            2,	LP_TYPE							
			mDBMng.SetParamInt       	    3,	LP_POINT
			mDBMng.SetParamVarWChar 	    4,	LP_COMMENTS
			mDBMng.SetParamInt       	    5,	0
			mDBMng.SetParamInt       	    6,	0
			mDBMng.SetParamVarWChar 	    7,	LP_CONTENTS1

            'debug()
            insertLOG_POINT = mDBMng.Execute (pConn)
					
		End Function  
		
		'##### 포인트 리스트    ######################
       
       
		Public Function RetrieveLOG_POINTINOUTByAdmin(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveLOG_POINTINOUTByAdmin"
			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site


            RetrieveLOG_POINTINOUTByAdmin = mDBMng.Patch (pConn)
					
		End Function   

		Public Function RetrieveLOG_DAILY_DATA_STAT(ByRef pConn, sStartDate, sEndDate)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveLOG_DAILY_DATA_STAT"
									
			mDBMng.SetParamVarWChar 	    1,	sStartDate
			mDBMng.SetParamVarWChar 	    2,	sEndDate


            RetrieveLOG_DAILY_DATA_STAT = mDBMng.Patch (pConn)
					
		End Function   

		'정산현황
		Public Function RetrieveLOG_Cal_DATA_STAT(ByRef pConn, sStartDate, sEndDate)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveLOG_CAL_DATA_STAT"
									
			mDBMng.SetParamVarWChar 	    1,	sStartDate
			mDBMng.SetParamVarWChar 	    2,	sEndDate


            RetrieveLOG_Cal_DATA_STAT = mDBMng.Patch (pConn)
					
		End Function  

		Public Function GetINFO_CHARGEByHourStat(ByRef pConn,  sStartDate, sEndDate, site)
                
			mDBMng.StoredProc = "dbo.UP_GetINFO_CHARGEByHourStat"
						
			mDBMng.SetParamVarWChar 	    1,	sStartDate
			mDBMng.SetParamVarWChar 	    2,	sEndDate
			mDBMng.SetParamVarWChar 	    3,	site

            GetINFO_CHARGEByHourStat = mDBMng.Patch (pConn)
					
		End Function   
		
		'##### 롤링정산시 로그 등록 (17-12-19추가)   ######################	
		Public Function InsertLOG_ADMIN_CASHINOUT(ByRef pConn, IU_SITE, IA_ID, IA_CASH, IA_GCASH, IA_TYPE, LC_CONTENT, IB_IDX, LAC_GROUP, LAC_GROUP1, LAC_GROUP2, LAC_GROUP3, LAC_GROUP4)
			mDBMng.StoredProc = "dbo.UP_InsertLOG_ADMIN_CASHINOUT"
			mDBMng.SetParamVarWChar		1, IU_SITE
			mDBMng.SetParamVarWChar		2, IA_ID
			mDBMng.SetParamInt			3, IA_CASH
			mDBMng.SetParamInt			4, IA_GCASH
			mDBMng.SetParamInt			5, IA_TYPE
			mDBMng.SetParamVarWChar		6, LC_CONTENT
			mDBMng.SetParamInt			7, IB_IDX
			mDBMng.SetParamInt			8, LAC_GROUP
			mDBMng.SetParamInt			9, LAC_GROUP1
			mDBMng.SetParamInt			10, LAC_GROUP2
			mDBMng.SetParamInt			11, LAC_GROUP3
			mDBMng.SetParamInt			12, LAC_GROUP4

			UP_InsertLOG_ADMIN_CASHINOUT =  mDBMng.Execute (pConn)
		End Function

								
	End Class
			
    Dim dfaccountSql
    Set dfaccountSql = new accountSql
%>
