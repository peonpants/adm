<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/08_Board/_Sql/boardSql.Class.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<html>
<head>
<title></title>

<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/Sc/Base.js"></script>
<script  language="javascript">
function fc_sendC() {
        //  전송해줄  텍스트박스의  값
        //  전송할  폼
        document.frm_hiddenC.hid_data.value = document.frm_hiddenC.TB_contents.value;
        //alert(document.frm_hidden.TB_IP.value);
        //  값을  전송
        document.frm_hiddenC.submit();
    }

function fc_sendH() {
        //  전송해줄  텍스트박스의  값
        //  전송할  폼
        document.frm_hiddenH.hid_data.value = document.frm_hiddenH.TB_contents.value;
        //alert(document.frm_hidden.TB_IP.value);
        //  값을  전송
        document.frm_hiddenH.submit();
    }

function fc_sendS() {
        //  전송해줄  텍스트박스의  값
        //  전송할  폼
        document.frm_hiddenS.hid_data.value = document.frm_hiddenS.TB_contents.value;
        //alert(document.frm_hidden.TB_IP.value);
        //  값을  전송
        document.frm_hiddenS.submit();
    }
</script>
</head>
<%
        '######### 디비 연결                    ################	
        dfDBConn.SetConn = Application("DBConnString")
	    dfDBConn.Connect()	
		%>
<body topmargin="25" marginheight="25">
<table ><tr valign='top'><td>
<!---------------------------------------------축하----------------------------------------------->
<table border="0"><tr>
<%
	SET DbRec=Server.CreateObject("ADODB.Recordset") 
    TstrSQL = ""
	TstrSQL = "SELECT IBC_CONTENTS,IBC_IDX FROM INFO_BOARD_CONTENTS  where IBC_TYPE = '0' ORDER BY IBC_IDX asc"
	DbRec.Open TstrSQL, dfDBConn.conn

IF NOT DbRec.EOF THEN	
		TB = 1
	ELSE
		TB = 0		
	END IF
     %>	
<form  action="Board_Contents_List_Proc.asp"  name="frm_hiddenC"  method="post">     
	<td align="center" bgcolor="e7e7e7"><b>IDX</b></td>
	<td align="center" bgcolor="e7e7e7" ><b>축하 코멘트</b></td></tr>
	<%	IF TB <> 0 THEN	    
    Do Until DbRec.eof %>
    <tr>
	<td align="center"><%=DbRec("IBC_IDX")%></td>
    <td><table border="0" cellpadding="0" cellspacing="0">
    <tr><td width='300'><FONT><B><%=DbRec("IBC_CONTENTS")%></B></FONT></a></td>
		<td><img src="blank.gif" border="0" width="10" height="1"></td>
		<td><a href="Board_Contents_List_Proc.asp?IBC_IDX=<%=DbRec("IBC_IDX")%>&FLAG=DEL"><FONT COLOR="RED"><B>[삭제]</B></FONT></a></td></tr></table>
	</td>
</tr><%
DbRec.MoveNext
loop
else%>
<tr><td align="center" colspan="3" height="35">축하 코멘트 정보가 없습니다.</td></tr>
<%end if%>

<input  type="hidden"  name="hid_data" value="">
<input  type="hidden"  name="FLAG" value="ADDC">
<tr><td align="right" colspan="2"><input type="text" id="TB_contents" name="TB_contents" style="width:330px;">
<input  type="button"  value="추가" onclick="fc_sendC()"></td></tr></form></table>
<!---------------------------------------------축하----------------------------------------------->
</td><td>

<!---------------------------------------------기원----------------------------------------------->
<table border="0"><tr>
<%
	SET DbRec=Server.CreateObject("ADODB.Recordset") 
    TstrSQL = ""
	TstrSQL = "SELECT IBC_CONTENTS,IBC_IDX FROM INFO_BOARD_CONTENTS  where IBC_TYPE = '1' ORDER BY IBC_IDX asc"
	DbRec.Open TstrSQL, dfDBConn.conn

