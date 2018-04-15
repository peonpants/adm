<%

	Class memberSql
	
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
	
	

             
        '##### 관리자 페이지 접속 로그    ######################
       
		Public Function RetrieveINFO_USER(ByRef pConn, page, pageSize, sortColumn, sortDirection, keywordType, keyword,startPeriod, endPeriod, site, IA_GROUP, IA_GROUP1, IA_LEVEL)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_USER"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	sortColumn
			mDBMng.SetParamVarWChar 	    4,	sortDirection		
			mDBMng.SetParamVarWChar 	    5,	keywordType
			mDBMng.SetParamVarWChar 	    6,	keyword		
			mDBMng.SetParamVarWChar 	    7,	startPeriod
			mDBMng.SetParamVarWChar 	    8,	endPeriod
			mDBMng.SetParamVarWChar 	    9,	site
			mDBMng.SetParamInt 				10,	IA_GROUP
			mDBMng.SetParamInt 				11,	IA_GROUP1
			mDBMng.SetParamVarWChar 	    12,	IA_LEVEL
										
            'debug
            RetrieveINFO_USER = mDBMng.Patch (pConn)
					
		End Function    
        '##### 본사관리자 페이지 접속 로그    ######################
       
		Public Function RetrieveINFO_USERs1(ByRef pConn, page, pageSize, sortColumn, sortDirection, keywordType, keyword,startPeriod, endPeriod, site, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_LEVEL)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_USERs1"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	sortColumn
			mDBMng.SetParamVarWChar 	    4,	sortDirection		
			mDBMng.SetParamVarWChar 	    5,	keywordType
			mDBMng.SetParamVarWChar 	    6,	keyword		
			mDBMng.SetParamVarWChar 	    7,	startPeriod
			mDBMng.SetParamVarWChar 	    8,	endPeriod
			mDBMng.SetParamVarWChar 	    9,	site
			mDBMng.SetParamInt 				10,	IA_GROUP
			mDBMng.SetParamInt 				11,	IA_GROUP1
			mDBMng.SetParamInt 				12,	IA_GROUP2
			mDBMng.SetParamVarWChar 	    13,	IA_LEVEL
										
            'debug
            RetrieveINFO_USERs1 = mDBMng.Patch (pConn)
					
		End Function 
        '##### 부본사관리자 페이지 접속 로그    ######################
       
		Public Function RetrieveINFO_USERs2(ByRef pConn, page, pageSize, sortColumn, sortDirection, keywordType, keyword,startPeriod, endPeriod, site, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_LEVEL)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_USERs2"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	sortColumn
			mDBMng.SetParamVarWChar 	    4,	sortDirection		
			mDBMng.SetParamVarWChar 	    5,	keywordType
			mDBMng.SetParamVarWChar 	    6,	keyword		
			mDBMng.SetParamVarWChar 	    7,	startPeriod
			mDBMng.SetParamVarWChar 	    8,	endPeriod
			mDBMng.SetParamVarWChar 	    9,	site
			mDBMng.SetParamInt 				10,	IA_GROUP
			mDBMng.SetParamInt 				11,	IA_GROUP1
			mDBMng.SetParamInt 				12,	IA_GROUP2
			mDBMng.SetParamInt 				13,	IA_GROUP3
			mDBMng.SetParamVarWChar 	    14,	IA_LEVEL
										
            'debug
            RetrieveINFO_USERs2 = mDBMng.Patch (pConn)
					
		End Function 
        '##### 총판관리자 페이지 접속 로그    ######################
       
		Public Function RetrieveINFO_USERs3(ByRef pConn, page, pageSize, sortColumn, sortDirection, keywordType, keyword,startPeriod, endPeriod, site, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4, IA_LEVEL)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_USERs3"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	sortColumn
			mDBMng.SetParamVarWChar 	    4,	sortDirection		
			mDBMng.SetParamVarWChar 	    5,	keywordType
			mDBMng.SetParamVarWChar 	    6,	keyword		
			mDBMng.SetParamVarWChar 	    7,	startPeriod
			mDBMng.SetParamVarWChar 	    8,	endPeriod
			mDBMng.SetParamVarWChar 	    9,	site
			mDBMng.SetParamInt 				10,	IA_GROUP
			mDBMng.SetParamInt 				11,	IA_GROUP1
			mDBMng.SetParamInt 				12,	IA_GROUP2
			mDBMng.SetParamInt 				13,	IA_GROUP3
			mDBMng.SetParamInt 				14,	IA_GROUP4
			mDBMng.SetParamVarWChar 	    15,	IA_LEVEL
										
            'debug
            RetrieveINFO_USERs3 = mDBMng.Patch (pConn)
					
		End Function 
        '##### 총 회원수    ######################
		Public Function GetINFO_USERTotalCount(ByRef pConn)
                
			mDBMng.StoredProc = "dbo.UP_GetINFO_USERTotalCount"

            GetINFO_USERTotalCount = mDBMng.Patch (pConn)
					
		End Function   
		
        '##### 총 회원수    ######################
		Public Function GetINFO_NICKNAME(ByRef pConn, pNickName)
                
			mDBMng.StoredProc = "dbo.UP_GetINFO_NICKNAME"
            mDBMng.SetParamVarWChar 	    1,	pNickName
            
            GetINFO_NICKNAME = mDBMng.Patch (pConn)
					
		End Function   
				
		
		
        
        '##### 충전 내역    ######################
		Public Function RetrieveInfo_Charge(ByRef pConn, page, pageSize, IC_ID, IC_SITE)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_Charge"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	IC_ID
			mDBMng.SetParamVarWChar 	    4,	IC_SITE		
										
            'debug
            RetrieveInfo_Charge = mDBMng.Patch (pConn)
					
		End Function  

        '##### 환전 내역    ######################
		Public Function RetrieveInfo_Exchange(ByRef pConn, page, pageSize, IC_ID, IC_SITE)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_Exchange"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	IC_ID
			mDBMng.SetParamVarWChar 	    4,	IC_SITE		
										
            'debug
            RetrieveInfo_Exchange = mDBMng.Patch (pConn)
					
		End Function  

        '##### 로그인 정보 내역    ######################
		Public Function RetrieveLog_LoginByUser(ByRef pConn, page, pageSize, IC_ID, IC_SITE)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveLog_LoginByUser"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	IC_ID
			mDBMng.SetParamVarWChar 	    4,	IC_SITE		
										
            'debug
            RetrieveLog_LoginByUser = mDBMng.Patch (pConn)
					
		End Function  	
		
		'##### 회원 적중률 내역    ######################
		Public Function RetrieveInfo_HitByUser(ByRef pConn, page, pageSize, keywordType, keyword, search2, search4, search5, search6, search7, startPeriod, endPeriod, site)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_HitByUser"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	keywordType
			mDBMng.SetParamVarWChar 	    4,	keyword	
			mDBMng.SetParamVarWChar 	    5,	search2
			mDBMng.SetParamVarWChar 	    6,	search4
			mDBMng.SetParamVarWChar 	    7,	search5	
			mDBMng.SetParamVarWChar 	    8,	search6	
			mDBMng.SetParamVarWChar 	    9,	search7	
			mDBMng.SetParamVarWChar 	    10,	startPeriod	
			mDBMng.SetParamVarWChar 	    11,	endPeriod
			mDBMng.SetParamVarWChar 	    12,	site
										
            'debug
            RetrieveInfo_HitByUser = mDBMng.Patch (pConn)
					
		End Function  	

		'##### 회원 핸드폰 번호    ######################
		Public Function RetrieveInfo_UserByPhone(ByRef pConn, pIU_LEVEL)
            
            IF cStr(pIU_LEVEL) = "0" Then     
			    mDBMng.Query = "SELECT IU_MOBILE FROM INFO_USER WITH(NOLOCK) WHERE IU_LEVEL != ? AND IU_STATUS = 1"
            Else
			    mDBMng.Query = "SELECT IU_MOBILE FROM INFO_USER WITH(NOLOCK) WHERE IU_LEVEL = ?  AND IU_STATUS = 1"
            End IF
										
            mDBMng.SetParamInt 	    1,	pIU_LEVEL            
            RetrieveInfo_UserByPhone = mDBMng.Patch (pConn)
					
		End Function  		

		'##### 회원 핸드폰 번호    ######################
		Public Function RetrieveLOG_LOGINByDay(ByRef pConn, pType, pIU_ID, pLL_SITE)
            
			mDBMng.StoredProc = "UP_RetrieveLOG_LOGINByDay_Seller"
										
            mDBMng.SetParamInt 	    1,	pType 
            mDBMng.SetParamVarWChar 2,	pIU_ID     
            mDBMng.SetParamVarWChar 3,	pLL_SITE     

            RetrieveLOG_LOGINByDay = mDBMng.Patch (pConn)
					
		End Function  		
		
		Public Function RetrieveINFO_USERByDay(ByRef pConn)
            
			mDBMng.StoredProc = "UP_RetrieveINFO_USERByDay"
										
       
            RetrieveINFO_USERByDay = mDBMng.Patch (pConn)
					
		End Function  		

		Public Function RetrieveINFO_USERByDayForSeller(ByRef pConn, pIU_SITE)
            
			    mDBMng.StoredProc = "UP_RetrieveINFO_USERByDayForSeller"
				mDBMng.SetParamVarWChar 1,	pIU_SITE  						
       
            RetrieveINFO_USERByDayForSeller = mDBMng.Patch (pConn)
					
		End Function  		
		
        Public Function RetrieveLOG_LOGINByDayForSeller(ByRef pConn, pType, pIU_ID, pIU_SITE)
            
			mDBMng.StoredProc = "UP_RetrieveLOG_LOGINByDayForSeller"
										
            mDBMng.SetParamInt 	    1,	pType 
            mDBMng.SetParamVarWChar 2,	pIU_ID     
            mDBMng.SetParamVarWChar 3,	pIU_SITE   

            RetrieveLOG_LOGINByDayForSeller = mDBMng.Patch (pConn)
					
		End Function  		
		
		Public Function RetrieveINFO_USERByRecomID(ByRef pConn)
            
			mDBMng.StoredProc = "UP_RetrieveINFO_USERByRecomID"
										
       
            RetrieveINFO_USERByRecomID = mDBMng.Patch (pConn)
					
		End Function  
		

		Public Function RetrieveINFO_USERByRecomID1(ByRef pConn,pIU_ID)
            
			mDBMng.StoredProc = "UP_RetrieveINFO_USERByRecomID1"
										
            mDBMng.SetParamVarWChar 1,	pIU_ID 
            RetrieveINFO_USERByRecomID1 = mDBMng.Patch (pConn)
					
		End Function  

								
	End Class
			
    Dim dfmemberSql
    Set dfmemberSql = new memberSql
%>
