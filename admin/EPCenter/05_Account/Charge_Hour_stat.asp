<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/05_Account/_Sql/accountSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
    
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999)
	pageSize = 100
    sStartDate  = REQUEST("sStartDate")
    sEndDate = REQUEST("sEndDate")
    Search = REQUEST("Search")
	Find = REQUEST("Find")
	site = REQUEST("JOBSITE")
	
    IF sStartDate <> "" Then
        sStartDate  = dateValue(sStartDate) & " 00:00:00"
        sEndDate  = dateValue(sStartDate) & " 23:59:59"
    Else
        sStartDate  = dateValue(now()) & " 00:00:00"   
        sEndDate  = dateValue(now()) & " 23:59:59"
    End IF
    
    IF site = "" Then
        site = "all"
    End IF
    
    
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### ���� ������ ������                 ################	
   
	Call dfAccountSql.GetINFO_CHARGEByHourStat(dfDBConn.Conn, sStartDate, sEndDate, site)


    CNT = 0 
    CNT1 = 0 
    SUM_ABMOUNT = 0 
    SUM_ABMOUNT1 = 0 
	strXML = ""
	strXML1 = ""
	strXML  = strXML &  "<chart caption='date' >" 		
    IF dfAccountSql.RsCount <> 0 Then
        For i = 0 to dfAccountSql.RsCount - 1
            strXML  = strXML & "<set label='"& dfAccountSql.Rs(i,"HH") & "' name='"& dfAccountSql.Rs(i,"HH") & "' value='" & dfAccountSql.Rs(i,"CNT") & "'/>"
            CNT = CNT + dfAccountSql.Rs(i,"CNT")
            IF dfAccountSql.Rs(i,"HH")  < 12 Then
                CNT1 = CNT1 + dfAccountSql.Rs(i,"CNT")
            End IF
        Next
    End IF
    
    strXML  = strXML & "</chart>"    
        
	strXML1  = strXML1 &  "<chart caption='date' >" 		
    IF dfAccountSql.RsCount <> 0 Then
        For i = 0 to dfAccountSql.RsCount - 1
            strXML1  = strXML1 & "<set label='"& dfAccountSql.Rs(i,"HH") & "' name='"& dfAccountSql.Rs(i,"HH") & "' value='" & dfAccountSql.Rs(i,"SUM_AMOUNT")/10000 & "'/>"
            SUM_ABMOUNT = SUM_ABMOUNT +  dfAccountSql.Rs(i,"SUM_AMOUNT") 
            IF dfAccountSql.Rs(i,"HH")  < 12 Then
                SUM_ABMOUNT1 = SUM_ABMOUNT1 + dfAccountSql.Rs(i,"SUM_AMOUNT")
            End IF            
        Next
    End IF
    
    strXML1  = strXML1 & "</chart>"    

%>

<html>
<head>
<title>���� �ð��� ���</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script type="text/javascript" src="/FusionCharts/FusionCharts.js"></script>
</head>

<body topmargin="0" marginheight="0">

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> ���� �ð��� ���</b></td>
</tr>
</table>    
<div style="height:10px;"></div>
<!-- �˻��� -->
<table border="0" cellpadding="0" cellspacing="0" align="right">
<form name="searchForm" action="Charge_Hour_stat.asp" method="get">
<tr>
    <td>
        <select name="JOBSITE">
            <option>ALL</option>
        </select>
    </td>
    <td>
        <input type="text" name="sStartDate"  class="input" value="<%= dateValue(sStartDate) %>" />            
    </td>
    <td>
        <input type="submit" value="    �˻�    "  class="input" />            
    </td>
</tr>
</form>
</table>
<br /><br /><br />
<table>
<tr>
    <td>
        <b>
        <%= dateValue(sStartDate) %>
        ���Աݾ� : <%= formatNumber(SUM_ABMOUNT,0) %>��
        ���ԱݰǼ� : <%= formatNumber(CNT,0) %>��<br />
        ���� �Աݾ� : <%= formatNumber(SUM_ABMOUNT1,0) %>��
        ���� �ԱݰǼ� : <%= formatNumber(CNT1,0) %>��<br />
        ���� �Աݾ� : <%= formatNumber(SUM_ABMOUNT-SUM_ABMOUNT1,0) %>��
        ���� �ԱݰǼ� : <%= formatNumber(CNT-CNT1,0) %>��<br />        
        </b>
    </td>
</tr>
</table>
<br />
<!-- �˻��� -->
<table width="100%">
<tr>
    <td valign="top">
        <%= dateValue(sStartDate) %> �� �ð��� �Ա� ���
        <table width="100%" cellpadding="3" cellspacing="1" border="0" bgcolor="#AAAAAA">
        <tr bgcolor="#EEEEEE">
            <td>�ð�</td>
            <td>�Ǽ�</td>
            <td>�ݾ�</td>
        </tr>
<%
    IF dfAccountSql.RsCount <> 0 Then
        For i = 0 to dfAccountSql.RsCount - 1
            response.Write "<tr bgcolor='#FFFFFF'><td>" & dfAccountSql.Rs(i,"HH") & "��</td><td>" & dfAccountSql.Rs(i,"CNT") & "��</td><td>" & formatnumber(dfAccountSql.Rs(i,"SUM_AMOUNT"),0) & "��</td></tr>"                            
        Next
    End IF    
%>        
        </table>
    </td>
    <td valign="top">
        <div id="chart1"></div>
    </td>
    <td valign="top">
        <div id="chart2"></div>
    </td>        
</tr>
</table>
<script type="text/javascript">
    var xmlData = "<%= strXML %>" ;
    var chart1 = new FusionCharts("/FusionCharts/Column3D.swf", "����íƮ", "400", "250", "0", "1");
    chart1.setDataXML(xmlData);    
    chart1.render("chart1"); 
    var xmlData = "<%= strXML1 %>" ;
    var chart1 = new FusionCharts("/FusionCharts/Column3D.swf", "����íƮ", "400", "250", "0", "1");
    chart1.setDataXML(xmlData);    
    chart1.render("chart2");     
</script>

</body>
</html>

