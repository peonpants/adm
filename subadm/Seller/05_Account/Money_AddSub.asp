<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/Seller/05_Account/_Sql/accountSql.Class.asp"-->
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
    
    IF (Search = "LC_ID" And Find <> "") OR (Search = "IU_NICKNAME" And Find <> "") Then
        sStartDate = ""
        sEndDate = ""    
        page        = 1
        pageSize    = 999999
    End IF
    
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	

	'######### ���� ������ ������                 ################	
   
	Call dfAccountSql.RetrieveLog_CashInOut(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site)
    
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
<link rel="stylesheet" type="text/css" href="/Seller/Css/Style.css">
<link rel="stylesheet" href="../Includes/bootstrap3.3.2.min.css" type="text/css" />          <!-- ��Ʈ��Ʈ��  ----------------->
<link rel="stylesheet" href="../Includes/bootstrap-theme3.3.2.min.css" type="text/css" />    <!-- ��Ʈ��Ʈ�� �߰��׸� ----------------->
<script src="/js/jquery-1.10.2.min.js" type="text/javascript"></script>						<!-- ��Ʈ��Ʈ��  ----------------->
<script src="../Includes/bootstrap3.3.2.min.js" type="text/javascript"></script>			<!-- ��Ʈ��Ʈ��  ----------------->
<link rel="stylesheet" href="../css/HberAdmin_Style.css" type="text/css" />			<!-- ��ڸ޴� ��Ÿ�� �׸�  ----------------->


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

<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="background-color:#ffffff;padding:0px 3px 3px 3px;">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
	<tr>
		<td style="width:100%; background-color:#999999;  padding:5px;"><span style="color:white; font-size:14px;font-weight:bold;" >�������&nbsp;&nbsp;�� Money ����</td>
	</tr>
</table>    
<div style="border:1px solid #f0f0f0">
  

<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="get" action="Money_AddSub.asp">
<tr><td>���� :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" value="<%=Left(sStartDate,10)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>���� :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" value="<%=Left(sEndDate,10)%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolo��:#F5E0E0;padding-left:10px" class="input">
		<option value="">---�˻���---</option>
		<option value="IU_NICKNAME" <%if Search = "IU_NICKNAME" then Response.Write "selected"%>>�г���</option>
		<option value="LC_ID" <%if Search = "LC_ID" then Response.Write "selected"%>>���̵�</option>		
		<option value="LC_CONTENTS" <%if Search = "LC_CONTENTS" then Response.Write "selected"%>>ó������</option>
		<option value="LC_SITE" <%if Search = "LC_SITE" then Response.Write "selected"%>>����Ʈ��</option></select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="�� ��"></td>
	<!--
	<td><img src="blank.gif" border="0" width="10" height="1"></td>
	<td><input type="button" value="��������" onclick="location.href='BankAccount_Excel2.asp?Search=<%=Search%>&Find=<%=Find%>&sStartDate=<%=sStartDate%>&sEndDate=<%=sEndDate%>';" style="border: 1 solid; background-color: #C5BEBD;" id=button1 name=button2></td> --></tr></form></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>


<table border="0"  cellspacing="1" cellpadding="2" bgcolor="#AAAAAA" width="100%" class="trhover HberTh HberTableLG" >



<col width="40" />
<col width="100" />
<col width="80" />
<col width="80" />
<col width="60" />
<col width="150" />
<col width="40" />
<col width="70" />
<form name="frm" method="post">
<tr class="title-backgra">


	<!-- <td align="center"><b>����</b></td> -->
	<td align="center" ><b>No.</b></td>
	<td align="center" ><b>���̵�</b></td>	
	<td align="center" ><b>���Ӵ�</b></td>
	<td align="center" ><b>�����Ӵ�</b></td>
	<td align="center" ><b>��&nbsp;&nbsp;��</b></td>
	<td align="center"><b>���</b></td>
	<td align="center" ><b>����Ʈ</b></td>
	<td align="center" ><b>��¥</b></td>
	
	</tr>

