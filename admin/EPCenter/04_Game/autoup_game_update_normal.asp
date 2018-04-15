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
Response.Charset="euc-kr" 'asp페이지 charset설정
%>
<table border="0"  cellspacing="0" cellpadding="0" bgcolor="FFFFFF" width="900" valign="top">
<font color="red"><b>**기준사이트의 프로그램 파싱결과입니다. 90초주기로 업데이트가 되며 결과업데이트가 비정상이거나 10분이상 업데이트가 안될시 고객센터 문의주세요</b></font>
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