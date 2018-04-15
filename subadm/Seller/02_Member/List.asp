<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/Seller/02_Member/_Sql/memberSql.Class.asp"-->
<%
    
    '######### Request Check                    ################	    

    
    pageSize      = 50             
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
	sStartDate     = Trim(dfRequest.Value("sStartDate"))
	sEndDate       = Trim(dfRequest.Value("sEndDate"))
	Search     = Trim(dfRequest.Value("Search"))
	Find         =  Trim(dfRequest.Value("Find"))
	sortColumn = Trim(dfRequest.Value("sortColumn"))
	
	reqIU_SITE =  Session("rJOBSITE")' 
	IA_SITE = Session("rJOBSITE")
	SQLLIST2 = "select top 1 * from info_admin where ia_site = '"&Session("rJOBSITE")&"'"
	SET RS2 = DBCON.EXECUTE(SQLLIST2)

	IA_LEVEL = RS2("IA_LEVEL")
	IA_GROUP = RS2("IA_GROUP")
	IA_GROUP1 = RS2("IA_GROUP1")
	IA_GROUP2 = RS2("IA_GROUP2")
	IA_GROUP3 = RS2("IA_GROUP3")
	IA_GROUP4 = RS2("IA_GROUP4")
	IA_Type = RS2("IA_Type")
	RS2.CLOSE
	SET RS2 = Nothing
	sortDirection = Trim(dfRequest.Value("sortDirection"))
	IF sortDirection = "" Then
	    sortDirection ="DESC"  
	End IF 

   'dfRequest.debug
   'response.end
	
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
    '######### �� ȸ����              ################	
    Dim dfmemberSql1
    Set dfmemberSql1 = new memberSql
		
	'######### ȸ�� ����Ʈ�� �ҷ���                 ################	

	If IA_LEVEL = "2" THEN
		Call dfmemberSql.RetrieveINFO_USER(dfDBConn.Conn,  page, pageSize, sortColumn, sortDirection, Search, Find, sStartDate, sEndDate, reqIU_SITE, IA_GROUP, IA_GROUP1, IA_LEVEL)
	ELSEIf IA_LEVEL = "3" Then
		Call dfmemberSql.RetrieveINFO_USERs1(dfDBConn.Conn,  page, pageSize, sortColumn, sortDirection, Search, Find, sStartDate, sEndDate, reqIU_SITE, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_LEVEL)
	ELSEIf IA_LEVEL = "4" Then
		Call dfmemberSql.RetrieveINFO_USERs2(dfDBConn.Conn,  page, pageSize, sortColumn, sortDirection, Search, Find, sStartDate, sEndDate, reqIU_SITE, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_LEVEL)
	ELSEIf IA_LEVEL = "5" Then
		Call dfmemberSql.RetrieveINFO_USERs3(dfDBConn.Conn,  page, pageSize, sortColumn, sortDirection, Search, Find, sStartDate, sEndDate, reqIU_SITE, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4, IA_LEVEL)
	End If
	
    'dfmemberSql.debug
	IF dfMemberSql.RsCount <> 0 Then
	    nTotalCnt = dfMemberSql.RsOne("TC")
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
		
    sortimg_cash = ""		
    sortimg_point = ""
    sortimg_date = ""
    sortimg_incash = ""
    sortimg_outcash = ""
    sortimg_login = ""
    sorting_cashinout = ""
    
    IF sortDirection ="DESC" Then
        sortDirection1 ="ASC"
        sortimg = "��"
    Else
        sortDirection1 ="DESC"        
        sortimg = "��"
    End IF	  
    
    if sortColumn = "IU_CASH" Then sortimg_cash = sortimg
    if sortColumn = "IU_POINT" Then sortimg_point = sortimg    
    if sortColumn = "IU_CHARGE" Then sortimg_incash = sortimg
    if sortColumn = "IU_EXCHANGE" Then sortimg_outcash = sortimg
    if sortColumn = "IU_REGDATE" Then sortimg_date = sortimg
    if sortColumn = "IU_LOGIN_CNT" Then sortimg_login = sortimg
    if sortColumn = "IU_CASHINOUT" Then sorting_cashinout = sortimg

%>

<html>
<head>
<title></title>
  <script type="text/javascript" src="../includes/calendar1.js"></script>
  <script type="text/javascript" src="../includes/calendar2.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/Seller/Css/Style.css">

