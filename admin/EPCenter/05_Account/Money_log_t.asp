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
    sStartDate  = REQUEST("sStartDate")
    sEndDate = REQUEST("sEndDate")
    
    IF sStartDate = "" Then
        sStartDate = right("000" & year(now)  , 4) & "-" & right("0" & month(now) , 2) & "-01 00:00"
        sEndDate    = dateadd("m",1,sStartDate)
    Else
        sEndDate    = dfStringUtil.GetFullDate(dateadd("s",-1,dateadd("m",1,sStartDate)))
    End IF
    
    totalCnt = datediff("d", sStartDate,sEndDate) 
    'response.Write sStartDate & "---" &  sEndDate
    
    SQLa = "SELECT CONVERT(VARCHAR,lc_regdate, 111) as sumCashDate, ISNULL(SUM (lc_cash),0) AS sumCash FROM log_cashinout where lc_contents = '��������' and lc_regdate >= '"&sStartDate&"' AND lc_regdate <= '"&sEndDate&"' GROUP BY CONVERT(VARCHAR,lc_regdate, 111)"

	SET RSa= DbCon.Execute(SQLa)
	If Not RSa.EOF then
		
	End If 
	RSa.CLOSE
	SET RSa = Nothing
	
%>
<html>
<head>
	<title>�� ������ �ƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢƢ�</title>
	<link rel="stylesheet" type="text/css" href="../css/style.css">
</head>
<!-- #include virtual="/Inc_Month.asp"-->
<body topmargin="0" marginheight="0">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> ���� ����</b></td>
</tr>
</table>    
<div style="height:10px;"></div>
<form name="frm" method="get">
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#bebebe"  style="border-collapse:collapse" style=table-layout:fixed>
<tr>
    <td>
		<table  border="0" align="right" cellpadding="0" cellspacing="0" >
		  <tr height="25">
		    <td width="70" align="right"><font color="#000000" style="font-size:12px;" ><strong>�Ⱓ : </strong>&nbsp;&nbsp;</font></td>
		    <td >
			<font color="#000000" style="font-size:12px;" > 
			<div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:135;display:none;position: absolute; z-index: 99"></div>
			<input type="text" name="sStartDate" value="<%=REQUEST("sStartDate")%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:70" class="input">	
			</td>
		    <td width="65">&nbsp;<input name="submit" type="submit" value="�˻�" class="input"/></td>
		  </tr>
		</table>	
    </td>
</tr>
</table>
</form>		
<table width="100%" border="1" cellpadding="0" cellspacing="0"  bordercolorlight="#bebebe"  style="border-collapse:collapse">
  <tr > 
    <td width="110" rowspan="2" align="center" valign="middle">��¥</td>
    <td height="25" colspan="3" align="center" valign="middle">����</td>
    <td height="25" colspan="3" align="center" valign="middle">ȯ��</td>
    <td height="25" align="center" valign="middle">����</td>
    <td height="25" colspan="3" align="center" valign="middle">����Ʈ</td>
    <td height="25" colspan="3" align="center" valign="middle">������Ȳ</td>
    <td height="25" colspan="2" align="center" valign="middle">�Խ���</td>
	<td width="60" height="25" rowspan="2" align="center" valign="middle">ȸ������</td>
    <td width="70" rowspan="2" align="center" valign="middle">����Ʈ</td>
  </tr>
  <tr > 
    <td width="70" height="25" align="center" valign="middle">�Ѿ�</td>
    <td width="70" height="25" align="center" valign="middle">�Ա�</td>
    <td width="70" height="25" align="center" valign="middle">����������</td>
    <td width="70" height="25" align="center" valign="middle">�Ѿ�</td>
    <td width="70" height="25" align="center" valign="middle">���</td>
    <td width="70" height="25" align="center" valign="middle">����������</td>
    <td width="70" height="25" align="center" valign="middle">�Ա� - ���</td>
    <td width="70" height="25" align="center" valign="middle">�Ѿ�</td>
    <td width="70" height="25" align="center" valign="middle">�Ա�</td>
    <td width="70" height="25" align="center" valign="middle">����������</td>    
    <td width="70" height="25" align="center" valign="middle">���ñ�</td>
    <td width="70" height="25" align="center" valign="middle">���߱�</td>
    <td width="70" height="25" align="center" valign="middle">������</td>
    <td width="70" height="25" align="center" valign="middle">������</td>
	<td width="70" height="25" align="center" valign="middle">�����Խ���</td>
  </tr>
<%
    For i = 0 to totalCnt
%>
  <tr > 
    <td  height="25" align="center" valign="middle">
    <%= dateValue(dateadd("d",-i,sEndDate)) %>
    </td>
    <td  height="25" align="center" valign="middle">
    </td>
    <td  height="25" align="center" valign="middle">
    </td>
    <td  height="25" align="center" valign="middle">
    </td>
    <td  height="25" align="center" valign="middle">
    </td>
    <td  height="25" align="center" valign="middle">
    </td>
    <td  height="25" align="center" valign="middle">
    </td>
    <td  height="25" align="center" valign="middle">
    </td>
    <td  height="25" align="center" valign="middle">
    </td>    
    <td  height="25" align="center" valign="middle">
    </td>
    <td  height="25" align="center" valign="middle">
    </td>
    <td  height="25" align="center" valign="middle">
    </td>
    <td  height="25" align="center" valign="middle">
    </td>
    <td  height="25" align="center" valign="middle">
    </td>
    <td  height="25" align="center" valign="middle">
    </td>
    <td  height="25" align="center" valign="middle">
    </td>
    <td  height="25" align="center" valign="middle">
    </td>
    <td  height="25" align="center" valign="middle">
    </td>        
  </tr>
<%    
    Next
%>  
</table>  
</body>
</html>