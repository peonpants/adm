<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->


<%
'=================================================================================   ȫ����
' ���ӱ��� ��ü���� üũ�ڽ� �����
'  jquery-1.4.1.min.js  ���
'
'
'
'=================================================================================   ȫ����



	SRS_Sports	= REQUEST("SRS_Sports")
	SRL_League	= REQUEST("SRL_League")
	SFlag		= REQUEST("SFlag")
	Page		= REQUEST("Page")
    ea		= REQUEST("ea")
    IF ea = "" Then
        ea = 1
    End IF
    
	IF SRS_Sports = "" THEN SRS_Sports = "�౸"
%>

<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<!-- <script src="/Sc/Base.js"></script> -->


<%'================================================================================= ȫ %>
<script src="/js/jquery-1.4.1.min.js" type="text/javascript"></script>
<script type="text/javascript">

        $(document).ready(function() {
            //[1] ��ü���� üũ�ڽ� Ŭ����
        $('#chkAll').click(function() {
                // CHKDiv �� ���ԵǾ��� �ִ� ��� üũ�ڽ��� ������
				var $checkboxes = $(this).parents('div:first').find(':checkbox');

                // chkAll üũ�Ǿ��� �ִٸ�, "��ü����" -> "��������"
                if (this.checked) {
                    $(this).next().text("��������"); // <em>�� �ؽ�Ʈ "��������"�� ����
                    $checkboxes.attr('checked', 'true'); // ��� üũ�ڽ��� checked�Ӽ��� �߰�
					
                }
                else {
                    $(this).next().text('��ü����');
                    $checkboxes.attr('checked', '');
                }
            });
        });
    </script>

<%'================================================================================= ȫ %>


<script type="text/javascript">
	function new_win(link) {
		if(link!="#") {
		location.href = ""+link+"";	}}

	function Checkform()
	{
		var frm = document.frm1;
		var ttt = frm.SRL_League.value;

		frm.submit();
	}
	
    function get_ea(v)	
    {
        form = document.frm1;
        var SRS_Sports = form.SRS_Sports[form.SRS_Sports.selectedIndex].text
        
        //alert(form.SRS_Sports.selectedIndex);

    
	    location.href='Regist.asp?SRS_Sports='+SRS_Sports+'&SRL_League=<%=SRL_League%>&ea='+v
    }

	
</script></head>
<!-- #include virtual="/Inc_MonthMulty.asp"-->
<body topmargin="0" marginheight="0">

<table border="1"  bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="95%">
<form name="frm1" method="post" action="Regist_Proc.asp">
<input type="Hidden" name="Process" value="I">
<input type="Hidden" name="Page" value="<%=Page%>">
<input type="Hidden" name="SFlag" value="<%=SFlag%>">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">���� ����</font><font color="ffffff">&nbsp;&nbsp;�� ���� ���</font></b></td></tr></table>




<table width="95%">
<tr>    
	<td width="557" valign="bottom"><span class="style2">�������� ���Ӹ���Ʈ ���� �����Ͻø� �ټ��� ������ ����ϽǼ� �ֽ��ϴ�.</span> </td>
	<td  align="right">
	    ��� ���� ����Ʈ ��
		<select name="input_ea" onchange="get_ea(this.value)">
			<option value="1" <% IF cStr(ea) = "1" Then %>selected<% End IF %>>1</option>
			<option value="2" <% IF cStr(ea) = "2" Then %>selected<% End IF %>>2</option>
			<option value="3" <% IF cStr(ea) = "3" Then %>selected<% End IF %>>3</option>
			<option value="4" <% IF cStr(ea) = "4" Then %>selected<% End IF %>>4</option>
			<option value="5" <% IF cStr(ea) = "5" Then %>selected<% End IF %>>5</option>
			<option value="6" <% IF cStr(ea) = "6" Then %>selected<% End IF %>>6</option>
			<option value="7" <% IF cStr(ea) = "7" Then %>selected<% End IF %>>7</option>
			<option value="8" <% IF cStr(ea) = "8" Then %>selected<% End IF %>>8</option>
			<option value="9" <% IF cStr(ea) = "9" Then %>selected<% End IF %>>9</option>
			<option value="10" <% IF cStr(ea) = "10" Then %>selected<% End IF %>>10</option>
			<option value="20" <% IF cStr(ea) = "20" Then %>selected<% End IF %>>20</option>
			<option value="30" <% IF cStr(ea) = "30" Then %>selected<% End IF %>>30</option>
		</select>
	</td>
  </tr>
