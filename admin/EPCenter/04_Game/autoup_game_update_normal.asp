<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
    <link rel="stylesheet" type="text/css" href="/EPCenter/css/style.css">
<%
    set db = Server.CreateObject("adodb.connection")
    db.Open "Provider=SQLOLEDB;UID=asi132;PWD=df99!!DAD1edj9!$$@;Initial Catalog=DTEVIL;Data Source=103.31.12.5,3289"
    sql1="select * from info_parsing"
		
	set rs=Server.CreateObject("adodb.recordset")
	rs.open sql1,db,0,1
%>
<%
Response.Charset="euc-kr" 'asp������ charset����
%>
<table border="0"  cellspacing="0" cellpadding="0" bgcolor="FFFFFF" width="900" valign="top">
<font color="red"><b>**���ػ���Ʈ�� ���α׷� �Ľ̰���Դϴ�. 90���ֱ�� ������Ʈ�� �Ǹ� ���������Ʈ�� �������̰ų� 10���̻� ������Ʈ�� �ȵɽ� ������ �����ּ���</b></font>
								<TR>
								<td align="left" NAME="IP_GAME_UPDATE">
					<%
						if not RS.EOF then
							do until RS.EOF
					%>
					/<%=rs("IP_REGDATE") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="blue"><%=rs("IP_GAME_UPDATE") %></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								
					<%
							RS.movenext
							loop
						end if
					%>
</table>