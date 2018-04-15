<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/11_Event/_Sql/eventSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
    
    '######### Request Check                    ################	    
    
    IGI_STARTDATE            = Trim(dfRequest.Value("IGI_STARTDATE"))
	
	IF IGI_STARTDATE = "" Then
	    IGI_STARTDATE = date()
	End IF
	
		
	IGI_PREVTDATE = dateadd("d",-1, IGI_STARTDATE)
	IGI_NEXTTDATE = dateadd("d",1, IGI_STARTDATE)
	
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    	
	'######### ���� ����Ʈ�� �ҷ���                 ################	

	Call dfeventSql.GetINFO_GAME_INNING(dfDBConn.Conn,  IGI_STARTDATE, IGI_NEXTTDATE)

%>	
<html>
<head>
<title>�̴� �̺�Ʈ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script language="javascript">

function LockF5(){
	if (event.keyCode == 116) {
		event.keyCode = 0;
		return false;
	}	
}
document.onkeydown = LockF5;

</script>

</head>
<body>
�̴� �̺�Ʈ <br />
<table cellpadding="5" cellspacing="1" border="0" width="500" align="center" bgcolor="#AAAAAA">
<tr bgcolor="#EEEEEE">
    <td align="center">
        <a href="list.asp?IGI_STARTDATE=<%= IGI_PREVTDATE %>"><%= IGI_PREVTDATE %></a>
    </td>
    <td align="center">
        <a href="list.asp?IGI_STARTDATE=<%= IGI_STARTDATE %>"><%= IGI_STARTDATE %></a>
    </td>
    <td align="center">
        <a href="list.asp?IGI_STARTDATE=<%= IGI_NEXTTDATE %>"><%= IGI_NEXTTDATE %></a>
    </td>
</tr>
</table>
<br />

<% IF dfeventSql.RsCount = 0 Then %>
<form name="addForm" method="post" action="insertGame.asp" >
<table width="100%" cellpadding="5" cellspacing="1" border="0" bgcolor="#AAAAAA">
<tr>
    <td bgcolor="#EEEEEE" width="150">��� �ð�</td>
    <td bgcolor="#FFFFFF">
          <input type="text" name="IGI_STARTTIME" class="input_box1" />
          <br /> Ex) <%= date() %> 16:30:00
    </td>
</tr>
<tr>
    <td bgcolor="#EEEEEE" width="150">�̺�Ʈ ���� �ð�</td>
    <td bgcolor="#FFFFFF">
          <input type="text" name="IGI_EVENTTIME" class="input_box1" />
          <br /> Ex) <%= date() %> 16:30:00
    </td>
</tr>
<tr>
    <td bgcolor="#EEEEEE" width="150">Ȩ��</td>
    <td bgcolor="#FFFFFF">
          <input type="text" name="IGI_TEAM1" class="input_box1" />
    </td>
</tr>
<tr>
    <td bgcolor="#EEEEEE" width="150">������</td>
    <td bgcolor="#FFFFFF">
          <input type="text" name="IGI_TEAM2" class="input_box1" />
    </td>
</tr>
<tr>
    <td bgcolor="#EEEEEE" width="150">�ʱ� �����</td>
    <td bgcolor="#FFFFFF">
          <input type="text" name="IGI_RESULT" value="0000000000" class="input_box1" />
    </td>
</tr>
</table>
<input type="submit" value="            ���                  "  class="input2" />
</form>
<% Else %>
<script type="text/javascript">
function openInningResult(IGID_INNING)
{
    window.open("updateInning.asp?IGI_IDX=<%= dfeventSql.RsOne("IGI_IDX") %>&IGI_RESULT=<%= Trim(dfeventSql.RsOne("IGI_RESULT")) %>&IGID_INNING=" + IGID_INNING, "inning","width=200,height=200");
}

function addBetEvent()
{
    var userCount = document.getElementById("userCount").value ; 
    window.open("addBetEvent_proc.asp?IGI_STARTTIME=<%= dfeventSql.RsOne("IGI_STARTTIME") %>&IGI_IDX=<%= dfeventSql.RsOne("IGI_IDX") %>&top=" + userCount, "inning","width=200,height=200");
}

