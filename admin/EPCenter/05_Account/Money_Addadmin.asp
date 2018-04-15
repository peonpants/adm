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
	pageSize = 20
	PGSIZE = 10
    sStartDate  = REQUEST("sStartDate")
    sEndDate = REQUEST("sEndDate")
    Search = Trim(REQUEST("Search"))
	Find = Trim(REQUEST("Find"))
	site = request.Cookies("JOBSITE")'REQUEST("JOBSITE")
    
    IF Search = "" Then
        sStartDate = datevalue(now)  & " 00:00:00"
        sEndDate = datevalue(now) & " 23:59:59" 
        pageSize = 10000            
    End IF
    
    
    IF REQUEST("sStartDate") <> "" AND REQUEST("sEndDate") <> "" Then
        sStartDate =  REQUEST("sStartDate") & " 00:00:00"
        sEndDate =  REQUEST("sEndDate") & " 23:59:59"  
        pageSize = 500                  
    End IF
    
    IF (Search = "LAC_ID" And Find <> "") Then
        sStartDate = ""
        sEndDate = ""    
        page        = 1
        pageSize    = 999999
    End IF
    
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	

	'######### ���� ������ ������                 ################	
   
	Call dfAccountSql.RetrieveLog_AdminCashInOut(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site)
    
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
<title>�Ӵϻ��α�</title>
<!-- #include virtual="/Inc_Month.asp"-->
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">

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
			alert("��������� ������ ������ �ּ���."); 
			return;
		} 
		
		if (!confirm("���� ����Ͻðڽ��ϱ�?")) return;		
		form.action = "CashAccount_Cancel.asp?page=<%=PAGE%>";
		form.submit();
	}
</SCRIPT></head>

<body topmargin="0" marginheight="0">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> �������&nbsp;&nbsp;�� ���� ���� ����</b></td>
</tr>
</table>    
<div style="height:10px;"><font color="red"><b>**�������� ���̳ʽ��� ���� �������Ǻ��� ������������ ��������Դϴ�</br>**��ȯ���ݾ��� 0���ΰ��� �Ϻ���ȯ������ ���� �������Դϴ�</b></font></div>

<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="get" action="Money_Addadmin.asp">
<tr><td>�������� :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" value="<%=Left(sStartDate,10)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>�������� :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" value="<%=Left(sEndDate,10)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolo��:#F5E0E0;padding-left:10px" class="input">
		<option value="">---�˻���---</option>
		<option value="IB_IDX" <%if Search = "IB_IDX" then Response.Write "selected"%>>���ù�ȣ</option>
		<option value="LAC_ID" <%if Search = "LAC_ID" then Response.Write "selected"%>>���̵�</option>		
		<option value="LAC_CONTENT" <%if Search = "LAC_CONTENT" then Response.Write "selected"%>>ó������</option>
		<option value="LAC_SITE" <%if Search = "LAC_SITE" then Response.Write "selected"%>>����Ʈ��</option></select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="�� ��"></td>
	</tr></form></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0"  cellspacing="1" cellpadding="2" bgcolor="#AAAAAA" width="100%">
<col width="40" />
<col width="100" />
<col width="60" />
<col width="60" />
<col width="60" />
<col width="60" />
<col width="150" />
<col width="40" />
<col width="70" />
<form name="frm" method="post">
<tr height="25" bgcolor="e7e7e7"> 
	<!-- <td align="center"><b>����</b></td> -->
	<td align="center" ><b>No.</b></td>
	<td align="center" ><b>�������̵�</b></td>	
	<td align="center" ><b>����/ȯ��</b></td>	
	<td align="center" ><b>����/ȯ���ݾ�</b></td>
	<td align="center" ><b>�������ϸ���</b></td>
	<td align="center" ><b>������</b></td>
	<td align="center" ><b>��&nbsp;&nbsp;��</b></td>
	<td align="center" ><b>�����ڵ�</b></td>
	<td align="center" ><b>��¥</b></td>
	
	</tr>

