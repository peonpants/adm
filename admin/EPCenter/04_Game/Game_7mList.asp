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

<%'==========================================================================================  ȫ ���� ===========
' �����Ͻ� : 2017-08-07  �Ϸ�
' �� �� �� : ȫ����
'
' * �۾����� :  üũ�ڽ��� ����� �ϰ���� ����, �ڵ� �ϰ����ù�ư, ��/�� �ϰ����ù�ư
' * ���� ���� ��ư�� ���ְ� ���õ�� ��ư�� ����
'
' ���� ��������
' line 30~ 93 �߰� : ��ü���� üũ�ڽ���  Jquery
' line 260 <div> �߰� <--- ��ü���ÿ� �־ �߿�
' line 262 �߰� :  ���� <form �� ����� �Ѱ��ִ��������� ������  <form name="allFM" method="post" action="Game_7mRegist_ProcAll.asp" >
'
' <<<<<<<<<<<<<<<<<<<<<<<<<<< Game_7mRegist_ProcAll.asp ������ ���� ���� >>>>>>>>>>>>>>>>>>>>>
'
' line 285 ~ 288 : ��ü���� üũ�ڽ� ����
' line 373 ~ 	' ����  <input name�� <%= ii % > �߰�����
' line 411 '�Ʒ� input �� class="CheckBoxHandy" �߰�
' line 442 '�Ʒ� input �� class="CheckBoxOverUnder" �߰�
' line 468 ~ 476 ���� ���� ��ư ���ְ� üũ�ڽ��� ��ü & ������ �ִ� <form> ����
' line 470 		<input type="CheckBox" Class="CheckBoxRegist" name="chkb" value="<%= ii % >" > üũ�ڽ� �߰�����
' line 493 ~ 494 </form></div> �߰�
'  * �����׽�Ʈ�� �Ͽ����� Ȥ�ø� ���װ� ������ ����
'
' �߰����� line 424~, 454~ �ڵ�ĸ ����� �⺻��� 1.88�� ����
'==========================================================================================  ȫ ���� ===========%>
<%'================================================================================= ȫ �߰� %>
<script src="/js/jquery-1.4.1.min.js" type="text/javascript"></script>
<script type="text/javascript">

        $(document).ready(function() {
            //[1] ��ü���� üũ�ڽ� Ŭ����

        $('#chkAllHandy').click(function() {
                // ���� Div �� ���ԵǾ��� �ִ� ��� üũ�ڽ��� ������

				var $checkboxes = $(this).parents('div:first').find('.CheckBoxHandy');

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
        $(document).ready(function() {
            //[1] ��ü���� üũ�ڽ� Ŭ����

        $('#chkAllOverUn').click(function() {
                // ���� Div �� ���ԵǾ��� �ִ� ��� üũ�ڽ��� ������

				var $checkboxes = $(this).parents('div:first').find('.CheckBoxOverUnder');

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
        $(document).ready(function() {
            //[1] ��ü���� üũ�ڽ� Ŭ����

        $('#chkAllRegi').click(function() {
                // ���� Div �� ���ԵǾ��� �ִ� ��� üũ�ڽ��� ������

				var $checkboxes = $(this).parents('div:first').find('.CheckBoxRegist');

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
<%'================================================================================= ȫ �߰� %>


<%

    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    reqType            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("type")), 0, 0, 2)     
    reqLang            = Trim(dfRequest.Value("lang"))
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
    pageSize        = 150
    reqLang = "kr"
	'######### ���� ����Ʈ�� �ҷ���                 ################	
    IF reqLang = "kr" Then
	    Call dfgameSql.RetrieveINFO_7M_kr(dfDBConn.Conn,page, pageSize, reqType)
    Else
        Call dfgameSql.RetrieveINFO_7M(dfDBConn.Conn)
    End IF	    
    'dfgameSql.debug

	IF dfgameSql.RsCount <> 0 Then
	    nTotalCnt = dfgameSql.RsOne("TC")
	Else
	    nTotalCnt = 0
	End IF
		
    '--------------------------------
	'   Page Navigation
	'--------------------------------
	Dim objPager
	Set objPager = New Pager
	
	objPager.RecordCount = nTotalCnt
	objPager.PageIndexVariableName = "page"
	objPager.NumericButtonFormatString = "{0}"
	objPager.PageButtonCount = 10
	objPager.PageSize = pageSize
	objPager.NumericButtonCssClass = "paging"
	objPager.SelectedNumericButtonCssClass = "paging_crnt"
	objPager.NavigateButtonCssClass = "paging_txt1"
	objPager.CurrentPageIndex = page
	objPager.NumericButtonDelimiter = "<span class=""paging_txt2"">|</span>"
	objPager.NavigationButtonDelimiter = "<span class=""paging_txt2"">|</span>"
	objPager.NavigationShortCut = false
	
%>
<html>
<head>
<title>7m ���� ����Ʈ</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<!--<script src="/Sc/Base.js"></script>-->
</head>


<script type="text/javascript">
function checkFormGame(form)
{
    var txtConfirm1 = txtConfirm = "";
    if(form.IG_TEAM1BENEFIT.value == "")
    {
        IG_TEAM1BENEFIT = (form.I7_C_TEAM1BENEFIT.value != "") ? form.I7_C_TEAM1BENEFIT.value : form.I7_TEAM1BENEFIT.value ;
        form.IG_TEAM1BENEFIT.value = IG_TEAM1BENEFIT; 
    }      
    if(form.IG_DRAWBENEFIT.value == "")
    {
        IG_DRAWBENEFIT = (form.I7_C_DRAWBENEFIT.value != "") ? form.I7_C_DRAWBENEFIT.value : form.I7_DRAWBENEFIT.value ;            
        form.IG_DRAWBENEFIT.value = IG_DRAWBENEFIT; 
    }        
    if(form.IG_TEAM2BENEFIT.value == "")
    {
        IG_TEAM2BENEFIT = (form.I7_C_TEAM2BENEFIT.value != "") ? form.I7_C_TEAM2BENEFIT.value : form.I7_TEAM2BENEFIT.value ;            
        form.IG_TEAM2BENEFIT.value = IG_TEAM2BENEFIT;   
    }        
    if(form.IG_Type02.checked)
        txtConfirm1 += "�ڵ�ĸ"
    if(form.IG_Type03.checked)
        txtConfirm1 += " �������"   
                 
    if(txtConfirm1 != "")
        txtConfirm = "(" + txtConfirm1 + " ���� ) "
        
    var rtn = confirm("�����Ͻðڽ��ϱ�?" + txtConfirm) ;
    if(!rtn)
    {
        return false;   
    }
       
}
       
    function getBenefit(BF)       
    {
        //BF = parseInt(BF,10);
        var min ;
        if(BF < 1.3)
            min = 0.01
        else if(BF >= 1.3 && BF < 1.4)
            min = 0.02
        else if(BF >= 1.4 && BF < 1.6)
            min = 0.03
        else if(BF >= 7 && BF < 8)                        
            min = 1                    
        else if(BF >= 8)                        
            min = 1.5
        else
            min = 0 
                  
        return (BF-min).toFixed(2);                        
    }
    function gameList()
    {
        window.open("/EPCenter/04_Game/List.asp?SRS_Sports=&SRL_League=&SFlag=R");
    }  
    
    function showHideLayer(divID)
    {
        var dis = document.getElementById(divID).style.display == "none" ? "block" : "none" ;
        document.getElementById(divID).style.display = dis ;
    }
    
    function goList(type)
    {        
        location.href = "Game_7mList.asp?type=" + type
    }
    
    function goHTML()
    {
        window.open("Game_7mListHtml.asp")
    }
</script>
<style>
.input3     {font-size: 12px; color: #000000;  font-family: verdana,����, Tahoma; height:22px; border: 1px solid #6C6C6C; padding:2px; background-color:F5FDBD;}
.input4     {font-size: 12px; color: #000000;  font-family: verdana,����, Tahoma; height:22px; border: 1px solid #6C6C6C; padding:2px; background-color:F4DAFE;}
.input5     {font-size: 12px; color: #000000;  font-family: verdana,����, Tahoma; height:22px; border: 1px solid #6C6C6C; padding:2px; background-color:C7CBFF;}
</style>
<body>
<table width="100%">
<tr>
    <td align="right">
        <input type="button" value="��ü ��⺸��" class="input4" onclick="goList(0)" />        
        <input type="button" value="�̵�� ��⺸��" class="input5" onclick="goList(1)" />            
        <input type="button" value="��� ��⺸��" class="input5" onclick="goList(2)" />  
        <a href="Game_7mListHtml.asp"  target="_blank">HTML ����</a>
    </td>
</tr>
</table>
<br />
<!-- paging Start -->
<table width="100%">
<tr>
    <td align="center" height="30">
    [��ü ��� ���� : <%= nTotalCnt %> ]  
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
    </td>   
</tr>
</table>
<!-- paging End -->
<br />
<% '===============================  ȫ����%>
<div>
<form name="allFM" method="post" action="Game_7mRegist_ProcAll.asp" >
<% '===============================  ȫ����%>


<table border="0"  cellspacing="1" cellpadding="3" bgcolor="#AAAAAA" width="100%" id="tblGameList">
<tr bgcolor="eeeeee"  height="25"> 
    <td>����</td>
    <td>�����Ͻ�</td>
    <td>IDX</td>   
    <td>Ȩ��</td>    
    <td>��</td>
    <td>��</td>
    <td>��</td>
    <td>��(����)</td>
    <td>��(����)</td>
    <td>��(����)</td>
    <td>������</td>
    <td>��(����)</td>
    <td>��(����)</td>
    <td>��(����)</td>
	<% '===============================  ȫ����%>
    <td>�ڵ� <br/><input type="checkbox" id="chkAllHandy"><em>��ü����</em></td>
    <td>��/��<br/><input type="checkbox" id="chkAllOverUn"><em>��ü����</em></td>
    <td>���        <input type="submit" value="���õ��" />
	<br/><input type="checkbox" id="chkAllRegi"><em>��ü����</em></td>
	<% '===============================  ȫ����%>
</tr>    
<%	
    IF  dfgameSql.RsCount = 0 THEN	
%>
<tr bgcolor="ffffff"> <td align="center" colspan="13" height="35">��ϵ� ������ �����ϴ�. .</td></tr>
<%
	ELSE
	    FOR ii = 0 TO dfgameSql.RsCount -1
            
           
            IF ii mod 2 = 0 Then
                bgColor = "#FFFFFF"
            Else
                bgColor = "#EEEEEE"
            End IF   
            
            IF dfGameSql.Rs(ii,"IG_TEAM1BENEFIT") <> "" Then
                bgColor = "#FCEAEA"
            End IF    
            
            IF  dfGameSql.Rs(ii,"I7_TEAM1BENEFIT") <= 1.6 OR  dfGameSql.Rs(ii,"I7_TEAM1BENEFIT") >= 5 Or dfGameSql.Rs(ii,"I7_TEAM2BENEFIT") <= 1.6 OR  dfGameSql.Rs(ii,"I7_TEAM2BENEFIT") >= 5 Then
                fontColor = "red"
                className = "input_boxred"
            Else
                fontColor = "#000000"
                className = "input_box"
            End IF
            
            IG_STARTTIME = dfGameSql.Rs(ii,"I7_STARTTIME") 
            
            checkTime = ""
            IF isNull(dfGameSql.Rs(ii,"IG_STARTTIME")) Or dfGameSql.Rs(ii,"IG_STARTTIME") <> "" Then
                IF dfGameSql.Rs(ii,"I7_STARTTIME") <> dfGameSql.Rs(ii,"IG_STARTTIME") Then
                   checkTime = "<b><font color='red'>[�ð�����]</font></b>"
                End IF
            End IF
            
            '��� ����
            IF dfGameSql.Rs(ii,"IG_TEAM1BENEFIT") <> "" Then
                trClass = "reg"
            Else
                trClass = "noreg"
            End IF
            
            '���� ����
            IF fontColor = "red" Then
                trClass2 = "war"
            Else
                trClass2 = "nowar"
            End IF
            
            ' ���� ���� �۾� ����
            IG_TEAM1BENEFIT = dfGameSql.Rs(ii,"I7_TEAM1BENEFIT") 
            IG_DRAWBENEFIT = dfGameSql.Rs(ii,"I7_DRAWBENEFIT") 
            IG_TEAM2BENEFIT = dfGameSql.Rs(ii,"I7_TEAM2BENEFIT") 

            IF NOT isNull(dfGameSql.Rs(ii,"I7_C_TEAM1BENEFIT")) AND dfGameSql.Rs(ii,"I7_C_TEAM1BENEFIT") <> "" Then
                IG_TEAM1BENEFIT = dfGameSql.Rs(ii,"I7_C_TEAM1BENEFIT") 
                IG_DRAWBENEFIT = dfGameSql.Rs(ii,"I7_C_DRAWBENEFIT") 
                IG_TEAM2BENEFIT = dfGameSql.Rs(ii,"I7_C_TEAM2BENEFIT")                 
            End IF
            
            IF NOT isNull(dfGameSql.Rs(ii,"IG_TEAM1BENEFIT")) AND dfGameSql.Rs(ii,"IG_TEAM1BENEFIT") <> "" Then
                IF dfGameSql.Rs(ii,"IG_TYPE") <> 0 Then
                    IG_DRAWBENEFIT = dfGameSql.Rs(ii,"IG_HANDICAP")
                Else
                    IG_DRAWBENEFIT =  dfGameSql.Rs(ii,"IG_DRAWBENEFIT")
                End IF            
                IG_TEAM1BENEFIT = dfGameSql.Rs(ii,"IG_TEAM1BENEFIT") 
                IG_TEAM2BENEFIT = dfGameSql.Rs(ii,"IG_TEAM2BENEFIT") 
            End IF
                        
'      <form name="frm<%= ii % >" method="post" action="Game_7mRegist_Proc.asp" target="exeFrame" onsubmit="return checkFormGame(this);">      
            
%>

<% IF dfGameSql.Rs(ii,"IG_TEAM1BENEFIT")  = "" Then %>
<input type="Hidden" name="Process<%= ii %>" value="add">
<% 
Else
%>
	<% '===============================  ȫ����
	'
	' ����  input �鿡  name �ڿ� <%= ii % > �߰�����
	'
	'===============================  ȫ����%>

<input type="Hidden" name="Process<%= ii %>" value="modify">
<input type="Hidden" name="IG_IDX<%= ii %>" value="<%= dfGameSql.Rs(ii,"IG_IDX") %>">
<input type="Hidden" name="IG_TYPE<%= ii %>" value="<%= dfGameSql.Rs(ii,"IG_TYPE") %>">
<input type="hidden" name="IG_STATUS<%= ii %>" value="<%= dfGameSql.Rs(ii,"IG_STATUS")  %>" />
<% End IF %>
<input type="hidden" name="SRL_League<%= ii %>" value="<%= dfGameSql.Rs(ii,"I7_LEAGUE") %>" />


<input type="hidden" name="IG_StartTime<%= ii %>" value="<%= dfStringUtil.GetFullDate(dfGameSql.Rs(ii,"I7_STARTTIME")) %>" />
<tr bgcolor="<%= bgColor %>" height="25" class="<%= trClass %>" useAtt="<%= trClass2 %>" style="display:block"> 
    <td style="color:<%= fontColor %>"><%= dfGameSql.Rs(ii,"I7_LEAGUE") %></td>
    <td><%= dfStringUtil.GetFullDate(IG_STARTTIME) %> <%= checkTime %></td>
    <td><input type="text" class="<%= className %>" size="7" name="I7_IDX<%= ii %>" value="<%= dfGameSql.Rs(ii,"I7_IDX") %>" readonly /></td>    
    <td><input type="text" class="<%= className %>" name="IG_Team1<%= ii %>" value="<%= dfGameSql.Rs(ii,"I7_TEAM1") %>"  /></td>    
    <td><input type="text" class="<%= className %>" name="I7_TEAM1BENEFIT<%= ii %>" size="5" value="<%= dfGameSql.Rs(ii,"I7_TEAM1BENEFIT") %>" readonly /></td>
    <td><input type="text" class="<%= className %>" name="I7_DRAWBENEFIT<%= ii %>" size="5" value="<%= dfGameSql.Rs(ii,"I7_DRAWBENEFIT") %>" readonly /></td>
    <td><input type="text" class="<%= className %>" name="I7_TEAM2BENEFIT<%= ii %>" size="5" value="<%= dfGameSql.Rs(ii,"I7_TEAM2BENEFIT") %>"  readonly/></td>
    <td><input type="text" class="<%= className %>" name="I7_C_TEAM1BENEFIT<%= ii %>" size="5" value="<%= dfGameSql.Rs(ii,"I7_C_TEAM1BENEFIT") %>" readonly /></td>
    <td><input type="text" class="<%= className %>" name="I7_C_DRAWBENEFIT<%= ii %>" size="5" value="<%= dfGameSql.Rs(ii,"I7_C_DRAWBENEFIT") %>" readonly /></td>
    <td><input type="text" class="<%= className %>" name="I7_C_TEAM2BENEFIT<%= ii %>" size="5" value="<%= dfGameSql.Rs(ii,"I7_C_TEAM2BENEFIT") %>" readonly /></td>
    <td><input type="text" class="<%= className %>" name="IG_Team2<%= ii %>" value="<%= dfGameSql.Rs(ii,"I7_TEAM2") %>"  /></td>
    <td>
        <input type="text" class="input_box1" name="IG_TEAM1BENEFIT<%= ii %>" size="5" value="<%= dfGameSql.Rs(ii,"IG_TEAM1BENEFIT") %>" />
    </td>
    <td>
        <input type="text" class="input_box1" name="IG_DRAWBENEFIT<%= ii %>" size="5" value="<%= IG_DRAWBENEFIT %>" />
    </td>
    <td>
        <input type="text" class="input_box1" name="IG_TEAM2BENEFIT<%= ii %>" size="5" value="<%= dfGameSql.Rs(ii,"IG_TEAM2BENEFIT") %>" />
    </td>     
           
    <td>    
    <% IF dfGameSql.Rs(ii,"IG_TYPE") = 0 AND  dfGameSql.Rs(ii,"IG_IDX") = "" Then %>
<% ' ================================================================= ȫ�߰� ========
'�Ʒ� input �� class="CheckBoxHandy" �߰�
%>
	<input type="CheckBox" class="CheckBoxHandy" name="IG_Type02<%= ii %>" value="Yes" onclick="showHideLayer('divHandi<%= ii %>');"> �ڵ�ĸ

	
	<div id="divHandi<%= ii %>" style="position:relative;display:none;">
       <div style="position:absolute;background:#FFF;left:-60px;">
        <table width="100%" cellpadding="2" cellspacing=1  bgcolor="#AAAAAA">
        <tr bgcolor="EEEEEE" height="30"> 
            <td>�� </td>
            <td>�ڵ�</td>
            <td>��</td>     
        </tr>                
        <tr bgcolor="ffffff" height="25">
            <td><input type="text" class="input_box1" name="IG_H_TEAM1BENEFIT<%= ii %>" size="4" value="1.88" /></td> <%' �⺻��� ���� --------------------------ȫ%>
            <td><input type="text" class="input_box1" name="IG_H_DRAWBENEFIT<%= ii %>" size="4" value="1.0" /></td>   <%' �⺻��� ���� --------------------------ȫ%>
            <td><input type="text" class="input_box1" name="IG_H_TEAM2BENEFIT<%= ii %>" size="4" value="1.88" /></td> <%' �⺻��� ���� --------------------------ȫ%>  
        </tr>
        </table>

        </div>        

    </div>        
    <% ElseIF dfGameSql.Rs(ii,"IG_TYPE") = 1 Then  %>
        <font color="blue">�ڵ�ĸ</font>
    <% End IF %>
    </td>
    <td>
    <% IF dfGameSql.Rs(ii,"IG_TYPE") = 0 AND  dfGameSql.Rs(ii,"IG_IDX") = "" Then %>

<% ' ================================================================= ȫ�߰� ========
'�Ʒ� input �� class="CheckBoxOverUnder" �߰�
%>
    <input type="CheckBox" class="CheckBoxOverUnder" name="IG_Type03<%= ii %>" value="Yes" onclick="showHideLayer('divOver<%= ii %>');"> �������
    <div id="divOver<%= ii %>" style="position:relative;display:none;">
        <div style="position:absolute;background:#FFF;left:5px;">
        <table width="100%" cellpadding="2" cellspacing=1  bgcolor="#AAAAAA">
        <tr bgcolor="EEEEEE" height="30"> 
            <td>�� </td>
            <td>�ջ�</td>
            <td>��</td>     
        </tr>                
        <tr bgcolor="ffffff" height="25"> <%' �⺻��� ���� --------------------------ȫ%>
            <td><input type="text" class="input_box1" name="IG_O_TEAM1BENEFIT<%= ii %>" size="4" value="1.88" /></td> <%' �⺻��� ���� --------------------------ȫ%>
            <td><input type="text" class="input_box1" name="IG_O_DRAWBENEFIT<%= ii %>" size="4" value="1.0" /></td>   <%' �⺻��� ���� --------------------------ȫ%>
            <td><input type="text" class="input_box1" name="IG_O_TEAM2BENEFIT<%= ii %>" size="4" value="1.88" /></td> <%' �⺻��� ���� --------------------------ȫ%>  
        </tr>
        </table>
        </div>        
    </div>   
   <% ElseIF dfGameSql.Rs(ii,"IG_TYPE") = 2 Then  %>
        <font color="blue">�������</font>
    <% End IF %>     
    </td>    
    <td>

<% ' ================================================================= ȫ���� ========%>
    <% IF dfGameSql.Rs(ii,"IG_STATUS") = "" Then%>�ű�

    <% ElseIF dfGameSql.Rs(ii,"IG_STATUS") = "R" Or dfGameSql.Rs(ii,"IG_STATUS") = "S" Then %>                
         <b>����</b>

    <% Else %>        
         <b>����2</b>
 
	<% End IF %>   
<% ' ================================================================= ȫ���� ========%>
<% ' ================================================================= ȫ�߰� ========%>
		<input type="CheckBox" Class="CheckBoxRegist" name="chkb" value="<%= ii %>"  class="input2"  >
<% ' ================================================================= ȫ�߰� ========%>


	
    </td>
</tr> 

<%	    
	    Next
    End IF	    
%>	 
</table>
<% ' ================================================================= ȫ�߰� ========%>
</form>
</div>
<% ' ================================================================= ȫ�߰� ========%>
<br />
<!-- paging Start -->
<table width="100%">
<tr>
    <td align="center" height="30">
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
    </td>   
</tr>
</table>
<!-- paging End -->
<iframe name="exeFrame" width=0 height=0 frameborder=0></iframe>
</body>
</html>