</table>

<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" width="95%">


<tr><td width="150" bgcolor="e7e7e7" align="center"><b>������</b></td>
	<td width="250">
	<select name="SRS_Sports" style="width:240px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" onChange="new_win(this.options[this.selectedIndex].value)">
	<%	SQLR = "SELECT RS_SPORTS FROM Ref_Sports WHERE RS_STATUS = 1 Order By RS_IDX"
		SET RS = Server.CreateObject("ADODB.Recordset")
		RS.Open SQLR, DbCon, 1

		RSCount = RS.RecordCount

		FOR a =1 TO RSCount
		
			RLS = RS(0) %>
	<option value="Regist.asp?SRS_Sports=<%=RLS%>&SRL_League=<%=SRL_League%>&ea=<%= ea %>" <% IF SRS_Sports = RLS THEN Response.write "SELECTED" %>><%=RLS%></option>
	<%	RS.movenext
		NEXT
		
		RS.Close
		Set RS=Nothing	%></select></td>


	<td width="150" bgcolor="e7e7e7" align="center"><b>���׼���</b></td>
	<td width="250" colspan="3">
	<%
		SQLMSG = " RL_SPORTS = '"& SRS_Sports & "' "
		SQLR = "SELECT RL_LEAGUE FROM Ref_League WHERE "& SQLMSG &" Order By RL_LEAGUE"
	%>
	<select name="SRL_League" style="width:240px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px">
	<%	

		SET RS = Server.CreateObject("ADODB.Recordset")
		RS.Open SQLR, DbCon, 1

		RSCount = RS.RecordCount

		FOR a =1 TO RSCount
		
			RLS = RS(0)
    %>
	<option value="<%=RLS%>" <% IF SRL_League = RLS THEN Response.write "SELECTED" %>><%=RLS%></option>
	<%	
	        RS.movenext
		NEXT
		
		RS.Close
		Set RS=Nothing
    %>
    </select>

    </td></tr>

<%	cyear = year(date())
	cmonth = month(date())
	cday = day(date())	%>
</table>	
<script type="text/javascript">
function setStartTime()
{
    frm1.start_date.value = "<%= dateValue(dateadd("h",3,now())) %>"
    frm1.start_hour.value = "<%= right("0" & hour(dateadd("h",4,now())),2) %>"
    frm1.start_second.value = "00"
    frm1.starttime.value = frm1.start_date.value + " " + frm1.start_hour.value + ":" + frm1.start_second.value

}

function getStartTime(i)
{
    document.getElementById("IG_STARTTIME_date" + i).value = frm1.start_date.value ;
    document.getElementById("IG_STARTTIME_hour" + i).value = frm1.start_hour.value ;
    document.getElementById("IG_STARTTIME_second" + i).value = frm1.start_second.value ;
    
}
</script>
<table cellpadding="3" cellspacing="1" width="95%" bgcolor="#AAAAAA">
<tr bgcolor="#FFFFFF">
    <td width="80">�������  </td>
    <td>
        <input type="hidden" name="starttime" />
        <input type="text" name="start_date" value="" class="input" size="15" />��
        <input type="text" name="start_hour" value="" class="input" size="2" />��
        <input type="text" name="start_second" value="" class="input" size="2" />��
        <input type="button" value="<%= dfStringUtil.GetStartDate(dateadd("h",4,now())) %>" onclick="setStartTime();" class="input" />
    </td>
    <td width="80">�ڵ�ĸ  </td>
    <td>
        <input type="text" name="handiCnt" value="0.5" class="input" size="4" />
    </td>
    <td width="80">�ջ�</td>
    <td>
        <input type="text" name="overCnt" value="2.5" class="input" size="4" />
    </td>    
    <td width="80">�ڵ�/�������</td>
    <td>
        <input type="text" name="hoBet" value="1.88" class="input" size="4" />
    </td>