function delEvent()
{
    window.open("delEvent_proc.asp?IGI_IDX=<%= dfeventSql.RsOne("IGI_IDX") %>", "del","width=200,height=200");
}
</script>
<table width="100%" cellpadding="5" cellspacing="1" border="0" bgcolor="#AAAAAA">
<tr height="25" bgcolor="#EEEEEE">
    <td>���۽ð�</td>
    <td width="150">����1</td>
<%
    For ii = 1 to 9
%>  
    <td><%= ii %></td>
<%
    Next
%>
    <td>����</td>
    <td>����2</td>        
</tr>
<tr height="25" bgcolor="#FFFFFF">
    <td rowspan="4" width="15%">
        <%= dfeventSql.RsOne("IGI_STARTTIME") %><br />
        �̺�Ʈ ����<br />
        <%= dfeventSql.RsOne("IGI_EVENTTTIME") %>
    </td>
    <td rowspan="4" width="15%">
        <%= dfeventSql.RsOne("IGI_TEAM1") %>
    </td>
<%
    For ii = 0 to dfeventSql.RsCount - 1
%>  
    <td>
        <%= dfeventSql.Rs(ii,"IGID_SCORE1") %>
    </td>
<%
    Next
%>
    <td rowspan="4" width="15%">
        <%= dfeventSql.RsOne("IGI_TEAM2") %>
    </td>        
</tr>
<tr height="25" bgcolor="#FFFFFF">
<%
    IGI_RESULT =""
    For ii = 0 to dfeventSql.RsCount - 1
        
%>  
   <td>
        <%= dfeventSql.Rs(ii,"IGID_SCORE2") %>
    </td>
<%
    Next
%>
</tr>
<tr height="25" bgcolor="#FFFFFF">

<%  
    IGI_RESULT = ""
    For ii = 0 to dfeventSql.RsCount - 1
        IF dfeventSql.Rs(ii,"IGID_RESULT")  = 0 Then
            response.Write "<td>-</td>"
        ElseIF dfeventSql.Rs(ii,"IGID_RESULT")  = 1 Then
            IGI_RESULT = IGI_RESULT & dfeventSql.Rs(ii,"IGID_RESULT") 
            response.Write "<td>Ȧ</td>"
        ElseIF dfeventSql.Rs(ii,"IGID_RESULT")  = 2 Then
            IGI_RESULT = IGI_RESULT & dfeventSql.Rs(ii,"IGID_RESULT") 
            response.Write "<td>¦</td>"
        End IF

    Next
    
%>
</tr>
<tr height="25" bgcolor="#FFFFFF">
<%
    For ii = 1 to 10
%>  
    <td>
        <input type="button" class="input2" value="����" onclick="openInningResult(<%= ii %>);"/>
    </td>
<%
    Next
%>
</tr>
</table>
<input type="text" id="userCount" value="100"  />
<input type="button" value="�̺�Ʈ�����ϱ�" class="input2" onclick="addBetEvent();" />
<input type="button" value="�̺�Ʈ�ʱ�ȭ" class="input2" onclick="delEvent();" />
<%

    Set dfeventSql1 = new eventSql	
    Call dfeventSql1.RetrieveINFO_GAME_INNING_USER(dfDBConn.Conn, dfeventSql.RsOne("IGI_IDX"))
    
    response.Write "<Br>������ : " &  dfeventSql1.RsCount & "��<br>"
%>
<table width="100%">
<tr>
    <td width="50%" valign="top">
        <table width="100%" id="tblSuccess" >
<%

    IF dfeventSql1.RsCount <> 0 Then
        For ii = 0 to dfeventSql1.RsCount - 1
        
            if dfeventSql1.Rs(ii,"IGIU_IP") = "" or isNull(dfeventSql1.Rs(ii,"IGIU_IP") ) Then
                userBgColor = "#FFFFFF"
            Else
                userBgColor = "#69A0D2"
                IF dfeventSql1.Rs(ii,"IGIU_IP") = "119.193.6.112" Then
                    userBgColor = "#FFFFFF"
                End IF                
            End IF
