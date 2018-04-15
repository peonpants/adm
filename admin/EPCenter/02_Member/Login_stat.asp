<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/02_Member/_Sql/memberSql.Class.asp"-->
<%
    
    '######### Request Check                    ################	    
       
    reqType            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("type")), 1, 1, 3) 
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
    
    
    	
	'######### 회원 리스트를 불러옴                 ################	
    Dim strXML
    
	Call dfmemberSql.RetrieveLOG_LOGINByDay(dfDBConn.Conn,  reqType, IU_ID)
	
	IF reqType = 1 Then
	    strXML  = strXML &  "<chart caption='date' >" 
	ElseIF reqType = 2 Then
	    strXML  = strXML &  "<chart caption='id' >" 
	End IF
    IF dfmemberSql.RsCount <> 0 Then
        For i = 0 to dfmemberSql.RsCount - 1
            IF reqType = 1 Then
                strXML  = strXML & "<set label='"& dfmemberSql.Rs(i,"LL_REGDATE") & "' name='"& dfmemberSql.Rs(i,"LL_REGDATE") & "' value='" & dfmemberSql.Rs(i,"cnt") & "'/>"
                'response.Write dfmemberSql.Rs(i,"cnt") & "--" & dfmemberSql.Rs(i,"LL_REGDATE") & "<br>"
            ElseIF reqType = 2 Then
                strXML  = strXML & "<set label='"& dfmemberSql.Rs(i,"LL_NICKNAME") & "' name='"& dfmemberSql.Rs(i,"LL_NICKNAME") & "' value='" & dfmemberSql.Rs(i,"cnt") & "'/>" 
                'response.Write dfmemberSql.Rs(i,"cnt") & "--" & dfmemberSql.Rs(i,"LL_ID") & "<br>"
            End IF
                            
        Next
    End IF
    
    strXML  = strXML & "</chart>"
    
%>

<html>
<head>
<title></title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script type="text/javascript" src="/FusionCharts/FusionCharts.js"></script>
<script src="/Sc/Base.js"></script>
<script type="text/javascript">
function getID(IU_NICKNAME)
{
    detailFrame.location.href = "Login_statDetail.asp?type=3&IU_NICKNAME=" + IU_NICKNAME ;
}

function getDate(LL_REGDATE)
{
    detailFrame.location.href = "Login_statDetail.asp?type=4&LL_REGDATE=" + LL_REGDATE ;
}
</script>
</head>

<body topmargin="0" marginheight="0">
<table border="1" bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
  <tr>
    <td bgcolor="706E6E" style="padding-left:12" height="23">
	  <b>
	    <font color="FFFF00">회원관리</font>
		<font color="ffffff">&nbsp;&nbsp;▶ 회원 로그인 통계
      </b> 
    </td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td height="10">&nbsp;
	</td>
  </tr>
</table>
<div>
<a href="Login_stat.asp?type=1">[날짜별 통계]</a>
<a href="Login_stat.asp?type=2">[회원별 통계]</a>
</div>
<table>
<tr>
    <td>
        <div id="chart1"></div>
    </td>
    <td>
        <div style="width:400px;height:350px;overflow:auto"> 
        <table width="100%" cellpadding="3" cellspacing="1" border="0" bgcolor="#AAAAAA">
<%
    IF dfmemberSql.RsCount <> 0 Then
        For i = 0 to dfmemberSql.RsCount - 1
            IF reqType = 1 Then
                response.Write "<tr bgcolor='#FFFFFF'><td>" & dfmemberSql.Rs(i,"cnt") & "</td><td><a href=javascript:getDate('"&dfmemberSql.Rs(i,"LL_REGDATE") &"')>" & dfmemberSql.Rs(i,"LL_REGDATE") & "</a></td></tr>"
            ElseIF reqType = 2 Then
                response.Write "<tr bgcolor='#FFFFFF'><td>" & dfmemberSql.Rs(i,"cnt") & "</td><td><a href=javascript:getID('"&dfmemberSql.Rs(i,"LL_NICKNAME") &"')>" &  dfmemberSql.Rs(i,"LL_NICKNAME") & "</a></td></tr>"
            End IF
                            
        Next
    End IF    
%>        
        </table>
        </div>
    </td>
</tr>
</table>

<iframe name="detailFrame" width="100%" height="380" frameborder="0" scrolling="no"></iframe>
<script type="text/javascript">
    var xmlData = "<%= strXML %>" ;
    var chart1 = new FusionCharts("/FusionCharts/Column3D.swf", "배팅챠트", "600", "350", "0", "1");
    chart1.setDataXML(xmlData);    
    chart1.render("chart1"); 
</script>
</body>
</html>