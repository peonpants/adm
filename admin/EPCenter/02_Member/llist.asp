<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<% 
SET DbRec=Server.CreateObject("ADODB.Recordset") 
	DbRec.CursorType=1 
	
sql = "select iu_id from info_user"
SET RS = DbCon.Execute(SQL)
rs(iu_id) = ll_id
rs.close
set rs = nothing

sqllist = "select max(ll_regdate), ll_id  from log_login where ll_id=" &IU_id 
set srs = dbcon.execute(sqllist)
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<style>
	td{font-size:9pt;}
</style>
</head>

<body>
<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
<tr>
  <td align="center" height="30" bgcolor="e7e7e7" width="80"><b>아이디</b></td>
  <td align="center" height="30" bgcolor="e7e7e7" width="60"><b>최종접속</b></td>
</tr>
<% if srs.eof then %>
<tr bgcolor="#FFFFFF" height="25">
  <td align="center" colspan="14" height="35">현재 등록된 회원이 없습니다.</td>
</tr>
<% 
  else 
   do until srs.eof
     ll_regdate = trim(srs("max(ll_regdate)"))
     ll_id = trim(srs("ll_id")) 
%>
<tr bgcolor="#FFFFFF" height="25">
  <td align="center" height="30" bgcolor="e7e7e7" width="80"><b><%=ll_regdate %></b></td>
  <td align="center" height="30" bgcolor="e7e7e7" width="60"><b><%=ll_id %></b></td>
</tr>
<% 
  srs.movenext
  loop
  
  end if 
%>
</table>
</body>
</html>
<% 
  srs.close
  set srs = nothing
%>
  