<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
	SETSIZE = 20
	PGSIZE = 30

    PAGE = REQUEST("PAGE")
	Search = REQUEST("Search")
	Find = Trim(REQUEST("Find"))
    sStartDate = REQUEST("sStartDate")
    sEndDate = REQUEST("sEndDate")
    

	
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 

	'######### ���� ����Ʈ�� �ҷ���                 ################	
   
	Call dfgameSql.RetrieveInfo_TopBenefit_Betting(dfDBConn.Conn,  sStartDate, sEndDate)

    'dfGameSql.debug
	IF dfgameSql.RsCount <> 0 Then
	    nTotalCnt = dfgameSql.RsOne("TC")
	Else
	    nTotalCnt = 0
	End IF
		
    '--------------------------------
	'   Page Navigation
	'--------------------------------
	Dim objPager
	Set objPager = New Pager
	
	objPager.RecordCount = nTotalCnt
	objPager.PageIndexVariableName = "page"
	objPager.NumericButtonFormatString = "{0}"
	objPager.PageButtonCount = 5
	objPager.PageSize = pageSize
	objPager.NumericButtonCssClass = "paging"
	objPager.SelectedNumericButtonCssClass = "paging_crnt"
	objPager.NavigateButtonCssClass = "paging_txt1"
	objPager.CurrentPageIndex = page
	objPager.NumericButtonDelimiter = "<span class=""paging_txt2"">|</span>"
	objPager.NavigationButtonDelimiter = "<span class=""paging_txt2"">|</span>"
	objPager.NavigationShortCut = false
	
%>

<html>
<head>
<title>���� ����Ʈ</title>
<!-- #include virtual="/Inc_Month.asp"-->
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">


<script type="text/javascript">
	function goDetail(IB_Idx, gameCnt)
	{
	    var url = "Betting_Detail.asp?IB_Idx="+IB_Idx;
	    dis = document.getElementById("tr"+IB_Idx).style.display == "none" ? "block" : "none" ;
	    document.getElementById("tr"+IB_Idx).style.display = dis ;
	    if(dis == "block")
	    {
	        
	        document.getElementById("iframe"+IB_Idx).style.width = "100%" ;
	        document.getElementById("iframe"+IB_Idx).style.height = (gameCnt*20) + 120 ;
	        document.getElementById("iframe"+IB_Idx).src = url ;
	    }
	}
</script>

</head>

<body topmargin="0" marginheight="0">
<iframe name="exeFrame" id="exeFrame" width=0 height=0 frameborder=0></iframe>
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td>
        <b class="text07"> ���� ���� &nbsp;&nbsp; ��  �ְ��� ���� ����Ʈ  
	      </b>
    </td>
</tr>
</table>    
<div style="height:10px;"></div>

<iframe src="Betting_Money.asp" width="100%" height="50" frameborder="0"></iframe>
<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="get" action="TopBenefit_Betting.asp">
<tr><td>�������� :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" value="<%=Left(sStartDate,12)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>�������� :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" value="<%=Left(sEndDate,12)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="�� ��"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td></td></tr></form></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0"  cellspacing="1" cellpadding="3" bgcolor="#AAAAAA" width="100%">
<form name="frm1" method="post">
<tr bgcolor="eeeeee"> 
	<!-- <td align="center" height="30" width="40"><b>����</b></td> -->
	<td align="center" width="50"><b>��ȣ</b></td>
	<td align="center" width="40"><b>����</b></td>
	<td align="center" width="80"><b>ID</b></td>
	<td align="center" width="60"><b>����Ʈ</b></td>
	<td align="center" width="40"><b>���Ӽ�</b></td>
	<td align="center"><b>�������೻��</b></td>		
	<td align="center" width="60"><b>�����</b></td>
	<td align="center" width="90"><b>���þ�</b></td>
	<td align="center" width="90"><b>������߱�</b></td>
	<td align="center" width="160"><b>���ýð�</b></td>		
	<td align="center" width="60"><b>���</b></td>
	<td align="center" width="60"><b>��</b></td>
	<td align="center" width="60"><b>���</b></td>
	</tr>

<%	IF  dfgameSql.RsCount = 0 THEN	%>

<tr bgcolor="ffffff"> <td align="center" colspan="13" height="35">���� ��ϵ� ������ �����ϴ�.</td></tr>

