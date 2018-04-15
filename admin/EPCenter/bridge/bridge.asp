<META HTTP-EQUIV="Refresh" CONTENT="6;url=http://admmain.addfwzm.com:21993/EPCenter/bridge/bridge.asp">
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%	
	SQLR = "SELECT top 1 IG_STARTTIME,II_IDX,IG_TEAM1BETTING,IG_TEAM2BETTING from info_game where ig_memo is null and ig_type=0 and ig_anal is null and ig_event='R' and (dateadd(ss,85,ig_starttime) between getdate() and dateadd(ss,70,getdate()))"
	SET RS = Server.CreateObject("ADODB.Recordset")
	RS.Open SQLR, DbCon, 1

	if not RS.EOF then
		value0 = rs(0)
		value1 = rs(1)
		value2 = Trim(rs("IG_TEAM1BETTING"))
		value4 = Trim(rs("IG_TEAM2BETTING"))
		idx1 =rs("II_IDX")
		response.write value2
	end If
	RS.Close
	Set RS=Nothing

%>
<%
function getHTML(url, data)
    Set xmlHttp = Server.Createobject("WinHttp.WinHttpRequest.5.1")
    xmlHttp.Open "POST", url, False
    xmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
    xmlhttp.Option(4) = 13056
    xmlHttp.Send Data
    getHTML = xmlHttp.responseText
    xmlHttp.abort()
    set xmlHttp = Nothing   
end function

url = "https://starapi.net/?UserId=zumacc23&GameType=b&GameTypeSub=a&PickNum=1&BetMoney=100&SiteName=STAR&AuthCode=05FA43F4BEBC"
data = ""

ajax = getHTML(url,data)
response.write(ajax)

%>