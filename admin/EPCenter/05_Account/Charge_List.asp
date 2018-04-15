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
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
    
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999)
	pageSize = 100
    sStartDate  = REQUEST("sStartDate")
    sEndDate = REQUEST("sEndDate")
    Search = REQUEST("Search")
	Find = REQUEST("Find")
	site = request.Cookies("JOBSITE")'REQUEST("JOBSITE")
	


    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### ���� ������ ������                 ################	
   
	Call dfAccountSql.RetrieveCharge_List(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site)
    'dfAccountSql.debug
	IF dfAccountSql.RsCount <> 0 Then
	    nTotalCnt = dfAccountSql.RsOne("TC")
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
	objPager.PageButtonCount = 10
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
<title>�� ������ �ƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢ�</title>
<!-- #include virtual="/Inc_Month.asp"-->
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">

<SCRIPT LANGUAGE="JavaScript">
	function go_regist(form)
	{
		var v_cnt = 0;
		var v_data = "";
		
		for( var i=0; i<form.elements.length; i++) 
		{
			var ele = form.elements[i];
			if( (ele.name=="SelUser") && (ele.checked) )
			{ 
				if (v_data.length==0)
					v_data = ele.value;
				else
					v_data = v_data + "," + ele.value; 
				v_cnt = v_cnt + 1; 
			} 
		}
			
		if (v_cnt == 0)
		{ 
			alert("�Ա� ó���� ������ ������ �ּ���."); 
			return;
		} 
		
		if (!confirm("�Ա�ó���� �Ǹ� ����� ĳ���� ������ �̷����ϴ�.\n���� �Ա� ó���Ͻðڽ��ϱ�?")) return;		
		form.action = "Charge_Regists.asp?page=<%=PAGE%>&sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=<%=Search%>&Find=<%=Find%>";
		//form.target = "HiddenFrm";
		form.submit();
	}

	function go_regist2(form)
	{
		var v_cnt = 0;
		var v_data = "";
		
		for( var i=0; i<form.elements.length; i++) 
		{
			var ele = form.elements[i];
			if( (ele.name=="SelUser") && (ele.checked) )
			{ 
				if (v_data.length==0)
					v_data = ele.value;
				else
					v_data = v_data + "," + ele.value; 
				v_cnt = v_cnt + 1; 
			} 
		}
			
		if (v_cnt == 0)
		{ 
			alert("��� ó���� ������ ������ �ּ���."); 
			return;
		} 
		
		if (!confirm("���ó���� �Ǹ� ��û�˶��� �︮�� �ʽ��ϴ�..\n���� ��� ó���Ͻðڽ��ϱ�?")) return;		
		form.action = "Charge_Regists2.asp?page=<%=PAGE%>&sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=<%=Search%>&Find=<%=Find%>";
		form.target = "HiddenFrm";
		form.submit();
	}
	
	function go_regist3(form)
	{
		var v_cnt = 0;
		var v_data = "";
		
		for( var i=0; i<form.elements.length; i++) 
		{
			var ele = form.elements[i];
			if( (ele.name=="SelUser") && (ele.checked) )
			{ 
				if (v_data.length==0)
					v_data = ele.value;
				else
					v_data = v_data + "," + ele.value; 
				v_cnt = v_cnt + 1; 
			} 
		}
			
		if (v_cnt == 0)
		{ 
			alert("�Ա� ó���� ������ ������ �ּ���."); 
			return;
		} 
		
		if (!confirm("�Ա���Ұ� �Ǹ� ����� ĳ���� �����˴ϴ�.\n���� �Ա� ����Ͻðڽ��ϱ�?")) return;		
		form.action = "Charge_Regists3.asp?page=<%=PAGE%>&sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=<%=Search%>&Find=<%=Find%>";
		//form.target = "HiddenFrm";
		form.submit();
	}
		
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
		
		if (!confirm("���� �����Ͻðڽ��ϱ�?")) return;		
		form.action = "Charge_Delete.asp?page=<%=PAGE%>&sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=<%=Search%>&Find=<%=Find%>";
		form.target = "HiddenFrm";
		form.submit();
	}
	
	// ��� üũ�ڽ� on/off
	function AllChk() {
		var chkAll = document.frm1.chkAll;
		var cbox = document.frm1.SelUser;
		if (cbox.length) {
			for(var i=0; i<cbox.length; i++) {
				cbox[i].checked = chkAll.checked;
			}
		}
		else {
			cbox.checked = chkAll.checked;
		}
	}