<%
	ELSE

	FOR ii = 0 TO dfgameSql.RsCount -1

		IB_Idx		= dfgameSql.Rs(ii,"IB_Idx")
		IB_ID		= dfgameSql.Rs(ii,"IB_ID")
		IB_Type		= dfgameSql.Rs(ii,"IB_Type")
		IB_Num		= dfgameSql.Rs(ii,"IB_Num")
		IG_Idx		= dfgameSql.Rs(ii,"IG_Idx")
		IB_Benefit	= dfgameSql.Rs(ii,"IB_Benefit")
		IB_Amount	= dfgameSql.Rs(ii,"IB_Amount")
		IB_Status	= dfgameSql.Rs(ii,"IB_Status")
		IB_RegDate	= dfgameSql.Rs(ii,"IB_RegDate")
		IB_SITE		= dfgameSql.Rs(ii,"IB_SITE")
		IU_NICKNAME = dfgameSql.Rs(ii,"IU_NICKNAME")

		IF IB_Type = "M" THEN
			arr_IG_Idx = split(IG_Idx, ",")
			arrLen = Ubound(arr_IG_Idx)
			GameCnt = arrLen+1
			arr_IB_Num = split(IB_Num, ",")
			arr_IB_Benefit = split(IB_Benefit,",")
			
			BenefitRate = 1
			FOR i=0 TO arr_Len
				BenefitRate = Cdbl(BenefitRate) * Cdbl(formatnumber(arr_IB_Benefit(i),2))
			NEXT
		ELSE
			GameCnt = 1
			BenefitRate = int(IB_Benefit*100)/100
		END IF
		
		Benefit = Cdbl(BenefitRate) * Cdbl(IB_Amount)	%>

