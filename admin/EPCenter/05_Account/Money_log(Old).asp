<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>날짜별 현황</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="styles/style.css" />
<script>
function overMouse(obj){
	
	obj.bgColor = '#b8e1ff';
	
}

function outMouse(obj){
	
	obj.bgColor = '#ffffff';
	
}
</script>
<style>
.tdbg {

	background-color: #b8e1ff;
}
A:link {
	color:#ffffff;
	text-decoration:none;
	font-family:verdana, "dotum";
	font-size:11px;
}
A:visited {
	color:#ffffff;	
	text-decoration:none;
	font-family:verdana, "dotum";
	font-size:11px;
}
A:active {
	color:#ffffff;
	font-family:verdana, "dotum";
	font-size:11px;
}
A:hover {
	color:#ffffff;
	font-family:verdana, "dotum";
	font-size:11px;
	text-decoration: underline
}
</style>
<script src="/Sc/Base.js"></script>
</head>
<!-- #include virtual="/Inc_Month.asp"-->
<body >
<form name="frm" method="post">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="list0" style=table-layout:fixed> 
    <tr><td align="left" width="40%"><strong>&nbsp;&nbsp;날짜별 현황</strong></td></tr>
	<tr><td><img src="blank.gif" border="0" width="5" height="5"></td></tr>

	<tr>
      <td > 
		<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#bebebe"  style="border-collapse:collapse" style=table-layout:fixed><tr><td>
		<table width="300" border="0" align="right" cellpadding="0" cellspacing="0" >

		  <tr height="25">
		    <td width="70" align="right"><font color="#000000" style="font-size:12px;" ><strong>기간 : </strong>&nbsp;&nbsp;</font></td>
		    <td width="220">
			<font color="#000000" style="font-size:12px;" > 
			<div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:135;display:none;position: absolute; z-index: 99"></div>
			<input type="text" name="sStartDate" value="<%=REQUEST("sStartDate")%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:70" class="input">
			<img src="blank.gif" border="0" width="1" height="1">
			~<img src="blank.gif" border="0" width="1" height="1">
			<input type="text" name="sEndDate" value="<%=REQUEST("sEndDate")%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:70" class="input"></font>			
			</td>
		    <td width="65"><input name="Submit" type="submit" value="검색"></td>
		  </tr>
		</table>	
		</td></tr></table>
	</td>
    </tr>
	<tr><td><img src="blank.gif" border="0" width="5" height="5"></td></tr>

    <tr> 
      <td >
<table width="100%" border="1" cellpadding="0" cellspacing="0"  bordercolorlight="#bebebe"  style="border-collapse:collapse">
  <tr > 
    <td width="40" rowspan="2" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>번호</strong></font></td>
    <td width="110" rowspan="2" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>날짜</strong></font></td>
    <td height="25" colspan="3" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>충전</strong></font></td>
    <td height="25" colspan="3" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>환전</strong></font></td>
    <td height="25" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>차액</strong></font></td>
    <td height="25" colspan="3" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>배팅현황</strong></font></td>
    <td height="25" colspan="2" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>게시판</strong></font></td>
	<td width="60" height="25" rowspan="2" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>회원가입</strong></font></td>
    <td width="70" rowspan="2" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>사이트</strong></font></td>
  </tr>
  <tr > 
    <td width="70" height="25" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>총액</strong></font></td>
    <td width="70" height="25" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>입금</strong></font></td>
    <td width="70" height="25" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>관리자증감</strong></font></td>
    <td width="70" height="25" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>총액</strong></font></td>
    <td width="70" height="25" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>출금</strong></font></td>
    <td width="70" height="25" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>관리자차감</strong></font></td>
    <td width="70" height="25" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>입금 
      - 출금</strong></font></td>
    <td width="70" height="25" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>배팅금</strong></font></td>
    <td width="70" height="25" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>적중금</strong></font></td>
    <td width="70" height="25" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>적중율</strong></font></td>
    <td width="70" height="25" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>고객센터</strong></font></td>
	<td width="70" height="25" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><strong>자유게시판</strong></font></td>
  </tr>
