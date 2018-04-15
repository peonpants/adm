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
       
		Public Function RetrieveINFO_USER_REAL(ByRef pConn, page, pageSize, sortColumn, sortDirection, keywordType, keyword,startPeriod, endPeriod, site)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_USER_REAL"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	sortColumn
			mDBMng.SetParamVarWChar 	    4,	sortDirection		
			mDBMng.SetParamVarWChar 	    5,	keywordType
			mDBMng.SetParamVarWChar 	    6,	keyword		
			mDBMng.SetParamVarWChar 	    7,	startPeriod
			mDBMng.SetParamVarWChar 	    8,	endPeriod
			mDBMng.SetParamVarWChar 	    9,	site
										
            'debug
            RetrieveINFO_USER_REAL = mDBMng.Patch (pConn)
					
		End Function  

        '##### 2레벨업 대상 로그    ######################
       
		Public Function RetrieveINFO_USER_REAL_2lvup(ByRef pConn, page, pageSize, sortColumn, sortDirection, keywordType, keyword,startPeriod, endPeriod, site)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_USER_REAL_2lvup"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	sortColumn
			mDBMng.SetParamVarWChar 	    4,	sortDirection		
			mDBMng.SetParamVarWChar 	    5,	keywordType
			mDBMng.SetParamVarWChar 	    6,	keyword		
			mDBMng.SetParamVarWChar 	    7,	startPeriod
			mDBMng.SetParamVarWChar 	    8,	endPeriod
			mDBMng.SetParamVarWChar 	    9,	site
										
            'debug
            RetrieveINFO_USER_REAL_2lvup = mDBMng.Patch (pConn)
					
		End Function  
             
        '##### 3레벨업 대상 로그    ######################
       
		Public Function RetrieveINFO_USER_REAL_3lvup(ByRef pConn, page, pageSize, sortColumn, sortDirection, keywordType, keyword,startPeriod, endPeriod, site)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_USER_REAL_3lvup"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	sortColumn
			mDBMng.SetParamVarWChar 	    4,	sortDirection		
			mDBMng.SetParamVarWChar 	    5,	keywordType
			mDBMng.SetParamVarWChar 	    6,	keyword		
			mDBMng.SetParamVarWChar 	    7,	startPeriod
			mDBMng.SetParamVarWChar 	    8,	endPeriod
			mDBMng.SetParamVarWChar 	    9,	site
										
            'debug
            RetrieveINFO_USER_REAL_3lvup = mDBMng.Patch (pConn)
					
		End Function  

        '##### 4레벨업 대상 로그    ######################
       
		Public Function RetrieveINFO_USER_REAL_4lvup(ByRef pConn, page, pageSize, sortColumn, sortDirection, keywordType, keyword,startPeriod, endPeriod, site)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_USER_REAL_4lvup"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	sortColumn
			mDBMng.SetParamVarWChar 	    4,	sortDirection		
			mDBMng.SetParamVarWChar 	    5,	keywordType
			mDBMng.SetParamVarWChar 	    6,	keyword		
			mDBMng.SetParamVarWChar 	    7,	startPeriod
			mDBMng.SetParamVarWChar 	    8,	endPeriod
			mDBMng.SetParamVarWChar 	    9,	site
										
            'debug
            RetrieveINFO_USER_REAL_4lvup = mDBMng.Patch (pConn)
					
		End Function  

        '##### 5레벨업 대상 로그    ######################
       
		Public Function RetrieveINFO_USER_REAL_5lvup(ByRef pConn, page, pageSize, sortColumn, sortDirection, keywordType, keyword,startPeriod, endPeriod, site)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_USER_REAL_5lvup"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	sortColumn
			mDBMng.SetParamVarWChar 	    4,	sortDirection		
			mDBMng.SetParamVarWChar 	    5,	keywordType
			mDBMng.SetParamVarWChar 	    6,	keyword		
			mDBMng.SetParamVarWChar 	    7,	startPeriod
			mDBMng.SetParamVarWChar 	    8,	endPeriod
			mDBMng.SetParamVarWChar 	    9,	site
										
            'debug
            RetrieveINFO_USER_REAL_5lvup = mDBMng.Patch (pConn)
					
		End Function  

        '##### 관리자 페이지 접속 로그    ######################
       
		Public Function RetrieveINFO_USER(ByRef pConn, page, pageSize, sortColumn, sortDirection, keywordType, keyword,startPeriod, endPeriod, site)
                
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
										
            'debug
            RetrieveINFO_USER = mDBMng.Patch (pConn)
					
		End Function  

		'##### 관리자 페이지 접속 로그    ######################
       
		Public Function RetrieveINFO_USER_NEW(ByRef pConn, page, pageSize, sortColumn, sortDirection, keywordType, keyword,startPeriod, endPeriod, site,SearchStatus)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_USER_ADMIN"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	sortColumn
			mDBMng.SetParamVarWChar 	    4,	sortDirection		
			mDBMng.SetParamVarWChar 	    5,	keywordType
			mDBMng.SetParamVarWChar 	    6,	keyword		
			mDBMng.SetParamVarWChar 	    7,	startPeriod
			mDBMng.SetParamVarWChar 	    8,	endPeriod
			mDBMng.SetParamVarWChar 	    9,	site
			mDBMng.SetParamVarWChar 	    10,	SearchStatus
										
            'debug
            RetrieveINFO_USER_NEW = mDBMng.Patch (pConn)
					
		End Function
		
		
		
				 '##### 관리자레벨 글쓰기 리스트    ######################
       
		Public Function Retrievewriter_list(ByRef pConn, page, pageSize, sortColumn, sortDirection, Search, Find)
                
			mDBMng.StoredProc = "dbo.UP_Retrievewriter_list"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	sortColumn
			mDBMng.SetParamVarWChar 	    4,	sortDirection		
			mDBMng.SetParamVarWChar 	    5,	keywordType
			mDBMng.SetParamVarWChar 	    6,	keyword		
										
            'debug
            'response.end
            Retrievewriter_list = mDBMng.Patch (pConn)
					
		End Function   
		
		
						 '##### 관리자레벨 리스트    ######################
       
		Public Function RetrieveBOARD_NICKNAME(ByRef pConn)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveBOARD_NICKNAME"
										
            'debug
            'response.end
            RetrieveBOARD_NICKNAME = mDBMng.Patch (pConn)
					
		End Function   
		
		
		'##### 관리자레벨 글쓰기 아이디 생성    ######################
		Public Function Recoverywriter_BOARD(ByRef pConn, IU_ID, BN_LEVEL , BN_SPORTS , IU_NICKNAME)
                
			mDBMng.StoredProc = "dbo.UP_Recoverywriter_BOARD"
			mDBMng.SetParamVarWChar 	    1,	IU_ID
			mDBMng.SetParamInt 	            2,	BN_LEVEL
			mDBMng.SetParamVarWChar 	    3,	BN_SPORTS
			mDBMng.SetParamVarWChar 	    4,	IU_NICKNAME		
										
            'debug
            'RESPONSE.END
            Recoverywriter_BOARD = mDBMng.Execute (pConn)
					
		End Function  
		
		'##### 회원 레벨 관리    ######################
		   Public Function RetrieveINFO_USER_LEVEL_CONTROL(ByRef pConn, page, pageSize, sortColumn, sortDirection, Search, Find, sStartDate, sEndDate, reqIU_SITE)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_USER_LEVEL_CONTROL"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	sortColumn
			mDBMng.SetParamVarWChar 	    4,	sortDirection		
			mDBMng.SetParamVarWChar 	    5,	keywordType
			mDBMng.SetParamVarWChar 	    6,	keyword		
			mDBMng.SetParamVarWChar 	    7,	startPeriod
			mDBMng.SetParamVarWChar 	    8,	endPeriod
			mDBMng.SetParamVarWChar 	    9,	site
										
            'debug
            RetrieveINFO_USER_LEVEL_CONTROL = mDBMng.Patch (pConn)
					
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
		Public Function RetrieveInfo_UserByPhone(ByRef pConn, pIU_LEVEL, pIU_SITE, pIU_CHARGE)
            
            Dim whereOption
            whereOption = ""
            IF cStr(pIU_LEVEL) <> "" Then    
                whereOption = whereOption & " AND IU_LEVEL = " & pIU_LEVEL
            End IF

            IF cStr(pIU_SITE) <> "" Then     
                whereOption = whereOption & " AND IU_SITE = '" & pIU_SITE & "'"
            End IF
            
            IF cStr(pIU_CHARGE) <> "" Then     
                whereOption = whereOption & " AND IU_CHARGE > 0 "
            End IF
            
                whereOption = whereOption & " AND IU_status = 1 "
                
            strSQL = "SELECT IU_MOBILE FROM INFO_USER WITH(NOLOCK) WHERE 1=1 " & whereOption

			mDBMng.Query = strSQL
         
            RetrieveInfo_UserByPhone = mDBMng.Patch (pConn)
					
		End Function  		

		'##### 회원 핸드폰 번호    ######################
		Public Function RetrieveLOG_LOGINByDay(ByRef pConn, pType, pIU_ID)
            
			mDBMng.StoredProc = "UP_RetrieveLOG_LOGINByDay"
										
            mDBMng.SetParamInt 	    1,	pType 
            mDBMng.SetParamVarWChar 2,	pIU_ID     

            RetrieveLOG_LOGINByDay = mDBMng.Patch (pConn)
					
		End Function  		
		
		Public Function RetrieveINFO_USERByDay(ByRef pConn)
            
			mDBMng.StoredProc = "UP_RetrieveINFO_USERByDay"
										
       
            RetrieveINFO_USERByDay = mDBMng.Patch (pConn)
					
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


        '##### 회원정보를 지운다    ######################
		Public Function UpdateINFO_USERByDel(ByRef pConn, pIU_IDX)
                
			mDBMng.StoredProc = "dbo.UP_UpdateINFO_USERByDel"
            mDBMng.SetParamInt 	    1,	pIU_IDX
            
            UpdateINFO_USERByDel = mDBMng.Execute (pConn)
					
		End Function   

		'#####  중복 아이피 체크    ######################
		Public Function RetrieveDoubleLogin(ByRef pConn, page, pageSize)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveDoubleLogin"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						

            RetrieveDoubleLogin = mDBMng.Patch (pConn)

		End Function  	
												
	End Class
			
    Dim dfmemberSql
    Set dfmemberSql = new memberSql
%>
