<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<%
	Page		= Trim(dfRequest("Page"))
	SFlag		= Trim(dfRequest("SFlag"))	
	SRS_Sports	= Trim(dfRequest("SRS_Sports"))
	SRL_League	= Trim(dfRequest("SRL_League"))

    IG_IDX		= Trim(dfRequest("IG_IDX"))

    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    	
	'######### ���� ���� �󼼸� �ҷ���                 ################	    
	Call dfgameSql.GetInfo_Game(dfDBConn.Conn,  IG_IDX)
	
    IF dfgameSql.RsCount <> 0 Then
	    RL_LEAGUE		= dfgameSql.RsOne("RL_LEAGUE")
	    IG_STARTTIME	= dfgameSql.RsOne("IG_STARTTIME")
	    IG_TEAM1		= dfgameSql.RsOne("IG_TEAM1")
	    IG_TEAM2		= dfgameSql.RsOne("IG_TEAM2")
	    IG_HANDICAP		= dfgameSql.RsOne("IG_HANDICAP")
	    IG_STATUS		= dfgameSql.RsOne("IG_STATUS")
	    IG_Score1		= dfgameSql.RsOne("IG_SCORE1")
	    IG_Score2		= dfgameSql.RsOne("IG_SCORE2")
	    IG_Type         = dfgameSql.RsOne("IG_TYPE")
    End IF
    IF IG_Type = 1 Then
        txtIG_Type  = "�ڵ�ĸ"    
    ElseIF IG_Type = 2 Then
        txtIG_Type  = "����/���"    
    Else
        txtIG_Type  = "�¹���"    
    End IF
    
%>

<html>
<head>
    <title>����Է�</title>
    <link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
    <!--<script src="/Sc/Base.js"></script>-->
    <script>
	    function FrmChk() {
		    var frm = document.frm1;
    		
		    if (frm.IG_Score1.value == "") {
			    alert("Ȩ���� ���ھ �����ּ���.");
			    frm.IG_Score1.focus();
			    return false;
		    }
    		
		    if (frm.IG_Score2.value == "") {
			    alert("�������� ���ھ �����ּ���.");
			    frm.IG_Score2.focus();
			    return false;
		    }
    		
		    if (!confirm("<%=IG_TEAM1%> "+frm.IG_Score1.value+" : "+frm.IG_Score2.value+" <%=IG_TEAM2%>\n��� ����� �Ͻðڽ��ϱ�?\nȮ���� �����ø� ����� ��� ���ӸӴϿ� �ݿ��� �˴ϴ�.")) {
			    return;
		    }
		    else
			    frm.submit();
    		
	    }
	    
    function goGameCancel(gidx) 
    {
	    if (!confirm("���� ����Ͻðڽ��ϱ�?\n\n��ҽ� �ش� ���ÿ� ���� ȯ��ó���� �̷�� ���ϴ�.")) return;		
	    exeFrame.location.href="ResultGame_Step1_Proc.asp?IG_Idx="+gidx + "&IG_Cancel=1";
    }	

    function goBettingList(gidx) 
    {
	    if (!confirm("���ø���Ʈ�� ���ðڽ��ϱ�?\n\n������ �ε� �ӵ��� ������ ���� �� �ֽ��ϴ�..")) return;		
	    exeFrame.location.href="ResultGame_Step2.asp?IG_Idx="+gidx;
    }	
    function goInsertMoney(gidx) 
    {
	    if (!confirm("�����ϱ� �Ͻðڽ��ϱ�?\n\nȮ���� �����ø� ����� ��� ���ӸӴϿ� �ݿ��� �˴ϴ�.")) return;		
	    exeFrame.location.href="ResultGame_Step3.asp?IG_Idx="+gidx;
    }	    
    function goRollBack(gidx)    	    
    {
	    if (!confirm("���굹���� �Ͻðڽ��ϱ�?\n\nȮ���� ������� �������·� ���ư��ϴ�.")) return;		
	    exeFrame.location.href="ResultGame_RollBack.asp?IG_Idx="+gidx;    
    }
    </script>
    <style>
.input3     {font-size: 12px; color: #000000;  font-family: verdana,����, Tahoma; height:22px; border: 1px solid #6C6C6C; padding:2px; background-color:F5FDBD;}
.input4     {font-size: 12px; color: #000000;  font-family: verdana,����, Tahoma; height:22px; border: 1px solid #6C6C6C; padding:2px; background-color:F4DAFE;}
.input5     {font-size: 12px; color: #000000;  font-family: verdana,����, Tahoma; height:22px; border: 1px solid #6C6C6C; padding:2px; background-color:C7CBFF;}
</style>
</head>
<body marginheight="0" marginwidth="0">

<table width="100%" cellpadding="0" cellspacing="1" border="0" bgcolor="#AAAAAA">
<form name="frm1" target="exeFrame" action="ResultGame_Step1_Proc.asp">
<input type="hidden" name="IG_IDX" value="<%=IG_IDX%>">
<input type="hidden" name="Page" value="<%=Page%>">
<input type="hidden" name="SRS_Sports" value="<%=SRS_Sports%>">
<input type="hidden" name="SRL_League" value="<%=SRL_League%>">
<input type="hidden" name="SFlag" value="<%=SFlag%>">
<tr height="25" bgcolor="#FFFFFF">
    <td align="center"><b><%= txtIG_Type %></b>-<%=RL_LEAGUE%></td>
	<td colspan="2">&nbsp;<%=IG_STARTTIME%></td>
</tr>
<tr height="25" bgcolor="#FFFFFF">
    <td width="33%"  align="center">Ȩ:<%=IG_TEAM1%></td>
	<td width="33%"  align="center">������</td>
	<td width="33%"  align="center">����:<%=IG_TEAM2%></td>
</tr>
<tr height="25" bgcolor="#FFFFFF">
<td align="center">&nbsp;<input type="text" name="IG_Score1" value="<%=IG_Score1%>" style="width:40px;border:1px solid;text-align:center;" maxlength="3"></td>
	<td align="center"><%=IG_HANDICAP%></td>
	<td align="center">&nbsp;<input type="text" name="IG_Score2" value="<%=IG_Score2%>" style="width:40px;border:1px solid;text-align:center;" maxlength="3">
</td>
</tr>
</table>

<table width="100%" cellpadding="0" cellspacing="" border="0" bgcolor="#AAAAAA">
<tr height="25" bgcolor="#FFFFFF">
    <td width="33%"  align="center">	    
	    <input type="button" value="�������"       class="input" onclick="FrmChk();">
	    <input type="button" value="�������"       class="input" onclick="goGameCancel(<%= IG_IDX %>);">
    </td>	    
    <td width="33%"  align="center">	    
	    <input type="button" value="���ó�������"   class="input" onclick="goBettingList(<%= IG_IDX %>);">
    </td>	    
    <td width="33%"  align="center">	    	    
        <input type="button" value="�����ϱ�"       class="input" onclick="goInsertMoney(<%= IG_IDX %>);">
        <input type="button" value="���굹����"     class="input3" onclick="goRollBack(<%= IG_IDX %>);" >
	</td>
</tr>
</table>
<iframe width="100%" height="600" name="exeFrame"></iframe>
</form>
</body>
</html>