<%
	
	SET DbRec=Server.CreateObject("ADODB.Recordset") 
	DbRec.CursorType=1

	SQLR = " LOG_CASHINOUT Where 1=1 "

	SQLLIST = "SELECT COUNT(*) AS TN From "& SQLR &""

	SQLR = " Info_Game Where 1=1 "

	PGSIZE = 1
	SETSIZE = 10

	PAGE = REQUEST("PAGE")
	IF REQUEST("PAGE") = "" THEN
		PAGE = 1
		STARTPAGE = 1
	ELSE
		PAGE = CINT(REQUEST("PAGE")) 
		STARTPAGE = INT(PAGE/SETSIZE)

		IF STARTPAGE = (PAGE/SETSIZE) THEN
			STARTPAGE = PAGE-SETSIZE + 1
		ELSE
			STARTPAGE = INT(PAGE/SETSIZE) * SETSIZE + 1
		END IF
	END If

		PGCOUNT = INT(TN/PGSIZE)
	IF PGCOUNT * PGSIZE <> TN THEN 
		PGCOUNT = PGCOUNT+1
	END IF


    
	eDate = FormatDateTime(Left(Now(),4)&"/"&Mid(Now(),6,2)&"/"&Mid(Now(),9,2),2)
	TTN01 = DateDiff("d", fDate,eDate)

	START_ROWNUM	=	CINT(CINT(CINT(PGSIZE) * CINT(CINT(PAGE) -1)) + 1)
	END_ROWNUM		=	CINT(CINT(PGSIZE) * CINT(PAGE))

	TN = DateDiff("d", fDate,eDate) + 1 
	AATN = DateDiff("d", fDate,eDate)

		NEXTPAGE = CINT(PAGE) + 1
		PREVPAGE = CINT(PAGE) - 1
		NN = TN - (PAGE-1) * PGSIZE


	STARTPAGE = int(PAGE / SETSIZE) * SETSIZE + 1 

	TTN = TTN01 - 1 - PGSIZE * (PAGE - 1)
	eDate = DateAdd("d",-PGSIZE*(page-1),eDate)
	fDate = DateAdd("d",-PGSIZE+1,eDate)

	sStartDate = REQUEST("sStartDate")
	If sStartDate <> "" Then 
		sStartDate = replace(sStartDate,"-","/")
	End If 
	sEndDate = REQUEST("sEndDate")
	If sEndDate <> "" Then 
		sEndDate = replace(sEndDate,"-","/")
	End If 

	If sStartDate <> "" And sEndDate <> "" Then
	
		fDate = FormatDateTime(sStartDate,2)
		eDate = FormatDateTime(sEndDate,2)
		TN = DateDiff("d", fDate,eDate) 
	Else
	 	TN = PGSIZE 
	End If 

	nowDate = replace(eDate,"-","/")


    

%>	
<%	IF TN = 0 THEN	%>

