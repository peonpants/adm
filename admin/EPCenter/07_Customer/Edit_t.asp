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
    BCT_IDX		= Trim(REQUEST("BCT_IDX"))
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 충전 내역을 볼러옴                 ################	
   
	Call dfcustomerSql.GetBOARD_CUSTOMER_TEMPLATE(dfDBConn.Conn , BCT_IDX)
    
IF dfcustomerSql.RsCount <> 0 THEN
		BCT_IDX		= dfcustomerSql.Rs(0,"BCT_IDX")
		BCT_TITLE	= dfcustomerSql.Rs(0,"BCT_TITLE")
		BCT_CONTENTS	= dfcustomerSql.Rs(0,"BCT_CONTENTS")
End IF		
%>

<html>
<head>
<title></title>
<!-- #include virtual="/Inc_Month.asp"-->
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/Sc/Base.js"></script>
<script src="/Sc/Base.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	function Checkform()
	{
		var frm = document.frm1;
	
		if (frm.BCT_TITLE.value == "" )
		{
			alert("제복을 입력하세요");
			frm.BCT_TITLE.focus();
			return false;
		}
				
		if (frm.BCT_CONTENTS.value == "" )
		{
			alert("내용을 입력하세요");
			frm.BCT_CONTENTS.focus();
			return false;
		}
		
		frm.submit();
	}
</SCRIPT>
</head>

<body topmargin="0" marginheight="0">

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 고객센터[템플릿] 관리</b></td>
</tr>
</table>    
<div style="height:10px;"></div>
<form name="frm1" method="post" action="Edit_t_proc.asp">
<input type="hidden" name="BCT_IDX" value="<%= BCT_IDX %>" />
<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
<tr bgcolor="#EEEEEE">
	<td align="center" height="30" width="100"><b>제목</b></td>
	<td align="left" height="30" bgcolor="#FFFFFF" >
	    <input type="text" name="BCT_TITLE" style="width:100%;border: 1 solid;" value="<%= BCT_TITLE %>" />
	</td>
</tr>
<tr bgcolor="#EEEEEE">	
	<td align="center" height="30" ><b>내용</b></td>
	<td align="left" height="30" bgcolor="#FFFFFF" >
	    <textarea name="BCT_CONTENTS" style="width:100%;height:200px;border:1px solid #aaaaaa;"><%= BCT_CONTENTS %></textarea>
	</td>	
</tr>

</table>
<br />
<div align="right">
<input type="button" value="    수 정    " onclick="Checkform();" style="border: 1 solid;" />
<input type="button" value="    리스트    " onclick="location.href='list_t.asp'" style="border: 1 solid;" />
</div>
</body>
</html>
<%
	DbCon.Close
	Set DbCon=Nothing
%>