function setBonusCash(IC_Idx, per)		
    {
        var rtn = parseInt(document.getElementById("IC_Amount"+IC_Idx).value.replace(/,/gi,""),10)*(per);   
        //alert(document.getElementById("IC_Amount"+IC_Idx).value.replace(/,/gi,""));  

        document.getElementById("SelUser"+IC_Idx).checked =true;
        document.getElementById("IC_BONUS_AMOUNT"+IC_Idx).value = parseInt(rtn,10);
    }		
	function setAllReady()
	{
	    top.HiddenFrm.location.href = "Charge_Regists4.asp"
	}    
	
	function changeAdmin(IC_Idx)
	{
	    IAN_CHARGE = document.getElementById("IAN_CHARGE"+IC_Idx).value ; 
	    location.href = "changeAdmin.asp?mode=1&IAN_CHARGE=" + IAN_CHARGE ; 
	}
</SCRIPT>
</head>

<body topmargin="0" marginheight="0">

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> ���� ����</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="post" action="Charge_List.asp">
<tr><td>�������� :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" value="<%=Left(sStartDate,10)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>�������� :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" value="<%=Left(sEndDate,10)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
	    <option value="IU_NICKNAME" <%if Search = "IU_NICKNAME" then Response.Write "selected"%>>�г���</option>
		<option value="IC_ID" <%if Search = "IC_ID" then Response.Write "selected"%>>����ھ��̵�</option>		
		<option value="IC_NAME" <%if Search = "IC_NAME" then Response.Write "selected"%>>�Ա����̸�</option>
		<option value="IC_SITE" <%if Search = "IC_SITE" then Response.Write "selected"%>>����Ʈ��</option>
		<option value="IU_LEVEL" <%if Search = "IU_LEVEL" then Response.Write "selected"%>>����</option>
		<option value="IC_STATUS" <%if Search = "IC_STATUS" then Response.Write "selected"%>>����</option>
		</select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="�� ��"> ���°� : 1 (�Ϸ�) / 2 (���)</td>
	<!--
	<td><img src="blank.gif" border="0" width="10" height="1"></td>
	<td><input type="button" value="��������" onclick="location.href='BankAccount_Excel2.asp?Search=<%=Search%>&Find=<%=Find%>&sStartDate=<%=sStartDate%>&sEndDate=<%=sEndDate%>';" style="border: 1 solid; background-color: #C5BEBD;" id=button1 name=button2></td> --></tr></form></table>
<%IF request.Cookies("AdminLevel") = 1 THEN %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td width="30%">
	<input type="button" value="  �Ա� ó��  " onclick="javascript:go_regist(document.frm1);" style="border: 1 solid; background-color: skyblue;" id=button3 name=button1>			
	<input type="button" value="��� ó��" onclick="javascript:go_regist2(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;" id=button4 name=button2>	
	<input type="button" value="��ü ��� ó��" onclick="javascript:setAllReady();" style="border: 1 solid; background-color: #C5BEBD;" id=button8 name=button2>
	</td>

	<td align="right" width="40%">	
	<input type="reset" value=" �� �� " onclick="javascript:go_delete(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;" id=reset2 name=reset1></td></tr></table>
<% END IF %>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0"  cellspacing="1" cellpadding="1" bgcolor="#AAAAAA" width="100%">
<form name="frm1" method="post">
<tr bgcolor="e7e7e7" >
    <td align="center" height="25"  width="30">
        <input type="Checkbox" name="chkAll" onclick="AllChk();">
    </td>
    <td align="center"><b>Lv</b></td>
	<td align="center"><b>���̵�</b></td>
	<td align="center"><b>�Ա���</b></td>
	<td align="center"><b>�Աݱݾ�</b></td>
	<td align="center"><b>���ʽ�</b></td>
	<td align="center"><b>��ϳ�¥</b></td>
	<td align="center"><b>ó����¥</b></td>
	<td align="center"><b>����Ʈ</b></td>
	<td align="center"><b>����</b></td>
	<td align="center"><b>ȸ��</b></td>	

	</tr>

<%	IF dfAccountSql.RsCount = 0 THEN	%>
<tr bgcolor="#FFFFFF" height="25"><td align="center" colspan="9" >���� ��ϵ� �Աݽ�û ������ �����ϴ�.</td></tr>