<tr><td align="center" colspan="15" height="25">데이터가 없습니다.</td></tr>
<%
	ELSE

	FOR i = 0 TO TN - 1

    response.Write replace(nowDate, "-","/")

    nowDate = replace(nowDate, "-","/")
	SQLa = "SELECT CONVERT(VARCHAR,lc_regdate, 111) AS l, ISNULL(SUM (lc_cash),0) AS dd FROM log_cashinout where lc_contents = '배팅차감' and CONVERT(VARCHAR,lc_regdate, 111) = '"&nowDate&"'  GROUP BY CONVERT(VARCHAR,lc_regdate, 111)"
	aNUM3 = 0
	SET RSa= DbCon.Execute(SQLa)
	If Not RSa.EOF then
		aNUM3 = CDBL(RSa("DD"))
	End If 
	RSa.CLOSE
	SET RSa = Nothing

	SQLa = "SELECT CONVERT(VARCHAR,lc_regdate, 111) AS l, ISNULL(SUM (lc_cash),0) AS dd FROM log_cashinout where lc_contents = '배팅배당' and CONVERT(VARCHAR,lc_regdate, 111) = '"&nowDate&"'  GROUP BY CONVERT(VARCHAR,lc_regdate, 111)"
	aNUM4 = 0
	SET RSa= DbCon.Execute(SQLa)
	If Not RSa.EOF then
		aNUM4 = CDBL(RSa("DD"))
	End If 
	RSa.CLOSE
	SET RSa = Nothing

		
	SQLa = "SELECT CONVERT(VARCHAR,lc_regdate, 111) AS l, ISNULL(SUM (lc_cash),0) AS dd FROM log_cashinout where lc_contents = '배팅취소' and CONVERT(VARCHAR,lc_regdate, 111) = '"&nowDate&"'  GROUP BY CONVERT(VARCHAR,lc_regdate, 111)"
	aNUM = 0
	SET RSa= DbCon.Execute(SQLa)
	If Not RSa.EOF then
		aNUM = CDBL(RSa("DD"))
	End If 
	RSa.CLOSE
	SET RSa = Nothing
	
	SQLa = "SELECT COUNT(CONVERT(VARCHAR,BF_REGDATE, 111)) as cnt FROM BOARD_FREE WHERE CONVERT(VARCHAR,BF_REGDATE, 111) = '"&nowDate&"'  GROUP BY CONVERT(VARCHAR,BF_REGDATE, 111) "
	bNUM = 0
	SET RSa= DbCon.Execute(SQLa)
	If Not RSa.EOF then
		bNUM = CDBL(RSa("cnt"))
	End If 
	RSa.CLOSE
	SET RSa = Nothing


	SQLa = "SELECT COUNT(CONVERT(VARCHAR,BC_REGDATE, 111)) as cnt FROM BOARD_CUSTOMER WHERE CONVERT(VARCHAR,BC_REGDATE, 111) = '"&nowDate&"' GROUP BY CONVERT(VARCHAR,BC_REGDATE, 111) "
	dNUM  = 0
	SET RSa= DbCon.Execute(SQLa)
	If Not RSa.EOF then
		dNUM = CDBL(RSa("cnt"))
	End If 
	RSa.CLOSE
	SET RSa = Nothing


	SQLa = "SELECT CONVERT(VARCHAR,ic_setdate, 111) AS l, isNULL(SUM (ic_amount),0) AS dd FROM info_charge WHERE CONVERT(VARCHAR,ic_setdate, 111) = '"&nowDate&"'  GROUP BY CONVERT(VARCHAR,ic_setdate, 111)"
	gaa = 0
	
	SET RSa= DbCon.Execute(SQLa)
	If Not RSa.EOF then
		gaa = FORMATNUMBER(CDbl(RSa("dd")),0)
	End If 
	RSa.CLOSE
	SET RSa = Nothing

	SQLa = " select CONVERT(VARCHAR,ie_setdate, 111) AS l, isNULL(SUM (ie_amount),0) AS dd from info_exchange WHERE CONVERT(VARCHAR,ie_setdate, 111) = '"&nowDate&"'  GROUP BY CONVERT(VARCHAR,ie_setdate, 111)"
	gbb = 0
	SET RSa= DbCon.Execute(SQLa)
	If Not RSa.EOF then
		gbb = FORMATNUMBER(abs(CDbl(RSa("dd"))),0)
	End If 
	RSa.CLOSE
	SET RSa = Nothing

	SQLa = "SELECT   CONVERT(VARCHAR,lc_regdate, 111) AS l, ISNULL(SUM (lc_cash),0) AS dd FROM log_cashinout where lc_contents = '배팅차감' and CONVERT(VARCHAR,lc_regdate, 111) = '"&nowDate&"'  GROUP BY CONVERT(VARCHAR,lc_regdate, 111)"
	gcc = 0
	SET RSa= DbCon.Execute(SQLa)
	If Not RSa.EOF then
		gcc = FORMATNUMBER(abs(CDbl(RSa("dd"))),0)
	End If 
	RSa.CLOSE
	SET RSa = Nothing

	SQLa = "SELECT   CONVERT(VARCHAR,lc_regdate, 111) AS l, ISNULL(SUM (lc_cash),0) AS dd FROM log_cashinout where lc_contents = '배팅배당' and CONVERT(VARCHAR,lc_regdate, 111) = '"&nowDate&"'  GROUP BY CONVERT(VARCHAR,lc_regdate, 111)"
	gee = 0
	SET RSa= DbCon.Execute(SQLa)
	If Not RSa.EOF then
		gee = FORMATNUMBER(CDbl(RSa("dd")),0)
	End If 
	RSa.CLOSE
	SET RSa = Nothing



	
	SQLa = "select sum(ic_amount) as cnt from info_charge where CONVERT(VARCHAR,ic_regdate,111) = '"&nowDate&"' "
	'response.write SQLa
	iNUM  = 0
	SET RSa= DbCon.Execute(SQLa)
	If Not RSa.EOF then
		iNUM = RSa("cnt")
	End If 
	RSa.CLOSE
	SET RSa = Nothing

	SQLa = "select sum(ic_amount) as cnt from info_charge where CONVERT(VARCHAR,ic_regdate,111) = '"&nowDate&"' and  ic_status = 1"
	lNUM = 0
	SET RSa= DbCon.Execute(SQLa)
	If Not RSa.EOF then
		lNUM = RSa("cnt")
	End If 
	RSa.CLOSE
	SET RSa = Nothing

	SQLa = "SELECT   CONVERT(VARCHAR,lc_regdate, 111) AS l, ISNULL(SUM (lc_cash),0) AS dd FROM log_cashinout where lc_contents = '관리자증감' and CONVERT(VARCHAR,lc_regdate, 111) = '"&nowDate&"'   GROUP BY CONVERT(VARCHAR,lc_regdate, 111)"
	mNUM = 0
	SET RSa= DbCon.Execute(SQLa)
	If Not RSa.EOF then
		mNUM = RSa("DD")
	End If 
	RSa.CLOSE
	SET RSa = Nothing


	SQLa = "SELECT   CONVERT(VARCHAR,lc_regdate, 111) AS l, ISNULL(SUM (lc_cash),0) AS dd FROM log_cashinout where lc_contents = '관리자차감' and CONVERT(VARCHAR,lc_regdate, 111) = '"&nowDate&"'  GROUP BY CONVERT(VARCHAR,lc_regdate, 111)"
	oNUM = 0
	SET RSa= DbCon.Execute(SQLa)
	If Not RSa.EOF then
		oNUM = RSa("DD")
	End If 
	RSa.CLOSE
	SET RSa = Nothing


	SQLa = "select count(iu_idx) as cnt from info_user where CONVERT(VARCHAR,iu_regdate,111) = '"&nowDate&"' "
	qNUM = 0
	SET RSa= DbCon.Execute(SQLa)
	If Not RSa.EOF then
		qNUM = RSa("cnt")
	End If 
	RSa.CLOSE
	SET RSa = Nothing
    
    
