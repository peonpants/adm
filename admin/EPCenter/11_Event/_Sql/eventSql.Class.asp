<%

	Class eventSql
	
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

        '#####  이벤트   ######################
        Public Function RetrieveINFO_EVENT(ByRef pConn, page,pageSize)
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_EVENT"
    
			mDBMng.SetParamInt	1,	page            			  		
			mDBMng.SetParamInt	2,	pageSize  
     		    			
			RetrieveINFO_EVENT = mDBMng.Patch ( pConn )
			
        End Function 
        
        Public Function GetINFO_EVENT(ByRef pConn, IE_IDX)
			mDBMng.StoredProc = "dbo.UP_GetINFO_EVENT"
    
			mDBMng.SetParamInt	1,	IE_IDX            			  		
     		    			
			GetINFO_EVENT = mDBMng.Patch ( pConn )
			
        End Function 

        Public Function InsertINFO_EVENT (ByRef pConn, IE_TITLE, IE_URL, IE_STARTDATE, IE_ENDDATE)
        
			mDBMng.StoredProc = "dbo.UP_InsertINFO_EVENT"
    			  		
			mDBMng.SetParamVarWChar	1,	IE_TITLE 
		    mDBMng.SetParamVarWChar	2,	IE_URL 
			mDBMng.SetParamVarWChar	3,	IE_STARTDATE   
			mDBMng.SetParamVarWChar	4,	IE_ENDDATE   

			InsertINFO_EVENT = mDBMng.Execute ( pConn )
			
        End Function  
        
        Public Function UpdateINFO_EVENT (ByRef pConn, IE_TITLE, IE_URL, IE_STARTDATE, IE_ENDDATE, IE_IDX)
        
			mDBMng.StoredProc = "dbo.UP_UpdateINFO_EVENT"
    			  		
			mDBMng.SetParamVarWChar	1,	IE_TITLE 
		    mDBMng.SetParamVarWChar	2,	IE_URL 
			mDBMng.SetParamVarWChar	3,	IE_STARTDATE   
			mDBMng.SetParamVarWChar	4,	IE_ENDDATE  
			mDBMng.SetParamInt	5,	IE_IDX    

			UpdateINFO_EVENT = mDBMng.Execute ( pConn )
			
        End Function    
        
        Public Function DeleteINFO_EVENT(ByRef pConn, IE_IDX)
			mDBMng.StoredProc = "dbo.UP_DeleteINFO_EVENT"
    
			mDBMng.SetParamInt	1,	IE_IDX            			  		
     		    			
			DeleteINFO_EVENT = mDBMng.Execute ( pConn )
			
        End Function               	
	
        '#####  로그인 이벤트   ######################
        '#####  로그인 이벤트   ######################
        '#####  로그인 이벤트   ######################        
        	                     
        '##### 로그인 이벤트 날짜별 로그인 회원을 가져온다     ######################        
        
        Public Function RetrieveEvent_Login(ByRef pConn, pRound)
			mDBMng.StoredProc = "dbo.up_RetrieveEvent_Login"
    
			mDBMng.SetParamInt	1,	pRound            			  		
     		    			
			RetrieveEvent_Login = mDBMng.Patch ( pConn )
			
        End Function 
       
        '##### 코드값을 업데이트한다.     ######################
        
        Public Function UpdateEvent_LoginByCode(ByRef pConn, pEL_CODE, pEL_IDX)
			mDBMng.Query = "Update EVENT_LOGIN Set EL_CODE = ? WHERE EL_IDX = ?"
    
			mDBMng.SetParamVarWChar	1,	pEL_CODE            			  		
			mDBMng.SetParamInt  	2,	pEL_IDX            
     		    			
			UpdateEvent_LoginByCode = mDBMng.ExeCute ( pConn )
			
        End Function              

        '##### 코드값을 업데이트한다.     ######################
        
        Public Function UpdateEvent_LoginByUsed(ByRef pConn, pEL_IDX)
			mDBMng.Query = "Update EVENT_LOGIN Set EL_USED = 0 WHERE EL_IDX = ?"
    			  		
			mDBMng.SetParamInt  	1,	pEL_IDX            
     		    			
			UpdateEvent_LoginByUsed = mDBMng.ExeCute ( pConn )
			
        End Function   
        
        '##### 코드값을 업데이트한다.     ######################
        
        Public Function GetEvent_Login(ByRef pConn,  pEL_IDX)
			mDBMng.Query = "SELECT * FROM EVENT_LOGIN  WHERE EL_IDX = ?"
    			  		
			mDBMng.SetParamInt  	1,	pEL_IDX            
     		    			
			GetEvent_Login = mDBMng.Patch ( pConn )
			
        End Function  
        
        '##### 당첨 회원수 만들기     ######################
        Public Function InsertEVENT_LOGIN (ByRef pConn, reqRound, IGI_STARTTIME, IGI_ENDTIME)
        
			mDBMng.StoredProc = "dbo.UP_InsertEVENT_LOGIN"
    			  		
			mDBMng.SetParamInt  	1,	reqRound            
		    mDBMng.SetParamVarWChar	2,	IGI_STARTTIME 
			mDBMng.SetParamVarWChar	3,	IGI_ENDTIME   

			InsertEVENT_LOGIN = mDBMng.Execute ( pConn )
			
        End Function  
                
        

        '#####  이닝 이벤트   ######################
        '#####  이닝 이벤트   ######################
        '#####  이닝 이벤트   ######################
 
        '#####  이닝 이벤트 값을 넣는다.    ######################
        
        Public Function InsertINFO_GAME_INNING(ByRef pConn, IGI_TEAM1, IGI_TEAM2, IGI_STARTTIME, IGI_RESULT, IGI_EVENTTIME)
			mDBMng.StoredProc = "dbo.UP_InsertINFO_GAME_INNING"

    
			mDBMng.SetParamVarWChar	1,	IGI_TEAM1       			  		
			mDBMng.SetParamVarWChar	2,	IGI_TEAM2 
			mDBMng.SetParamVarWChar	3,	IGI_STARTTIME 
			mDBMng.SetParamVarWChar	4,	IGI_RESULT 
			mDBMng.SetParamVarWChar	5,	IGI_EVENTTIME
     		    			
			InsertINFO_GAME_INNING = mDBMng.Execute ( pConn )
			
        End Function 

        '#####  이닝 스코어를 값을 업데이트한다.    ######################
        
        Public Function updateINFO_GAME_INNING_DETAIL(ByRef pConn, IGI_IDX, IGID_INNING, IGID_SCORE1,IGID_SCORE2, IGID_RESULT)
			mDBMng.StoredProc = "dbo.UP_updateINFO_GAME_INNING_DETAIL"

			mDBMng.SetParamInt	1,	IGI_IDX       			  		
			mDBMng.SetParamInt	2,	IGID_INNING 
			mDBMng.SetParamInt	3,	IGID_SCORE1 
			mDBMng.SetParamInt	4,	IGID_SCORE2 
			mDBMng.SetParamInt	5,	IGID_RESULT 
     		    			
			updateINFO_GAME_INNING_DETAIL = mDBMng.Execute ( pConn )
			
        End Function 
        
        Public Function  GetINFO_GAME_INNING(ByRef pConn, IGI_STARTDATE, IGI_NEXTTDATE)                      
			mDBMng.StoredProc = "dbo.UP_GetINFO_GAME_INNING"

			mDBMng.SetParamVarWChar	1,	IGI_STARTDATE         
			mDBMng.SetParamVarWChar	2,	IGI_NEXTTDATE         
			
			GetINFO_GAME_INNING = mDBMng.Patch ( pConn )			  
        End Function 

        Public Function RetrieveCHECK_NICKNAME(ByRef pConn, pTop, pIGI_IDX)                      
			mDBMng.StoredProc = "dbo.UP_RetrieveCHECK_NICKNAME"
            
            mDBMng.SetParamInt	1,	pTop          			
            mDBMng.SetParamInt	2,	pIGI_IDX     
			RetrieveCHECK_NICKNAME = mDBMng.Patch ( pConn )			  
			
        End Function 
        
        Public Function RetrieveINFO_GAME_INNING_USER(ByRef pConn, IGI_IDX) 
	
	        mDBMng.StoredProc = "dbo.UP_RetrieveINFO_GAME_INNING_USER"
            
            mDBMng.SetParamInt	1,	IGI_IDX 
                                			
			RetrieveINFO_GAME_INNING_USER = mDBMng.Patch ( pConn )			  
        End Function 
        
        Public Function delINFO_GAME_INNING(ByRef pConn, IGI_IDX) 
	
	        mDBMng.StoredProc = "dbo.UP_DeleteINFO_GAME_INNING"
            
            mDBMng.SetParamInt	1,	IGI_IDX 
                                			
			delINFO_GAME_INNING = mDBMng.Execute ( pConn )			  
        End Function 
              
        '#####  승무패 이벤트   ######################
        '#####  승무패 이벤트   ######################
        '#####  승무패 이벤트   ######################
        Public Function RetrieveINFO_EVENT_GAME(ByRef pConn, page,pageSize)
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_EVENT_GAME"
    
			mDBMng.SetParamInt	1,	page            			  		
			mDBMng.SetParamInt	2,	pageSize  
     		    			
			UP_RetrieveINFO_EVENT_GAME = mDBMng.Patch ( pConn )
			
        End Function 
        
        Public Function GetINFO_EVENT_GAME(ByRef pConn, IEG_IDX)
			mDBMng.StoredProc = "dbo.UP_GetINFO_EVENT_GAME"
    
			mDBMng.SetParamInt	1,	IEG_IDX            			  		
     		    			
			GetINFO_EVENT_GAME = mDBMng.Patch ( pConn )
			
        End Function 

        Public Function InsertINFO_EVENT_GAME(ByRef pConn, IEG_TITLE, IEG_CONTENT, IEG_AMOUNT, IEG_STARTTIME, IEG_ENDTIME )
        
			mDBMng.StoredProc = "dbo.UP_InsertINFO_EVENT_GAME"
    			  		
			mDBMng.SetParamVarWChar	1,	IEG_TITLE 
		    mDBMng.SetParamVarWChar	2,	IEG_CONTENT 
			mDBMng.SetParamInt  	3,	IEG_AMOUNT   
			mDBMng.SetParamVarWChar	4,	IEG_STARTTIME   
			mDBMng.SetParamVarWChar	5,	IEG_ENDTIME   		

			InsertINFO_EVENT_GAME = mDBMng.Execute ( pConn )
			
        End Function                                 
        
        
        Public Function UpdateINFO_EVENT_GAME (ByRef pConn, IEG_TITLE, IEG_CONTENT, IEG_AMOUNT, IEG_STARTTIME, IEG_ENDTIME , IEG_IDX)
        
			mDBMng.StoredProc = "dbo.UP_UpdateINFO_EVENT_GAME"
    			  		
			mDBMng.SetParamVarWChar	1,	IEG_TITLE 
		    mDBMng.SetParamVarWChar	2,	IEG_CONTENT 
			mDBMng.SetParamInt	3,	IEG_AMOUNT   
			mDBMng.SetParamVarWChar	4,	IEG_STARTTIME  
			mDBMng.SetParamVarWChar	5,	IEG_ENDTIME
			mDBMng.SetParamInt	6,	IEG_IDX    

			UpdateINFO_EVENT_GAME = mDBMng.Execute ( pConn )
			
        End Function          

        Public Function DeleteINFO_EVENT_GAME(ByRef pConn, IEG_IDX)
			mDBMng.StoredProc = "dbo.UP_DeleteINFO_EVENT_GAME"
    
			mDBMng.SetParamInt	1,	IEG_IDX            			  		
     		    			
			DeleteINFO_EVENT_GAME = mDBMng.Execute ( pConn )
			
        End Function  
        
        Public Function RetrieveINFO_EVENT_GAME_DETAIL(ByRef pConn, IEG_IDX)
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_EVENT_GAME_DETAIL"
    
			mDBMng.SetParamInt	1,	IEG_IDX            			  		
     		    			
			RetrieveINFO_EVENT_GAME_DETAIL = mDBMng.Patch ( pConn )
			
        End Function 
                
        Public Function InsertINFO_EVENT_GAME_DETAIL(ByRef pConn, IEG_TEAM1, IEG_TEAM2, IEG_IDX)
        
			mDBMng.StoredProc = "dbo.UP_InsertINFO_EVENT_GAME_DETAIL"
    			  		
			mDBMng.SetParamVarWChar	1,	IEG_TEAM1 
		    mDBMng.SetParamVarWChar	2,	IEG_TEAM2 
			mDBMng.SetParamInt  	3,	IEG_IDX   
	
			InsertINFO_EVENT_GAME_DETAIL = mDBMng.Execute ( pConn )
			
        End Function  
                
        Public Function UpdateINFO_EVENT_GAME_DETAIL(ByRef pConn, IEG_TEAM1, IEG_TEAM2, IEG_IDX, IEGD_RESULT, IEGD_IDX)
        
			mDBMng.StoredProc = "dbo.UP_UpdateINFO_EVENT_GAME_DETAIL"
    			  		
			mDBMng.SetParamVarWChar	1,	IEG_TEAM1 
		    mDBMng.SetParamVarWChar	2,	IEG_TEAM2 
			mDBMng.SetParamInt  	3,	IEG_IDX   
			mDBMng.SetParamInt  	4,	IEGD_RESULT   			
			mDBMng.SetParamInt  	5,	IEGD_IDX   

			UpdateINFO_EVENT_GAME_DETAIL = mDBMng.Execute ( pConn )
			
        End Function  
                 
        Public Function DeleteINFO_EVENT_GAME_DETAIL(ByRef pConn, IEGD_IDX)
			mDBMng.StoredProc = "dbo.UP_DeleteINFO_EVENT_GAME_DETAIL"
    
			mDBMng.SetParamInt	1,	IEGD_IDX            			  		
     		    			
			DeleteINFO_EVENT_GAME_DETAIL = mDBMng.Execute ( pConn )
			
        End Function  
              
        Public Function RetrieveCHECK_NICKNAME_Type1(ByRef pConn, pTop, pIGI_IDX)                      
        
			mDBMng.StoredProc = "dbo.UP_RetrieveCHECK_NICKNAME_Type1"
            
            mDBMng.SetParamInt	1,	pTop          			
            mDBMng.SetParamInt	2,	pIGI_IDX     
            
			RetrieveCHECK_NICKNAME_Type1 = mDBMng.Patch ( pConn )			  
			
        End Function                          

        Public Function RetrieveINFO_EVENT_GAME_USER(ByRef pConn,IEG_IDX)                      
        
			mDBMng.StoredProc = "dbo.UP_RetrieveINFO_EVENT_GAME_USER"
            
            mDBMng.SetParamInt	1,	IEG_IDX          			        
            
			RetrieveINFO_EVENT_GAME_USER = mDBMng.Patch ( pConn )			  
			
        End Function

        '######## 잭팟 이벤트
        Public Function GetINFO_JACKPOT(ByRef pConn)                      
        
			mDBMng.Query= "SELECT IJ_CASH , IJ_PERCENT FROM dbo.INFO_JACKPOT "
           
            
			GetINFO_JACKPOT = mDBMng.Patch ( pConn )			  
			
        End Function

        Public Function UpdateINFO_JACKPOT(ByRef pConn, IJ_CASH ,IJ_PERCENT)
        
			mDBMng.Query = "UPDATE dbo.INFO_JACKPOT SET IJ_CASH =?, IJ_PERCENT =? "
    			  		
			mDBMng.SetParamInt  	    1,	IJ_CASH   
			mDBMng.SetparamDecimal  	2,	IJ_PERCENT   			

			UpdateINFO_JACKPOT = mDBMng.Execute ( pConn )
			
        End Function  
        