</tr>
</table>
<Br />
<script type="text/javascript">
function betValue(obj1,obj2)
{
    document.getElementById(obj1).value = document.getElementById(obj2).value ;
}

function betPercent(home,draw,away,rtnObj,IG_Type)
{
    var home , draw , away ;
    var rtn ;
    
    home = (document.getElementById(home) == null) ? 0 : document.getElementById(home).value;   
    draw = (document.getElementById(draw) == null) ? 0 : document.getElementById(draw).value;
    away = (document.getElementById(away) == null) ? 0 : document.getElementById(away).value;

    home = home == "" ? 0 : parseFloat(home);
    draw = draw == "" ? 0 : parseFloat(draw);
    away = away == "" ? 0 : parseFloat(away);   
    
    if(IG_Type !=0)
    {    
        draw = parseFloat(draw);      
    }
    
    if(draw != 0) //�¹��а� �ִ°��
    {
        rtn = ((100/((100/home)+(100/draw)+(100/away)))*100)
    }
    else //���и� �ִ� ���
    {
        rtn = ((100/((100/home)+(100/away)))*100)
    }
    document.getElementById(rtnObj).value = rtn ;
    //document.getElementById(rtnObj).value = home ;
}
</script>
<%
    For i = 1 To ea 
%>

<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" width="95%">
<tr>
    <td width="120" bgcolor="e7e7e7" align="center"><b>��������</b></td>	
	<td  width="250">
	<input type="text" name="IG_STARTTIME_date<%= i %>" id="IG_STARTTIME_date<%= i %>"  class="input" size="15" /> ��
	<input type="text" name="IG_STARTTIME_hour<%= i %>" id="IG_STARTTIME_hour<%= i %>" class="input" size="2"  /> ��
	<input type="text" name="IG_STARTTIME_second<%= i %>"  id="IG_STARTTIME_second<%= i %>"class="input" size="2" />�� 
	<input type="button" value="�Է�" onclick="getStartTime(<%= i %>);" class="input" /></td>
	<td bgcolor="FF9600" align="center" width="100"><b>�����Y/N</b></td>
	<td ><input type="CheckBox" name="IG_SP<%= i %>" value="Y"></td>
	<td bgcolor="FF9600" align="center" width="300"><b>�ǽð�Y/N</BR>(�ǽð��޴��� �����Ұ�츸 üũ)</b></td>
	<td ><input type="CheckBox" name="IG_CONTENT<%= i %>" value="Y"></td>		
</tr></table>
	
<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" width="95%">
<tr><td bgcolor="e7e7e7" align="center" width="150"><b>Ȩ �� ��</b></td>
	<td width="350"><input type="text" name="IG_Team1<%= i %>" maxlength="550" size="70"></td>
	<td bgcolor="e7e7e7" align="center" width="150"><b>��������</b></td>
	<td width="350"><input type="text" name="IG_Team2<%= i %>" maxlength="550" size="70"></td></tr></table>







<div name="CHKDiv"  style="border:1px solid red;">
<table width="95%" border="0" cellpadding="2" cellspacing="1" bgcolor="#C8C8C8" name="CHKDiv">
<tr bgcolor="#ECECEC">
	<td width="70" align="left">
		<input type="checkbox" id="chkAll"><em>��ü����</em></td>
	<td width="143" align="center"> <b>���ӱ���</b></td>
	<td width="360" align="center" colspan="3"><b>���ӹ����</b></td>
	<td width="143" align="center"><b>����</b></td>
	</tr>
