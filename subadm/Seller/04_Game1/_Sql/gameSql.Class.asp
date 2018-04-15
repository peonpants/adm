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
		
        '##### 배팅 정보 리스트(부본사통합 17/9/17)    ######################
        
		Public Function RetrieveInfo_Betting_SUBNEW(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site, IB_AMOUT, real_user, IA_GROUP, IA_GROUP1, IA_LEVEL)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_Betting_SUBNEW"			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site
			mDBMng.SetParamInt 	    8,	IB_AMOUT
			mDBMng.SetParamInt 	    9,	real_user
			mDBMng.SetParamInt 	    10,	IA_GROUP
			mDBMng.SetParamInt 	    11,	IA_GROUP1
			mDBMng.SetParamInt 	    12,	IA_LEVEL
            RetrieveInfo_Betting_SUBNEW = mDBMng.Patch (pConn)
					
		End Function

        '##### 배팅 정보 리스트(부본사통합 17/9/17)    ######################
        
		Public Function RetrieveInfo_Betting_SUBNEWs1(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site, IB_AMOUT, real_user, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_LEVEL)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_Betting_SUBNEWs1"			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site
			mDBMng.SetParamInt 	    8,	IB_AMOUT
			mDBMng.SetParamInt 	    9,	real_user
			mDBMng.SetParamInt 	    10,	IA_GROUP
			mDBMng.SetParamInt 	    11,	IA_GROUP1
			mDBMng.SetParamInt 	    12,	IA_GROUP2
			mDBMng.SetParamInt 	    13,	IA_LEVEL
            RetrieveInfo_Betting_SUBNEWs1 = mDBMng.Patch (pConn)
					
		End Function

        '##### 배팅 정보 리스트(부본사통합 17/9/17)    ######################
        
		Public Function RetrieveInfo_Betting_SUBNEWs2(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site, IB_AMOUT, real_user, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_LEVEL)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_Betting_SUBNEWs2"			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site
			mDBMng.SetParamInt 	    8,	IB_AMOUT
			mDBMng.SetParamInt 	    9,	real_user
			mDBMng.SetParamInt 	    10,	IA_GROUP
			mDBMng.SetParamInt 	    11,	IA_GROUP1
			mDBMng.SetParamInt 	    12,	IA_GROUP2
			mDBMng.SetParamInt 	    13,	IA_GROUP3
			mDBMng.SetParamInt 	    14,	IA_LEVEL
            RetrieveInfo_Betting_SUBNEWs2 = mDBMng.Patch (pConn)
					
		End Function
        '##### 배팅 정보 리스트(부본사통합 17/9/17)    ######################
        
		Public Function RetrieveInfo_Betting_SUBNEWs3(ByRef pConn, page, pageSize,  Search, Find, sStartDate, sEndDate, site, IB_AMOUT, real_user, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4, IA_LEVEL)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveInfo_Betting_SUBNEWs3"			
			
			mDBMng.SetParamInt 	    1,	page
			mDBMng.SetParamInt 	    2,	pageSize							
			mDBMng.SetParamVarWChar 	    3,	Search
			mDBMng.SetParamVarWChar 	    4,	Find
			mDBMng.SetParamVarWChar 	    5,	sStartDate
			mDBMng.SetParamVarWChar 	    6,	sEndDate
			mDBMng.SetParamVarWChar 	    7,	site
			mDBMng.SetParamInt 	    8,	IB_AMOUT
			mDBMng.SetParamInt 	    9,	real_user
			mDBMng.SetParamInt 	    10,	IA_GROUP
			mDBMng.SetParamInt 	    11,	IA_GROUP1
			mDBMng.SetParamInt 	    12,	IA_GROUP2
			mDBMng.SetParamInt 	    13,	IA_GROUP3
			mDBMng.SetParamInt 	    14,	IA_GROUP4
			mDBMng.SetParamInt 	    15,	IA_LEVEL
            RetrieveInfo_Betting_SUBNEWs3 = mDBMng.Patch (pConn)
					
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
				
		Public Function Get_Betting_Money(ByRef pConn, moneyType)
                
			mDBMng.StoredProc = "dbo.UP_GET_BETTING_MONEY"
						
			mDBMng.SetParamInt 	    1,	moneyType
	
            Get_Betting_Money = mDBMng.Patch (pConn)
					
		End Function   

        '##### 베팅 머니 간단 보기   ######################
       
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
		
		Public Function RetrieveINFO_7M_kr(ByRef pConn)
                
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_7M_kr"
            
            RetrieveINFO_7M_kr = mDBMng.Patch (pConn)
					
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
															
	End Class
			
    Dim dfgameSql
    Set dfgameSql = new gameSql
%>
