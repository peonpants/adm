<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/05_Account/_Sql/accountSql.Class.asp"-->
<!-- #include virtual="/_Global/DBHelper.asp" -->
<%
    '### 디비 관련 클래스(Command) 호출
    Set Dber = new clsDBHelper 
    
	SelUser = Request("SelUser")
	TotalCount = Request("SelUser").Count
		
	FOR i = 1 TO TotalCount
		IC_Idx = Trim(Request("SelUser")(i))
        IC_Idx            = dfStringUtil.F_initNumericParam(Trim(IC_Idx), 0, 1, 99999999) 
        
		SQLMSG = "SELECT IC_ID, IC_SITE, IC_AMOUNT , isNull(IC_BONUS_AMOUNT,0) As IC_BONUS_AMOUNT, IC_Status   FROM INFO_CHARGE WHERE IC_IDX = ?"
        reDim param(0)
        param(0) = Dber.MakeParam("@IC_Idx",adInteger,adParamInput,,IC_Idx)                   'adInteger adVarWChar adDouble
                    
        Set RS = Dber.ExecSQLReturnRS(SQLMSG,param,nothing)   	

		IF RS.Eof Then
			With Response
				.write "<script language='javascript'>" & VbCrLf
				.write "location.href='Charge_List.asp';" & VbCrLf
				.write "</script>" & VbCrLf
				.end
			End With		
		End IF

		
		IF CDbl(RS("IC_Status")) = 1 THEN
    
            IC_ID           = RS("IC_ID")
            IC_SITE         = RS("IC_SITE")
            IC_AMOUNT       = RS("IC_AMOUNT")
            IC_BONUS_AMOUNT = RS("IC_BONUS_AMOUNT")
            
            IU_Cash = CDBL(IC_AMOUNT)  + CDBL(IC_BONUS_AMOUNT)

	        'IC_Status를 1(충전완료)로 변경
	        UPDSQL = "UPDATE INFO_CHARGE SET IC_Status = 2 WHERE IC_Idx = ? "
            reDim param(0)
            param(0) = Dber.MakeParam("@IC_Idx",adInteger,adParamInput,,IC_Idx)                   'adInteger adVarWChar adDouble
					
	        Dber.ExecSQL UPDSQL,param,Nothing

	        '사용자 머니 충전를 업데이트한다.
	        UPDSQL = "UPDATE INFO_USER SET IU_Cash = IU_Cash - (?) , IU_CHARGE= IU_CHARGE -(?)  WHERE IU_ID = ? AND IU_SITE = ?"
            reDim param(3)
            param(0) = Dber.MakeParam("@IU_Cash",adInteger,adParamInput,,IU_Cash)                   'adInteger adVarWChar adDouble
            param(1) = Dber.MakeParam("@IC_AMOUNT",adInteger,adParamInput,,IC_AMOUNT)                   'adInteger adVarWChar adDouble
            param(2) = Dber.MakeParam("@IC_ID",adVarWChar,adParamInput,20,IC_ID)                   'adInteger adVarWChar adDouble
            param(3) = Dber.MakeParam("@IC_SITE",adVarWChar,adParamInput,50,IC_SITE)                   'adInteger adVarWChar adDouble
            	        
	        Dber.ExecSQL UPDSQL,param,Nothing

	        SQLMSG = "SELECT IU_Cash, B.IUL_Charge_Percent FROM INFO_USER A INNER JOIN INFO_USER_LEVEL B ON A.IU_LEVEL = B.IUL_LEVEL  WHERE IU_ID=? AND IU_SITE = ?"
            reDim param(1)
            param(0) = Dber.MakeParam("@IC_ID",adVarWChar,adParamInput,20,IC_ID)                   'adInteger adVarWChar adDouble
            param(1) = Dber.MakeParam("@IC_SITE",adVarWChar,adParamInput,50,IC_SITE)                   'adInteger adVarWChar adDouble
                        
            Set UMO = Dber.ExecSQLReturnRS(SQLMSG,param,nothing) 
            	        	        
	        CIU_Cash	= UMO("IU_Cash")
	        IUL_Charge_Percent	= UMO("IUL_Charge_Percent")
	        
	        UMO.Close
	        Set UMO = Nothing

		    'Log_CashInOut 에 환전 기록...
		    INSSQL = "Insert Into Log_CashInOut( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE) values( ?, ?, ? , '머니충전취소', ? )"
    		
            reDim param(3)
            param(0) = Dber.MakeParam("@IC_ID",adVarWChar,adParamInput,20,IC_ID)                   'adInteger adVarWChar adDouble
            param(1) = Dber.MakeParam("@IC_AMOUNT",adInteger,adParamInput,,IC_AMOUNT)                   'adInteger adVarWChar adDouble
            param(2) = Dber.MakeParam("@CIU_Cash",adInteger,adParamInput,,CIU_Cash)                   'adInteger adVarWChar adDouble            
            param(3) = Dber.MakeParam("@IC_SITE",adVarWChar,adParamInput,50,IC_SITE)                   'adInteger adVarWChar adDouble
                                	    
            Dber.ExecSQL INSSQL,param,Nothing	
            
			
		END IF
	Next

	Dber.Dispose
	Set Dber = Nothing 	
	
	With Response
		.write "<script language='javascript'>" & VbCrLf
		.write "alert('입금 취소 처리되었습니다. 대기 상태로 돌아갑니다.');" & VbCrLf
		'.write "top.ViewFrm.location.reload();" & VbCrLf
		.write "top.ViewFrm.location.href='Charge_List.asp';" & VbCrLf
		.write "</script>" & VbCrLf
		.end
	End With
%>