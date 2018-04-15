<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<%

JOBSITE = SESSION("rJOBSITE")

	SET DbRec=Server.CreateObject("ADODB.Recordset")
	DbRec.CursorType=1

    'nvl = count(*)이 널값이면 0이되고 널값이 아니면 본래값
	'CSng 와 CDbl 도 각각 Single, Double 형의 값을 반환 
    'intFirst = CSng ("12345.54321") 
    'intSecond = CDbl ("12345.54321")
    'intFirst 값은 12345.54, intSecond 값은 12345.54321 
 	'CSng 보다 CDbl 이 더 정밀
    
	'게시판에 올라오는 새 글의 수를 tbod01에 담음 

	SQLLIST = "SELECT IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4, IA_LEVEL, IA_TYPE FROM INFO_ADMIN with(nolock) WHERE IA_SITE='"& JOBSITE &"'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	IA_GROUP = RSLIST(0)
	IA_GROUP1 = RSLIST(1)
	IA_GROUP2 = RSLIST(2)
	IA_GROUP3 = RSLIST(3)
	IA_GROUP4 = RSLIST(4)
	IA_LEVEL = RSLIST(5)
	IA_TYPE = RSLIST(6)
	RSLIST.CLOSE
	SET RSLIST = Nothing

	sStartDate = LEFT(Date,10)&" 00:00:00"
	'sStartDate = "2009-03-01 00:00:00"
	sEndDate = LEFT(Date,10)&" 23:59:59"



	'H 내그룹수준 하위 그룹들 셀렉트 AND 문작성
	SelGroupSQL = " "		'ia
	SelGroupSqlA = " "	'ia JOIN용
	SelGroupSqlU = " "	'iu
	SelGroupSqlB = " "	'info_betting , ib_group
	if IA_GROUP1 = 0 then
	else
		SelGroupSQL = SelGroupSQL & " AND IA_GROUP1 ="&IA_GROUP1
		SelGroupSqlA = SelGroupSqlA & " AND A.IA_GROUP1 ="&IA_GROUP1
		SelGroupSqlU = SelGroupSqlU & " AND IU_GROUP1 ="&IA_GROUP1
		SelGroupSqlB = SelGroupSqlB & " AND IB_GROUP1 ="&IA_GROUP1
	end if
	if IA_GROUP2 = 0 then
	else
		SelGroupSQL = SelGroupSQL & " AND IA_GROUP2 ="&IA_GROUP2
		SelGroupSqlA = SelGroupSqlA & " AND A.IA_GROUP2 ="&IA_GROUP2
		SelGroupSqlB = SelGroupSqlB & " AND IB_GROUP2 ="&IA_GROUP1

	end if
	if IA_GROUP3 = 0 then
	else
		SelGroupSQL = SelGroupSQL & " AND IA_GROUP3 ="&IA_GROUP3
		SelGroupSqlA = SelGroupSqlA & " AND A.IA_GROUP3 ="&IA_GROUP3
		SelGroupSqlB = SelGroupSqlB & " AND IB_GROUP3 ="&IA_GROUP1
	end if
	if IA_GROUP4 = 0 then
	else
		SelGroupSQL = SelGroupSQL & " AND IA_GROUP4 ="&IA_GROUP4
		SelGroupSqlA = SelGroupSqlA & " AND A.IA_GROUP4 ="&IA_GROUP4
		SelGroupSqlB = SelGroupSqlB & " AND IB_GROUP4 ="&IA_GROUP1
	end if



	SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut WHERE   LC_ID NOT IN (SELECT IU_ID FROM INFO_USER WHERE IU_LEVEL =9) "&SelGroupSQL&" AND LC_CONTENTS='머니충전' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	INSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING


	'H 환전차감은... 그룹명 데이타가 없음.. JOIN문으로 고쳐야함
	'원본 보관 SQLLIST = "SELECT ISNULL(SUM(LC_CASH),0) FROM Log_CashInOut WHERE   LC_ID NOT IN (SELECT IU_ID FROM INFO_USER WHERE IU_LEVEL =9) "&SelGroupSQL&" AND LC_CONTENTS='환전차감' AND LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
	'Join문 삽입
	SQLLIST = "SELECT ISNULL(SUM(C.LC_CASH),0) FROM Log_CashInOut AS C INNER JOIN INFO_ADMIN AS A ON C.LC_SITE = A.ia_id WHERE  C.LC_ID NOT IN (SELECT IU_ID FROM INFO_USER WHERE IU_LEVEL =9) "&SelGroupSqlA&"   AND C.LC_CONTENTS='환전차감' AND C.LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	OUTSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING

	SQLLIST = "SELECT ISNULL(SUM(C.LC_CASH),0) FROM Log_CashInOut AS C INNER JOIN INFO_ADMIN AS A ON C.LC_SITE = A.ia_id WHERE C.LC_ID NOT IN (SELECT IU_ID FROM INFO_USER WHERE IU_LEVEL =9) "&SelGroupSqlA&"  AND C.LC_CONTENTS='배팅차감' AND C.LC_COMMENTS != '내부' AND C.LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BINSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING

	SQLLIST = "SELECT ISNULL(SUM(C.LC_CASH),0) FROM Log_CashInOut AS C INNER JOIN INFO_ADMIN AS A ON C.LC_SITE = A.ia_id WHERE C.LC_ID NOT IN (SELECT IU_ID FROM INFO_USER WHERE IU_LEVEL =9) "&SelGroupSqlA&"  AND C.LC_CONTENTS='배팅취소' AND C.LC_COMMENTS != '내부' AND C.LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BOUSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING

	SQLLIST = "SELECT ISNULL(SUM(C.LC_CASH),0) FROM Log_CashInOut AS C INNER JOIN INFO_ADMIN AS A ON C.LC_SITE = A.ia_id WHERE C.LC_ID NOT IN (SELECT IU_ID FROM INFO_USER WHERE IU_LEVEL =9) "&SelGroupSqlA&"  AND C.LC_CONTENTS='배팅배당' AND C.LC_COMMENTS != '내부' AND C.LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
	SET RSLIST = DbCon.Execute(SQLLIST)
	BTOSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING
    
    SQLLIST = "SELECT ISNULL(SUM(U.IU_CASH),0) FROM Info_User AS U INNER JOIN INFO_ADMIN AS A ON U.iu_site = A.ia_id WHERE U.IU_STATUS=1 AND U.IU_LEVEL <> 9 "&SelGroupSqlA &" "
	SET RSLIST = DbCon.Execute(SQLLIST)
	SUSERMO = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing

    SQLLIST = "select isNULL(sum(IB_AMOUNT),0) from INFO_BETTING where IB_CNT <> IB_RESULT_CNT "& SelGroupSqlB
	SET RSLIST = DbCon.Execute(SQLLIST)
	NEW_BTOSUM = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing

	If IA_TYPE = 2 Then
		SQLLIST = "select isNULL(sum(IA_CASH),0) from INFO_ADMIN WITH(NOLOCK) where IA_SITE LIKE '"&JOBSITE&"' "
	ELSE
		If IA_LEVEL = 2 THEN
			SQLLIST = "select isNULL(sum(lac_cash),0) from LOG_ADMIN_CASHINOUT WITH(NOLOCK)  where LAC_GROUP='" & IA_GROUP & "' and LAC_GROUP1 = '"& IA_GROUP1 &"' AND LAC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
		ElseIf IA_LEVEL = 3 Then
			SQLLIST = "select isNULL(sum(lac_cash),0) from LOG_ADMIN_CASHINOUT WITH(NOLOCK)  where LAC_GROUP='" & IA_GROUP & "' and LAC_GROUP1 = '"& IA_GROUP1 &"' and LAC_GROUP2 = '"& IA_GROUP2 &"' AND LAC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
		ElseIf IA_LEVEL = 4 Then
			SQLLIST = "select isNULL(sum(lac_cash),0) from LOG_ADMIN_CASHINOUT WITH(NOLOCK)  where LAC_GROUP='" & IA_GROUP & "' and LAC_GROUP1 = '"& IA_GROUP1 &"' and LAC_GROUP2 = '"& IA_GROUP2 &"' and LAC_GROUP3 = '"& IA_GROUP3 &"' AND LAC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
		ElseIf IA_LEVEL = 5 Then
			SQLLIST = "select isNULL(sum(lac_cash),0) from LOG_ADMIN_CASHINOUT WITH(NOLOCK)  where LAC_GROUP='" & IA_GROUP & "' and LAC_GROUP1 = '"& IA_GROUP1 &"' and LAC_GROUP2 = '"& IA_GROUP2 &"' and LAC_GROUP3 = '"& IA_GROUP3 &"' and LAC_GROUP4 = '"& IA_GROUP4 &"' AND LAC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"
		End If
	End IF
	SET RSLIST = DbCon.Execute(SQLLIST)
	CASHSUM1 = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing

    SQLLIST = "select isNULL(sum(IA_CASH),0) from INFO_ADMIN WITH(NOLOCK) where IA_SITE = '"&JOBSITE&"' "
	SET RSLIST = DbCon.Execute(SQLLIST)
	CASHSUM2 = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing

    SQLLIST = "select ia_sportspercent from INFO_ADMIN WITH(NOLOCK) where IA_SITE = '"&JOBSITE&"' "
	SET RSLIST = DbCon.Execute(SQLLIST)
	PROSP = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing

    SQLLIST = "select ia_livepercent from INFO_ADMIN WITH(NOLOCK) where IA_SITE = '"&JOBSITE&"' "
	SET RSLIST = DbCon.Execute(SQLLIST)
	PROLI = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing
	
	If IA_TYPE = 1 Then
		If IA_LEVEL = 2 THEN
			SQLLIST = "select count(ia_id) from INFO_ADMIN WITH(NOLOCK) where IA_GROUP='" & IA_group & "' and IA_group1 = '"& IA_group1 &"'"
		ELSEIf IA_LEVEL = 3 THEN
			SQLLIST = "select count(ia_id) from INFO_ADMIN WITH(NOLOCK) where IA_GROUP='" & IA_group & "' and IA_group1 = '"& IA_group1 &"' and IA_group2 = '"& IA_group2 &"'"
		ELSEIf IA_LEVEL = 4 THEN
			SQLLIST = "select count(ia_id) from INFO_ADMIN WITH(NOLOCK) where IA_GROUP='" & IA_group & "' and IA_group1 = '"& IA_group1 &"' and IA_group2 = '"& IA_group2 &"' and IA_group3 = '"& IA_group3 &"'"
		ELSEIf IA_LEVEL = 5 THEN
			SQLLIST = "select count(ia_id) from INFO_ADMIN WITH(NOLOCK) where IA_GROUP='" & IA_group & "' and IA_group1 = '"& IA_group1 &"' and IA_group2 = '"& IA_group2 &"' and IA_group3 = '"& IA_group3 &"' and IA_group4 = '"& IA_group4 &"'"
		End If
		SET RSLIST = DbCon.Execute(SQLLIST)
		CHONG1 = CDBL(RSLIST(0))
		RSLIST.CLOSE
		SET RSLIST = Nothing		
	Else
		SQLLIST = "select count(ia_id) from INFO_ADMIN WITH(NOLOCK) where IA_group = '"&IA_group&"' and ia_level=3 "
		SET RSLIST = DbCon.Execute(SQLLIST)
		CHONG1 = CDBL(RSLIST(0))
		RSLIST.CLOSE
		SET RSLIST = Nothing
	End If 
%>