<tr bgcolor="#FFFFFF">
	<td><input type="checkbox" name="IG_Type01<%= i %>" value="Yes" id="Checkboxid"></td><td> �¹���</td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td>��(���)</td>
			<td align="right"><input type="text" name="01_Bet<%= i %>" id="01_Bet<%= i %>" class="input" style="width:60px;"  onkeyup='betPercent("01_Bet<%= i %>","02_Bet<%= i %>","03_Bet<%= i %>","percent_0_<%= i %>",0)' value="0"></td></tr></table></td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td>��(���)</td>
			<td align="right"><input type="text" name="02_Bet<%= i %>" id="02_Bet<%= i %>" class="input" style="width:60px;"  onkeyup='betPercent("01_Bet<%= i %>","02_Bet<%= i %>","03_Bet<%= i %>","percent_0_<%= i %>",0)' value="0"></td></tr></table></td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td>��(���)</td>
			<td align="right"><input type="text" name="03_Bet<%= i %>" id="03_Bet<%= i %>" class="input" style="width:60px;"  onkeyup='betPercent("01_Bet<%= i %>","02_Bet<%= i %>","03_Bet<%= i %>","percent_0_<%= i %>",0)' value="0"></td></tr></table></td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td>����</td>
			<td align="right"><input type="text" id="percent_0_<%= i %>" name="percent_0_<%= i %>" class="input" style="width:60px;" ></td>
			<td><input type="radio" name="01_SITE<%= i %>" value="All" checked> ��ü����
		<% 	Set PML = Server.CreateObject("ADODB.Recordset")
			PML.Open "SELECT SITE01 FROM SET_SITE Order By SEQ", dbCon, 1

			PMLC = PML.RecordCount
		   
			IF PMLC > 0 THEN

			FOR PM = 1 TO PMLC
		   
			IF PML.EOF THEN
				EXIT FOR
			END IF

			SITE01=PML(0) %>
		<input type="radio" name="01_SITE<%= i %>" value="<%=SITE01%>"> <%=SITE01%>
		<%	PML.Movenext
			Next
			END IF %></td>
			</tr></table></td>			
	</tr>
<tr bgcolor="#FFFFFF">
	<td><input type="checkbox" name="IG_Type02<%= i %>" value="Yes" id="Checkboxid"></td><td> �ڵ�ĸ</td>
	<td>
	    <table border="0" cellpadding="0" cellspacing="0" width="100%">
		    <tr>
		        <td style="cursor:pointer" onclick='betValue("04_Bet<%= i %>","hoBet")'>�ڵ��(���)</td>
			    <td align="right"><input type="text" name="04_Bet<%= i %>" id="04_Bet<%= i %>" class="input" style="width:60px;" onkeyup='betPercent("04_Bet<%= i %>",0,"06_Bet<%= i %>","percent_1_<%= i %>",1)' value="0"></td>
			</tr>
		</table>
	</td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td style="cursor:pointer" onclick='betValue("05_Bet<%= i %>","handiCnt")'>�ڵ�ĸ</td>
			<td align="right"><input type="text" name="05_Bet<%= i %>" id="05_Bet<%= i %>" class="input" style="width:60px;"  value="0"></td></tr></table></td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td style="cursor:pointer"  onclick='betValue("06_Bet<%= i %>","hoBet")'>�ڵ���(���)</td>
			<td align="right"><input type="text" name="06_Bet<%= i %>" id="06_Bet<%= i %>" class="input" style="width:60px;" onkeyup='betPercent("04_Bet<%= i %>",0,"06_Bet<%= i %>","percent_1_<%= i %>",1)' value="0"></td></tr></table></td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td>����</td>
			<td align="right"><input type="text" id="percent_1_<%= i %>" name="percent_1_<%= i %>" class="input" style="width:60px;" ></td>
			<td><input type="radio" name="02_SITE<%= i %>" value="All" checked> ��ü����
		<% 	Set PML = Server.CreateObject("ADODB.Recordset")
			PML.Open "SELECT SITE01 FROM SET_SITE Order By SEQ", dbCon, 1

			PMLC = PML.RecordCount
		   
			IF PMLC > 0 THEN

			FOR PM = 1 TO PMLC
		   
			IF PML.EOF THEN
				EXIT FOR
			END IF

			SITE01=PML(0) %>
		<input type="radio" name="02_SITE<%= i %>" value="<%=SITE01%>"> <%=SITE01%>
		<%	PML.Movenext
			Next
			END IF %></td>
			
			</tr></table></td>						
	</tr>
