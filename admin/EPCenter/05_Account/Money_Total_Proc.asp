<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->


<%
	SET DbRec=Server.CreateObject("ADODB.Recordset")
	DbRec.CursorType=1

    'nvl = count(*)�� �ΰ��̸� 0�̵ǰ� �ΰ��� �ƴϸ� ������
	'CSng �� CDbl �� ���� Single, Double ���� ���� ��ȯ 
    'intFirst = CSng ("12345.54321") 
    'intSecond = CDbl ("12345.54321")
    'intFirst ���� 12345.54, intSecond ���� 12345.54321 
 	'CSng ���� CDbl �� �� ����
    
	'�Խ��ǿ� �ö���� �� ���� ���� tbod01�� ���� 
	'TBOD01 = 0
	'SQLLIST = "SELECT ISNULL(COUNT(*),0) FROM Board_free Where Bf_Status=1 and bf_hits = 0 "
	'SET RSLIST = DbCon.Execute(SQLLIST)
	'TBOD01 = CDBL(RSLIST(0))
	'RSLIST.CLOSE
	'SET RSLIST = Nothing
	


	sStartDate = LEFT(Date,10)&" 00:00:00"
	'sStartDate = "2009-03-01 00:00:00"
	sEndDate = LEFT(Date,10)&" 23:59:59"


	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='�Ӵ�����' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"

	SET RSLIST = DbCon.Execute(SQLLIST)
	
	INSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING

	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND (LC_CONTENTS='ȯ������' or LC_CONTENTS='ȯ�����') AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	OUTSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING

	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='��������' AND LC_COMMENTS != '����' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BINSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING

	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='�������' AND LC_COMMENTS != '����' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BOUSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING



	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='��������' AND LC_COMMENTS != '����' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"' AND LC_LIVEYN = 'N'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BINSUM1 = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING

	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='�������' AND LC_COMMENTS != '����' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"' AND LC_LIVEYN = 'N'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BOUSUM1 = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing



	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='��������' AND LC_COMMENTS != '����' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"' AND LC_LIVEYN <> 'N'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BINSUM2 = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING

	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='�������' AND LC_COMMENTS != '����' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"' AND LC_LIVEYN <> 'N'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BOUSUM2 = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing	


	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='���ù��' AND LC_COMMENTS != '����' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BTOSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING
 

	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='���ù��' AND LC_COMMENTS != '����' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"' AND LC_LIVEYN = 'N'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BTOSUM1 = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing


	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut with(nolock),INFO_USER with(nolock) WHERE IU_LEVEL <> 9 and Log_CashInOut.lc_id=INFO_USER.iu_id AND LC_CONTENTS='���ù��' AND LC_COMMENTS != '����' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"' AND LC_LIVEYN <> 'N'"
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