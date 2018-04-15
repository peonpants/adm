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
    
    reqIB_AMOUNT = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("IB_AMOUNT")), 0, 0, 3000000)
    real_user = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("real_user")), 0, 0, 1)
    
    site = "MSPORTS" 'REQUEST("JOBSITE")
        
	SET DbRec=Server.CreateObject("ADODB.Recordset") 
	DbRec.CursorType=1

	SQLR = " INFO_BETTING a,info_user b WHERE 1=1 and a.IB_ID = b.IU_ID AND A.IB_SITE = B.IU_SITE"

	SQLLIST = "SELECT COUNT(*) AS TN FROM "& SQLR &""
	SET RSLIST = DbCon.Execute(SQLLIST)
	TOMEM = RSLIST(0)
	RSLIST.CLOSE
	SET RSLIST = Nothing


    pageSize        = 20             
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 

	
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 

	'######### ���� ����Ʈ�� �ҷ���                 ################	
   
	Call dfgameSql.RetrieveInfo_Betting(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site, reqIB_AMOUNT, real_user)

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
<script src="/js/ajax.js" language="JavaScript" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript">
function go_delete(form)
{
	var v_cnt = 0;
	var v_data = "";
	
	for( var i=0; i<form.elements.length; i++) 
	{
		var ele = form.elements[i];
		if( (ele.name=="SelUser") && (ele.checked) )
		{ 
			//if (v_cnt == 0)
			if (v_data.length==0)
				v_data = ele.value;
			else
				v_data = v_data + "," + ele.value; 
			v_cnt = v_cnt + 1; 
		} 
	}
		
	if (v_cnt == 0) 
	{ 
		alert("������ ������ ������ �ּ���."); 
		return;
	} 
	
	//alert(v_data);
	
	if (!confirm("���� �����Ͻðڽ��ϱ�?")) return;		
	form.action = "Delete.asp?page=<%=page%>";
	form.submit();
}
	
	function SearchSports(ss) {
		document.frm1.action = "List.asp?RS_Sports="+ss;	
		document.frm1.submit();
	}
	
	function SearchLeague(ss,sl) {
		// document.frm1.action = "List.asp?RS_Sports="+ss+"&RL_League="+sl;
		// document.frm1.submit();
		location.href = "List.asp?RS_Sports="+ss+"&RL_League="+sl;
	}

	function goMyBetDetail(idx,pg,tt) {
		goUrl = "Betting_Detail.asp?IB_Idx="+idx+"&page="+pg+"&total="+tt;
		location.href=goUrl;
	}
	function goBatdel(gidx) {
		if (!confirm("���� ����Ͻðڽ��ϱ�?\n\n��ҽ� �ش� ���ÿ� ���� ȯ��ó���� �̷�� ���ϴ�.")) return;		
		exeFrame.location.href="Bet_Cancel_Proc.asp?IB_Idx="+gidx;
	}
	
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

    function ajaxRequestBet(ib_idx, e)
	{

        var E=window.event;
        var x =  E.clientX + document.body.scrollLeft ;
	    var y =  E.clientY + document.body.scrollTop;
    	
		document.getElementById("aaa").style.left = x ;
		document.getElementById("aaa").style.top = y ;	
		        
		var url = "ajaxBetting_Detail.asp";
		var pars = 'ib_idx=' + ib_idx
		
		var myAjax = new Ajax.Request(
			url, 
			{
				method: 'get', 
				parameters: pars, 
				onComplete: showResponse
			});

	
				
	}

	function showResponse(originalRequest)
	{
	
		document.getElementById("aaa").innerHTML = originalRequest.responseText;
        
	}


</SCRIPT>


</head>

<body topmargin="0" marginheight="0">
<iframe name="exeFrame" id="exeFrame" widht="0" height="0"></iframe>
<div id="aaa" style="position:absolute;left:1;top:1;width:500px;"></div>
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td>
        <b class="text07"> ���� ���� &nbsp;&nbsp; ��  ���� ����Ʈ  
	      </b>
    </td>
</tr>
</table>    
<div style="height:10px;"></div>

<iframe src="Betting_Money.asp" width="100%" height="50" frameborder="0"></iframe>
<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="get" action="Betting_List.asp">
<tr><td>�������� :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" value="<%=Left(sStartDate,12)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>�������� :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" value="<%=Left(sEndDate,12)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="iu_nickname" <%if Search = "iu_nickname" then Response.Write "selected"%>>�г���</option>
		<option value="IB_ID" <%if Search = "IB_ID" then Response.Write "selected"%>>���̵�</option>
		<option value="IG_TEAM" <%if Search = "IG_TEAM" then Response.Write "selected"%>>����</option>
		<option value="IB_TYPE" <%if Search = "IB_TYPE" then Response.Write "selected"%>>���ӱ���</option>
		<option value="IB_CNT" <%if Search = "IB_CNT" then Response.Write "selected"%>>������</option>
		<option value="IB_SITE" <%if Search = "IB_SITE" then Response.Write "selected"%>>����Ʈ��</option>
		</select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="3" height="1"></td>
	<td>�ݾ�</td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="IB_AMOUNT" size="20" maxlength="30" value="<%=reqIB_AMOUNT%>" class="input"></td>	
			
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="�� ��" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><%IF request.Cookies("AdminLevel") = 1 THEN %><input type="button" value="��������" onclick="location.href='Betting_List_Excel.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=<%=Search%>&Find=<%=Find%>';" style="border: 1 solid; background-color: #C5BEBD;" id=button1 name=button2><% END IF %></td></tr></form></table>

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
	<td align="center" width="120"><b>���ýð�</b></td>		
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
	<td align="center">
	<div onclick="ajaxRequestBet(<%=IB_Idx%>,event)" style="cursor:pointer"><%=IB_Idx%></div>
	</td>
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
                
                IF IB_Num = 1 Then
                    bgShape = "��"
                ElseIF IB_Num = 2 Then
                    bgShape = "��"
                ElseIF IB_Num = 0 Then
                    bgShape = "��"
                End IF
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
				
                IF arr_IB_Num(i) = 1 Then
                    bgShape = "��"
                ElseIF arr_IB_Num(i) = 2 Then
                    bgShape = "��"
                ElseIF arr_IB_Num(i) = 0 Then
                    bgShape = "��"
                End IF
                				
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
	<td align="center"><!-- <a href="javascript:goMyBetDetail(<%=IB_Idx%>,<%=Page%>,<%=total%>);">�󼼺���</a> -->
	<a href="Betting_Detail.asp?IB_Idx=<%=IB_Idx%>&page=<%=Page%>&sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=<%=Search%>&Find=<%=Find%>">�󼼺���</a><br />
	<a href="javascript:goDetail(<%=IB_Idx%>, <%= GameCnt %>);">�ٷκ���</a>
	</td><td align="center">
	<!--<a href="http://111.68.3.5:8088/member/MyBet_Pop.asp?IB_ID=<%= IB_ID %>&IU_ID=dlseprtm!@~" target="_blank">ȸ�����ó�������</a>-->
	
	<%IF request.Cookies("AdminLevel") = 1 THEN %><input type="button" value="���" style="border:1px solid;height:16px;" onclick="goBatdel(<%=IB_Idx%>);"><% ELSE %>�Ұ�<% END IF %></td>
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