<tr bgcolor="#FFFFFF">
	<td><input type="checkbox" name="IG_Type03<%= i %>" value="Yes" id="Checkboxid"></td><td> �������</td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td style="cursor:pointer" onclick='betValue("07_Bet<%= i %>","hoBet")'>����(���)</td>
			<td align="right"><input type="text" name="07_Bet<%= i %>"  id="07_Bet<%= i %>" class="input" style="width:60px;" onkeyup='betPercent("07_Bet<%= i %>",0,"09_Bet<%= i %>","percent_2_<%= i %>",2)' value="0"></td></tr></table></td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td style="cursor:pointer"  onclick='betValue("08_Bet<%= i %>","overCnt")'>�ջ�</td>
			<td align="right"><input type="text" name="08_Bet<%= i %>" id="08_Bet<%= i %>" class="input" style="width:60px;" value="0"></td></tr></table></td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td style="cursor:pointer"  onclick='betValue("09_Bet<%= i %>","hoBet")'>���(���)</td>
			<td align="right"><input type="text" name="09_Bet<%= i %>" id="09_Bet<%= i %>" class="input" style="width:60px;" onkeyup='betPercent("07_Bet<%= i %>",0,"09_Bet<%= i %>","percent_2_<%= i %>",2)' value="0"></td></tr></table></td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td>����</td>
			<td align="right"><input type="text" id="percent_2_<%= i %>" name="percent_2_<%= i %>" class="input" style="width:60px;"></td>
			<td><input type="radio" name="03_SITE<%= i %>" value="All" checked> ��ü����
		<% 	Set PML = Server.CreateObject("ADODB.Recordset")
			PML.Open "SELECT SITE01 FROM SET_SITE Order By SEQ", dbCon, 1

			PMLC = PML.RecordCount
		   
			IF PMLC > 0 THEN

			FOR PM = 1 TO PMLC
		   
			IF PML.EOF THEN
				EXIT FOR
			END IF

			SITE01=PML(0) %>
		<input type="radio" name="03_SITE<%= i %>" value="<%=SITE01%>"> <%=SITE01%>
		<%	PML.Movenext
			Next
			END IF %></td>
			</tr></table>




			</td>						
	</tr>
<% 	IF SRS_Sports = "�߱�" THEN %>
<tr bgcolor="#FFFFFF">
	<td><input type="CheckBox" name="IG_Type04<%= i %>" value="Yes"  id="Checkboxid"> </td><td>[1�̴� ����/������]</td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td>[1�̴� ����]</td>
			<td align="right"><input type="text" name="10_Bet<%= i %>" id="10_Bet<%= i %>" class="input" style="width:60px;"  onkeyup='betPercent("10_Bet<%= i %>","11_Bet<%= i %>","12_Bet<%= i %>","percent_3_<%= i %>",0)' value="0"></td></tr></table></td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td></td>
			<td align="right"><input type="text" name="11_Bet<%= i %>" id="11_Bet<%= i %>" class="input" style="width:60px;"  onkeyup='betPercent("10_Bet<%= i %>","11_Bet<%= i %>","12_Bet<%= i %>","percent_3_<%= i %>",0)' value=0 readonly></td></tr></table></td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td>[1�̴� ������]</td>
			<td align="right"><input type="text" name="12_Bet<%= i %>" id="12_Bet<%= i %>" class="input" style="width:60px;"  onkeyup='betPercent("10_Bet<%= i %>","11_Bet<%= i %>","12_Bet<%= i %>","percent_3_<%= i %>",0)' value="0"></td></tr></table></td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td>����</td>
			<td align="right"><input type="text" id="percent_3_<%= i %>" name="percent_3_<%= i %>" class="input" style="width:60px;" ></td>
			<td><input type="radio" name="04_SITE<%= i %>" value="All" checked> ��ü����
		<% 	Set PML = Server.CreateObject("ADODB.Recordset")
			PML.Open "SELECT SITE01 FROM SET_SITE Order By SEQ", dbCon, 1

			PMLC = PML.RecordCount
		   
			IF PMLC > 0 THEN

			FOR PM = 1 TO PMLC
		   
			IF PML.EOF THEN
				EXIT FOR
			END IF

			SITE01=PML(0) %>
		<input type="radio" name="04_SITE<%= i %>" value="<%=SITE01%>"> <%=SITE01%>
		<%	PML.Movenext
			Next
			END IF %></td>
			</tr></table></td>			
	</tr>