<link rel="stylesheet" href="../Includes/bootstrap3.3.2.min.css" type="text/css" />          <!-- ��Ʈ��Ʈ��  ----------------->
<link rel="stylesheet" href="../Includes/bootstrap-theme3.3.2.min.css" type="text/css" />    <!-- ��Ʈ��Ʈ�� �߰��׸� ----------------->
<script src="/js/jquery-1.10.2.min.js" type="text/javascript"></script>						<!-- ��Ʈ��Ʈ��  ----------------->
<script src="../Includes/bootstrap3.3.2.min.js" type="text/javascript"></script>			<!-- ��Ʈ��Ʈ��  ----------------->
<link rel="stylesheet" href="../css/HberAdmin_Style.css" type="text/css" />			<!-- ��ڸ޴� ��Ÿ�� �׸�  ----------------->

<SCRIPT LANGUAGE="JavaScript">   
    
	function go_update(form,st)
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
		form.action = "Update.asp?page=<%=Page%>&IU_Status="+st+"&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>";
		form.submit();
	}
    function go_update1(IU_IDX, st)
    {
        if (!confirm("���� �����Ͻðڽ��ϱ�?")) return;	
        location.href = "Update.asp?page=<%=Page%>&IU_IDX="+IU_IDX+"&IU_Status="+st+"&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>";
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
			alert("�������� ó���� ȸ���� ������ �ּ���."); 
			return;
		} 
		
		if (!confirm("��������ó���� �Ǹ� �ٽ� �����Ͻ� �� �����ϴ�. ���� ���� ó���Ͻðڽ��ϱ�?")) return;		
		form.action = "00_Member_Del.asp?page=<%=Page%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>";
		form.submit();
	}

	function go_regist3(form)
	{
		var v_cnt = 0;
		var v_data = "";
		if (!confirm("������������ó���� �Ǹ� �ٽ� �����Ͻ� �� �����ϴ�. ���� ���� ó���Ͻðڽ��ϱ�?")) return;		
		form.action = "00_Member_P_Del.asp?page=<%=Page%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>";
		form.submit();
	}

	function go_regist4(form)
	{
		var v_cnt = 0;
		var v_data = "";

		if (!confirm("��ȭ��ȣ �� ���¹�ȣ����ó���� ���� �Ͻðڽ��ϱ�?")) return;		
		form.action = "00_Member_P_MO.asp?page=<%=Page%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>";
		form.submit();
	}

	function MM_openBrWindow(theURL,winName,features) { 
	  window.open(theURL,winName,features);
	}
	
	function SearchFrm() {
		document.frmchk.submit();
	}
	
	// ��� üũ�ڽ� on/off
	function AllChk() {
		var chkAll = document.frmchk.chkAll;
		var cbox = document.frmchk.SelUser;
		if (cbox.length) {
			for(var i=0; i<cbox.length; i++) {
				cbox[i].checked = chkAll.checked;
			}
		}
		else {
			cbox.checked = chkAll.checked;
		}
	}

	function MemJoin(URL) {

		window.open(URL, 'MemJoin', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,width=758,height=665');
		}
function changeTrColor(IG_IDX)
{

    if(document.getElementById("tr" + IG_IDX).bgColor == "#b7d1fc" )
    {
        document.getElementById("tr" + IG_IDX).bgColor = "#ffffff" ;
    }
    else
    {
        document.getElementById("tr" + IG_IDX).bgColor = "#b7d1fc" ;    
    }        
}
</SCRIPT>
</head>

<body topmargin="0" marginheight="0" style="padding:0px 0px 0px 1px;" class="AdminBodyW99">
<div class="MenuLeft_MainDiv2 width100pIMP">
	<div class="MenuLeft_MainInnerDiv width95pIMP">


	
	<div class="title-default">
		<span class="txtsh011b" style="color:#adc;"> �� </span>
		 ȸ������ - [�� �ο� : <%=nTotalCnt%> ��]<% IF REQUEST("sStartDate") <> "" Or REQUEST("sEndDate") <> "" Or REQUEST("Search") <> "" Or REQUEST("Find") <> "" THEN %>
				[�˻� �ο� : <%=formatnumber(TN,0)%> ��]2018-01-05<%
				END IF 
				%>
	</div>


<div style="height:10px;"></div>


<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="get" action="List.asp">
<tr><td>�������� :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>
	<input type="text" name="sStartDate" id="txtDate" value="<%=Left(sStartDate,12)%>" onclick="fnPopUpCalendar(txtDate,txtDate,'yyyy/mm/dd')" class='text_box1' style="width:70px;"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>�������� :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" id="txtDate2" value="<%=Left(sEndDate,12)%>" onclick="fnPopUpCalendar2(txtDate2,txtDate2,'yyyy/mm/dd')" class='text_box1' style="width:70px;"></td>
	<td>
	  <img src="blank.gif" border="0" width="50" height="1">
	</td>
	<td>
	  <select name="IU_SITE" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
	    <option value="All" <%if reqIU_SITE = "All" then Response.Write "selected"%>>ALL</option>

      </select>
	</td>
	<td>
	  <select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
	    <option value="IU_NICKNAME" <%if Search = "IU_NICKNAME" then Response.Write "selected"%>>�г���</option>
		<option value="IU_ID" <%if Search = "IU_ID" then Response.Write "selected"%>>���̵�</option>		
		<option value="IU_BANKOWNER" <%if Search = "IU_BANKOWNER" then Response.Write "selected"%>>�̸�</option>
      </select>
	</td>
	<td>
	  <img src="blank.gif" border="0" width="5" height="1">
	</td>
	<td><div class="input-group input-group-sm">
		  <input type="text" name="Find" size="50" maxlength="30" value="<%=Find%>" class="input text_box1 form-control " style="width:100px;">
		  <span class="input-group-btn">
				  <input type="submit" value="�� ��" class="btn btn-info">
			  </span>
		  </div>
	</td>
	<td>
	  <img src="blank.gif" border="0" width="5" height="1">
	</td>
	<td>
	  
	</td>
	<td>
	  <img src="blank.gif" border="0" width="5" height="1">
	</td>

  </tr>
  </form>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td>
	  <img src="blank.gif" border="0" width="1" height="10">
	</td>
  </tr>
</table>
<div style="padding:0px;margin:0px;border:1px solid #cccccc;">
<table border="0"  cellspacing="1" cellpadding="2" bgcolor="#AAAAAA" width="100%" class="trhover HberTh HberTableLG" >
<col width="15" />
<col width="80" />
<col width="15" />
<col width="85" />
<col width="65" />
<col width="55" />
<col width="75" />
<col width="80" />
<col width="60" />
<col width="40" />
<col width="20" />
<col width="90" />
<col width="40" />
<col width="30" />
<col width="20" />
<col width="20" />
  <form name="frmchk" method="post">
  <tr bgcolor="e7e7e7" class="title-backgra">
    <th align="center"   width="15">
	  <input type="Checkbox" class="chklgray" name="chkAll" onclick="AllChk();">
	</th>
	<th align="center"  >
	  <b>���̵�</b>
	</th>
	<th align="center"  >
	  <b>lv</b>
	</th>	
	<th align="center"  >
	  <b>�г���</b>
	</th>
	<th align="center"  >
	<b>
	  <a href="List.asp?sortColumn=IU_CASH&sortDirection=<%= sortDirection1 %>">���øӴ�<%= sortimg_cash %></a>
    </b>
    </th>
	<th align="center"  >
	  <b><a href="List.asp?sortColumn=IU_POINT&sortDirection=<%= sortDirection1 %>">����Ʈ<%= sortimg_point %></a></b>
	</th>	
	<th align="center"  >
        <a href="List.asp?sortColumn=IU_CHARGE&sortDirection=<%= sortDirection1 %>"><b>�Ա�<%= sortimg_incash %></b></a>
	</th>
	<th align="center"  >
       <a href="List.asp?sortColumn=IU_EXCHANGE&sortDirection=<%= sortDirection1 %>"> <b>���<%= sortimg_outcash %></b></a>
	</th>	
	<th align="center"  >
       <a href="List.asp?sortColumn=IU_CASHINOUT&sortDirection=<%= sortDirection1 %>"><b>����<%= sortimg_login %></b></a>
	</th>		
	<th align="center"  >
        <a href="List.asp?sortColumn=IU_LOGIN_CNT&sortDirection=<%= sortDirection1 %>"><b>�α���<%= sortimg_login %></b></a>
	</th>
	<th align="center"  >
        <b>���ü�<%= sortimg_login %></b>
	</th>			
	<th align="center"  >
	  <b><a href="List.asp?sortColumn=IU_REGDATE&sortDirection=<%= sortDirection1 %>">�����<%= sortimg_date %></a></b>
	</th>	
	<th align="center"  >
	  <b>����Ʈ</b>
	</th>
	<th align="center"   >
	  <b>����</b>
	</th>	
<!--	
	<th align="center"  >
	  <b>����</b>
	</th>	
-->
	<th align="center"  >
	  <b>����</b>
	</th>	
  </tr>

<%
IF dfMemberSql.RsCount = 0 Then
%>

  <tr>
    <td align="center" colspan="13" height="35">���� ��ϵ� ȸ���� �����ϴ�.</td>
  </tr>

<%
ELSE

	FOR i = 0 TO dfMemberSql.RsCount -1
      
		IU_Idx			= dfMemberSql.Rs(I,"IU_IDX")
		IU_ID			= dfMemberSql.Rs(I,"IU_ID")
		IU_PW			= dfMemberSql.Rs(I,"IU_PW")
		IU_NickName		= dfMemberSql.Rs(I,"IU_NICKNAME")
		IU_Email		= dfMemberSql.Rs(I,"IU_EMAIL")
		IU_Cash			= dfMemberSql.Rs(I,"IU_CASH")
		IU_Level		= dfMemberSql.Rs(I,"IU_LEVEL")
		IU_BankName		= dfMemberSql.Rs(I,"IU_BANKNAME")
		IU_BankNum		= dfMemberSql.Rs(I,"IU_BANKNUM")
		IU_BankOwner	= dfMemberSql.Rs(I,"IU_BANKOWNER")
		IU_RegDate		= dfMemberSql.Rs(I,"IU_REGDATE")
		IU_Status		= dfMemberSql.Rs(I,"IU_STATUS")
		IU_SITE			= dfMemberSql.Rs(I,"IU_SITE")
		IU_POINT		= dfMemberSql.Rs(I,"IU_POINT")
		IU_LOGINDATE	= dfMemberSql.Rs(I,"IU_LOGINDATE")
		IU_CHARGE	        = dfMemberSql.Rs(i,"IU_CHARGE")
		IU_EXCHANGE	    = dfMemberSql.Rs(I,"IU_EXCHANGE")
		IU_LOGIN_CNT	    = dfMemberSql.Rs(I,"IU_LOGIN_CNT")		
		LC_IDX_CK       = dfMemberSql.Rs(I,"LC_IDX_CK")
		VIP             = dfMemberSql.Rs(I,"VIP")
		IDUSECK         = dfMemberSql.Rs(I,"IDUSECK")
		IU_CASHINOUT    = dfMemberSql.Rs(I,"IU_CASHINOUT")
		IU_BETCNT    = dfMemberSql.Rs(I,"IU_BETCNT")

		IF IU_Status  = 1 THEN
			IU_Status = "<font color=blue>����</font>"
		ELSEIF IU_Status = 0 THEN
			IU_Status = "<font color=gray>����</font>"
		ELSEIF IU_Status = 9 THEN
			IU_Status = "<font color=red>Ż��</font>"
		END IF	
		
		if i mod 2 = 0 Then
		    trColor = "#FFFFFF"
		Else
		    trColor = "#F3F3F3"
		End IF
%>
<tr bgcolor="<%= trColor %>" id="tr<%= IU_Idx %>">


<td align="center">
<input type="checkbox"  name="SelUser" value="<%=IU_Idx%>" onclick="changeTrColor(this.value)">
</td>
	
<%
    IF isNull(VIP) Or Vip = "" Then
%>	
    <td >
<%
	else 
%>
    <td bgcolor="#sbfcgt">         
<%  end if %>		  
        <a href="View.asp?IU_IDX=<%=IU_IDX%>&IU_SITE=<%=IU_SITE%>&PAGE=<%=PAGE%>" style="font-weight:bold; color:#464666"><%=iu_id%></a>
	</td>
	
	<td align="center">
	    <%= IU_LEVEL %>
	</td>
	
	<td align="left">
	  <%=IU_NickName%>
	</td>
	<td align='right'>
	<%=formatnumber(IU_CASH,0)%>
	</td>
	<td align='right'>
	<%=formatnumber(IU_POINT,0)%>
	</td>	
	<td align="right">
        <%= formatnumber(IU_CHARGE,0)%>
	</td>
	<td align="right">
        <%= formatnumber(IU_EXCHANGE,0)%>
	</td>
	<td align="right" bgcolor="#FEE5E5">
        <%= formatnumber(IU_CASHINOUT,0)%>
	</td>	
	<td  align="right">
        <%= formatnumber(IU_LOGIN_CNT,0)%>
	</td>
	<td  align="right">
        <%= formatnumber(IU_BETCNT,0)%>
	</td>	
	<td align="center" style="color:#666696">
	  <%=right(dfStringUtil.GetFullDate(IU_RegDate),14)%>
	</td>		
	<td  align="center">
        <%= IU_SITE%>
	</td>
	<td align="center"><%=IU_Status%></td>	
<!--
	<td align="center"> 
	    <input type="button" class="input" value="����" onclick="location.href='Write_Message.asp?cd=<%=IU_ID%>&cdi=<%=IU_IDX%>&JOBSITE=<%=IU_SITE%>'"> 
	</td>	
-->
	<td style="width:50px;">
	    <input type="button" class="btn btn-default btn-xs" value="����" onclick="location.href='/Seller/04_Game1/Betting_List.asp?Search=IB_ID&Find=<%= IU_ID %>'">
	</td>	
  </tr>
	    

<%
    Next 
END IF
%>

</table>
</div>
<br clear="all">
<div style="text-align:center;">
<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
</div>
<br /><br />
<!-- paging End -->
</form>
</div>
</div>
</body>
</html>