<!-- #include virtual="/_Global/DbCono.asp" -->
<%

	sStartDate = LEFT(Date,10)&" 00:00:00"
	'sStartDate = "2009-03-01 00:00:00"
	sEndDate = LEFT(Date,10)&" 23:59:59"
	
	SET DbRec=Server.CreateObject("ADODB.Recordset") 
	DbRec.CursorType=1

	SQLLIST = "SELECT ISNULL(COUNT(*),0) FROM Info_Charge Where IC_Status=0"
	SET RSLIST = DbCon.Execute(SQLLIST)
	TINPUT = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING

	SQLLIST = "SELECT ISNULL(COUNT(*),0) FROM Info_Exchange Where IE_Status=0"
	SET RSLIST = DbCon.Execute(SQLLIST)
	TOUTPUT = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING
	
	SQLLIST = "SELECT ISNULL(COUNT(*),0) FROM Board_Customer Where BC_Status=1 AND BC_WRITER <> '包府磊' AND BC_READYN=0"
	SET RSLIST = DbCon.Execute(SQLLIST)
	TMSG = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing
	


	SQLLIST = "SELECT ISNULL(COUNT(*),0) FROM Board_Customer Where BC_Status=1 AND BC_WRITER <> '包府磊' AND BC_REPLY = 0 AND BC_DELYN = 0"
	SET RSLIST = DbCon.Execute(SQLLIST)
	TMSG_2 = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING
	
	SQLLIST = "select ISNULL(count(*),0)  from info_charge where IC_Status=1 and  ic_SETDATE > '"& sStartDate &"' AND ic_SETDATE < '" & sEndDate & "'"
	
	SET RSLIST = DbCon.Execute(SQLLIST)
	
	INSUM_1 = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing
	
	SQLLIST = "select ISNULL(count(*),0)  from info_charge where IC_Status=2 "
	
	SET RSLIST = DbCon.Execute(SQLLIST)
	
	INSUM_2 = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing

	SQLLIST = "select ISNULL(count(*),0)  from info_exchange where Ie_Status=1  and  ie_SETDATE > '"& sStartDate &"' AND ie_SETDATE < '" & sEndDate & "'"
	
	SET RSLIST = DbCon.Execute(SQLLIST)
	
	OUTSUM_1 = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing
	
	SQLLIST = "select ISNULL(count(*),0)  from info_exchange where Ie_Status=2 "
	
	SET RSLIST = DbCon.Execute(SQLLIST)
	
	OUTSUM_2 = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing
	
	SQLLIST = "SELECT ISNULL(COUNT(*),0) FROM INFO_USER where ADMIN_CHK IS NULL AND IU_STATUS = 1 and IU_LEVEL < 6"

	SET RSLIST = DbCon.Execute(SQLLIST)
	
	USER_IN = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing
	
    SQLLIST = "SELECT TOP 1 IU_NICKNAME  FROM INFO_USER where IU_LEVEL <> 9 AND IU_STATUS = 1 AND IU_REGDATE > '"& sStartDate &"' AND IU_REGDATE < '" & sEndDate & "' ORDER BY IU_REGDATE DESC"

	SET RSLIST = DbCon.Execute(SQLLIST)
	IF NOT RSLIST.EOF Then
	    NEW_USER_NICKNAME = RSLIST(0)
	End IF
	RSLIST.CLOSE
	SET RSLIST = Nothing

	SQLLIST = "select count(*) from dbo.info_betting with(nolock) where  (ib_id = 'xodzm05'  or ib_id = 'parlia' ) and ib_status = 0 And IB_REGDATE > dateadd(minute,-3,getdate())"
	SET RSLIST = DbCon.Execute(SQLLIST)
	WB = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing
	
	
	SQLLIST = "SELECT SET_EXE FROM SET_EXE_INC"

	SET RSLIST = DbCon.Execute(SQLLIST)
	
	//SET_EXE = RSLIST(0)
	RSLIST.CLOSE
	SET RSLIST = Nothing	

	
	SQLLIST = "select count(*) from info_user where iu_status = 5"
	SET RSLIST = DbCon.Execute(SQLLIST)
	GAME_IN = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing
	
%>