<tr bgcolor="#FFFFFF">
	<td><input type="CheckBox" name="IG_Type05<%= i %>" value="Yes" id="Checkboxid"></td><td> [ù����]</td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td>[ù����]</td>
			<td align="right"><input type="text" name="13_Bet<%= i %>" id="13_Bet<%= i %>" class="input" style="width:60px;"  onkeyup='betPercent("13_Bet<%= i %>","14_Bet<%= i %>","15_Bet<%= i %>","percent_4_<%= i %>",0)' value="0"></td></tr></table></td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td></td>
			<td align="right"><input type="text" name="14_Bet<%= i %>" id="14_Bet<%= i %>" class="input" style="width:60px;"  onkeyup='betPercent("13_Bet<%= i %>","14_Bet<%= i %>","15_Bet<%= i %>","percent_4_<%= i %>",0)' value=0 readonly></td></tr></table></td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td>[ù����]</td>
			<td align="right"><input type="text" name="15_Bet<%= i %>" id="15_Bet<%= i %>" class="input" style="width:60px;"  onkeyup='betPercent("13_Bet<%= i %>","14_Bet<%= i %>","15_Bet<%= i %>","percent_4_<%= i %>",0)' value="0"></td></tr></table></td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td>����</td>
			<td align="right"><input type="text" id="percent_4_<%= i %>" name="percent_4_<%= i %>" class="input" style="width:60px;"  value="0"></td>
			<td><input type="radio" name="05_SITE<%= i %>" value="All" checked> ��ü����
		<% 	Set PML = Server.CreateObject("ADODB.Recordset")
			PML.Open "SELECT SITE01 FROM SET_SITE Order By SEQ", dbCon, 1

			PMLC = PML.RecordCount
		   
			IF PMLC > 0 THEN

			FOR PM = 1 TO PMLC
		   
			IF PML.EOF THEN
				EXIT FOR
			END IF

			SITE01=PML(0) %>
		<input type="radio" name="05_SITE<%= i %>" value="<%=SITE01%>"> <%=SITE01%>
		<%	PML.Movenext
			Next
			END IF %></td>
			</tr></table></td>			
	</tr>
<!--4�̴� �ڵ�ĸ����-->
<tr bgcolor="#FFFFFF">
	<td><input type="CheckBox" name="IG_Type06<%= i %>" value="Yes" id="Checkboxid"></td><td> ����� �ڵ�ĸ[4�̴�]</td>
	<td>
	    <table border="0" cellpadding="0" cellspacing="0" width="100%">
		    <tr>
		        <td style="cursor:pointer" onclick='betValue("16_Bet<%= i %>","hoBet")'>�ڵ�� [4�̴�]</td>
			    <td align="right"><input type="text" name="16_Bet<%= i %>" id="16_Bet<%= i %>" class="input" style="width:60px;" onkeyup='betPercent("16_Bet<%= i %>",0,"18_Bet<%= i %>","percent_5_<%= i %>",1)' value="0"></td>
			</tr>
		</table>
	</td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td style="cursor:pointer" onclick='betValue("17_Bet<%= i %>","handiCnt")'>�ڵ�ĸ</td>
			<td align="right"><input type="text" name="17_Bet<%= i %>" id="17_Bet<%= i %>" class="input" style="width:60px;" value="0" ></td></tr></table></td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td style="cursor:pointer"  onclick='betValue("18_Bet<%= i %>","hoBet")'>�ڵ��� [4�̴�]</td>
			<td align="right"><input type="text" name="18_Bet<%= i %>" id="18_Bet<%= i %>" class="input" style="width:60px;" onkeyup='betPercent("16_Bet<%= i %>",0,"18_Bet<%= i %>","percent_5_<%= i %>",1)' value="0"></td></tr></table></td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td>����</td>
			<td align="right"><input type="text" id="percent_5_<%= i %>" name="percent_5_<%= i %>" class="input" style="width:60px;" ></td>
			<td><input type="radio" name="06_SITE<%= i %>" value="All" checked> ��ü����
		<% 	Set PML = Server.CreateObject("ADODB.Recordset")
			PML.Open "SELECT SITE01 FROM SET_SITE Order By SEQ", dbCon, 1

			PMLC = PML.RecordCount
		   
			IF PMLC > 0 THEN

			FOR PM = 1 TO PMLC
		   
			IF PML.EOF THEN
				EXIT FOR
			END IF

			SITE01=PML(0) %>
		<input type="radio" name="06_SITE<%= i %>" value="<%=SITE01%>"> <%=SITE01%>
		<%	PML.Movenext
			Next
			END IF %></td>
			
			</tr></table></td>						
	</tr>
