<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/07_Customer/_Sql/customerSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->

<%
	Page		= REQUEST("Page")
	BC_Idx		= REQUEST("BC_Idx")
	Find		= Trim(REQUEST("Find"))
	Search		= Trim(REQUEST("Search"))
	sStartDate	= Trim(REQUEST("sStartDate"))
	sEndDate	= Trim(REQUEST("sEndDate"))
	BC_Type	= Trim(REQUEST("BC_Type"))

	SQLstr="UPDATE Board_Customer SET BC_READYN=BC_READYN+1 WHERE BC_Idx = '"& BC_Idx &"' "
	DbCon.Execute(SQLstr)

	SQLMSG = "SELECT * FROM Board_Customer WHERE BC_Idx = '"& BC_Idx &"' "
	SET RS = DbCon.Execute(SQLMSG)

	BC_Idx		= Trim(RS("BC_Idx"))
	BC_ID       = Trim(RS("BC_ID"))
	BC_Writer	= RS("BC_Writer")
	BC_Title	= Trim(RS("BC_Title"))
	BC_Contents	= RS("BC_Contents")
	BC_RegDate	= Trim(RS("BC_RegDate"))
	BC_Reply	= CDbl(RS("BC_Reply"))
	BC_SITE		= RS("BC_SITE")

	
	IF BC_Reply = 1 and Not BC_Writer = "������" Then
		SQLMSG = "SELECT BCR_Contents FROM Board_Customer_Reply WHERE BCR_RefNum = " & BC_Idx &" "
		SET RS = DbCon.Execute(SQLMSG)	
		BCR_Contents = rs("BCR_Contents")
	END IF

	RS.Close
	Set RS = Nothing
%>
<%
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### ���� ������ ������                 ################	
   
	Call dfcustomerSql.RetrieveBOARD_CUSTOMER_TEMPLATE(dfDBConn.Conn )
    

%>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">

<SCRIPT LANGUAGE="JavaScript">
	function Checkform()
	{
		var frm = document.frm1;
		
		if (frm.BCR_Contents.value == "" )
		{
			alert("�亯�� �Է��ϼ���");
			frm.BCR_Contents.focus();
			return false;
		}
		
		frm.submit();
	}
	
	function getContent(BCT_IDX)
	{
	    if(BCT_IDX != 0) frmConent.location.href = "getContent_t.asp?BCT_IDX="+ BCT_IDX;
	}
</SCRIPT></head>

<body topmargin="0" marginheight="0">
<iframe width=0 height=0 frameborder=0 name="frmConent"></iframe>

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> ������ ����</b></td>
</tr>
</table>    
<div style="height:10px;"></div>
<form name="frm1" method="post" action="Edit_proc.asp">
<input type="hidden" name="BC_Idx" value="<%=BC_Idx%>">
<input type="hidden" name="Page" value="<%=Page%>">
<input type="hidden" name="Find" value="<%=Find%>">
<input type="hidden" name="Search" value="<%=Search%>">
<input type="hidden" name="sStartDate" value="<%=sStartDate%>">
<input type="hidden" name="sEndDate" value="<%=sEndDate%>">



