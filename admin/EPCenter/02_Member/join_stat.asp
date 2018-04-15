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
    
	Call dfmemberSql.RetrieveINFO_USERByDay(dfDBConn.Conn)
	
	IF reqType = 1 Then
	    strXML  = strXML &  "<chart caption='date' >" 
	ElseIF reqType = 2 Then
	    strXML  = strXML &  "<chart caption='id' >" 
	End IF
    IF dfmemberSql.RsCount <> 0 Then
        For i = 0 to dfmemberSql.RsCount - 1
                strXML  = strXML & "<set label='"& dfmemberSql.Rs(i,"IU_REGDATE") & "' name='"& dfmemberSql.Rs(i,"IU_REGDATE") & "' value='" & dfmemberSql.Rs(i,"cnt") & "'/>"
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
function getID(IU_ID)
{
    detailFrame.location.href = "Login_statDetail.asp?type=3&IU_ID=" + IU_ID ;
}
</script>
</head>

<body topmargin="0" marginheight="0">
<table border="1" bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
  <tr>
    <td bgcolor="706E6E" style="padding-left:12" height="23">
	  <b>
	    <font color="FFFF00">회원관리</font>
		<font color="ffffff">&nbsp;&nbsp;▶ 회원 회원가입 통계
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

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
    <td>
        <div id="chart1"></div>
    </td>
</tr>
</table>

<iframe name="detailFrame" width="100%" height="350" frameborder="0" scrolling="no"></iframe>
<script type="text/javascript">
    var xmlData = "<%= strXML %>" ;
    var chart1 = new FusionCharts("/FusionCharts/Column3D.swf", "회원가입", "800", "600", "0", "1");
    chart1.setDataXML(xmlData);    
    chart1.render("chart1"); 
</script>
</body>
</html>