%>
  <tr> 
    <td width="40" height="25" align="center" valign="middle" rowspan="2"><font color="#000000" style="font-size:12px;"><%=NN%></font></td>
    <td width="110" height="25" align="center" valign="middle" rowspan="2"><font color="#000000" style="font-size:12px;"><%=Mid(FormatDateTime(nowDate,1),1,12)%><br><%=Mid(FormatDateTime(nowDate,1),13,4)%></font></td>
    <td width="70"  height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(CDbl(CDbl(gaa)+CDbl(mNUM)),0)%></font></td>
    <td width="70"  height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(CDbl(gaa),0)%></font></td>
    <td width="70"  height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(CDbl(mNUM),0)%></font></td>
    <td width="70"  height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(CDbl(CDbl(gbb)+abs(CDbl(oNUM))),0)%></font></td>
    <td width="70"  height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(CDbl(gbb),0)%></font></td>
    <td width="70"  height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(abs(CDbl(oNUM)),0)%></font></td>
    <td width="70"  height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(CDbl(CDbl(gaa)-CDbl(gbb)),0)%>   </font></td>
    <td width="70"  height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=gcc%></font></td>
    <td width="70"  height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=gee%></font></td>
    <td width="70"  height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;">
    <%
		If gee <> "" and gcc <> "" And gcc <> 0 And gee <> 0 Then
			response.write Int(CDbl(gee) / CDbl(gcc) * 100 )	
		Else
			response.write "0"
		End If 
	%>%</font></td>
    <td width="70"  height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=dNUM%></font></td>
    <td width="70"  height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=bNUM%></font></td>
    <td width="60"  height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=qNUM%></font></td>
	<td width="70"  height="25" align="center" valign="middle"><font color="#000000" style="font-size:12px;">-</font></td><!--site-->
  </tr>
 
  <tr bgcolor="#ffcccc"> 
    <td width="70" height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(CDbl(CDbl(k1aa)+CDbl(n1NUM)+CDbl(kaa)+CDbl(nNUM)+CDbl(gaa)+CDbl(mNUM)),0)%></font></td>
    <td width="70" height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(CDbl(CDbl(k1aa)+CDbl(kaa)+CDbl(gaa)),0)%></font></td>
    <td width="70" height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(CDbl(CDbl(n1NUM)+CDbl(nNUM)+CDbl(mNUM)),0)%></font></td>
    <td width="70" height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(CDbl(CDbl(k1bb)+CDbl(kbb)+CDbl(gbb)+abs(CDbl(oNUM))+abs(CDbl(pNUM))+abs(CDbl(p1NUM))),0)%></font></td>
    <td width="70" height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(CDbl(CDbl(k1bb)+CDbl(kbb)+CDbl(gbb)),0)%></font></td>
    <td width="70" height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(CDbl(abs(CDbl(oNUM))+abs(CDbl(pNUM))+abs(CDbl(p1NUM))),0)%></font></td>
    <td width="70" height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(CDbl(CDbl(k1aa)+CDbl(kaa)+CDbl(gaa)-CDbl(kbb)-CDbl(k1bb)-CDbl(gbb)),0)%></font></td>
    <td width="70" height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(ABS(CDbl(aNUM3))-aNUM,0)%></font></td>
    <td width="70" height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FORMATNUMBER(CDbl(aNUM4),0)%></font></td>
    <td width="70" height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;">
    <%
		If aNUM4 <> "" And( gcc <> "" or kcc <> "" ) And aNUM4 <> 0 And (gcc <> 0 or kcc <> 0) Then
			response.write Int(CDbl(aNUM4) / (CDbl(k1cc)+CDbl(kcc)+CDbl(gcc)) * 100)	
		Else
			response.write "0"
		End If 
	%>%</font></td>
    <td width="70" height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=dNUM+fNUM+f1NUM%></font></td>
    <td width="70" height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=bNUM+cNum+c1Num%></font></td>
	<td width="60" height="25" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=CDbl(qNum)+CDbl(rNum)+CDbl(r1Num)%></font></td>
	<td width="70"  height="25" align="center" valign="middle"><font color="#000000" style="font-size:12px;">-</font></td><!--site2-->
  </tr> 
	<%  NN = NN - 1 
			TTN = TTN - 1
		nowDate = DateAdd("d", -(i+1), eDate)
		a001 = a001 + CDbl(CDbl(k1aa)+CDbl(n1NUM)+CDbl(kaa)+CDbl(nNUM)+CDbl(gaa)+CDbl(mNUM))
		a002 = a002 + CDbl(CDbl(k1aa)+CDbl(kaa)+CDbl(gaa))
		a003 = a003 + CDbl(CDbl(n1NUM)+CDbl(nNUM)+CDbl(mNUM))
		a004 = a004 + CDbl(CDbl(k1bb)+CDbl(kbb)+CDbl(gbb)+abs(CDbl(oNUM))+abs(CDbl(pNUM))+abs(CDbl(p1NUM)))
		a005 = a005 + CDbl(CDbl(k1bb)+CDbl(kbb)+CDbl(gbb))
		a006 = a006 + CDbl(abs(CDbl(oNUM))+abs(CDbl(pNUM)))
		a007 = a007 + CDbl(CDbl(k1aa)+CDbl(kaa)+CDbl(gaa)-CDbl(kbb)-CDbl(k1bb)-CDbl(gbb))
		a008 = a008 + ABS(CDbl(aNUM3))-aNUM
		a009 = a009 + CDbl(aNUM4)
		a010 = a010 + dNUM+fNUM+f1NUM
		a011 = a011 + bNUM+cNum+c1Num
		a012 = a012 + CDbl(qNum)+CDbl(rNum)+CDbl(r1Num)
		Next %>
  <tr bgcolor="#e9e9ee" height="35"> 
	<td width="40"  height="35" align="center" valign="middle"><font color="#000000" style="font-size:12px;">TOTAL : </font></td>
	<td width="110"  height="35" align="center" valign="middle"><font color="#000000" style="font-size:12px;"><%=Mid(FormatDateTime(fDate,1),1,12)%><br> ~ <%=Mid(FormatDateTime(eDate,1),1,12)%></font></td>
    <td width="70" height="35" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FormatNumber(a001,0)%></font></td>
    <td width="70" height="35" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FormatNumber(a002,0)%></font></td>
    <td width="70" height="35" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FormatNumber(a003,0)%></font></td>
    <td width="70" height="35" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FormatNumber(a004,0)%></font></td>
    <td width="70" height="35" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FormatNumber(a005,0)%></font></td>
    <td width="70" height="35" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FormatNumber(a006,0)%></font></td>
    <td width="70" height="35" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FormatNumber(a007,0)%></font></td>
    <td width="70" height="35" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FormatNumber(a008,0)%></font></td>
    <td width="70" height="35" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FormatNumber(a009,0)%></font></td>
    <td width="70" height="35" align="right" valign="middle"><font color="#000000" style="font-size:12px;"
    ><%
		If a009 <> "" And a008 <> "" And a009 <> 0 And a008 <> 0  Then
			response.write Int(a009 / a008 * 100)	
		Else
			response.write "0"
		End If 
	%>%</font></td>
    <td width="70" height="35" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FormatNumber(a010,0)%></font></td>
    <td width="70" height="35" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FormatNumber(a011,0)%></font></td>
	<td width="60" height="35" align="right" valign="middle"><font color="#000000" style="font-size:12px;"><%=FormatNumber(a012,0)%></font></td>
	<td width="70"  height="35" align="center" valign="middle"><font color="#000000" style="font-size:12px;">-</font></td><!--site total-->
  </tr> 		
	<% END IF %>