<%
	ELSE
    IC_ADMIN = ""
	FOR i = 0 TO dfAccountSql.RsCount -1

		IC_Idx = dfAccountSql.Rs(i,"IC_IDX")
		IC_ID = dfAccountSql.Rs(i,"IC_ID")
		IC_Name = dfAccountSql.Rs(i,"IC_NAME")
		IC_Amount = dfAccountSql.Rs(i,"IC_AMOUNT")
		IC_RegDate = dfAccountSql.Rs(i,"IC_REGDATE")
		IC_SetDate = dfAccountSql.Rs(i,"IC_SETDATE")
		IC_Status = dfAccountSql.Rs(i,"IC_STATUS")
		IC_SITE	= dfAccountSql.Rs(i,"IC_SITE")
		IU_NICKNAME = dfAccountSql.Rs(i,"IU_NICKNAME")
		IC_T_YN = dfAccountSql.Rs(i,"IC_T_YN")
        IU_IDX = dfAccountSql.Rs(i,"IU_IDX")
        IC_BONUS_AMOUNT  = dfAccountSql.Rs(i,"IC_BONUS_AMOUNT")
        IU_M_CHECK  = dfAccountSql.Rs(i,"IU_M_CHECK")
        MAX_SETDATE  = dfAccountSql.Rs(i,"MAX_SETDATE")
        IU_REGDATE  = dfAccountSql.Rs(i,"IU_REGDATE")
        IC_ADMIN  = dfAccountSql.Rs(i,"IC_ADMIN")
        IU_LEVEL  = dfAccountSql.Rs(i,"IU_LEVEL")
        
        
        tdBunusStyle = "style=background:#ffffff"
        percentage = 0
        avgAmount = 0	    
	    'IF IC_Status = "0" OR IC_Status = "2" Then
            strSQL = "select isNull(sum(Percentage),0), isNull(avg(sumAmount/Cnt),0), isNull(sum(Cnt),0)  from ( " &_
            " select ib_cnt , count(*) as Cnt,  sum(ib_amount) as sumAmount    " &_
            " , Percentage = convert(DECIMAL(5,1),convert(MONEY,100.0 * count(*) /     " &_
            "       (SELECT count(*) FROM   info_betting where ib_id = a.ib_id and ib_site <> 'None')) )     " &_
            "  from info_betting a where ib_site <> 'None' and ib_id = '"&IC_ID&"'    " &_
            " group by ib_cnt , ib_id        " &_
            " ) as bb " &_
            " where ib_cnt <=2"
            
            SET RS1 = DbCon.Execute(strSQL)             
		    IF NOT RS1.Eof Then            
                percentage = rs1(0)
                avgAmount = rs1(1)  
                sumCnt = rs1(2)  
                
                IF avgAmount = "" OR isNull(avgAmount) Then avgAmount = 1
                IF sumCnt = "" OR isNull(sumCnt) Then sumCnt = 1
                                                
                IF cDbl(percentage) >= cDbl(50) And cDbl(avgAmount) >= cDbl(400000) Then
                    tdBunusStyle = "style=background:C2FB9F"
                Else
                    tdBunusStyle = "style=background:#ffffff"                
                End IF                                      
                
                IF tdBunusStyle = "style=background:#ffffff" And cDbl(percentage) >= cDbl(70) And cDbl(avgAmount) >= cDbl(100000) Then
                    tdBunusStyle = "style=background:FEB3B3"
                End IF    
                
                IF sumCnt <= 3 Then
                    tdBunusStyle = "style=background:ffffff"
                End IF                
            End IF	
                                    
        'End IF           
        IF IU_LEVEL =5 OR IU_LEVEL=6 Then 
            tdBunusStyle = "style=background:yellow"
        End IF            
        
        IF IC_SetDate <> "" Then
            IC_SetDate = dfStringUtil.GetFullDate(IC_SetDate)
        End IF          
        
        IF IC_BONUS_AMOUNT <> "" Then
            IC_BONUS_AMOUNT = formatnumber(IC_BONUS_AMOUNT,0)
        Else
            IC_BONUS_AMOUNT = 0
        End IF
		IF IC_Status = "1" THEN
			FlagName = "�Ϸ�"			
			trFlagName = "bgcolor='#ffffff'"
		ELSEIF IC_Status = "0" then
			FlagName = "<font color='red'>��û</font>"
			If cStr(IU_M_CHECK) = "1" Then
			    trFlagName = "bgcolor='#FFA1A1'"
			Else
			    trFlagName = "bgcolor='#FBE79A'"
			End IF
		ELSEIF IC_Status = "2" then
			FlagName = "<font color='blue'>���</font>"
            If cStr(IU_M_CHECK) = "1" Then
			    trFlagName = "bgcolor='#FFA1A1'"
			Else
			    trFlagName = "bgcolor='#B7D1FC'"
			End IF			
			
		END IF
		
		tdBgColor = "" 
		
		'1 3��° ���� �������
		'IF IC_Status = "0" OR IC_Status = "2" then
        IF IC_Status = "0"then		
		    IF cDate(MAX_SETDATE) <  cDate(date() & " 00:00") Then
		        tdBgColor = "bgcolor=yellow"
		    End IF
		End if	
		
        df = datediff("m",Cdate(IU_REGDATE),now())
        
		IF df <= 2 AND IC_Amount >= 500000 Then
		    btnNewMemCheck = "style=background:#FF0000;color:#ffffff"
		    tdNewMemCheck = "style=background:#FF0000;color:#ffffff"
		Else
		    btnNewMemCheck = "style=background:#CCCCCC"
		    tdNewMemCheck = ""
		End IF
		
		
		IF IC_ADMIN <> IC_ADMIN1 Then
		    IF tdAdminStyle = "style=background:#FF9999" Then
		        tdAdminStyle = "style=background:#99FF99"
            Else
                tdAdminStyle = "style=background:#FF9999"
            End IF		        
		End IF
		IF IC_ADMIN = "" Then
		    tdAdminStyle = "style=background:#ffffff"
		End IF
		
		
		
