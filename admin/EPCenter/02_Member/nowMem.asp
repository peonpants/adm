<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>

<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/EPCenter/05_Account/_Sql/accountSql.Class.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<%
    nn = 0 
    nn1 = 0
	SQLLIST2 = "select  IU_IDX, iu_id, iu_nickName, iu_cash,iu_point, (select top 1 c_dir from realtime_log where iu_id = a.iu_id order by REGDATE desc) as c_dir , IU_LOGIN_CNT, IU_CHARGE, IU_EXCHANGE , IU_SITE from  info_user a where a.iu_id IN (select iu_id from realtime_log) and iu_level <>  9 and iu_logout is null order by iu_site "
	SET RS2 = DBCON.EXECUTE(SQLLIST2)

	
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
    
	'######### �׷캰 ���� ����Ʈ�� �ҷ���	################
	Call dfCpSql.RetrieveINFO_ADMIN(dfDBConn.Conn, request.Cookies("GROUP"), request.Cookies("AdminLevel"))

%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">

</head>
<body topmargin="0" marginheight="0">

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td>
        <b class="text07"> ȸ�� ���� &nbsp;&nbsp; ��  ���������� & �޼���
	      </b>
    </td>
</tr>
</table>    
<div style="height:10px;"></div>
<table width="900" border="0" acellpadding="3" cellspacing="1" bgcolor="#AAAAAA">
	<tr height='25' bgcolor="#EEEEEE">
	    <td align="center" ><b>��ȣ</b></td>
	    <td align="center" ><b>���̵�</b></td>
	    <td align="center" ><b>�г���</b></td>
	    <td align="center" ><b>��ġ</b></td>
	    <td align="center" ><b>ĳ��</b></td>
	    <td align="center" ><b>����Ʈ</b></td>
	    <td align="center" ><b>�α���</b></td>
	    <td align="center" ><b>�Ա�</b></td>
	    <td align="center" ><b>���</b></td>
	    <td align="center" ><b>����Ʈ</b></td>
	    <td align="center" ><b>����</b></td>
	    <td align="center" ><b>����</b></td>
	    <td align="center" ><b>�Խñ�</b></td>
	    <td align="center" ><b>�ñ�</b></td>
	</tr>
<%
    
    		
	IF NOT RS2.EOF Then
        DO WHILE NOT RS2.EOF
            IF Rs2("IU_SITE") = "news" Then
		        nn = nn + 1		        
            Else
                nn1 = nn1 + 1
            End IF
%>
    <tr bgcolor="#ffffff">
        <td>
<%
            IF Rs2("IU_SITE") = "news" Then
		        response.Write nn
            Else
                response.Write nn1
            End IF    
%>                
        </td>
        <td><a href="View.asp?IU_IDX=<%= RS2("iu_idx") %>"><%= RS2("IU_ID") %></a></td>
        <td><%= RS2("IU_nickname") %></td>
        <td><%
cb_dir=RS2("c_dir")
		if InStr(1,cb_dir, "support_m",1) > 0 then%>����ϰ�������
		<%elseif  InStr(1,cb_dir, "support",1) > 0 then%>��������
		<%elseif  InStr(1,cb_dir, "game",1) > 0 then%>����ȭ��&���������
		<%elseif  InStr(1,cb_dir, "event",1) > 0 then%>�̺�Ʈ
		<%elseif  InStr(1,cb_dir, "guide",1) > 0 then%>�̿�ȳ�
		<%elseif  InStr(1,cb_dir, "freeboard",1) > 0 then%>�Խ���
		<%elseif  InStr(1,cb_dir, "money",1) > 0 then%>��ȯ��
		<%elseif  InStr(1,cb_dir, "member ",1) > 0 then%>���ó���&ȸ������		 
		<%elseif  isnull(cb_dir) then%>����ȭ��
		<%else%>
		<%=cb_dir%>
		<%end if%>
		</td>
        <td><%= formatNumber(RS2("IU_CASH"),0) %></td>
        <td><%= formatNumber(RS2("IU_POINT"),0) %></td>
        <td><%= formatNumber(RS2("IU_LOGIN_CNT"),0) %></td>
        <td><%= formatNumber(RS2("IU_CHARGE"),0) %></td>     
        <td><%= formatNumber(RS2("IU_EXCHANGE"),0) %></td>                
        <td><%= RS2("IU_SITE") %></td>
        <td><input type="button" value="����" onclick="location.href='Write_Message.asp?cd=<%=RS2("IU_ID")%>&cdi=<%=RS2("IU_IDX")%>'" style="border: 1 solid; background-color:#C5BEBD;"> </td>
        <td><input type="button" value="����" onclick="location.href='/EPCenter/04_Game/Betting_List.asp?Search=IB_ID&Find=<%= RS2("IU_ID") %>'" style="border: 1 solid; background-color:#C5BEBD;"></td>
        <td><input type="button" value="�Խñ�" onclick="location.href='/EPCenter/08_Board/Board_List.asp?Search=BF_Writer&Find=<%= RS2("IU_nickname") %>'" style="border: 1 solid; background-color:#C5BEBD;"></td>    
      <td><input type="button" value="�ñ�" onclick="location.href='user_logount.asp?mode=user&iu_id=<%=RS2("IU_ID")%>'" style="border: 1 solid; background-color:#C5BEBD;"> </td>		
    </tr>
