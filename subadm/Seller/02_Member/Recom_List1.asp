<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/seller/02_Member/_Sql/memberSql.Class.asp"-->
<%
 	
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	IU_ID = dfRequest.Value("IU_ID")
	site        = SESSION("rJOBSITE")
    
    	
	'######### ȸ�� ����Ʈ�� �ҷ���                 ################	
   
	Call dfmemberSql.RetrieveINFO_USERByRecomID1(dfDBConn.Conn, IU_ID)

	    
%>

<html>
<head>
<title></title>
<!-- #include virtual="/Inc_Month.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/Seller/Css/Style.css">
<script src="/Sc/Base.js"></script>
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

</SCRIPT>
</head>

<body topmargin="0" marginheight="0">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07">  ȸ������ �� ��õ ȸ�� ����Ʈ > ��õ�� ȸ���� : <%= IU_ID %>���� ��õ�� ȸ���� : <%= dfMemberSql.RsCount %> �� </b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">

  <tr>
	
	  
	<td align="center" height="30" bgcolor="e7e7e7">
	  <b>���̵�<br>(�α�������)</b>
	</td>
	<td align="center" height="30" bgcolor="e7e7e7">
	  <b>���</b>
	</td>
	<td align="center" height="30" bgcolor="e7e7e7">
	  <b>�г���</b>
	</td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>����ó</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>
	  <%
	  Response.Write "<a href=List.asp?page="&i&"&sStartDate="&REQUEST("sStartDate")&"&sEndDate="&REQUEST("sEndDate")&"&Search="& Search&"&Find="&Find&"&Search2="&Search2&"&Search6=email>�̸���</a></b></td>"
	  %>
	<td align="center" height="30" bgcolor="e7e7e7"><b>
	  <%
	  Response.Write "<a href=List.asp?page="&i&"&sStartDate="&REQUEST("sStartDate")&"&sEndDate="&REQUEST("sEndDate")&"&Search="& Search&"&Find="&Find&"&Search2="&Search2&"&Search4=money>ĳ��</a></b></td>"
	  %>
	<td align="center" height="30" bgcolor="e7e7e7">
	  <b>����Ʈ</b>
	</td>	  
	<td align="center" height="30" bgcolor="e7e7e7">
	  <b>��������</b>
	</td>
	<td align="center" height="30" bgcolor="e7e7e7">
	  <b>�����</b>
	</td>
	<td align="center" height="30" bgcolor="e7e7e7" width="40">
	  <b>����</b>
	</td>
	<td align="center" height="30" bgcolor="e7e7e7">
	  <b>����Ʈ</b>
	</td>
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
		CNT	= dfMemberSql.Rs(I,"CNT")
		
		LC_IDX_CK       = dfMemberSql.Rs(I,"LC_IDX_CK")
		VIP             = dfMemberSql.Rs(I,"VIP")
		IDUSECK         = dfMemberSql.Rs(I,"IDUSECK")

		IF IU_Status  = 1 THEN
			IU_Status = "<font color=blue>����</font>"
		ELSEIF IU_Status = 0 THEN
			IU_Status = "<font color=gray>����</font>"
		ELSEIF IU_Status = 9 THEN
			IU_Status = "<font color=red>Ż��</font>"
		END IF	%>
<tr bgcolor="#FFFFFF" height="25">	
<%
    IF isNull(VIP) Or Vip = "" Then
%>	
    <td >
<%
	else 
%>
    <td bgcolor="#sbfcgt">         
<%  end if %>		  
        <a href="View.asp?IU_IDX=<%=IU_IDX%>&IU_SITE=<%=IU_SITE%>&PAGE=<%=PAGE%>"><%=iu_id%></a>
	</td>
	<td align="center">
	  <%=IU_PW%>
	</td>
	<td align="center">
	  <%=IU_NickName%>
	</td>
	<td align="center">
	  <%=IU_Mobile%>
	</td>
	<td>
	  <%=IU_Email%>
	</td>
	<td align='right'>
	<%=formatnumber(IU_Cash,0)%>&nbsp;��&nbsp;
	</td>
	<td align='right'>
	<%=formatnumber(IU_POINT,0)%>&nbsp;P&nbsp;
	</td>	
	<td align='right'>
	    <%=IU_BankName%> - <%=IU_BankOwner%><br /> <%=IU_BankNum%>
	</td>
	<td align="center">
	  <%=dfStringUtil.GetFullDate(IU_RegDate)%>
	</td>
	
	<td align="center"><%=IU_Status%></td>

	<td>&nbsp;
        <%= IU_SITE%>
	</td>
	</tr>
	    

<%
    Next 
END IF
%>

</table>


</body>
</html>