</table>
<table><tr><td height="9"></td></tr></table>
<table  align="center"><tr>
<td width="25%">
</td>
<td width="10%" align="right">
	<% response.write "<a href=money_log(old).asp?page="&STARTPAGE-SETSIZE&"&Search="& Search&"&Find="&Find&"><font color='#000000'>◀</font></a>" %>
</td>
<td>
<table border="0" cellpadding="0" cellspacing="0" width="30%" align="center" >
<tr>
<%
	FOR i = STARTPAGE TO SETSIZE + STARTPAGE - 1
		If (i - 1) * PGSIZE > AATN Then
			Exit For
		End If 
		
		If CDbl(i) = CDbl(page) Then
%>
	<td class='td_game01' width="20" style="padding-left:10px; padding-right:10px;" align='center'><% response.write "<a href=money_log(old).asp?page="&i&"&Search="& Search&"&Find="&Find&"><font color='#dfdd00' size='3' >"&i&"</font></a>" %></td>
<%
		Else
%>
	<td class='td_game01' width="20" style="padding-left:10px; padding-right:10px;" align='center'><% response.write "<a href=money_log(old).asp?page="&i&"&Search="& Search&"&Find="&Find&"><font color='#000000' size='3' >"&i&"</font></a>" %></td>
<%
		End If 
NEXT
%>
</tr>
</table>
</td>
<td width="10%" align="left">
<%	IF i * PGSIZE > AATN  Then
	
	Else 
		response.write "<a href=money_log(old).asp?page="&STARTPAGE+SETSIZE&"&Search="& Search&"&Find="&Find&"><font color='#000000'>▶</font></a>" 
	End If 
%>
</td>
<td width="25%">
</td>
</tr></table>
<%
	DbCon.Close
	Set DbCon=Nothing
%>
</td></tr></table>
</form>
 </BODY>
</HTML>
