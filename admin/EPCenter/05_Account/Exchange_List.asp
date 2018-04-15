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
	PGSIZE = 10
    sStartDate  = REQUEST("sStartDate")
    sEndDate = REQUEST("sEndDate")
    Search = REQUEST("Search")
	Find = REQUEST("Find")    
	site = request.Cookies("JOBSITE")'REQUEST("JOBSITE")
	
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### ���� ������ ������                 ################	
   
	Call dfAccountSql.RetrieveExchange_List(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site)
    
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
<title></title>
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
			alert("ȯ�� ó���� ������ ������ �ּ���."); 
			return;
		} 
		
		if (!confirm("ȯ�� ó���Ͻðڽ��ϱ�?")) return;		
		form.action = "Exchange_Regist.asp?page=<%=PAGE%>&sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=<%=Search%>&Find=<%=Find%>";
		form.target = "HiddenFrm";
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
		form.action = "Exchange_Regist2.asp?page=<%=PAGE%>&sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=<%=Search%>&Find=<%=Find%>";
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
			alert("ȯ�� ����� ������ ������ �ּ���."); 
			return;
		} 
		
		if (!confirm("ȯ�� ���ó���� �Ǹ� ����ڿ��� �Ա�ó�� �˴ϴ�.\n���� ��� ó���Ͻðڽ��ϱ�?")) return;		
		form.action = "Exchange_Regist3.asp?page=<%=PAGE%>&sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=<%=Search%>&Find=<%=Find%>";
		form.target = "HiddenFrm";
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
		
		if (!confirm("ȯ�� ������ �����ϸ� �������� �Ӵϰ� �ѹ�����ʰ�\n���꿡���� �������� ������ \nȯ���������� �����˴ϴ�.\n�������� ȯ���� ����Ͻ÷��� ȯ����� ����� ������ּ��� \n��������� ��� ������ ȯ������ �α׿��� Ȯ���� �����մϴ�\n�������� �Ͻðڽ��ϱ�?")) return;		
		form.action = "Exchange_Delete.asp?page=<%=PAGE%>&sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=<%=Search%>&Find=<%=Find%>";
		form.target = "HiddenFrm";
		form.submit();
	}
	
	function showhide(objID)
	{
	    if(document.getElementById(objID).style.display == "none")
	    {
	        document.getElementById(objID).style.display = "block" ;
        }	        
        else
        {
            document.getElementById(objID).style.display = "none" ;
        }	        
	    
	}
</SCRIPT></head>

<body topmargin="0" marginheight="0">

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> ȯ������</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="post" action="Exchange_List.asp">
<tr><td>�������� :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" value="<%=Left(sStartDate,12)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>�������� :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" value="<%=Left(sEndDate,12)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">	
		<option value="A.IE_NICKNAME" <%if Search = "A.IE_NICKNAME" then Response.Write "selected"%>>�г���</option>
		<option value="A.IE_ID" <%if Search = "A.IE_ID" then Response.Write "selected"%>>���̵�</option>
		<option value="B.IU_BankOwner" <%if Search = "B.IU_BankOwner" then Response.Write "selected"%>>�Ա����̸�</option>
		</select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="�� ��"></td>
	<!--
	<td><img src="blank.gif" border="0" width="10" height="1"></td>
	<td><input type="button" value="��������" onclick="location.href='BankAccount_Excel2.asp?Search=<%=Search%>&Find=<%=Find%>&sStartDate=<%=sStartDate%>&sEndDate=<%=sEndDate%>';" style="border: 1 solid; background-color: #C5BEBD;" id=button1 name=button2></td> --></tr></form></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>
<%IF request.Cookies("AdminLevel") = 1 THEN %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td width="40%">
	<input type="button" value="ȯ�� ó��" onclick="javascript:go_regist(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;" id=button4 name=button1>
	<input type="button" value="��� ó��" onclick="javascript:go_regist2(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;" id=button5 name=button2>
	<input type="button" value="ȯ�� ���" onclick="javascript:go_regist3(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;" id=button6 name=button3></td>
	<td align="right" width="40%"><input type="reset" value=" �� �� " onclick="javascript:go_delete(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;" id=reset2 name=reset1></td></tr></table>
<% END IF %>
<table border="0"  cellspacing="1" cellpadding="1" bgcolor="#AAAAAA" width="100%">
<form name="frm1" method="post">
<tr><td align="center" height="25" bgcolor="e7e7e7"><b><%IF request.Cookies("AdminLevel") = 1 THEN %><input type="button" value="���" onclick="javascript:go_regist2(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;" id=button2 name=button2><% END IF %></b></td>
	<td align="center" bgcolor="e7e7e7"><b>���̵�</b></td>
	<td align="center" bgcolor="e7e7e7"><b>��û��</b></td>
	<td align="center" bgcolor="e7e7e7"><b>ȯ����û�ݾ�</b></td>	
	<td align="center" bgcolor="e7e7e7"><b>������</b></td>	
	<td align="center" bgcolor="e7e7e7"><b>����</b></td>
	<td align="center" bgcolor="e7e7e7"><b>���¹�ȣ</b></td>    
	<td align="center" bgcolor="e7e7e7"><b>����Ʈ</b></td>
	<td align="center" bgcolor="e7e7e7"><b>����</b></td>
	<td align="center" bgcolor="e7e7e7"><b>ȸ��</b></td>
	<td align="center" bgcolor="e7e7e7"><b>����</b></td>
	<td align="center" bgcolor="e7e7e7"><b>�Ӵ�</b></td>
	<td align="center" bgcolor="e7e7e7"><b>��ϳ�¥</b></td>
	<td align="center" bgcolor="e7e7e7"><b>ó����¥</b></td>	