%>

<tr <%= trFlagName %> height="25" >
	<td align="center"<% if IC_T_YN <> "N" then Response.Write "bgcolor='#b6b6b6'"%>><input type="checkbox" name="SelUser" id="SelUser<%=IC_Idx%>" value="<%=IC_Idx%>"><% if IC_T_YN <> "N" then %>&nbsp;���ǹ���<% End If %>	
	</td>
	<td align="center"><%=IU_LEVEL%></td>

<td align='center'>
	<b><a href="/EPCenter/05_Account/Charge_List.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=IC_ID&Find=<%=IC_ID%>"><%=IC_ID%>&nbsp;(<%=IU_NICKNAME%>)</a></b></td>
	<td align="center"><a href="/EPCenter/05_Account/Charge_List.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=IC_NAME&Find=<%=IC_Name%>"><%=IC_Name%></a></td>
	<td align="right" <%= tdBgColor %>>	    
	    <input type="text" name="IC_Amount<%=IC_Idx%>" value="<%=formatnumber(IC_Amount,0)%>" class="input" size="9" style="color:red;"/> �� 	    
	</td>
	<td align="right" <%= tdBunusStyle %>>
	    
	<%= percentage %>%
	<%
	    IF avgAmount > 10000 Then
	        avgAmount = formatnumber(avgAmount/10000,0)
	        response.Write avgAmount & "��"
	    Else
	        response.Write "�̸�"
	    End IF
	%>
		    
	    <input type="button" value="3%" class="input" onclick="setBonusCash(<%=IC_Idx%>, 0.03)" />
	    <input type="button" value="5%" class="input" onclick="setBonusCash(<%=IC_Idx%>, 0.05)" />
	    <input type="button" value="7%" class="input" onclick="setBonusCash(<%=IC_Idx%>, 0.07)" />
	    <input type="text" name="IC_BONUS_AMOUNT<%=IC_Idx%>" id="IC_BONUS_AMOUNT<%=IC_Idx%>" value="<%=formatnumber(IC_BONUS_AMOUNT,0)%>" class="input" size="9" /> �� 	    
	</td>
	<td align="center"><%= dfStringUtil.GetFullDate(IC_RegDate)%>&nbsp;</td>
	<td align="center"><%=IC_SetDate%>&nbsp;</td>
	<td align='center'>
        <a href="/EPCenter/05_Account/Charge_List.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=IC_SITE&Find=<%=IC_SITE%>"><%=IC_SITE%></a>
    </td>
	<td align="center"><%=FlagName%></td>
	<td align="center" <%= tdNewMemCheck %>>
	    <input type="button" value="����" class="input" <%= btnNewMemCheck %> onclick="window.open('/EPCenter/02_Member/View.asp?IU_IDX=<%=IU_IDX%>');" />
	    
	</td>

	</tr>

	<%  
	        IC_ADMIN1 = IC_ADMIN
		Next
	%>
		
	<% END IF %></table><br clear="all">

<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>



<%IF request.Cookies("AdminLevel") = 1 THEN %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td width="40%">
	<input type="button" value="�Ա� ó��" onclick="javascript:go_regist(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;" id=button1 name=button1>
	<input type="button" value="��� ó��" onclick="javascript:go_regist2(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;" id=button2 name=button2></td>
	<td align="right" width="40%"><input type="reset" value=" �� �� " onclick="javascript:go_delete(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;" id=reset1 name=reset1></td></tr></table></form>
<% END IF %>
</body>
</html>
