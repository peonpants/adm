<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
reqYear     = dfRequest("year")
reqMonth    = dfRequest("month")
reqDay      = dfRequest("day")
reqSite      = dfRequest("site")
if reqYear = "" Then
    reqYear     = Year(now)
    reqMonth    = Month(now)
    reqDay      = Day(now)
end IF

%>
<html>
<head>
<title>XML������ - ��������</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
</head>
<body topmargin="0" marginheight="0">

<table border="0" cellpadding="10" width="100%">
<tr>
    <td bgcolor="000000" >
	<b style="color:ffffff">XML������ - �������� </b>
	</td>
</tr>
</table>
<form target="xmlFrame" action="Game_XMLGetData.asp">
<table border="0" cellpadding="5" width="100%">
<tr>
    <td align="right">
    
    <select name="ig_type">
        <option value="0">�¹���</option>
        <option value="1">�ڵ�ĸ</option>
        <option value="2">�������</option>        
    </select>
    <!--
    <select name="ig_STATUS">
        <option value="S">������</option>
        <option value="E">���ø���</option>
        <option value="F">���긶��</option>        
        <option value="C">���/��Ư</option>        
    </select>     
    -->
    <input type="text" name="site" size="30" />
    <select name="year">
        <option value="<%= Year(dateadd("yyyy",-1,now)) %>"><%= Year(dateadd("yyyy",-1,now)) %></option>
        <option value="<%= Year(now) %>" selected><%= Year(now) %></option>
        <option value="<%= Year(dateadd("yyyy",1,now)) %>"><%= Year(dateadd("yyyy",1,now)) %></option>
    </select>��
    <select name="month">
        <option value="<%= Month(dateadd("m",-1,now)) %>"><%= Month(dateadd("m",-1,now)) %></option>
        <option value="<%= Month(now) %>" selected><%= Month(now) %></option>
        <option value="<%= Month(dateadd("m",1,now)) %>"><%= Month(dateadd("m",1,now)) %></option>
    </select>��    
    <select name="day">
        <option value="<%= Day(dateadd("d",-1,now)) %>"><%= Day(dateadd("d",-1,now)) %></option>
        <option value="<%= Day(now) %>" selected><%= Day(now) %></option>
        <option value="<%= Day(dateadd("d",1,now)) %>"><%= Day(dateadd("d",1,now)) %></option>
    </select>��  
    
    <input type="submit"  value=" �˻� " class="input" />
    </td>
</tr>
</table>   
</form>
<table border="0" cellpadding="5" width="100%" height="100%">
<tr>
    <td> 
        <iframe name="xmlFrame"  width="100%" height="100%" scrolling="auto" frameborder="0" style="border-width:1px; border-style:solid; border-color:000000;"></iframe>
    </td>
</tr>
</table>    
</html>