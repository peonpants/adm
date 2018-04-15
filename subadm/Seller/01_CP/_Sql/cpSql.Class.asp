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


        '##### 관리자 정보 리스트     ######################
        
        Public Function RetrieveINFO_ADMIN_NEW(ByRef pConn, IA_GROUP, IA_GROUP1, IA_Level, IA_SITE)
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_ADMIN_NEW"
			mDBMng.SetParamInt	    1,	IA_GROUP
			mDBMng.SetParamInt	    2,	IA_GROUP1
			mDBMng.SetParamInt	    3,	IA_Level            			
			mDBMng.SetParamVarWChar	4,	IA_SITE
			RetrieveINFO_ADMIN = mDBMng.Patch ( pConn )
			
        End Function      
        
        '##### 부본사 관리자 정보 리스트     ######################
        
        Public Function RetrieveINFO_ADMIN_NEW1(ByRef pConn, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_Level, IA_SITE)
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_ADMIN_NEW1"
			mDBMng.SetParamInt	    1,	IA_GROUP
			mDBMng.SetParamInt	    2,	IA_GROUP1
			mDBMng.SetParamInt	    3,	IA_GROUP2
			mDBMng.SetParamInt	    4,	IA_Level            			
			mDBMng.SetParamVarWChar	5,	IA_SITE
			RetrieveINFO_ADMIN1 = mDBMng.Patch ( pConn )
			
        End Function   
        '##### 총판 관리자 정보 리스트     ######################
        
        Public Function RetrieveINFO_ADMIN_NEW2(ByRef pConn, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_Level, IA_SITE)
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_ADMIN_NEW2"
			mDBMng.SetParamInt	    1,	IA_GROUP
			mDBMng.SetParamInt	    2,	IA_GROUP1
			mDBMng.SetParamInt	    3,	IA_GROUP2
			mDBMng.SetParamInt	    4,	IA_GROUP3
			mDBMng.SetParamInt	    5,	IA_Level            			
			mDBMng.SetParamVarWChar	6,	IA_SITE
			RetrieveINFO_ADMIN2 = mDBMng.Patch ( pConn )
			
        End Function 
        '##### 매장 관리자 정보 리스트     ######################
        
        Public Function RetrieveINFO_ADMIN_NEW3(ByRef pConn, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4, IA_Level, IA_SITE)
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_ADMIN_NEW3"
			mDBMng.SetParamInt	    1,	IA_GROUP
			mDBMng.SetParamInt	    2,	IA_GROUP1
			mDBMng.SetParamInt	    3,	IA_GROUP2
			mDBMng.SetParamInt	    4,	IA_GROUP3
			mDBMng.SetParamInt	    5,	IA_GROUP4
			mDBMng.SetParamInt	    6,	IA_Level            			
			mDBMng.SetParamVarWChar	7,	IA_SITE
			RetrieveINFO_ADMIN3 = mDBMng.Patch ( pConn )
			
        End Function 
        '##### 관리자 정보 보기     ######################
        
        Public Function GetINFO_ADMIN(ByRef pConn, IA_ID)
			mDBMng.StoredProc = "dbo.UP_GetINFO_ADMIN"
    
			mDBMng.SetParamVarWChar	1,	IA_ID            			
   
     		    			
			GetINFO_ADMIN = mDBMng.Patch ( pConn )
			
        End Function 
             
        '##### 관리자 정보 추가    ######################  
         
        Public Function insertINFO_ADMIN(ByRef pConn, IA_ID, IA_PW, IA_BankName, IA_BankNum, IA_BankOwner, IA_Level, IA_Site, IA_GROUP, IA_Percent)
			mDBMng.StoredProc = "dbo.UP_insertINFO_ADMIN"
    
			mDBMng.SetParamVarWChar	1,	IA_ID            			
			mDBMng.SetParamVarWChar	2,	IA_PW            		
			mDBMng.SetParamVarWChar	3,	IA_BankName       
			mDBMng.SetParamVarWChar	4,	IA_BankNum       
			mDBMng.SetParamVarWChar	5,	IA_BankOwner       
			mDBMng.SetParamInt	    6,	IA_Level       
			mDBMng.SetParamVarWChar	    7,	IA_Site      
     		mDBMng.SetParamInt	    8,	IA_GROUP       
     		mDBMng.SetParamInt	    9,	IA_Percent  
            
                 		    			
			insertINFO_ADMIN = mDBMng.Execute ( pConn )
			
        End Function 
        
        '##### 관리자 정보 수정    ######################
        
        Public Function updateINFO_ADMIN(ByRef pConn, IA_ID, IA_PW, IA_BankName, IA_BankNum, IA_BankOwner, IA_Level, IA_Site, IA_GROUP, IA_Percent,IA_NICKNAME)
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
			mDBMng.SetParamVarWChar	10,	IA_BankName   
                 		    			
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
						
        '##### 본사 회원 접속 로그    ######################
       
		Public Function RetrieveLOG_LOGINs1(ByRef pConn, page, pageSize, sortColumn, sortDirection, keywordType, keyword,startPeriod, endPeriod, IA_GROUP, IA_GROUP1)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveLOG_LOGINs1"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	sortColumn
			mDBMng.SetParamVarWChar 	    4,	sortDirection		
			mDBMng.SetParamVarWChar 	    5,	keywordType
			mDBMng.SetParamVarWChar 	    6,	keyword		
			mDBMng.SetParamVarWChar 	    7,	startPeriod
			mDBMng.SetParamVarWChar 	    8,	endPeriod
			mDBMng.SetParamInt 	    9,	IA_GROUP
			mDBMng.SetParamInt 	    10,	IA_GROUP1
										
            'debug
            RetrieveLOG_LOGINs1 = mDBMng.Patch (pConn)
					
		End Function 	
						
        '##### 부본사 회원 접속 로그    ######################
       
		Public Function RetrieveLOG_LOGINs2(ByRef pConn, page, pageSize, sortColumn, sortDirection, keywordType, keyword,startPeriod, endPeriod, IA_GROUP, IA_GROUP1, IA_GROUP2)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveLOG_LOGINs2"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	sortColumn
			mDBMng.SetParamVarWChar 	    4,	sortDirection		
			mDBMng.SetParamVarWChar 	    5,	keywordType
			mDBMng.SetParamVarWChar 	    6,	keyword		
			mDBMng.SetParamVarWChar 	    7,	startPeriod
			mDBMng.SetParamVarWChar 	    8,	endPeriod
			mDBMng.SetParamInt 	    9,	IA_GROUP
			mDBMng.SetParamInt 	    10,	IA_GROUP1
			mDBMng.SetParamInt 	    11,	IA_GROUP2
										
            'debug
            RetrieveLOG_LOGINs2 = mDBMng.Patch (pConn)
					
		End Function 	
		
        '##### 총판 회원 접속 로그    ######################
       
		Public Function RetrieveLOG_LOGINs3(ByRef pConn, page, pageSize, sortColumn, sortDirection, keywordType, keyword,startPeriod, endPeriod, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveLOG_LOGINs3"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	sortColumn
			mDBMng.SetParamVarWChar 	    4,	sortDirection		
			mDBMng.SetParamVarWChar 	    5,	keywordType
			mDBMng.SetParamVarWChar 	    6,	keyword		
			mDBMng.SetParamVarWChar 	    7,	startPeriod
			mDBMng.SetParamVarWChar 	    8,	endPeriod
			mDBMng.SetParamInt 	    9,	IA_GROUP
			mDBMng.SetParamInt 	    10,	IA_GROUP1
			mDBMng.SetParamInt 	    11,	IA_GROUP2
			mDBMng.SetParamInt 	    12,	IA_GROUP3
										
            'debug
            RetrieveLOG_LOGINs3 = mDBMng.Patch (pConn)
					
		End Function 
        '##### 매장 회원 접속 로그    ######################
       
		Public Function RetrieveLOG_LOGINs4(ByRef pConn, page, pageSize, sortColumn, sortDirection, keywordType, keyword,startPeriod, endPeriod, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveLOG_LOGINs4"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize						
			mDBMng.SetParamVarWChar 	    3,	sortColumn
			mDBMng.SetParamVarWChar 	    4,	sortDirection		
			mDBMng.SetParamVarWChar 	    5,	keywordType
			mDBMng.SetParamVarWChar 	    6,	keyword		
			mDBMng.SetParamVarWChar 	    7,	startPeriod
			mDBMng.SetParamVarWChar 	    8,	endPeriod
			mDBMng.SetParamInt 	    9,	IA_GROUP
			mDBMng.SetParamInt 	    10,	IA_GROUP1
			mDBMng.SetParamInt 	    11,	IA_GROUP2
			mDBMng.SetParamInt 	    12,	IA_GROUP3
			mDBMng.SetParamInt 	    13,	IA_GROUP4
										
            'debug
            RetrieveLOG_LOGINs4 = mDBMng.Patch (pConn)
					
		End Function 
		'##### 회원 접속 로그 카운트    ######################
		
		Public Function GetLOG_LOGINTotalCount(ByRef pConn)
                
			mDBMng.StoredProc = "dbo.UP_GetLOG_LOGINTotalCount"

            GetLOG_LOGINTotalCount = mDBMng.Patch (pConn)
					
		End Function  		

		'##### 관리자 전체캐쉬 정보    ######################
		
		Public Function GetAdminTotalCash(ByRef pConn)

			mDBMng.Query = " SELECT lc_contents,	ISNULL(sum(lc_cash), 0) as lc_cash " & _
                           " FROM  dbo.Log_cashinout WITH (NOLOCK) " & _
                           " WHERE ( lc_contents = '배팅배당' OR lc_contents = '배팅차감' Or lc_contents = '머니충전' OR lc_contents = '환전차감') " & _
                           " AND LC_SITE  ='" & Session("rJOBSITE") & "' GROUP BY lc_contents "

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


			    mDBMng.Query = " Select Top 100 * From [dbo].[LOG_ADMIN_CASHOUT] with(nolock)" & _
                               " WHERE adminID = '" & pIA_ID & "'" & _
                               " ORDER BY id desc"            

            RetrieveAdminCashLog = mDBMng.patch (pConn)
					
		End Function  	
						
						
	
		'##### 중복 아이피 체크    ######################
		
		Public Function RetrieveLOG_LOGINByCheckID(ByRef pConn, keywordType, keyword)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveLOG_LOGINByCheckID"

			mDBMng.SetParamVarWChar 	    1,	keywordType
			mDBMng.SetParamVarWChar 	    2,	keyword	
			
            RetrieveLOG_LOGINByCheckID = mDBMng.Patch (pConn)
					
		End Function  	
        '##### 관리자 정보 추가(17/09/08)    ######################  
         
        Public Function insertINFO_ADMIN_New(ByRef pConn, IA_ID, IA_PW, IA_BankName, IA_BankNum, IA_BankOwner, IA_Level, IA_Site, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4, IA_Percent, IA_Type,IA_SportsPercent,IA_LivePercent,IA_CalMethod,IA_NICKNAME)
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
			mDBMng.SetParamVarWChar	18,	IA_NICKNAME   
                 		    			
			insertINFO_ADMIN_New = mDBMng.Execute ( pConn )
			
        End Function 													
	End Class
			
    Dim dfcpSql
    Set dfcpSql = new cpSql
%>
