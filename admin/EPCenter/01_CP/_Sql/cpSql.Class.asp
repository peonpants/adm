<%

	Class cpSql
	
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
        
        Public Function insertCHK_ADMIN(ByRef pConn, IA_ID , AD_IP)
			mDBMng.StoredProc = "dbo.UP_insertCHK_ADMIN"
    
			mDBMng.SetParamVarWChar	1,	IA_ID            			
			mDBMng.SetParamVarWChar	2,	AD_IP            		
     		    			
			insertCHK_ADMIN = mDBMng.Execute ( pConn )
			
        End Function 
             
        '##### 관리자 페이지 접속 로그    ######################
            
		Public Function RetrieveCHK_ADMIN(ByRef pConn)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveCHK_ADMIN"
							
            RetrieveCHK_ADMIN = mDBMng.Patch (pConn)
					
		End Function 
		             
        '##### 관리자 페이지 접속 로그    ######################
            
		Public Function RetrieveLOG_API(ByRef pConn)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveLOG_API"
							
            RetrieveLOG_API = mDBMng.Patch (pConn)
					
		End Function 

		'##### 관리자 페이지 접속 로그    ######################
            
		Public Function RetrieveCHK_ADMIN_New(ByRef pConn, IAGTYPE)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveCHK_ADMIN_New"

			mDBMng.SetParamInt	    1,	IAGTYPE
							
            RetrieveCHK_ADMIN_New = mDBMng.Patch (pConn)
					
		End Function 


        '##### 관리자 정보 리스트     ######################
        
        Public Function RetrieveINFO_ADMIN_L1(ByRef pConn, IA_GROUP, IA_Level)
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_ADMIN_L1"
			mDBMng.SetParamInt	    1,	IA_GROUP
			mDBMng.SetParamInt	    2,	IA_Level
			RetrieveINFO_ADMIN_L1 = mDBMng.Patch ( pConn )
			
        End Function  

        '##### 관리자 정보 리스트     ######################
        
        Public Function RetrieveINFO_ADMIN_L2(ByRef pConn, IA_GROUP,IA_GROUP1,IA_GROUP2)
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_ADMIN_L2"
			mDBMng.SetParamInt	    1,	IA_GROUP
			mDBMng.SetParamInt	    2,	IA_GROUP1
			mDBMng.SetParamInt	    3,	IA_GROUP2
			RetrieveINFO_ADMIN_L2 = mDBMng.Patch ( pConn )
			
        End Function  

        '##### 관리자 정보 리스트     ######################
        
        Public Function RetrieveINFO_ADMIN_L3(ByRef pConn, IA_GROUP,IA_GROUP1,IA_GROUP2,IA_GROUP3)
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_ADMIN_L3"
			mDBMng.SetParamInt	    1,	IA_GROUP
			mDBMng.SetParamInt	    2,	IA_GROUP1
			mDBMng.SetParamInt	    3,	IA_GROUP2
			mDBMng.SetParamInt	    4,	IA_GROUP3
			RetrieveINFO_ADMIN_L3 = mDBMng.Patch ( pConn )
			
        End Function  

        '##### 관리자 정보 리스트     ######################
        
        Public Function RetrieveINFO_ADMIN(ByRef pConn, IA_GROUP, IA_Level)
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_ADMIN"
			mDBMng.SetParamInt	    1,	IA_GROUP
			mDBMng.SetParamInt	    2,	IA_Level
			RetrieveINFO_ADMIN = mDBMng.Patch ( pConn )
			
        End Function  

		'##### 관리자 정보 리스트     ######################
        
        Public Function RetrieveINFO_ADMIN_NEW(ByRef pConn, IA_GROUP, IA_Level,IAGTYPE)
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_ADMIN_NEW"
			mDBMng.SetParamInt	    1,	IA_GROUP
			mDBMng.SetParamInt	    2,	IA_Level
			mDBMng.SetParamInt	    3,	IAGTYPE
			RetrieveINFO_ADMIN_NEW = mDBMng.Patch ( pConn )
			
        End Function 
        
        
        '##### 관리자 정보 보기     ######################
        
        Public Function GetINFO_ADMIN(ByRef pConn, IA_ID)
			mDBMng.StoredProc = "dbo.UP_GetINFO_ADMIN"
    
			mDBMng.SetParamVarWChar	1,	IA_ID            			
   
     		    			
			GetINFO_ADMIN = mDBMng.Patch ( pConn )
			
        End Function 
             
        '##### 관리자 정보 추가    ######################  
         
        Public Function insertINFO_ADMIN_New(ByRef pConn, IA_ID, IA_PW, IA_BankName, IA_BankNum, IA_BankOwner, IA_Level, IA_Site, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4, IA_Percent, IA_Type,IA_SportsPercent,IA_LivePercent,IA_CalMethod)
			mDBMng.StoredProc = "dbo.UP_insertINFO_ADMIN_New"
    
			mDBMng.SetParamVarWChar	1,	IA_ID            			
			mDBMng.SetParamVarWChar	2,	IA_PW            		
			mDBMng.SetParamVarWChar	3,	IA_BankName       
			mDBMng.SetParamVarWChar	4,	IA_BankNum       
			mDBMng.SetParamVarWChar	5,	IA_BankOwner       
			mDBMng.SetParamInt	    6,	IA_Level       
			mDBMng.SetParamVarWChar	    7,	IA_Site      
     		mDBMng.SetParamInt	    8,	IA_GROUP            
     		mDBMng.SetParamInt	    9,	IA_GROUP1          
     		mDBMng.SetParamInt	    10,	IA_GROUP2          
     		mDBMng.SetParamInt	    11,	IA_GROUP3          
     		mDBMng.SetParamInt	    12,	IA_GROUP4     
     		mDBMng.SetParamInt	    13,	IA_Percent  
     		mDBMng.SetParamInt	    14,	IA_Type  
     		mDBMng.SetparamDecimal	15,	IA_SportsPercent 
     		mDBMng.SetparamDecimal	16,	IA_LivePercent 
     		mDBMng.SetParamInt	    17,	IA_CalMethod 
                 		    			
			insertINFO_ADMIN_New = mDBMng.Execute ( pConn )
			
        End Function 
        
        '##### 관리자 정보 수정    ######################
        
        Public Function updateINFO_ADMIN(ByRef pConn, IA_ID, IA_PW, IA_BankName, IA_BankNum, IA_BankOwner, IA_Level, IA_Site, IA_GROUP, IA_Percent, IA_Type, IA_SportsPercent, IA_LivePercent, IA_CASH)
			mDBMng.StoredProc = "dbo.UP_updateINFO_ADMIN"
    
			mDBMng.SetParamVarWChar	1,	IA_ID            			
			mDBMng.SetParamVarWChar	2,	IA_PW            		
			mDBMng.SetParamVarWChar	3,	IA_BankName       
			mDBMng.SetParamVarWChar	4,	IA_BankNum       
			mDBMng.SetParamVarWChar	5,	IA_BankOwner       
			mDBMng.SetParamInt	    6,	IA_Level
			mDBMng.SetParamVarWChar	    7,	IA_Site       
			mDBMng.SetParamInt	    8,	IA_GROUP             
            mDBMng.SetParamInt	    9,	IA_Percent
            mDBMng.SetParamInt	    10,	IA_Type
            mDBMng.SetparamDecimal	11,	IA_SportsPercent  
			mDBMng.SetparamDecimal	12,	IA_LivePercent 
			mDBMng.SetParamInt	    13,	IA_CASH 
			updateINFO_ADMIN = mDBMng.Execute ( pConn )
			
        End Function    
        
       '##### 관리자 정보 수정    ######################
        
        Public Function updateINFO_ADMINByPW(ByRef pConn, IA_ID, IA_PW)
			mDBMng.Query = "UPDATE INFO_ADMIN SET IA_PW = ? WHERE IA_ID = ?"
    
            mDBMng.SetParamVarWChar	1,	IA_PW            		
			mDBMng.SetParamVarWChar	2,	IA_ID            			
			

                 		    			
			updateINFO_ADMINByPW = mDBMng.Execute ( pConn )
			
        End Function            
             
        
        '##### 관리자 정보 삭제    ######################
        
        Public Function deleteINFO_ADMIN(ByRef pConn, IA_ID)
			mDBMng.StoredProc = "dbo.UP_deleteINFO_ADMIN"
    
			mDBMng.SetParamVarWChar	1,	IA_ID            			
         
     		    			
			deleteINFO_ADMIN = mDBMng.Execute ( pConn )
			
        End Function                
             
        '##### 게임 정보를 불러온다.    ######################
            
		Public Function RetrieveSet_Betting(ByRef pConn)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveSet_Betting"
							
            RetrieveSet_Betting = mDBMng.Patch (pConn)
					
		End Function   
        
        '##### 게임 정보를 수정.    ######################
		Public Function UpdateSet_Betting(ByRef pConn, SB_IDX, SB_SITE, SB_BETTINGMIN, SB_BETTINGMAX01, SB_BENEFITMAX01, SB_BETTINGMAX02, SB_BENEFITMAX02)
                
			mDBMng.StoredProc = "dbo.UP_UpdateSet_Betting"
			mDBMng.SetParamInt	        1,	SB_IDX            			
			mDBMng.SetParamVarWChar 	2,	SB_SITE            		
			mDBMng.SetparamDecimal	    3,	SB_BETTINGMIN       
			mDBMng.SetparamDecimal	    4,	SB_BETTINGMAX01       
			mDBMng.SetparamDecimal	    5,	SB_BENEFITMAX01       
			mDBMng.SetparamDecimal	    6,	SB_BETTINGMAX02 
			mDBMng.SetparamDecimal	    7,	SB_BENEFITMAX02
										
            UpdateSet_Betting = mDBMng.Execute (pConn)
					
		End Function   

		'##### 게임 정보를 등록.    ######################
		Public Function InsertSet_Betting(ByRef pConn, SB_SITE, SB_BETTINGMIN, SB_BETTINGMAX01, SB_BENEFITMAX01, SB_BETTINGMAX02, SB_BENEFITMAX02)
                
			mDBMng.StoredProc = "dbo.UP_InsertSet_Betting"       			
			mDBMng.SetParamVarWChar	    1,	SB_SITE            		
			mDBMng.SetparamDecimal	    2,	SB_BETTINGMIN       
			mDBMng.SetparamDecimal	    3,	SB_BETTINGMAX01       
			mDBMng.SetparamDecimal	    4,	SB_BENEFITMAX01       
			mDBMng.SetparamDecimal	    5,	SB_BETTINGMAX02 
			mDBMng.SetparamDecimal	    6,	SB_BENEFITMAX02
										
            InsertSet_Betting = mDBMng.Execute (pConn)
					
		End Function   				 
		
		'##### 게임 정보를 삭제.    ######################		
		Public Function DeleteSet_Betting(ByRef pConn, SB_IDX)
                
			mDBMng.StoredProc = "dbo.UP_DeleteSet_Betting"
			mDBMng.SetParamInt	1,	SB_IDX            			
										
            DeleteSet_Betting = mDBMng.Execute (pConn)
					
		End Function    	 							
		
        '##### 사이트 정보를 불러온다.    ######################
            
		Public Function RetrieveSet_Site(ByRef pConn)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveSet_Site"
							
            RetrieveSet_Site = mDBMng.Patch (pConn)
					
		End Function  	
		
		'##### 사이트 정보를 불러온다.    ######################
            
		Public Function RetrieveSet_Site_New(ByRef pConn, IAGTYPE)
        
			mDBMng.StoredProc = "dbo.UP_RetrieveSet_Site_New"

			mDBMng.SetParamInt	        1,	IAGTYPE
							
            RetrieveSet_Site_New = mDBMng.Patch (pConn)
					
		End Function  	
		
		'##### 사이트 정보를 등록.    ######################
		Public Function InsertSet_Site(ByRef pConn, SITE01, SITE02, SITE03, SITE04, SITE05, SITE06, SITE07)
                
			mDBMng.StoredProc = "dbo.UP_InsertSet_Site"       			
			mDBMng.SetParamVarWChar	    1,	SITE01            		
			mDBMng.SetParamVarWChar	    2,	SITE02       
			mDBMng.SetParamVarWChar	    3,	SITE03       
			mDBMng.SetParamVarWChar	    4,	SITE04       
			mDBMng.SetParamVarWChar	    5,	SITE05 
			mDBMng.SetParamVarWChar	    6,	SITE06
			mDBMng.SetParamVarWChar	    7,	SITE07
										
            InsertSet_Site = mDBMng.Execute (pConn)
					
		End Function  		
		
		'##### 사이트 정보를 수정    ######################
		Public Function updateSet_Site(ByRef pConn, SITE01, SITE02, SITE03, SITE04, SITE05, SITE06, SITE07, SEQ)
                
			mDBMng.StoredProc = "dbo.UP_updateSet_Site"       			
			mDBMng.SetParamVarWChar	    1,	SITE01            		
			mDBMng.SetParamVarWChar	    2,	SITE02       
			mDBMng.SetParamVarWChar	    3,	SITE03       
			mDBMng.SetParamVarWChar	    4,	SITE04       
			mDBMng.SetParamVarWChar	    5,	SITE05 
			mDBMng.SetParamVarWChar	    6,	SITE06
			mDBMng.SetParamVarWChar	    7,	SITE07
			mDBMng.SetParamInt	        8,	SEQ   
										
            updateSet_Site = mDBMng.Execute (pConn)
					
		End Function  	
		
		'##### 사이트 정보를 삭제    ######################
		Public Function deleteSet_Site(ByRef pConn, SEQ)
                
			mDBMng.StoredProc = "dbo.UP_deleteSet_Site"       			
			mDBMng.SetParamInt	        1,	SEQ   
										
            deleteSet_Site = mDBMng.Execute (pConn)
					
		End Function  	
						
        '##### 회원 접속 로그    ######################
       
		Public Function RetrieveLOG_LOGIN(ByRef pConn, page, pageSize, sortColumn, sortDirection, keywordType, keyword,startPeriod, endPeriod, site)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveLOG_LOGIN"
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
            RetrieveLOG_LOGIN = mDBMng.Patch (pConn)
					
		End Function 

		 '##### 회원 접속 로그    ######################
       
		Public Function RetrieveLOG_LOGIN_NEW(ByRef pConn, page, pageSize, sortColumn, sortDirection, keywordType, keyword,startPeriod, endPeriod, site, LLGTYPE)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveLOG_LOGIN_New"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	sortColumn
			mDBMng.SetParamVarWChar 	    4,	sortDirection		
			mDBMng.SetParamVarWChar 	    5,	keywordType
			mDBMng.SetParamVarWChar 	    6,	keyword		
			mDBMng.SetParamVarWChar 	    7,	startPeriod
			mDBMng.SetParamVarWChar 	    8,	endPeriod
			mDBMng.SetParamVarWChar 	    9,	site
			mDBMng.SetParamInt 	    10,	LLGTYPE
										
            'debug
            RetrieveLOG_LOGIN_NEW = mDBMng.Patch (pConn)
					
		End Function 

        '##### 회원 접속 로그    ######################
       
		Public Function RetrieveLOG_LOGIN_FAIL(ByRef pConn, page, pageSize, sortColumn, sortDirection, keywordType, keyword,startPeriod, endPeriod, site)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveLOG_LOGIN_FAIL"
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
            RetrieveLOG_LOGIN_FAIL = mDBMng.Patch (pConn)
					
		End Function 
				
		'##### 회원 접속 로그 카운트    ######################
		
		Public Function GetLOG_LOGINTotalCount(ByRef pConn)
                
			mDBMng.StoredProc = "dbo.UP_GetLOG_LOGINTotalCount"

            GetLOG_LOGINTotalCount = mDBMng.Patch (pConn)
					
		End Function  
		
		'##### 회원 접속 로그 카운트    ######################
		
		Public Function GetLOG_LOGINTotalCountNew(ByRef pConn,LLGTYPE)
                
			mDBMng.StoredProc = "dbo.UP_GetLOG_LOGINTotalCountNew"

			mDBMng.SetParamInt 	    1,	LLGTYPE

            GetLOG_LOGINTotalCountNew = mDBMng.Patch (pConn)
					
		End Function  

		'##### 관리자 전체캐쉬 정보    ######################
		
		Public Function GetAdminTotalCash(ByRef pConn)

			mDBMng.Query = " SELECT lc_contents,	ISNULL(sum(lc_cash), 0) as lc_cash " & _
                           " FROM  dbo.Log_cashinout WITH (NOLOCK) " & _
                           " WHERE ( lc_contents = '배팅배당' OR lc_contents = '배팅차감' Or lc_contents = '머니충전' OR lc_contents = '환전차감') " & _
                           " AND LC_SITE  ='" & request.Cookies("JOBSITE") & "' GROUP BY lc_contents "

            GetAdminTotalCash = mDBMng.Patch (pConn)
					
		End Function  		
			
		'##### 관리자 캐쉬 정보 업데이트    ######################
		
		Public Function UpdateAdminCashInfo(ByRef pConn, pCash, pIA_ID)

			mDBMng.Query = " UPDATE  dbo.INFO_ADMIN " & _
                           " SET  IA_CASH = IA_CASH + " & pCash & _
                           " WHERE IA_ID = '"  & pIA_ID & "'"

            UpdateAdminCashInfo = mDBMng.Execute (pConn)
					
		End Function  
					
		'##### 관리자 캐쉬 환전 로그 생성    ######################
		
		Public Function InsertAdminCashLog(ByRef pConn, pCash, pIA_ID)

			mDBMng.Query = " INSERT INTO [dbo].[LOG_ADMIN_CASHOUT] " & _
                           " ([adminID],[OutCash],[Status]) " & _
                           " values ('"  & pIA_ID & "' , " & pCash & " , 0)"

            InsertAdminCashLog = mDBMng.Execute (pConn)
					
		End Function  					
        								
		'##### 관리자 캐쉬 환전 로그 생성    ######################
		
		Public Function UpdateAdminCashLog(ByRef pConn, pID)

			mDBMng.Query = " UPDATE [dbo].[LOG_ADMIN_CASHOUT] " & _
                           " SET status = 1 "  & _
                           " , outDate = getdate() "  & _
                           " WHERE id = " & pID

            UpdateAdminCashLog = mDBMng.Execute (pConn)
					
		End Function  					        								
								
		'##### 관리자 캐쉬 환전 로그 리스트    ######################
		
		Public Function RetrieveAdminCashLog(ByRef pConn, pIA_ID)

            IF request.Cookies("AdminLevel") = 1 Then
			    mDBMng.Query = " Select Top 100 * From [dbo].[LOG_ADMIN_CASHOUT] with(nolock)" & _
                               " ORDER BY id desc"
            Else
			    mDBMng.Query = " Select Top 100 * From [dbo].[LOG_ADMIN_CASHOUT] with(nolock)" & _
                               " WHERE adminID = '" & pIA_ID & "'" & _
                               " ORDER BY id desc"            
            End IF                           

            RetrieveAdminCashLog = mDBMng.patch (pConn)
					
		End Function  	
						
						
	
		'##### 중복 아이피 체크    ######################
		
		Public Function RetrieveLOG_LOGINByCheckID(ByRef pConn, keywordType, keyword)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveLOG_LOGINByCheckID"

			mDBMng.SetParamVarWChar 	    1,	keywordType
			mDBMng.SetParamVarWChar 	    2,	keyword	
			
            RetrieveLOG_LOGINByCheckID = mDBMng.Patch (pConn)
					
		End Function  	
			
    '##### 관리자 전체캐쉬 정보    ######################		
		Public Function GetInfo_AdminSms(ByRef pConn)

			mDBMng.Query = " SELECT IAS_PHONE, IAS_ENABLE, IAS_IDX FROM INFO_ADMIN_SMS WITH (NOLOCK) "

            GetInfo_AdminSms = mDBMng.Patch (pConn)
					
		End Function 
				
 								
		'##### 관리자 캐쉬 환전 로그 생성    ######################
		
		Public Function UpdateInfo_AdminSms(ByRef pConn, IAS_PHONE, IAS_ENABLE)

			mDBMng.Query = " UPDATE INFO_ADMIN_SMS SET IAS_PHONE = ? , IAS_ENABLE= ? "
			
			mDBMng.SetParamVarWChar 	    1,	IAS_PHONE		
            mDBMng.SetParamInt 	            2,	IAS_ENABLE
            			
            UpdateInfo_AdminSms = mDBMng.Execute (pConn)
					
		End Function  

        '##### 사이트 비공개 설정 가져오기    ######################
        Public Function GetSET_SITE_OPEN(ByRef pConn)
        
            mDBMng.StoredProc = "dbo.UP_GetSET_SITE_OPEN"

            GetSET_SITE_OPEN = mDBMng.Patch (pConn)                    
        
        End Function
        
        
         '##### 잭팟 설정 가져오기    ######################
        Public Function GetSET_SITE_JACKPOT(ByRef pConn)
        
            mDBMng.StoredProc = "dbo.UP_GetSET_SITE_JACKPOT"

            GetSET_SITE_JACKPOT = mDBMng.Patch (pConn)                    
        
        End Function

        '##### 사이트 비공개 설정 업데이트    ######################
		Public Function UpdateSET_SITE_OPEN(ByRef pConn, SITE_OPEN)
                
			mDBMng.StoredProc = "dbo.UP_UpdateSET_SITE_OPEN"       			
			mDBMng.SetParamInt	        1,	SITE_OPEN   
										
            UpdateSET_SITE_OPEN = mDBMng.Execute (pConn)
					
		End Function  
				
        '##### 도메인변경 가져오기    ######################
        Public Function GetINFO_DOMAIN(ByRef pConn)
        
            mDBMng.StoredProc = "dbo.UP_GetINFO_DOMAIN"

            GetINFO_DOMAIN = mDBMng.Patch (pConn)                    
        
        End Function

        '##### 도메인변경 업데이트    ######################
		Public Function UpdateINFO_DOMAIN(ByRef pConn, ID_NAME, ID_URL, ID_USE)
                
			mDBMng.StoredProc = "dbo.UP_UpdateINFO_DOMAIN"       			
			mDBMng.SetParamVarWChar	        1,	ID_NAME   
			mDBMng.SetParamVarWChar	        1,	ID_URL   
			mDBMng.SetParamInt	        1,	ID_USE   
										
            UpdateINFO_DOMAIN = mDBMng.Execute (pConn)
					
		End Function  

        '##### 회원레벨 가져오기    ######################
        Public Function RetrieveINFO_USER_LEVEL(ByRef pConn)
        
            mDBMng.StoredProc = "dbo.UP_RetrieveINFO_USER_LEVEL"

            RetrieveINFO_USER_LEVEL = mDBMng.Patch (pConn)                    
        
        End Function
		

         '##### 회원별 레벨설정 업데이트    ######################
		Public Function UpdateINFO_USER_LEVEL(ByRef pConn, IUL_LEVEL, IUL_Percent, IUL_Percent_live, IUL_Recom_Percent, IUL_Recom_Percent_live, IUL_BPercent, IUL_BPercent_live, IUL_Recom_BPercent, IUL_Recom_BPercent_live,IUL_Charge_Percent,IUL_BETTINGMIN, IUL_BETTINGMAX, IUL_BENEFITMAX, IUL_BETTING_ONE_MIN)
                
			mDBMng.StoredProc = "dbo.UP_UpdateINFO_USER_LEVEL"       			
			mDBMng.SetParamVarWChar	        1,	IUL_LEVEL   
			mDBMng.SetparamDecimal	        2,	IUL_Percent   
			mDBMng.SetparamDecimal	        3,	IUL_Percent_live 
			mDBMng.SetparamDecimal	        4,	IUL_Recom_Percent   
			mDBMng.SetparamDecimal	        5,	IUL_Recom_Percent_live

			mDBMng.SetparamDecimal	        6,	IUL_BPercent   
			mDBMng.SetparamDecimal	        7,	IUL_BPercent_live 
			mDBMng.SetparamDecimal	        8,	IUL_Recom_BPercent   
			mDBMng.SetparamDecimal	        9,	IUL_Recom_BPercent_live

			mDBMng.SetparamDecimal	        10,	IUL_Charge_Percent   
			mDBMng.SetParamInt	        11,	IUL_BETTINGMIN   
			mDBMng.SetParamInt	        12,	IUL_BETTINGMAX   
			mDBMng.SetParamInt	        13,	IUL_BENEFITMAX
			mDBMng.SetParamInt	        14,	IUL_BETTING_ONE_MIN   							
            UpdateINFO_USER_LEVEL = mDBMng.Execute (pConn)
					
		End Function 		

        '##### IP 차단 리스트    ######################
       
		Public Function RetrieveBLOCK_IPByAdmin(ByRef pConn, page, pageSize)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveBLOCK_IPByAdmin"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						

										
            'debug
            RetrieveBLOCK_IPByAdmin = mDBMng.Patch (pConn)
					
		End Function 		

        '##### 메인 동영상    ######################
        								
        Public Function GetINFO_SITE_UCC(ByRef pConn)
        
            mDBMng.Query = "SELECT SITE_UCC FROM dbo.INFO_SITE_UCC WITH(NOLOCK)"

            GetINFO_SITE_UCC = mDBMng.Patch (pConn)                    
        
        End Function
        				

		Public Function UpdateINFO_SITE_UCC(ByRef pConn, SITE_UCC)
                
			mDBMng.Query = "UPDATE dbo.INFO_SITE_UCC SET SITE_UCC = ? "       			
			mDBMng.SetParamVarWChar	        1,	SITE_UCC   
										
            UpdateINFO_SITE_UCC = mDBMng.Execute (pConn)
					
		End Function  		


        '##### 사이트 환전    ######################
		Public Function UpdateSET_SITE_EXCHANGE(ByRef pConn, SITE_OPEN)
                
			mDBMng.Query = "UPDATE dbo.INFO_SITE_EXCHANGE SET SITE_EXCHANGE = ?  "       			
			mDBMng.SetParamInt	        1,	SITE_OPEN   
										
            UpdateSET_SITE_EXCHANGE = mDBMng.Execute (pConn)
					
		End Function  
				
        '##### 사이트 환전    ######################
        Public Function GetINFO_SITE_EXCHANGE(ByRef pConn)
        
            mDBMng.Query = "SELECT SITE_EXCHANGE FROM dbo.INFO_SITE_EXCHANGE WITH(NOLOCK)"

            GetINFO_SITE_EXCHANGE = mDBMng.Patch (pConn)                    
        
        End Function

         '##### CHAT_USE    ######################		
		Public Function GetSET_CHAT_USE(ByRef pConn)

			mDBMng.Query = " SELECT [CHAT_USE] as A_CHAT_USE FROM dbo.SET_CHAT WITH (NOLOCK) "

            GetSET_CHAT_USE = mDBMng.Patch (pConn)    
					
		End Function 
		
		'##### BET_MAX    ######################	
		Public Function GetSET_BET_MAX(ByRef pConn)

			mDBMng.Query = " select top 1 seq,scnt,pcnt,hcnt,lcnt,acnt,dcnt,rcnt,vcnt,mcnt,regdate from info_betting_max with(nolock) order by seq desc "

            GetSET_BET_MAX = mDBMng.Patch (pConn)    
					
		End Function 
		
		'#####  BET_MAX    ######################
		
		Public Function UpdateSET_BET_MAX(ByRef pConn, S_CNT,P_CNT,H_CNT,L_CNT,A_CNT,D_CNT,R_CNT,V_CNT,M_CNT,AID)

			response.write S_CNT & "<br>"
			response.write P_CNT & "<br>"
			response.write H_CNT & "<br>"
			response.write L_CNT & "<br>"
			response.write A_CNT & "<br>"
			response.write D_CNT & "<br>"
			response.write R_CNT & "<br>"
			response.write V_CNT & "<br>"
			response.write M_CNT & "<br>"
			response.write AID & "<br>"
			'response.end
			
			mDBMng.StoredProc = "dbo.UP_InsertSet_Bet_Max"
			
            mDBMng.SetParamInt 	            1,	S_CNT
			mDBMng.SetParamInt 	            2,	P_CNT
			mDBMng.SetParamInt 	            3,	H_CNT
			mDBMng.SetParamInt 	            4,	L_CNT
			mDBMng.SetParamInt 	            5,	A_CNT
			mDBMng.SetParamInt 	            6,	D_CNT
			mDBMng.SetParamInt 	            7,	R_CNT
			mDBMng.SetParamInt 	            8,	V_CNT
			mDBMng.SetParamInt 	            9,	M_CNT
			mDBMng.SetParamVarWChar         10,	AID
            			
            UpdateSET_BET_MAX = mDBMng.Execute (pConn)
					
		End Function  
 								
		'#####  CHAT_USE    ######################
		
		Public Function UpdateSET_CHAT_USE(ByRef pConn, SET_CHAT_USE)

			mDBMng.Query = " UPDATE SET_CHAT SET [CHAT_USE] = ?  "
			
            mDBMng.SetParamInt 	            1,	SET_CHAT_USE
            			
            UpdateSET_CHAT_USE = mDBMng.Execute (pConn)
					
		End Function  


         '##### 7m설정    ######################		
		Public Function GetSET_7M_USE(ByRef pConn)

			mDBMng.Query = " SELECT [7M_USE] as A_7M_USE FROM dbo.SET_7M_USE WITH (NOLOCK) "

            GetSET_7M_USE = mDBMng.Patch (pConn)    
					
		End Function 
				
 								
		'#####  7m설정    ######################
		
		Public Function UpdateSET_7M_USE(ByRef pConn, SET_7M_USE)

			mDBMng.Query = " UPDATE SET_7M_USE SET [7M_USE] = ?  "
			
            mDBMng.SetParamInt 	            1,	SET_7M_USE
            			
            UpdateSET_7M_USE = mDBMng.Execute (pConn)
					
		End Function  
		
		
		'#####  잭팟설정    ######################
		
		Public Function UpdateSITE_JACKPOT(ByRef pConn, IJ_CASH, IJ_PERCENT)

			mDBMng.Query = " UPDATE INFO_JACKPOT SET IJ_CASH = ? , IJ_PERCENT = ?  "
			
            mDBMng.SetParamInt 	            1,	IJ_CASH
            mDBMng.SetparamDecimal 	        2,	IJ_PERCENT
            			
            UpdateSITE_JACKPOT = mDBMng.Execute (pConn)
					
		End Function		

         '##### 총판환전신청기능 설정    ######################		
		Public Function GetSET_SUBEXCHANGE_USE(ByRef pConn)

			mDBMng.Query = "SELECT [EXCHANGE_USE] FROM [dbo].[SET_SUBEXCHANGE_USE]"

            GetSET_SUBEXCHANGE_USE = mDBMng.Patch (pConn)    
					
		End Function   	
		
		'#####  총판환전신청기능 설정    ######################
		Public Function UpdateEXCHANGE_USE(ByRef pConn, EXCHANGE_USE)

			mDBMng.Query = " UPDATE SET_SUBEXCHANGE_USE SET [EXCHANGE_USE] = ?  "
			
            mDBMng.SetParamInt 	            1,	EXCHANGE_USE
            			
            UpdateEXCHANGE_USE = mDBMng.Execute (pConn)
					
		End Function  
	End Class
			
    Dim dfcpSql
    Set dfcpSql = new cpSql
%>