</tr>

<%	IF dfAccountSql.RsCount = 0 THEN	%>
<tr bgcolor="#FFFFFF" height="25"><td align="center" colspan="112" height="35">���� ��ϵ� �Աݽ�û ������ �����ϴ�.</td></tr>

<%
	ELSE

	FOR i = 0 TO dfAccountSql.RsCount -1


		IE_Idx = dfAccountSql.Rs(i,"IE_Idx")
		IE_ID = dfAccountSql.Rs(i,"IE_ID")
		IE_NickName = dfAccountSql.Rs(i,"IE_NickName")
		IE_Amount = dfAccountSql.Rs(i,"IE_Amount")
		IU_BankName = dfAccountSql.Rs(i,"IU_BankName")
		IU_BankNum = dfAccountSql.Rs(i,"IU_BankNum")
		IU_BankOwner = dfAccountSql.Rs(i,"IU_BankOwner")
		IE_RegDate = dfAccountSql.Rs(i,"IE_REGDATE")
		IE_SetDate = dfAccountSql.Rs(i,"IE_SetDate")
		IE_Status = dfAccountSql.Rs(i,"IE_Status")
		IE_SITE = dfAccountSql.Rs(i,"IE_SITE")
		IU_IDX = dfAccountSql.Rs(i,"IU_IDX")
        
		IF IE_Status = "1" THEN
			FlagName = "�Ϸ�"
		ELSEIF IE_Status = "0" THEN
			FlagName = "<font color='red'>��û</font>"
		ELSEIF IE_Status = "2" THEN
			FlagName = "<font color='blue'>���</font>"
		ELSEIF IE_Status = "3" THEN
			FlagName = "<font color='blue'>���</font>"
		END IF
		
        IF IE_SetDate <> "" Then
            IE_SetDate = dfStringUtil.GetFullDate(IE_SetDate)
        End IF            		
%>

<tr <% IF IE_Status <> "1" then Response.Write "bgcolor='#f2f8f9'" Else Response.Write "bgcolor='#FFFFFF'" End IF %>>
	<td align="center"><input type="checkbox" name="SelUser" value="<%=IE_Idx%>"></td>
	<td align="center"><b><a href="/EPCenter/02_Member/View.asp?IU_IDX=<%=IU_IDX%>&IU_SITE=<%=IE_SITE%>"><%=IE_ID%></a></b></td>
	<td align="center"><b><a href="/EPCenter/04_Game/Betting_List.asp?Search=IB_ID&Find=<%=IE_ID%>"><%=IE_NickName%></a></b></td>
	<td align="right"><b style="color:red"><%=formatnumber(IE_Amount,0)%></b> ��</td>
	<td align="center"><a href="/EPCenter/05_Account/Exchange_List.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=B.IU_BankOwner&Find=<%=IU_BankOwner%>"><%=IU_BankOwner%></a></td>
	<td>
	<%= IU_BankName %>
	</td>
	<td align="right">
	    <b onmouseover="showhide('bankInfo_<%= i %>');" onmouseout="showhide('bankInfo_<%= i %>');"><font color="blue"><%= Left(IU_BankNum,4) %>&nbsp;
	    <font color="red"><%= Mid(IU_BankNum,5,4) %></font>&nbsp;
	    <%= Mid(IU_BankNum,9,Len(IU_BankNum)-8) %></font></b>
	    
	    

	        <div style="position:absolute;width:400px;height:100px;background:#ffffff;display:none;" id="bankInfo_<%= i %>">
	            <b>
	            <font color="blue" size="7">
	                <%= Left(IU_BankNum,4) %>&nbsp;
	                <font color="red" size="7"><%= Mid(IU_BankNum,5,4) %></font>&nbsp;
	                <%= Mid(IU_BankNum,9,Len(IU_BankNum)-8) %>
	            </font>
	            </b>	        

	    </div>
	</td>	
	<td align='center'>
        <a href="/EPCenter/05_Account/Exchange_List.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=A.IE_SITE&Find=<%=IE_SITE%>"><%=IE_SITE%></a></td>
	<td align="center"><%=FlagName%></td>
	<td align="center"><input type="button" value="����" style="cursor:hand;" class="input" onclick="window.open('/EPCenter/02_Member/View.asp?IU_IDX=<%=IU_IDX%>');"></td>
	<td align="center"><input type="button" value="����" style="cursor:hand;" class="input" onclick="window.open('/EPCenter/04_Game/Betting_List1.asp?Search=IB_ID&Find=<%=IE_ID%>');"></td>
    <td align="center"><input type="button" value="�Ӵ�" style="cursor:hand;" class="input" onclick="window.open('/EPCenter/05_Account/Money_AddSub.asp?sStartDate=&sEndDate=&Search=LC_ID&Find=<%=IE_ID%>');"></td>	
	<td align="center"><%=dfStringUtil.GetFullDate(IE_RegDate)%></td>
	<td align="center">
	<%=IE_SetDate%>
	</td>
	
</tr>

	<%  
		Next %>
		
	<% END IF %></table><br clear="all">


<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>


<%IF request.Cookies("AdminLevel") = 1 THEN %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td width="40%">
	<input type="button" value="ȯ�� ó��" onclick="javascript:go_regist(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;" id=button1 name=button1>
	<input type="button" value="��� ó��" onclick="javascript:go_regist2(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;" id=button2 name=button2>
	<input type="button" value="ȯ�� ���" onclick="javascript:go_regist3(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;" id=button3 name=button3></td>
	<td align="right" width="40%"><input type="reset" value=" �� �� " onclick="javascript:go_delete(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;" id=reset1 name=reset1></td></tr></table>
<% END IF %>
</form>
</body>
</html>