<table width="100%">
<tr>
    <td>
        <table width="700" border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF">
        <tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>�۾���</b></td>
   	        <td colspan="3">&nbsp;<%=BC_Writer%>(<a href="/EPCenter/02_Member/List.asp?sStartDate=&sEndDate=&Search=IU_ID&Find=<%= BC_ID %>" target="_blank"><%= BC_ID %></a>)</td></tr>
        <tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>����Ʈ</b></td>
   	        <td colspan="3">&nbsp;<%=BC_SITE%></td></tr>
        <tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>����</b></td>
   	        <td colspan="3">
   	        <select name="BC_Type" >
                <option value="0" <% IF cStr(BC_Type) = "0" Then %>selected<% End IF %>>�Ϲ�</option>
                <option value="1" <% IF cStr(BC_Type) = "1" Then %>selected<% End IF %>>���¹���</option>
             </select>   	        
   	        </td></tr>
        <tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>��&nbsp;&nbsp;��</b></td>
   	        <td colspan="3">&nbsp;<%=BC_Title%></td></tr>   	        
        <tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>��&nbsp;&nbsp;��</b></td>
            <td colspan="3" style="padding:10,10,10,10;">
			<textarea name="BCR_aaa" style="width:550px;height:100px;border:1px solid #aaaaaa;" readonly="readonly">
			<%= replace(BC_Contents,"textarea","aaa") %>
			</textarea>
			</td></tr>
        <tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>�����</b></td>
            <td colspan="3">&nbsp;<%=BC_RegDate%></td></tr>
        <tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>��&nbsp;&nbsp;��</b></td>
            <td colspan="3"><textarea name="BCR_Contents" style="width:550px;height:200px;border:1px solid #aaaaaa;"><% IF Len(BCR_Contents) > 0 THEN %><%=Checkot(BCR_Contents)%><% END IF %></textarea></td></tr></table><br>

        <table width="700" border="0" cellspacing="0" cellpadding="0">
        <tr><td align="center">
	        <input type="button" value=" �� ��(����) " onclick="Checkform();" style="border: 1 solid; background-color: #C5BEBD; cursor:hand">&nbsp;
	        <input type="reset" value=" �� �� " onclick="window.location='List.asp?page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&BC_Type=<%= BC_Type %>';" style="border: 1 solid; background-color: #C5BEBD;"></td></tr></table>    
    
    </td>
    <td align="left" valign="top" >
    <select size="25" style="width:300px;border: 1 solid;" onchange="getContent(this.value);">
    <option value="0" >--���� --</option>
<%	
IF dfcustomerSql.RsCount <> 0 THEN	

	FOR i = 0 TO dfcustomerSql.RsCount -1 

		BCT_IDX		= dfcustomerSql.Rs(i,"BCT_IDX")
		BCT_TITLE	= dfcustomerSql.Rs(i,"BCT_TITLE")
%>
    <option value="<%= BCT_IDX %>"><%= BCT_TITLE %></option>
<%		
    Next	
End IF    	
%>    
    </select>
    </td>
</tr>
</table>


</form>
<script>

	function FrmChk1()
	{
		if (!confirm("�����Ͻðڽ��ϱ�?")) {
			return;
		}
		else {
			var frm = document.frm2;
			
			if ((frm.Amount.value == "") || (frm.Amount.value == 0)) {
				alert("�߰�/�����Ͻ÷��� �ݾ��� �����ּ���.");
				frm.Amount.focus();
				return false;
			}
		
			document.frm2.submit();
		}
	}
	
	function FrmChk2()
	{
		if (!confirm("�����Ͻðڽ��ϱ�?")) {
			return;
		}
		else {
			var frm = document.frm3;
			
			if ((frm.Amount.value == "") || (frm.Amount.value == 0)) {
				alert("�߰�/�����Ͻ÷��� �ݾ��� �����ּ���.");
				frm.Amount.focus();
				return false;
			}
		
			document.frm3.submit();
		}
	}	
		
	function f_addPoin()
	{	    
	    document.getElementById("addCost").value =  parseInt((document.getElementById("cost").value/100) * document.getElementById("per").value,10)
	}
</script>
<form name="frm3" id="Form1" method="post" action="Point_Proc.asp" target="frmConent">	
<b>���� ���� : </b><br />
<input type="text" id="cost" class="input" /> ��
<input type="text" id="per" class="input" /> %
=
<input type="button" value="����ϱ�" onclick="f_addPoin();" class="input" />
<input type="text" id="addCost"  class="input"/>

<form name="frm3" id="frm3" method="post" action="Point_Proc.asp" target="frmConent">	
<table>
<tr>
    <td class="bu03"><strong>
    ȸ������Ʈ��ȯ��</strong>
    </td>
