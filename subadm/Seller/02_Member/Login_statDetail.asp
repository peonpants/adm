<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/Seller/02_Member/_Sql/memberSql.Class.asp"-->
<%
    
    '######### Request Check                    ################	    
       
    reqType            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("type")), 1, 1, 4) 
    IU_NICKNAME            = Trim(dfRequest.Value("IU_NICKNAME"))
    LL_REGDATE            = Trim(dfRequest.Value("LL_REGDATE"))
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
    
    
    	
	'######### 회원 리스트를 불러옴                 ################	
    Dim strXML
    
    IF reqType = 3 Then
	    Call dfmemberSql.RetrieveLOG_LOGINByDay(dfDBConn.Conn,  reqType, IU_NICKNAME,JOBSITE)
    ElseIF reqType = 4 Then
    
        Call dfmemberSql.RetrieveLOG_LOGINByDay(dfDBConn.Conn,  reqType, LL_REGDATE, JOBSITE)
        
    End IF
	
	IF reqType = 3 Then
	    Set dfmemberSql1 = new memberSql
	    Call dfmemberSql1.GetINFO_NICKNAME(dfDBConn.Conn,  IU_NICKNAME)
	End IF
	
	strXML  = strXML &  "<chart caption='date' >" 
    IF dfmemberSql.RsCount <> 0 Then
        For i = 0 to dfmemberSql.RsCount - 1
            IF reqType = 3 Then
                strXML  = strXML & "<set label='"& dfmemberSql.Rs(i,"LL_REGDATE") & "' name='"& dfmemberSql.Rs(i,"LL_REGDATE") & "' value='" & dfmemberSql.Rs(i,"cnt") & "'/>"
            ElseIF reqType = 4 Then                
                strXML  = strXML & "<set label='"& dfmemberSql.Rs(i,"LL_NICKNAME") & "' name='"& dfmemberSql.Rs(i,"LL_NICKNAME") & "' value='" & dfmemberSql.Rs(i,"cnt") & "'/>"
            End IF
        Next
    End IF
    
    strXML  = strXML & "</chart>"
    
%>

<html>
<head>
<title></title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/Seller/Css/Style.css">
<script type="text/javascript" src="/FusionCharts/FusionCharts.js"></script>

<script type="text/javascript">
function loginList()
{
    window.open("/Seller/01_cp/login_list.asp?Search=LL_NICKNAME&Find=<%= IU_NICKNAME %>");
}    

function userInfo(IU_IDX)
{
    window.open("/Seller/02_Member/View.asp?IU_IDX=" +  IU_IDX);
}    

</script>
</head>

<body>

<table>
<tr height="350">
    <td>
        <div id="chart1"></div>
    </td>
    <td>
        <div style="width:350px;height:350px;overflow:auto"> 
        <% 
            IF reqType = 3  Then
                IF dfmemberSql1.RsCount <> 0 Then 
        %>
        <a href="javascript:userInfo(<%= dfmemberSql1.RsOne("IU_IDX") %>);">[ <%= IU_NICKNAME %> 회원의 정보 바로가기] </a><br />
        <%      End IF
            End IF
        %>
        <% IF IU_NICKNAME <> "" Then %>
        <a href="javascript:loginList();">[ <%= IU_NICKNAME %> 회원의 로그인 로그 바로가기 ] </a>
        <% End IF %>
        <table width="100%" cellpadding="3" cellspacing="1" border="0" bgcolor="#AAAAAA">
<%
    IF dfmemberSql.RsCount <> 0 Then
        For i = 0 to dfmemberSql.RsCount - 1
            IF reqType = 3 Then
                response.Write "<tr bgcolor='#FFFFFF'><td>" & dfmemberSql.Rs(i,"cnt") & "</td><td>" & dfmemberSql.Rs(i,"LL_REGDATE") & "</td></tr>"
            Else                
                response.Write "<tr bgcolor='#FFFFFF'><td>" & dfmemberSql.Rs(i,"cnt") & "</td><td>" & dfmemberSql.Rs(i,"LL_NICKNAME") & "</td></tr>"
            End IF
                            
        Next
    End IF    
%>        
        </table>
        </div>
    </td>
</tr>
</table>
<iframe name="detailFrame" width="100%" height="400" frameborder="0"></iframe>
<script type="text/javascript">
    var xmlData = "<%= strXML %>" ;
    var chart1 = new FusionCharts("/FusionCharts/Column3D.swf", "배팅챠트", "600", "350", "0", "1");
    chart1.setDataXML(xmlData);    
    chart1.render("chart1"); 
</script>
</body>
</html>