<tr bgcolor="ffffff"><!-- <td align="center"><input type="checkbox" name="SelUser" value="<%=IB_Idx%>"></td> -->
	<td align="center"><%=IB_Idx%></td>
	<td align="center"><a href="/EPCenter/04_Game/Betting_List.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=IB_TYPE&Find=<%=IB_Type%>"><% IF IB_Type = "M" THEN response.write "����" ELSE response.write "�ܽ�" END IF %></a></td>
	<td>&nbsp;<a href="/EPCenter/04_Game/Betting_List.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=IB_ID&Find=<%=IB_ID%>"><%=IB_ID%>(<%=iu_nickname%>)</a></td>
	<%
	If IB_SITE = "Life" Then
		response.write "<td align='center' bgcolor='#ffcccc'>"
	elseIf IB_SITE = "Media" Then
		response.write "<td align='center' bgcolor='#648ba6'>"
	Else 
		response.write "<td align='center'>"
	End If 
	%>&nbsp;<a href="/EPCenter/04_Game/Betting_List.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=IB_SITE&Find=<%=IB_SITE%>"><%=IB_SITE%></a></td>
	<td align="center"><%=GameCnt%></td>
	<td align="center">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<% 
			IF IB_Type = "S" THEN
				StrCancel = ""

				SQLMSG = "SELECT IG_Status, IG_Result, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit FROM INFO_GAME WHERE IG_IDX = "& IG_Idx &" "
				SET RS1 = DbCon.Execute(SQLMSG)

                IF Not Rs1.Eof Then
				    IG_Status = rs1("IG_Status")
				    IG_Result = rs1("IG_Result")
                Else
                	IG_Status = "C"			    
				End IF
				

				TotalBenefitRate = IB_Benefit
				TotalBenefit = Cdbl(IB_Benefit) * Cdbl(IB_Amount)
				
				IF IG_Status = "S" OR IG_Status = "E" THEN
					ProcFlag = "FALSE"
					ResultFlag = "FALSE"
				ELSEIF IG_Status = "C" THEN
					ProcFlag = "FALSE"
					ResultFlag = "FALSE"
				ELSE
					ProcFlag = "TRUE"
					IF NOT isNull(IG_Result) Then
					    IF CStr(Trim(IG_Result)) = CStr(Trim(IB_Num)) THEN
						    ResultFlag = "TRUE"
					    ELSE
						    ResultFlag = "FALSE"
					    END IF
					End IF
				END IF
					
				IF IG_Status <> "C" THEN
					IF ProcFlag = "TRUE" and ResultFlag = "TRUE" THEN
						DspResult = "<td align='center' bgcolor='#777777' style='color:yellow;font-weight:bold;'>����</td>"
						bgColor = "Yellow"
						bgShape = "0"
					ELSEIF ProcFlag = "TRUE" and ResultFlag = "FALSE" THEN
						DspResult = "<td align='center' bgcolor='#777777' style='color:red;font-weight:bold;'>����</td>"
						bgColor = "Red"
						bgShape = "X"
					ELSE
						DspResult = "<td align='center' bgcolor='#777777' style='color:blue;font-weight:bold;'>������</td>"
						bgColor = "gray"
						bgShape = "?"
					END IF
					
				ELSE
					StrCancel = "cancel"
					
					DspResult = "<td align='center' bgcolor='#777777' style='color:white;font-weight:bold;'>���</td>"
					bgColor = "white"
					bgShape = "���"
				END IF
		%>
		<tr bgcolor="ffffff"><td width="100%" height="20" bgcolor=<%=bgColor%> style="border:1px solid #999999;color:#333333;" align="center"><%=bgShape%></td></tr>
		<%
			ELSE
		%>
		<tr>
		<%
			TotalBenefitRate = 1
			
			ProcFlag = "TRUE"
			ResultFlag = "TRUE"
			
			StrProc = ""
			StrResult = ""
			StrCancel = ""
			
			CancelCnt = 0
			
			FOR i=0 TO arrLen
			
				cellWidth = (100 / Cint(arrLen+1)) & "%"
				
				SQLMSG = "SELECT IG_Status, IG_Result, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Team1, IG_Team2 FROM INFO_GAME WHERE IG_IDX = "& arr_IG_Idx(i) &" "
				SET RS1 = DbCon.Execute(SQLMSG)

                IF Not Rs1.Eof Then
				    IG_Status = rs1("IG_Status")
				    IG_Result = rs1("IG_Result")
                Else
                	IG_Status = "C"			    
				End IF
				BenefitRate = arr_IB_Benefit(i)
				

				
				IF IG_Status <> "C" THEN
					
					'// ������ ���� ������ �ʾ�����...
					IF IG_Status = "S" OR IG_Status = "E" THEN
						ProcFlag = "FALSE"
						ResultFlag = "TRUE"
					ELSE
						ProcFlag = "TRUE"
						'// ��������...���߽���...
						IF NOT isNull(IG_Result) Then
						    IF CStr(Trim(IG_Result)) <> CStr(Trim(arr_IB_Num(i))) THEN
							    ResultFlag = "FALSE"
						    ELSE
							    ResultFlag = "TRUE"
						    END IF
						End IF

										
					END IF
				ELSE
					ProcFlag = "TRUE"
					ResultFlag = "TRUE"
				END IF
					
				StrProc = StrProc & "," & ProcFlag
				StrResult = StrResult & "," & ResultFlag
				
				IF IG_Status <> "C" THEN
					IF ProcFlag = "TRUE" AND ResultFlag = "TRUE" THEN
						bgColor = "yellow"
						bgShape = "0"
					ELSEIF ProcFlag = "TRUE" AND ResultFlag = "FALSE" THEN
						bgColor = "red"
						bgShape = "X"
					ELSE
						bgColor = "gray"
						bgShape = "?"
					END IF
				ELSE
					'// StrCancel = "cancel"
					CancelCnt = CancelCnt+1
					
					bgColor = "white"
					bgShape = "���"
				END IF
		%>
			<td height="20" width="<%=cellWidth%>" bgcolor="<%=bgColor%>" style="border:1px solid #999999;color:#333333;" align="center"><%=bgShape%></td>
		<%
				IF IG_Status <> "C" THEN
					'// ��ҵ� ����� ������� ������ �ʴ´�...
					TotalBenefitRate = Cdbl(TotalBenefitRate) * 100 * Cdbl(BenefitRate) * 100 / 10000
				END IF
			NEXT
			
			TotalBenefit = numdel(TotalBenefitRate) * Cdbl(IB_Amount)
									
			'// ���� ���а��...
			find_proc = Instr(StrProc,"FALSE")
			find_result = Instr(StrResult,"FALSE")
			
			IF Cint(CancelCnt) = Cint(arrLen)+1 THEN
				DspResult = "<td align='center' bgcolor='#777777' style='color:white;font-weight:bold;'>���</td>"
			ELSE
				IF find_result = 0 THEN 			'// ����� false�� ������...
					IF find_proc = 0 THEN
						DspResult = "<td align='center' bgcolor='#777777' style='color:yellow;font-weight:bold;'>����</td>"
					ELSE
						DspResult = "<td align='center' bgcolor='#777777' style='color:blue;font-weight:bold;'>������</td>"
					END IF
				ELSE
					DspResult = "<td align='center' bgcolor='#777777' style='color:red;font-weight:bold;'>����</td>"
				END IF
			END IF
		%>
			</tr>
		<%
			RS1.Close
			Set RS1 = Nothing

			END IF
		%></table></td>		
	<td align="right"><%=numdel(TotalBenefitRate)%>&nbsp;</td>
	<td align="right"><%=formatnumber(IB_Amount,0)%>��&nbsp;</td>
	<td align="right"><%=formatnumber(int(TotalBenefit*100)/100,0)%>��&nbsp;</td>
	<td align="center"><%=dfStringUtil.GetFullDate(IB_RegDate)%></td>		
	<%=DspResult%>
	<td align="center">
	
	<a href="javascript:goDetail(<%=IB_Idx%>, <%= GameCnt %>);">�ٷκ���</a>
	</td><td align="center" <% IF IB_SITe = "None" Then  %>bgcolor='skyblue'<% End IF %>>
	<%
	IF request.Cookies("AdminLevel") = 1 THEN 
	    IF  IB_SIte = "None" Then
            SQLMSG = "SELECT LC_REGDATE FROM LOG_CASHINOUt WHERE IB_IDX = "& IB_IDX
			SET RS1 = DbCon.Execute(SQLMSG)	  
			IF NOT RS1.Eof Then      
    %>
        ��ҳ���<br /><%= dfStringUtil.GetFullDate(Rs1("LC_REGDATE")) %>
    <%
            End IF
        Else
    %>
	
	<%
	    End IF
	%>
	<% ELSE %>�Ұ�<% END IF %></td>
	</tr>
<tr id="tr<%= IB_Idx %>" style="display:none;" >
    <td colspan="13" bgcolor="ffffff">
        <iframe id="iframe<%= IB_Idx %>" frameborder="0" ></iframe>
    </td>
</tr>
	<%  
		Next 
	%>
		
	<% END IF %>

</table><br clear="all">

<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
<!-- paging End -->

</form>

</body>
</html>

