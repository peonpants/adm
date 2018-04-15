<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->


<%
	SET DbRec=Server.CreateObject("ADODB.Recordset")
	DbRec.CursorType=1

    'nvl = count(*)이 널값이면 0이되고 널값이 아니면 본래값
	'CSng 와 CDbl 도 각각 Single, Double 형의 값을 반환 
    'intFirst = CSng ("12345.54321") 
    'intSecond = CDbl ("12345.54321")
    'intFirst 값은 12345.54, intSecond 값은 12345.54321 
 	'CSng 보다 CDbl 이 더 정밀
    
	'게시판에 올라오는 새 글의 수를 tbod01에 담음 
	'TBOD01 = 0
	'SQLLIST = "SELECT ISNULL(COUNT(*),0) FROM Board_free Where Bf_Status=1 and bf_hits = 0 "
	'SET RSLIST = DbCon.Execute(SQLLIST)
	'TBOD01 = CDBL(RSLIST(0))
	'RSLIST.CLOSE
	'SET RSLIST = Nothing
	


	sStartDate = LEFT(Date,10)&" 00:00:00"
	'sStartDate = "2009-03-01 00:00:00"
	sEndDate = LEFT(Date,10)&" 23:59:59"


	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='머니충전' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"

	SET RSLIST = DbCon.Execute(SQLLIST)
	
	INSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING

	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND (LC_CONTENTS='환전차감' or LC_CONTENTS='환전취소') AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	OUTSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING

	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='배팅차감' AND LC_COMMENTS != '내부' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BINSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING

	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='배팅취소' AND LC_COMMENTS != '내부' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BOUSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING



	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='배팅차감' AND LC_COMMENTS != '내부' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"' AND LC_LIVEYN = 'N'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BINSUM1 = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING

	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='배팅취소' AND LC_COMMENTS != '내부' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"' AND LC_LIVEYN = 'N'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BOUSUM1 = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing



	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='배팅차감' AND LC_COMMENTS != '내부' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"' AND LC_LIVEYN <> 'N'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BINSUM2 = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING

	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='배팅취소' AND LC_COMMENTS != '내부' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"' AND LC_LIVEYN <> 'N'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BOUSUM2 = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing	


	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='배팅배당' AND LC_COMMENTS != '내부' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BTOSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING
 

	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='배팅배당' AND LC_COMMENTS != '내부' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"' AND LC_LIVEYN = 'N'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BTOSUM1 = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing


	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='배팅배당' AND LC_COMMENTS != '내부' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"' AND LC_LIVEYN <> 'N'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BTOSUM2 = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing

	


    SQLLIST = "SELECT ISNULL(SUM(IU_CASH),0) FROM Info_User WHERE IU_STATUS=1 AND IU_LEVEL <> 9 "
	SET RSLIST = DbCon.Execute(SQLLIST)
	SUSERMO = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing

    SQLLIST = "select isNULL(sum(IB_AMOUNT),0) from INFO_BETTING with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and INFO_BETTING.ib_id=INFO_USER.iu_id and IB_CNT <> IB_RESULT_CNT "
	SET RSLIST = DbCon.Execute(SQLLIST)
	NEW_BTOSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing
    

    SQLLIST = "SELECT ISNULL(SUM(IU_point),0) FROM Info_User WHERE IU_STATUS=1 AND IU_LEVEL <> 9 "
	SET RSLIST = DbCon.Execute(SQLLIST)
	SUSERMOP = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing
	
	
	
	
%>