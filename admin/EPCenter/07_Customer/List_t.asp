<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/07_Customer/_Sql/customerSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### ���� ������ ������                 ################	
   
	Call dfcustomerSql.RetrieveBOARD_CUSTOMER_TEMPLATE(dfDBConn.Conn )
    

%>

<html>
<head>
<title></title>
<!-- #include virtual="/Inc_Month.asp"-->
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<!--<script src="/Sc/Base.js"></script>-->
</head>

<body topmargin="0" marginheight="0">


<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> ������[���ø�] ����</b></td>
</tr>
</table>    
<div style="height:10px;"></div>
<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">

<tr bgcolor="#EEEEEE">
	<td align="center" height="30" ><b>����</b></td>
	<td align="center" height="30" ><b>����</b></td>
</tr>

<%	
IF dfcustomerSql.RsCount = 0 THEN	
%>

<tr bgcolor="#FFFFFF">
    <td align="center" colspan="3" height="50">���� ��ϵ� ���� �����ϴ�.</td>
</tr>

<%
ELSE

	FOR i = 0 TO dfcustomerSql.RsCount -1 

		BCT_IDX		= dfcustomerSql.Rs(i,"BCT_IDX")
		BCT_TITLE	= dfcustomerSql.Rs(i,"BCT_TITLE")
%>
<tr bgcolor="#FFFFFF">
	<td  height="30" ><a href="Edit_t.asp?BCT_IDX=<%= BCT_IDX %>"><%= BCT_TITLE %></a></td>
	<td align="center" height="30" ><a href="Edit_t.asp?BCT_IDX=<%= BCT_IDX %>">����</a></td>
</tr>
<% 
	Next 
END IF 
%>

</table>
<br />
<div align="right">
<input type="button" value="    �� ��    " onclick="location.href='Write_t.asp'" style="border: 1 solid;" />
</div>
</body>
</html>
<%
	DbCon.Close
	Set DbCon=Nothing
%>