IF NOT DbRec.EOF THEN	
		TB = 1
	ELSE
		TB = 0		
	END IF
     %>	
<form  action="Board_Contents_List_Proc.asp"  name="frm_hiddenH"  method="post">     
	<td align="center" bgcolor="e7e7e7"><b>IDX</b></td>
	<td align="center" bgcolor="e7e7e7" ><b>기원 코멘트</b></td></tr>
	<%	IF TB <> 0 THEN	    
    Do Until DbRec.eof %>
    <tr>
	<td align="center"><%=DbRec("IBC_IDX")%></td>
    <td><table border="0" cellpadding="0" cellspacing="0">
    <tr><td width='300'><FONT><B><%=DbRec("IBC_CONTENTS")%></B></FONT></a></td>
		<td><img src="blank.gif" border="0" width="10" height="1"></td>
		<td><a href="Board_Contents_List_Proc.asp?IBC_IDX=<%=DbRec("IBC_IDX")%>&FLAG=DEL"><FONT COLOR="RED"><B>[삭제]</B></FONT></a></td></tr></table>
	</td>
</tr><%
DbRec.MoveNext
loop
else%>
<tr><td></td><td align="center" width='350'>기원 코멘트 정보가 없습니다.</td></tr>
<%end if%>

<input  type="hidden"  name="hid_data" value="">
<input  type="hidden"  name="FLAG" value="ADDH">
<tr><td align="right" colspan="2"><input type="text" id="TB_contents" name="TB_contents" style="width:330px;">
<input  type="button"  value="추가" onclick="fc_sendH()"></td></tr></form></table>
<!---------------------------------------------기원----------------------------------------------->
</td><td>
<!---------------------------------------------위로----------------------------------------------->
<table border="0"><tr>
<%
	SET DbRec=Server.CreateObject("ADODB.Recordset") 
    TstrSQL = ""
	TstrSQL = "SELECT IBC_CONTENTS,IBC_IDX FROM INFO_BOARD_CONTENTS  where IBC_TYPE = '2' ORDER BY IBC_IDX asc"
	DbRec.Open TstrSQL, dfDBConn.conn

IF NOT DbRec.EOF THEN	
		TB = 1
	ELSE
		TB = 0		
	END IF
     %>	
<form  action="Board_Contents_List_Proc.asp"  name="frm_hiddenS"  method="post">     
	<td align="center" bgcolor="e7e7e7"><b>IDX</b></td>
	<td align="center" bgcolor="e7e7e7" ><b>위로 코멘트</b></td></tr>
	<%	IF TB <> 0 THEN	    
    Do Until DbRec.eof %>
    <tr>
	<td align="center"><%=DbRec("IBC_IDX")%></td>
    <td><table border="0" cellpadding="0" cellspacing="0">
    <tr><td width='300'><FONT><B><%=DbRec("IBC_CONTENTS")%></B></FONT></a></td>
		<td><img src="blank.gif" border="0" width="10" height="1"></td>
		<td><a href="Board_Contents_List_Proc.asp?IBC_IDX=<%=DbRec("IBC_IDX")%>&FLAG=DEL"><FONT COLOR="RED"><B>[삭제]</B></FONT></a></td></tr></table>
	</td>
</tr><%
DbRec.MoveNext
loop
else%>
<tr><td></td><td align="center" width='350'>위로 코멘트 정보가 없습니다.</td></tr>
<%end if%>

<input  type="hidden"  name="hid_data" value="">
<input  type="hidden"  name="FLAG" value="ADDS">
<tr><td align="right" colspan="2"><input type="text" id="TB_contents" name="TB_contents" style="width:330px;">
<input  type="button"  value="추가" onclick="fc_sendS()"></td></tr></form></table>
<!---------------------------------------------위로----------------------------------------------->
</tD></tr></table>

</body>
</html>

<%
	DbRec.Close
	Set DbRec=Nothing

	DbCon.Close
	Set DbCon=Nothing
%>