<%	IF dfAccountSql.RsCount = 0 THEN	%>
<tr bgcolor="#FFFFFF" height="25"><td align="center" colspan="8" height="35">���� ��ϵ� ������ �����ϴ�.</td></tr>

<%
	ELSE

	TotCash = 0

	FOR i = 0 TO dfAccountSql.RsCount -1


		LC_IDX		= dfAccountSql.Rs(i,"LC_IDX")
		LC_ID		= dfAccountSql.Rs(i,"LC_ID")
		LC_CASH		= dfAccountSql.Rs(i,"LC_CASH")
		LC_GCASH	= dfAccountSql.Rs(i,"LC_GCASH")
		LC_CONTENTS	= dfAccountSql.Rs(i,"LC_CONTENTS")
		IC_CONTENTS1= dfAccountSql.Rs(i,"IC_CONTENTS1")
		LC_REGDATE	= dfAccountSql.Rs(i,"LC_REGDATE")
		LC_SITE	    = dfAccountSql.Rs(i,"LC_SITE")
		IB_IDX	    = dfAccountSql.Rs(i,"IB_IDX")
		IG_IDX	    = dfAccountSql.Rs(i,"IG_IDX")
		IU_NICKNAME = dfAccountSql.Rs(i,"IU_NICKNAME")
		
		TotCash = Cdbl(TotCash) + Cdbl(LC_CASH)		
		
		IF LC_CASH > 0 Then
		    tdCashStyle = "style='color:blue'"
		    plus = "+"
		Else
		    tdCashStyle = "style='color:red'"
		    plus = ""
		End IF

%>

<tr bgcolor="#FFFFFF" ><td align="center"><%=LC_IDX%></td>
	<td>&nbsp;<a href="/Seller/05_Account/Money_AddSub.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=LC_ID&Find=<%=LC_ID%>"><%=LC_ID%>&nbsp;&nbsp;(<%=IU_NICKNAME%>)</a></td>	
	<td align="right" <%= tdCashStyle %>><%= plus %><%=FORMATNUMBER(LC_CASH,0)%> ��&nbsp;</td>
	<td align="right" style="color:green;font-weight:bold"><%=FORMATNUMBER(LC_GCASH,0)%> ��&nbsp;</td>
	<td align="center"><a href="/Seller/05_Account/Money_AddSub.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=LC_CONTENTS&Find=<%=LC_CONTENTS%>"><%=LC_CONTENTS%></a>&nbsp;</td>	
	<td align="center">
	<% IF IB_IDX <> "" Then %>
	<a href="/Seller/05_Account/Money_AddSub.asp?Search=IB_IDX&Find=<%= IB_IDX %>">���ù�ȣ:</a>
	<a href="/Seller/04_Game1/Betting_List.asp?Search=IB_IDX&Find=<%=IB_IDX %>" target="_blank"><%= IB_IDX %></a> -- 
	<a href="/Seller/05_Account/Money_AddSub.asp?Search=IG_IDX&Find=<%= IG_IDX %>">���ӹ�ȣ</a>:
	<%= IG_IDX  %>
	<% End IF %>
	<% IF IC_CONTENTS1 <> "" Then %>
	<%= IC_CONTENTS1  %>
	<% End IF %>
	<td align='center'><a href="/Seller/05_Account/Money_AddSub.asp?sStartDate=<%=Left(sStartDate,10)%>&sEndDate=<%=Left(sEndDate,10)%>&Search=LC_SITE&Find=<%=LC_SITE%>"><%=LC_SITE%></a></td>
	<td align="center"><%=dfStringUtil.GetFullDate(LC_REGDATE)%></td>
	</td>
	</tr>

	<%  
		Next %>

<tr bgcolor="#FFFFFF"><td colspan="3" align="center"><b>�� ��</b></td>
	<td align="right"><b><%=FORMATNUMBER(TotCash,0)%>&nbsp;��&nbsp;</b></td>
	<td align="right">&nbsp;</td>
	<td colspan="3" align="center">&nbsp;</td></tr>

	<% END IF %></table><br clear="all">

<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>

</body>
</html>