</tr>
</table>
<table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="#AAAAAA">
<input type="hidden" name="IU_ID" value="<%= BC_ID %>">
<tr bgcolor="#FFFFFF">
    <td bgcolor="#ececec" width="150">
        <img src="/EPCenter/Images/subimg_06.gif" border="0" align="absmiddle"> ����Ʈ����
	</td>	
	<td width="220">
	    ����:<input type="Radio" name="CashFlag" value="Cash" checked>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        ȯ��:<input type="Radio" name="CashFlag" value="GCash" disabled>
    </td>	
	<td bgcolor="#ececec" width="150">
	    �߰�/����
	</td>	
	<td width="210">
	    +<input type="Radio" name="ProcFlag" value="+" checked>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		-<input type="Radio" name="ProcFlag" value="-">
    </td>	
	<td bgcolor="#ececec" width="100">
    ����Ʈ
    </td>	
	<td width="210">
	    <input type="text" name="Amount" class="input" style="width:100;text-align:right;" value=""> P
    </td>
	<td bgcolor="#ececec" width="100">
	    ���(����)
	</td>	
	<td width="210">
	    <input type="text" name="LP_CONTENTS1" class="input" style="width:180;text-align:right;" value="">
    </td>      
</tr>
</table>
<table width="100%">
<tr>
    <td colspan="11" align="right">
	<%IF request.Cookies("AdminLevel") = 1 THEN %>
	    <input type="button" value=" ����Ʈ��ȯ�� " onclick="FrmChk2();" style="border: 1 solid; background-color:#C5BEBD;">
	<% END IF %>
	</td>
</tr>
</table>	
</form>

<form name="frm2" id="frm2" method="post" action="Cash_Proc.asp" target="frmConent">
<table>
<tr>
    <td class="bu03">
        <strong>ȸ��ĳ����ȯ��</strong>
    </td>
</tr>
</table>
<table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="#AAAAAA">
<input type="hidden" name="IU_ID" value="<%=BC_ID%>">
<tr  bgcolor="#FFFFFF">
    <td bgcolor="#ececec" width="100">
        <img src="/EPCenter/Images/subimg_06.gif" border="0" align="absmiddle"> ĳ������
	</td>
	
	<td width="180">
        ����ĳ��:<input type="Radio" name="CashFlag" value="Cash" checked>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		ȯ��ĳ��:<input type="Radio" name="CashFlag" value="GCash" disabled>
    </td>	
	<td bgcolor="#ececec" width="100">
	    �߰�/����
	</td>	
	<td width="150">
	    +<input type="Radio" name="ProcFlag" value="+" checked>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        -<input type="Radio" name="ProcFlag" value="-">
    </td>	
	<td bgcolor="#ececec" width="100">
	    �Է±ݾ�
	</td>	
	<td width="110">
	    <input type="text" name="Amount" class="input" style="width:100;text-align:right;" value="5000">��
    </td>
	<td bgcolor="#ececec" width="100">
	    ���(����)
	</td>	
	<td width="210">
	    <input type="text" name="IC_CONTENT1" class="input" style="width:210;text-align:right;" value="���� ����ĳ�� ����">
    </td>    
</tr>	
</table>
<table width="100%">
<tr>
    <td align="right">
	<%IF request.Cookies("AdminLevel") = 1 THEN %>
	    <input type="button" value=" ĳ����ȯ�� " onclick="FrmChk1();" style="border: 1 solid; background-color:#C5BEBD;">
    <% END IF %>
    </td>
</tr>
</table>
</form>
<table width="1000">
<tr>
    <td width="500">
        <iframe src="/EPCenter/05_Account/Money_AddSub.asp?sStartDate=2010-11-25&sEndDate=2010-11-25&Search=LC_ID&Find=<%= BC_ID %>" width="500" height="300"></iframe>
    </td>
    <td width="500">
        <iframe src="/EPCenter/05_Account/point_list.asp?sStartDate=2010-11-25&sEndDate=2010-11-25&Search=LP_ID&Find=<%= BC_ID %>" width="500" height="300"></iframe>
    </td>
</tr>
</table>
<script>
	
   // frmConent.location.href = "getContent_t.asp?BCT_IDX=23"

</script>
</body>

</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>