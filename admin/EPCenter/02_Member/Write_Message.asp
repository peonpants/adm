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
	CD			= REQUEST("cd")
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 충전 내역을 볼러옴                 ################	
   
	Call dfcustomerSql.RetrieveBOARD_CUSTOMER_TEMPLATE(dfDBConn.Conn )
    	
%>

<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">

<SCRIPT LANGUAGE="JavaScript">
	function Checkform()
	{
		frm = document.frm1;
		if (frm.BC_TITLE.value == "") { alert("\n 제목을 입력하세요. \n"); frm.BC_TITLE.focus(); return false; }
		if (frm.BC_CONTENTS.value == "") { alert("\n 내용을 입력하세요. \n"); frm.BC_CONTENTS.focus(); return false; }
		frm.submit();	
    }
    
    function getContent(BCT_IDX)
	{
	    if(BCT_IDX != 0) frmConent.location.href = "/EPCenter/07_Customer/getContent_t.asp?BCT_IDX="+ BCT_IDX;
	}		    
</SCRIPT></head>

<body topmargin="25" marginheight="25">
<iframe width=0 height=0 frameborder=0 name="frmConent"></iframe>

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td>
        <b class="text07"> 회원정보 &nbsp;&nbsp; ▶  쪽지보내기  
	      </b>
    </td>
</tr>
</table>    
<div style="height:10px;"></div>

<form name="frm1" method="post" action="Message_Proc.asp">
<table width="100%">
<tr>
    <td>
<table width="700" border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF">
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>제&nbsp;&nbsp;목</b></td>
   	<td colspan="3">&nbsp;<input name="BC_TITLE" class=box2 style="WIDTH: 580px; HEIGHT: 17px"></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>글쓴이</b></td>
   	<td colspan="3">&nbsp;<input name="BC_MANAGER" class=box2 style="WIDTH: 120px; HEIGHT: 17px" value="관리자" readonly></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>받는이</b></td>
   	<td colspan="3">&nbsp;<input name="BC_WRITER" class=box2 style="WIDTH: 120px; HEIGHT: 17px" value="<%=CD%>" readonly></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>내&nbsp;&nbsp;용</b></td>
    <td colspan="3" style="padding:10,10,10,10;"><textarea name="BC_CONTENTS" style="width:580px;height:300px;overflow:hidden" class="box2"></textarea></td>
<input type="hidden" value="All" name="BC_SITE">	
</tr>
</table><br>

<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td align="center"> 
	<input type="button" value=" 등 록 " onclick="javascript:Checkform()" style="border: 1 solid; background-color: #C5BEBD;">
	<input type="button" value=" 취소 "  onclick="history.back(-1);" style="border: 1 solid; background-color: #C5BEBD;"></td></tr></form></table>

    <td align="left" valign="top" >
    <select size="25" style="width:300px;border: 1 solid;" onchange="getContent(this.value);">
    <option value="0" >--선택 --</option>
<%	
IF dfcustomerSql.RsCount <> 0 THEN	

	FOR i = 0 TO dfcustomerSql.RsCount -1 

		BCT_IDX		= dfcustomerSql.Rs(i,"BCT_IDX")
		BCT_TITLE	= dfcustomerSql.Rs(i,"BCT_TITLE")
%>
    <option value="<%= BCT_IDX %>"><%= BCT_TITLE %></option>
<%		
    Next	
End IF    	
%>    
    </select>
    </td>
</tr>
</table>
</form>
</body>
</html>