<%



		RS2.MOVENEXT
		LOOP
	END IF 

%>
</table>

<script type="text/javascript">
	function Checkform()
	{
		frm = document.frm1;
		if (frm.BC_TITLE.value == "") { alert("\n ������ �Է��ϼ���. \n"); frm.BC_TITLE.focus(); return false; }
		if (frm.BC_CONTENTS.value == "") { alert("\n ������ �Է��ϼ���. \n"); frm.BC_CONTENTS.focus(); return false; }
		frm.submit();	
	}
</script>


<form name="frm1" method="post" action="Message_Proc.asp">
�� ���� ������ & ��üȸ�� ����������<br />

<table width="700" border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA">
<tr>
    <td  colspan="2" bgcolor="eeeeee" align="LEFT" width="100%" nowrap><b><font color="red">**���������ڿ����� �������о��� ��ü������ �߼۵˴ϴ�</b></td>
</tr>

<tr>
<%
	IF dfCpSql.RsCount <> 0 Then
%>
<td bgcolor="eeeeee" align="center" width="120" nowrap><b>����Ʈ</b></td>
<td bgcolor="#FFFFFF">
<%
		For i = 0 to dfCpSql.RsCount - 1

			if site = dfCpSql.Rs(i,"IA_SITE") Then
				cheked = "cheked"
			Else
				cheked = ""
			End IF
%>
	<input type="radio" name="BC_SITE" value="<%= dfCpSql.Rs(i,"IA_SITE") %>" <%=cheked%> /> <%= dfCpSql.Rs(i,"IA_SITE") %>
<%
		Next
%>
</td>
<%
		
	End IF
%>
</tr>
<tr>
    <td bgcolor="eeeeee" align="center" width="120" nowrap><b>����</b></td>
    <td bgcolor="#FFFFFF">
        <input type="radio" name="bc_mode" value="nowMem" checked /> ���� ������
        <input type="radio" name="bc_mode" value="allMem" /> ��ü ȸ��
   	</td>
</tr>
<tr>
    <td bgcolor="eeeeee" align="center" width="120" nowrap><b>����</b></td>
    <td bgcolor="#FFFFFF">
        <input type="radio" name="bcl_mode" value="alllevel" checked /> ��ü����
        <input type="radio" name="bcl_mode" value="1level" /> 1����
        <input type="radio" name="bcl_mode" value="2level" /> 2����
        <input type="radio" name="bcl_mode" value="3level" /> 3����
        <input type="radio" name="bcl_mode" value="4level" /> 4����
        <input type="radio" name="bcl_mode" value="5level" /> 5����
   	</td>
</tr>
<tr>
    <td bgcolor="eeeeee" align="center" width="120" nowrap><b>��&nbsp;&nbsp;��</b></td>
   	<td bgcolor="#FFFFFF">&nbsp;<input name="BC_TITLE" class=box2 style="WIDTH: 580px;border: 1 solid;"></td>
</tr>
<tr>
    <td bgcolor="eeeeee" align="center" width="120" nowrap><b>�۾���</b></td>
   	<td bgcolor="#FFFFFF">&nbsp;<input name="BC_MANAGER" class=box2 style="WIDTH: 120px;border: 1 solid;" value="������" readonly></td>
</tr>
<tr>
    <td bgcolor="eeeeee" align="center" width="120" nowrap><b>��&nbsp;&nbsp;��</b></td>
    <td bgcolor="#FFFFFF"><textarea name="BC_CONTENTS" style="width:580px;height:300px;overflow:hidden;border: 1 solid;" class="box2"></textarea>
</td>    
</tr>
</table>

<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td align="center"> 
	    <input type="button" value=" �� �� " onclick="javascript:Checkform()" style="border: 1 solid; background-color: #C5BEBD;">
	    <input type="button" value=" ��� "  onclick="history.back(-1);" style="border: 1 solid; background-color: #C5BEBD;">
	</td>
</tr>
</table>
</form>
</body>
</html>