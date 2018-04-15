<%
Response.ChaRset = "euc-kr"
Response.ContentType="text/html;charset=euc-kr"
%>
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->


 

<%
	idx= Request("idx") 
	token   = Request("token")
	bt_kind = Request("bt_kind")
	bt_price  = Request("bt_price")


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

url = "https://api.good-day.com/betting.asp"
data = "token="+token+"&bt_type=9&bt_kind="+bt_kind+"&bt_price="+bt_price
ajax = getHTML(url,data)

result1 = Split(Split(replace(ajax, """", ""), "Code:")(1), ",")(0)

	Response.ChaRset = "euc-kr"

    '######### µðºñ ¿¬°á                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	

	UPDSQL = "insert into log_api(LA_IDX, LA_TYPE, LA_RESULT, LA_SENT, LA_CONTENTS, LA_REGDATE) values ('" & idx & "','»ç´Ù¸®(È¦Â¦)','" & result1 & "','" & data & "','" & ajax & "',getdate())"
	DbCon.execute(UPDSQL)

	If result1="0" Then
		SQL1 = "update info_game set ig_memo='1' where ig_memo is null and ig_type=0 and ig_anal is null and ig_event='Y' and (dateadd(ss,105,ig_starttime) between getdate() and dateadd(ss,90,getdate()))"
		DbCon.execute(SQL1)
	End if
%>