%>        
        <tr class="<%= dfeventSql1.Rs(ii,"IGIU_RESULT") %>"  style="display:block">
        <td bgcolor="<%= userBgColor %>"><%= dfeventSql1.Rs(ii,"IGIU_NAME") %></td>
        <td>
        <div>
        <%
            
           FOR jj = 1 to Len(dfeventSql1.Rs(ii,"IGIU_RESULT"))                
                fChar = Mid(dfeventSql1.Rs(ii,"IGIU_RESULT") ,jj,1)
                IF cStr(fChar) = "1" Then
                    response.Write "Ȧ "
                Else
                    response.Write "¦ "
                End IF
           Next
        
        %>
        </div>
        </td>
        <td><%= dfeventSql1.Rs(ii,"IGIU_REGDATE") %></td>
        <td><%= dfeventSql1.Rs(ii,"IGIU_CONTENT") %></td>
    </tr>
<%
        Next
    End IF
%>        
    </table>          
    </td>
    <td width="50%" valign="top">
    <table width="100%" id="tblFalse" >
<%

    IF dfeventSql1.RsCount <> 0 Then
        For ii = 0 to dfeventSql1.RsCount - 1
            if dfeventSql1.Rs(ii,"IGIU_IP") = "" or isNull(dfeventSql1.Rs(ii,"IGIU_IP") ) Then
                userBgColor = "#FFFFFF"
            Else
                userBgColor = "#69A0D2"
                IF dfeventSql1.Rs(ii,"IGIU_IP") = "119.193.6.112" Then
                    userBgColor = "#FFFFFF"
                End IF                   
            End IF
%>        
    <tr class="<%= dfeventSql1.Rs(ii,"IGIU_RESULT") %>"  style="display:block">
        <td bgcolor="<%= userBgColor %>"><%= dfeventSql1.Rs(ii,"IGIU_NAME") %></td>
        <td>
        <div>
        <%
            
           FOR jj = 1 to Len(dfeventSql1.Rs(ii,"IGIU_RESULT"))                
                fChar = Mid(dfeventSql1.Rs(ii,"IGIU_RESULT") ,jj,1)
                IF cStr(fChar) = "1" Then
                    response.Write "Ȧ "
                Else
                    response.Write "¦ "
                End IF
           Next
        
        %>
        </div>
        </td>
        <td><%= dfeventSql1.Rs(ii,"IGIU_REGDATE") %></td>
        <td><%= dfeventSql1.Rs(ii,"IGIU_CONTENT") %></td>
    </tr>
<%
        Next
    End IF
%>        
    </table>      
    </td>
</tr>
</table>
<script type="text/javascript">

showHideResult("<%= IGI_RESULT %>");
function showHideResult(result)
{
    var cutLen = result.length;
    var tblSuccess = document.getElementById("tblSuccess");        
    var trSuccess = tblSuccess.getElementsByTagName('tr');
    var tblFalse = document.getElementById("tblFalse");
    var trFalse = tblFalse.getElementsByTagName('tr');
        

    
    if(trFalse.length > 0)
    {
        for(var i=0;i<trFalse.length;i++)
        {                    
            if(trFalse[i].className.substr(0,cutLen) !=result)  trFalse[i].style.display = "block";
            if(trFalse[i].className.substr(0,cutLen) ==result)  trFalse[i].style.display = "none";
        }
    }
    
    if(trSuccess.length > 0)
    {
        for(var i=0;i<trSuccess.length;i++)
        {                    
            if(trSuccess[i].className.substr(0,cutLen) ==result)  trSuccess[i].style.display = "block";
            if(trSuccess[i].className.substr(0,cutLen) !=result)  trSuccess[i].style.display = "none";
        }
    }
    
}                                                        

</script>
<%    
End IF
%>

</body>
</html>