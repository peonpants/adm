<%

	Class gameSql
	
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
	
	

             
        '##### 게임 정보 리스트    ######################
       
		Public Function RetrieveInfo_Game(ByRef pConn, page, pageSize, RL_SPORTS, RL_LEAGUE, IG_STATUS, Search, Find, GSITE, IG_Type)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_Game"
			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	RL_SPORTS
			mDBMng.SetParamVarWChar 	    4,	RL_LEAGUE
			mDBMng.SetParamVarWChar 	    5,	IG_STATUS
			mDBMng.SetParamVarWChar 	    6,	Search
			mDBMng.SetParamVarWChar 	    7,	Find
			mDBMng.SetParamVarWChar 	    8,	GSITE		
            mDBMng.SetParamInt 	    9,	IG_Type
            'debug

            RetrieveInfo_Game = mDBMng.Patch (pConn)
					
		End Function    

		 '##### 게임 정보 리스트 NEW   ######################
       
		Public Function RetrieveInfo_Game_New(ByRef pConn, page, pageSize, RL_SPORTS, RL_LEAGUE, IG_STATUS, Search, Find, GSITE, IG_Type, Sort)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_Game_NEW"
			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	RL_SPORTS
			mDBMng.SetParamVarWChar 	    4,	RL_LEAGUE
			mDBMng.SetParamVarWChar 	    5,	IG_STATUS
			mDBMng.SetParamVarWChar 	    6,	Search
			mDBMng.SetParamVarWChar 	    7,	Find
			mDBMng.SetParamVarWChar 	    8,	GSITE		
            mDBMng.SetParamInt 	    9,	IG_Type
			mDBMng.SetParamInt 	    10,	Sort
            'debug

            RetrieveInfo_Game_New = mDBMng.Patch (pConn)
					
		End Function    
		
		'##### 게임 상세 정보    ######################
		
		Public Function GetINFO_GAME(byRef pConn, IG_Idx)
		    
	        mDBMng.StoredProc = "dbo.UP_GetINFO_GAME"
	        
	        mDBMng.SetParamInt 	    1,	IG_Idx
			
			GetINFO_GAME = mDBMng.Patch (pConn)
			
		End Function	

		'##### 게임 결과 입력 STEP(1)    ######################
		
		Public Function ExecGameResultStep1(byRef pConn, IG_IDX, IG_Score1, IG_Score2, IG_Result_Type, IG_Result, IG_Type)
		    
	        mDBMng.StoredProc = "dbo.UP_ExecGameResultStep1"
	        
	        mDBMng.SetParamInt 	    1,	IG_Idx
	        mDBMng.SetParamInt 	    2,	IG_Score1
	        mDBMng.SetParamInt 	    3,	IG_Score2	        
	        mDBMng.SetParamInt 	    4,	IG_Result_Type
	        mDBMng.SetParamInt 	    5,	IG_Result
	        mDBMng.SetParamInt 	    6,	IG_Type
			
			ExecGameResultStep1 = mDBMng.execute (pConn)
			'debug
		End Function	
			
        '##### 게임에 따른 배팅 내역을 불러옴 STEP(2)     ######################		
		Public Function ExecGameResultStep2(byRef pConn, IG_Idx, IB_STATUS)
		    
	        mDBMng.StoredProc = "dbo.UP_ExecGameResultStep2"
	        
	        mDBMng.SetParamInt 	    1,	IG_Idx
	        mDBMng.SetParamInt 	    2,	IB_STATUS
			
			ExecGameResultStep2 = mDBMng.Patch (pConn)
            			
		End Function	

        '##### 게임 정산하기 STEP(3)    ######################		
        
        Public Function ExecGameResultStep3(byRef pConn, IB_IDX, IG_IDX, BenefitAmount, IU_ID, IU_SITE, IB_CASHBACK, IB_RECOM_CASHBACK, RECOM_ID, IB_RESULT_TYPE, IA_Type, IA_CASHBACK, IU_Cash, PointUse, IU_NICKNAME)
		    
	        mDBMng.StoredProc = "dbo.UP_ExecGameResultStep3"
	        
	        mDBMng.SetParamInt 	    1,	IB_IDX
	        mDBMng.SetParamInt 	    2,	IG_IDX
	        mDBMng.SetParamInt 	    3,	BenefitAmount	        
	        mDBMng.SetParamVarWChar 	    4,	IU_ID
	        mDBMng.SetParamVarWChar 	    5,	IU_SITE
	        mDBMng.SetParamInt 	    6,	IB_CASHBACK	     
	        mDBMng.SetParamInt 	    7,	IB_RECOM_CASHBACK	     
	        mDBMng.SetParamVarWChar 	    8,	RECOM_ID	     
	        mDBMng.SetParamInt 	    9,	IB_RESULT_TYPE	     
	        mDBMng.SetParamInt 	    10,	IA_Type	    
	        mDBMng.SetParamInt 	    11,	IA_CASHBACK	    
	        mDBMng.SetParamInt 	    12,	IU_Cash	 
	        mDBMng.SetParamInt 	    13,	PointUse
			mDBMng.SetParamVarWChar 	    14,	IU_NICKNAME	 
			
			ExecGameResultStep3 = mDBMng.Patch (pConn)
			
		End Function	
		
        '##### 정산 돌리기    ######################		
		Public Function ExecGameResultRollBack(byRef pConn, IG_IDX)
		    
	        mDBMng.StoredProc = "dbo.UP_ExecGameResultRollBack"
	        
	        mDBMng.SetParamInt 	    1,	IG_Idx

			ExecGameResultRollBack = mDBMng.execute (pConn)
			
		End Function
				
        '##### 정산 필요한 배팅수 체크    ######################		
		Public Function ExecGameResultStep1Cnt(byRef pConn)
		    
	        mDBMng.StoredProc = "dbo.UP_ExecGameResultStep1Cnt"

			ExecGameResultStep1Cnt = mDBMng.Patch (pConn)
			
		End Function
						
        '##### 배팅 정보 리스트    ######################
        
		Public Function RetrieveInfo_Betting(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site, IB_AMOUT, real_user)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_Betting"			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site
			mDBMng.SetParamInt 	    8,	IB_AMOUT
			mDBMng.SetParamInt 	    9,	real_user

            RetrieveInfo_Betting = mDBMng.Patch (pConn)
					
		End Function

		'##### 배팅 정보 리스트    ######################
        
		Public Function RetrieveInfo_Betting1(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site, IB_AMOUT, real_user, IBGTYPE)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_Betting1"			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site
			mDBMng.SetParamInt 	    8,	IB_AMOUT
			mDBMng.SetParamInt 	    9,	real_user
			mDBMng.SetParamInt 	    10,	IBGTYPE
            RetrieveInfo_Betting1 = mDBMng.Patch (pConn)
					
		End Function
		
		'##### 배팅 정보 리스트    ######################
        
		Public Function RetrieveInfo_Betting_NEW(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site, IB_AMOUT, real_user,gameCode)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_Betting_NEW"			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site
			mDBMng.SetParamInt 	    8,	IB_AMOUT
			mDBMng.SetParamInt 	    9,	real_user
			mDBMng.SetParamInt 	    10,	gameCode
            RetrieveInfo_Betting_NEW = mDBMng.Patch (pConn)
					
		End Function

		'##### 배팅 정보 리스트    ######################
        
		Public Function RetrieveInfo_Betting_NEWs(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site, IB_AMOUT, real_user,gameCode,IBGTYPE)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_Betting_NEWs"			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site
			mDBMng.SetParamInt 	    8,	IB_AMOUT
			mDBMng.SetParamInt 	    9,	real_user
			mDBMng.SetParamInt 	    10,	gameCode
			mDBMng.SetParamInt 	    11,	IBGTYPE
            RetrieveInfo_Betting_NEWs = mDBMng.Patch (pConn)
					
		End Function

		'##### 배팅 정보 리스트    ######################
        
		Public Function RetrieveInfo_Betting_NEW2(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site, IB_AMOUT, real_user)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_Betting_NEW2"			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site
			mDBMng.SetParamInt 	    8,	IB_AMOUT
			mDBMng.SetParamInt 	    9,	real_user
            RetrieveInfo_Betting_NEW2 = mDBMng.Patch (pConn)
					
		End Function

		'##### 배팅 정보 리스트    ######################
        
		Public Function RetrieveInfo_Betting_NEW22(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site, IB_AMOUT, real_user,IBGTYPE)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_Betting_NEW22"			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site
			mDBMng.SetParamInt 	    8,	IB_AMOUT
			mDBMng.SetParamInt 	    9,	real_user
			mDBMng.SetParamInt 	    10,	IBGTYPE
            RetrieveInfo_Betting_NEW22 = mDBMng.Patch (pConn)
					
		End Function

        '##### 배팅 정보 리스트    ######################
        
		Public Function RetrieveInfo_Betting_list(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site, IB_AMOUT, real_user)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_Betting_list"			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site
			mDBMng.SetParamInt 	    8,	IB_AMOUT
			mDBMng.SetParamInt 	    9,	real_user
            RetrieveInfo_Betting_list = mDBMng.Patch (pConn)
					
		End Function 
        
		Public Function RetrieveInfo_Betting_Live(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site, IB_AMOUT, real_user)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_Betting_live"			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site
			mDBMng.SetParamInt 	    8,	IB_AMOUT
			mDBMng.SetParamInt 	    9,	real_user
            RetrieveInfo_Betting_Live = mDBMng.Patch (pConn)
					
		End Function
		Public Function RetrieveInfo_Betting_ADMINLEVEL(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site, IB_AMOUT, real_user)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_Betting_ADMINLEVEL"			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site
			mDBMng.SetParamInt 	    8,	IB_AMOUT
			mDBMng.SetParamInt 	    9,	real_user
            RetrieveInfo_Betting_ADMINLEVEL = mDBMng.Patch (pConn)
					
		End Function   
		         
		Public Function RetrieveInfo_Betting_Static(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site, IB_AMOUT)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_Betting_Static"			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site
			mDBMng.SetParamInt 	    8,	IB_AMOUT
            RetrieveInfo_Betting_Static = mDBMng.Patch (pConn)
					
		End Function    
				
		Public Function Get_Betting_Money(ByRef pConn, moneyType)
                
			mDBMng.StoredProc = "dbo.UP_GET_BETTING_MONEY"
						
			mDBMng.SetParamInt 	    1,	moneyType
	
            Get_Betting_Money = mDBMng.Patch (pConn)
					
		End Function   

        '##### 배팅 머니 간단 보기   ######################
       
		Public Function Get_Betting_MoneyList(ByRef pConn, sMoney, eMondy, moneyType)
                
			mDBMng.StoredProc = "dbo.UP_GET_BETTING_MONEYLIST"
			
			
			mDBMng.SetParamInt 	    1,	sMoney
			mDBMng.SetParamInt 	    2,	eMondy
			mDBMng.SetParamInt 	    3,	moneyType


            Get_Betting_MoneyList = mDBMng.Patch (pConn)
					
		End Function   
		
        '##### 7m 데이터 보기   ######################
       
		Public Function RetrieveINFO_7MbyRL(ByRef pConn, RL)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_7M"
            mDBMng.SetParamVarWChar 	    1,	RL
            
            RetrieveINFO_7MbyRL = mDBMng.Patch (pConn)
					
		End Function 
		       
		Public Function RetrieveINFO_7M(ByRef pConn)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_7M"
            
            RetrieveINFO_7M = mDBMng.Patch (pConn)
					
		End Function 
		
		Public Function RetrieveINFO_7M_kr(ByRef pConn, page, pageSize, reqType)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_7M_kr"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize
			mDBMng.SetParamInt 	    3,	reqType
			            
            RetrieveINFO_7M_kr = mDBMng.Patch (pConn)
					
		End Function 				
					
		Public Function RetrieveINFO_7M_IGTYPE(ByRef pConn, page, pageSize, reqType, IG_TYPE)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_7M_IGTYPE"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize
			mDBMng.SetParamInt 	    3,	reqType
			mDBMng.SetParamInt 	    4,	IG_TYPE
			            
            RetrieveINFO_7M_IGTYPE = mDBMng.Patch (pConn)
					
		End Function 		
							
        '##### 7m 데이터 보기   ######################
       
		Public Function RetrieveINFO_7M1(ByRef pConn)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_7M1"

            RetrieveINFO_7M1 = mDBMng.Patch (pConn)
					
		End Function 	
		
		Public Function getINFO_GAMEByTeamName(byRef pConn, teamName)
		    
	        mDBMng.Query = "SELECT IG_IDX FROM INFO_GAME  WITH (NOLOCK) WHERE IG_STATUS IN ('S','E') AND ( IG_TEAM1 = '" & teamName & "' OR IG_TEAM2 = '" & teamName & "')"
			
			getINFO_GAMEByTeamName = mDBMng.Patch (pConn)
			
		End Function

		
		'##### 인덱스 마감 전 경기 불러오기 (새로운 웹싸이트)  ######################
		
		Public Function RetrieveINFO_GAMEByStatusRS(byRef pConn)
		    
	        mDBMng.StoredProc = "UP_RetrieveINFO_GAMEByStatusRS"
			
			RetrieveINFO_GAMEByStatusRS = mDBMng.Patch (pConn)
			
		End Function
		
		'##### 인덱스 마감 전 경기 불러오기 (새로운 웹싸이트)  ######################
		
		Public Function RetrieveINFO_GAMEByStatusResult(byRef pConn, pII_IDX)
		    
	        mDBMng.StoredProc = "UP_RetrieveINFO_GAMEByStatusResult"
	        
	        mDBMng.SetParamInt 	    1,	pII_IDX
			
			RetrieveINFO_GAMEByStatusResult = mDBMng.Patch (pConn)
			
		End Function																		
																	
		'##### 인덱스 경기 불러오기   ######################
		
		Public Function RetrieveINFO_INDEX_GAME(byRef pConn, page, pageSize)
		    
	        mDBMng.StoredProc = "UP_RetrieveINFO_INDEX_GAME"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize
						
			RetrieveINFO_INDEX_GAME = mDBMng.Patch (pConn)
			
		End Function

		'##### 인덱스 경기 불러오기   ######################
		
		Public Function RetrieveINFO_INDEX_GAME2(byRef pConn, page, pageSize)
		    
	        mDBMng.StoredProc = "UP_RetrieveINFO_INDEX_GAME2"
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize
						
			RetrieveINFO_INDEX_GAME2 = mDBMng.Patch (pConn)
			
		End Function

		'##### 인덱스 경기 > 게임정보 넣기    ######################
		
		Public Function InsertINFO_GAMEByIndexData(byRef pConn, pIG_IDX)
		    
	        mDBMng.StoredProc = "UP_InsertINFO_GAMEByIndexData"
			mDBMng.SetParamInt 	    1,	pIG_IDX
			
			InsertINFO_GAMEByIndexData = mDBMng.execute (pConn)
			
		End Function

		Public Function RetrieveINFO_BETTING_DETAILByPreview(ByRef pConn, pIB_IDX)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_BETTING_DETAILByPreview"
						
			mDBMng.SetParamInt 	    1,	pIB_IDX

            RetrieveINFO_BETTING_DETAILByPreview = mDBMng.Patch (pConn)
				
		End Function   
		
		Public Function GetInfo_BettingDetailByIG_IDX(ByRef pConn, pIG_IDX)
                
			mDBMng.StoredProc = "dbo.UP_GetInfo_BettingDetailByIG_IDX"
						
			mDBMng.SetParamInt 	    1,	pIG_IDX

            GetInfo_BettingDetailByIG_IDX = mDBMng.Patch (pConn)
				
		End Function   

		Public Function CHK_BETTING(ByRef pConn, pIB_IDX)
                
			mDBMng.StoredProc = "dbo.UP_CHK_BETTING"
						
			mDBMng.SetParamInt 	    1,	pIB_IDX

            CHK_BETTING = mDBMng.Patch (pConn)
				
		End Function   							

		Public Function CHK_BETTING_A(ByRef pConn)
                
			mDBMng.StoredProc = "dbo.UP_CHK_BETTING_A"

            CHK_BETTING_A = mDBMng.Patch (pConn)
				
		End Function   							
		 '##### 사다리현재상황 설정 가져오기    ######################
        Public Function GetSET_SADARI_LST(ByRef pConn)
        
            mDBMng.StoredProc = "dbo.UP_UpdateSET_SADARI_Lst"

            GetSET_SADARI_LST = mDBMng.Patch (pConn)                    
        
        End Function

		'##### 사다리현재상황 변경 설정 업데이트    ######################
		Public Function UpdateSET_SADARI(ByRef pConn, SITE_OPEN)
                
			mDBMng.StoredProc = "dbo.UP_UpdateSET_SADARI"       			
			mDBMng.SetParamInt	        1,	SITE_OPEN   
										
            UpdateSET_SADARI = mDBMng.Execute (pConn)
					
		End Function 

		 '##### 달팽이현재상황 설정 가져오기    ######################
        Public Function GetSET_DAL_LST(ByRef pConn)
        
            mDBMng.StoredProc = "dbo.UP_UpdateSET_DAL_Lst"

            GetSET_DAL_LST = mDBMng.Patch (pConn)                    
        
        End Function

		'##### 달팽이현재상황 변경 설정 업데이트    ######################
		Public Function UpdateSET_DAL(ByRef pConn, SITE_OPEN)
                
			mDBMng.StoredProc = "dbo.UP_UpdateSET_DAL"       			
			mDBMng.SetParamInt	        1,	SITE_OPEN   
										
            UpdateSET_DAL = mDBMng.Execute (pConn)
					
		End Function 

		 '##### 알라딘사다리현재상황 설정 가져오기    ######################
        Public Function GetSET_ALADIN_LST(ByRef pConn)
        
            mDBMng.StoredProc = "dbo.UP_UpdateSET_ALADIN_Lst"

            GetSET_ALADIN_LST = mDBMng.Patch (pConn)                    
        
        End Function

		'##### 알라딘사다리현재상황 변경 설정 업데이트    ######################
		Public Function UpdateSET_ALADIN(ByRef pConn, SITE_OPEN)
                
			mDBMng.StoredProc = "dbo.UP_UpdateSET_ALADIN"       			
			mDBMng.SetParamInt	        1,	SITE_OPEN   
										
            UpdateSET_ALADIN = mDBMng.Execute (pConn)
					
		End Function 

		 '##### 다리다리현재상황 설정 가져오기    ######################
        Public Function GetSET_DARI_LST(ByRef pConn)
        
            mDBMng.StoredProc = "dbo.UP_UpdateSET_DARI_Lst"

            GetSET_DARI_LST = mDBMng.Patch (pConn)                    
        
        End Function

		'##### 다리다리현재상황 변경 설정 업데이트    ######################
		Public Function UpdateSET_DARI(ByRef pConn, SITE_OPEN)
                
			mDBMng.StoredProc = "dbo.UP_UpdateSET_DARI"       			
			mDBMng.SetParamInt	        1,	SITE_OPEN   
										
            UpdateSET_DARI = mDBMng.Execute (pConn)
					
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
			
    Dim dfgameSql
    Set dfgameSql = new gameSql

%>