<!--4�̴� �ڵ�ĸ��-->
<!--4�̴� ���������-->
<tr bgcolor="#FFFFFF">
	<td><input type="CheckBox" name="IG_Type07<%= i %>" value="Yes" id="Checkboxid"></td><td> ����� �����[4�̴�]</td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td style="cursor:pointer" onclick='betValue("19_Bet<%= i %>","hoBet")'>���� [4�̴�]</td>
			<td align="right"><input type="text" name="19_Bet<%= i %>"  id="19_Bet<%= i %>" class="input" style="width:60px;" onkeyup='betPercent("19_Bet<%= i %>",0,"21_Bet<%= i %>","percent_6_<%= i %>",2)' value="0"></td></tr></table></td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td style="cursor:pointer"  onclick='betValue("20_Bet<%= i %>","overCnt")'>�ջ�</td>
			<td align="right"><input type="text" name="20_Bet<%= i %>" id="20_Bet<%= i %>" class="input" style="width:60px;" value="0"></td></tr></table></td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td style="cursor:pointer"  onclick='betValue("21_Bet<%= i %>","hoBet")'>��� [4�̴�]</td>
			<td align="right"><input type="text" name="21_Bet<%= i %>" id="21_Bet<%= i %>" class="input" style="width:60px;" onkeyup='betPercent("19_Bet<%= i %>",0,"21_Bet<%= i %>","percent_6_<%= i %>",2)' value="0"></td></tr></table></td>
	<td><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td>����</td>
			<td align="right"><input type="text" id="percent_6_<%= i %>" name="percent_6_<%= i %>" class="input" style="width:60px;"></td>
			<td><input type="radio" name="07_SITE<%= i %>" value="All" checked> ��ü����
		<% 	Set PML = Server.CreateObject("ADODB.Recordset")
			PML.Open "SELECT SITE01 FROM SET_SITE Order By SEQ", dbCon, 1

			PMLC = PML.RecordCount
		   
			IF PMLC > 0 THEN

			FOR PM = 1 TO PMLC
		   
			IF PML.EOF THEN
				EXIT FOR
			END IF

			SITE01=PML(0) %>
		<input type="radio" name="07_SITE<%= i %>" value="<%=SITE01%>"> <%=SITE01%>
		<%	PML.Movenext
			Next
			END IF %></td>
			</tr></table></td>						
	</tr>
<!--4�̴� �������-->
<% End If %>
			</tr></table>

			</td>							
</table>
			</div>
<Br />

<%
    Next
%>


<table width="95%" border="0" cellspacing="0" cellpadding="0">
<tr><td align="center"> 
	<input type="button" value=" �� �� " onclick="javascript:Checkform()" style="border: 1 solid; background-color: #C5BEBD;">
	<input type="button" value=" ��� "  onclick="history.back(-1);" style="border: 1 solid; background-color: #C5BEBD;"></td></tr></table></form>

</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>