<%	IF dfAccountSql.RsCount = 0 THEN	%>
<tr bgcolor="#FFFFFF" height="25"><td align="center" colspan="8" height="35">���� ��ϵ� ������ �����ϴ�.</td></tr>

<%
	ELSE

	TotCash1 = 0
	TotCash2 = 0
	FOR i = 0 TO dfAccountSql.RsCount -1

		LAC_IDX		= dfAccountSql.Rs(i,"LAC_IDX")
		LAC_ID		= dfAccountSql.Rs(i,"LAC_ID")
		LAC_SITE		= dfAccountSql.Rs(i,"LAC_SITE")
		LAC_CASH	= dfAccountSql.Rs(i,"LAC_CASH")
		LAC_GCASH	= dfAccountSql.Rs(i,"LAC_GCASH")
		LAC_TYPE= dfAccountSql.Rs(i,"LAC_TYPE")
		LAC_CONTENT	= dfAccountSql.Rs(i,"LAC_CONTENT")
		IB_IDX	    = dfAccountSql.Rs(i,"IB_IDX")
		LAC_REGDATE	    = dfAccountSql.Rs(i,"LAC_REGDATE")

		
		TotCash1 = Cdbl(TotCash1) + Cdbl(LAC_CASH)	
		TotCash2 = Cdbl(TotCash2) + Cdbl(IB_IDX)	
		IF LAC_CASH > 0 Then
		    tdCashStyle = "style='color:blue'"
		    plus = "+"
		Else
		    tdCashStyle = "style='color:red'"
		    plus = ""
		End IF
		If IB_IDX = "0" Then
			charge = "<b><font color=black>����</font></b>"
		ElseIf IB_IDX > "0" Then
			charge = "<b><font color=blue>����</font></b>"
		ElseIf IB_IDX < "0" Then
			charge = "<b><font color=red>ȯ��</font></b>"
		End if
%>

<tr bgcolor="#FFFFFF" ><td align="center"><%=LAC_IDX%></td>
	<td>&nbsp;<a href="/EPCenter/05_Account/Money_Addadmin.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=LAC_ID&Find=<%=LAC_ID%>"><%=LAC_ID%></a></td>	
	<td align="center"><%=charge%></td>
	<td align="right"><%=FORMATNUMBER(IB_IDX,0)%>��</td>
	<td align="right"><%=FORMATNUMBER(LAC_CASH,0)%>��</td>
<% If CDbl(LAC_GCASH) > 0 Then %>
	<td align="right" style="color:green;font-weight:bold"><%=FORMATNUMBER(LAC_GCASH,0)%>&nbsp;%</td>
<% Else %>
	<td align="right" style="color:red;font-weight:bold"><%=FORMATNUMBER(LAC_GCASH,0)%>&nbsp;%</td>
<% End If %>
	<td align="center"><a href="/EPCenter/05_Account/Money_Addadmin.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=LAC_CONTENT&Find=<%=replace(replace(replace(replace(replace(LAC_CONTENT, "<font color=red>", ""), "</font>", ""), "<font color=blue>", ""), "<b>", ""), "</b>", "")%>"><%=LAC_CONTENT%></a>&nbsp;</td>	

	<td align='center'><a href="/EPCenter/05_Account/Money_Addadmin.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=LAC_SITE&Find=<%=LAC_SITE%>"><%=LAC_SITE%></a></td>
	<td align="center"><%=dfStringUtil.GetFullDate(LAC_REGDATE)%></td>
	</td>
	</tr>

	<%  
		Next %>

<tr bgcolor="#FFFFFF"><td colspan="3" align="center"><b>�� ��</b></td>
	<td align="right"><b><%=FORMATNUMBER(TotCash2,0)%>&nbsp;��&nbsp;</b></td>
	<td align="right"><b><%=FORMATNUMBER(TotCash1,0)%>&nbsp;��&nbsp;</b></td>
	<td align="right">&nbsp;</td>
	<td colspan="4" align="center">&nbsp;</td></tr>

	<% END IF %></table><br clear="all">

<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>

</body>
</html>