'##### 로또 관련 추가
	'##### 로또 이벤트 리스트    ######################
	Public Function RetrieveINFO_LOTTO(ByRef pConn, page, pageSize)
                
		mDBMng.StoredProc = "dbo.UP_RetrieveINFO_LOTTO"
			
		mDBMng.SetParamInt 	    1,	page
		mDBMng.SetParamInt 	    2,	pageSize							

        	RetrieveINFO_LOTTO = mDBMng.Patch (pConn)
					
	End Function 

	'##### 해당 로또 이벤트를 가져온다    ######################
	Public Function GetINFO_LOTTO(ByRef pConn, IL_GUID)
                
		mDBMng.StoredProc = "dbo.UP_GetINFO_LOTTO"
			
		mDBMng.SetParamVarWChar	1,	IL_GUID							

            	GetINFO_LOTTO = mDBMng.Patch (pConn)
					
	End Function

	'##### 해당 로또 이벤트의 게임 리스트    ######################
	Public Function RetrieveINFO_LOTTO_GAME(ByRef pConn, IL_GUID)
                
		mDBMng.StoredProc = "dbo.UP_RetrieveINFO_LOTTO_GAME"
			
		mDBMng.SetParamVarWChar	1,	IL_GUID							

            	RetrieveINFO_LOTTO_GAME = mDBMng.Patch (pConn)
					
	End Function
'##### //로또 관련 추가
                          														
	End Class
			
    Dim dfeventSql
    Set dfeventSql = new eventSql
%>
