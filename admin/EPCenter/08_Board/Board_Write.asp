<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/EPCenter/02_member/_Sql/memberSql.Class.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<%
BF_LEVEL        = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("BF_LEVEL")), 0, 0, 9) 	


    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### ���� ������ ������                 ################	
   
	Call dfmemberSql.RetrieveBOARD_NICKNAME(dfDBConn.Conn )

%>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script language="javascript" src="Alditor/alditor.js" type="text/javascript"></script>

<SCRIPT LANGUAGE="JavaScript">
function Checkform() {
	var frm = document.frm1;

	if ((frm.BF_Writer.value == "") || (frm.BF_Writer.value.length < 2))
	{
		alert("�ۼ��ڸ� �����ּ���.");
		frm.BF_Writer.focus();
		return ;	
	}
	
	if (frm.BF_Title.value == "")
	{
		alert("�Խ��� ������ �Է����ּ���.");
		frm.BF_Title.focus();
		return ;	
	}
	if (frm.BF_Contents.value == "")
	{
		alert("�Խ��� ������ �Է����ּ���.");
		frm.BF_Contents.focus();
		return ;
    }

    if (frm.BF_Hits.value == "") {
        frm.BF_Hits.value = 1;
    }

	

	frm.submit();
}
	function getContent(obj)
	{   
	    var txt = obj.options[obj.selectedIndex].text;
	    frm1.BF_Writer.value = txt.split("---")[0];
	    frm1.BN_LEVEL.value  = txt.split("---")[1];
	    //if(BN_IDX != 0) frmConent.location.href = "getName_t.asp?BN_IDX="+ BN_IDX;
	}
</SCRIPT></head>

<body topmargin="0" marginheight="0">
<iframe width=0 height=0 frameborder=0 name="frmConent"></iframe>
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> �Խ��� ����</b></td>
</tr>
</table> 
<div style="height:30px;"><font color="red"><b>**���ù�ȣ ÷�δ� �Ʒ����� ���ó������� ���ù�ȣ�� ÷���ϼž� ���ó����� ÷�ε˴ϴ�</b></font></br><font color="red"><b>**���ù�ȣ ÷�ν� �ĸ�(,)�� ���е˴ϴ�</b></font></br><font color="red"><b>**÷�ν��н� �Խ��� ����ȭ�鿡�� ���ó��� ������ �����մϴ�</b></font></div>
<form name="frm1" action="Board_Write_Proc.asp" method="post" >
<input type="Hidden" name="Process" value="I">
<input type="Hidden" name="BN_LEVEL" value="I">
<table width="100%">
<tr>
    <td>
        <table width="700" border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF">
        <tr>
    <td bgcolor="e7e7e7" align="center" width="100" nowrap><b>��������</b></td>
	<td colspan="3">
	<select name="level">
	<option value="0" <% IF BF_LEVEL = 0 Then %>selected<% End IF %>>�Ϲ�</option>
	<option value="1" <% IF BF_LEVEL = 1 Then %>selected<% End IF %>>��������</option>
	<option value="2" <% IF BF_LEVEL = 2 Then %>selected<% End IF %>>�� �� Ʈ</option>
	<option value="3" <% IF BF_LEVEL = 3 Then %>selected<% End IF %>>�帣�°���</option>
	<option value="4" <% IF BF_LEVEL = 4 Then %>selected<% End IF %>>����������</option>
	<option value="5" <% IF BF_LEVEL = 5 Then %>selected<% End IF %>>�ǽð�����</option>
	</select>
	</td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>����Ʈ����</b></td>
	<td>
	    <input type="radio" name="BF_SITE" value="All" checked> ��ü����
		<% 	Set PML = Server.CreateObject("ADODB.Recordset")
			PML.Open "SELECT SITE01 FROM SET_SITE Order By SEQ", dbCon, 1

			PMLC = PML.RecordCount
		   
			IF PMLC > 0 THEN

			FOR PM = 1 TO PMLC
		   
			IF PML.EOF THEN
				EXIT FOR
			END IF

			SITE01=PML(0) %>
		<input type="radio" name="BF_SITE" value="<%=SITE01%>"> <%=SITE01%>
		<%	PML.Movenext
			Next
			END IF %>
			</td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>�۾���(���̵�)</b></td>
<%
IF BF_LEVEL = 0 Then
    Set PMLs = Server.CreateObject("ADODB.Recordset")
    PMLs.Open "select top 1 IU_NickName from INFO_USER WHERE IU_LEVEL = 9 ORDER BY NEWID()", dbCon, 1
    IF NOT PMLs.EOF  Then
        BF_WRITER=PMLs(0)
    End IF
Else
     BF_WRITER = "������"			
End IF			

%>
    <td colspan="3"><input type="text" name="BF_Writer" style="width:300px;border:1px solid #999999;" value="<%= BF_WRITER %>" ></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>��&nbsp;&nbsp;��</b></td>
    <td colspan="3"><input type="text" name="BF_Title"  maxlength="100" style="width:300px;border:1px solid #999999;"></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>��&nbsp;��&nbsp;��&nbsp;ȣ</b></td>
    <td colspan="3"><input type="text" name="IB_IDX"  maxlength="100" style="width:300px;border:1px solid #999999;"></BR><FONT COLOR="RED">**���ù�ȣ ÷�ν� 1002,1003,1004 �̷������� �ĸ��α����Է�(�������)</FONT></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>��Ͻð�</b></td>
    <td colspan="3"><input type="text" name="BF_REGDATE"  maxlength="50" style="width:300px;border:1px solid #999999;"></BR> ��) 2001-01-01 23�� 21�� (2001�� 1�� 1�� ���� 11�� 21��) <br>�̵�Ͻ� �����Ϸ� ���</td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>��ȸ��</b></td>
    <td colspan="3">
    <%
        Randomize 
        num = Int((50*Rnd))
        'iMod = (num mod 10)+ 1
    %>
    <input type="text" name="BF_Hits" style="width:50px;border:1px solid #999999;" value = "<%= num %>">
    
    </td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>��&nbsp;&nbsp;��</b></td>
    <td colspan="3">
		<textarea name="BF_Contents" style="width:100%; height:250" class=input></textarea></td></tr></table>
<input type="hidden" name="bType" value="<%=bType%>">
<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td align="center"> 
	<input type="button" value=" �� �� " onclick="javascript:Checkform()" style="border: 1 solid; background-color: #C5BEBD;">
	<input type="button" value=" ��� "  onclick="history.back(-1);" style="border: 1 solid; background-color: #C5BEBD;"></td></tr></table>
	</td>
	
	
    <td align="left" valign="top" >
    <select size="25" name="BN_NICKNAME" id="BN_NICKNAME" style="width:300px;border: 1 solid;" onchange="getContent(this);">
    <option value="0" >--���� --</option>
<%	
IF dfmemberSql.RsCount <> 0 THEN	

	FOR i = 0 TO dfmemberSql.RsCount -1 

		BN_IDX		= dfmemberSql.Rs(i,"BN_IDX")
		BN_NICKNAME	= dfmemberSql.Rs(i,"BN_NICKNAME")
		BN_LEVEL	= dfmemberSql.Rs(i,"BN_LEVEL")
		BN_SPORTS	= dfmemberSql.Rs(i,"BN_SPORTS")
%>
    <option value="<%= BN_IDX %>"><%= BN_NICKNAME %>----<%= BN_LEVEL %>----<%= BN_SPORTS %></option>
<%		
    Next	
End IF    	
%>    
    </select>
    </td>
</tr>
</table>	
</form>
</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>

<%
    pageSize        = 27            
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
	sStartDate      = Trim(dfRequest.Value("sStartDate"))
	sEndDate        = Trim(dfRequest.Value("sEndDate"))
	Search          = Trim(dfRequest.Value("Search"))
	Find            = Trim(dfRequest.Value("Find"))	
	reqBF_LEVEL        = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("BF_LEVEL")), 0, 0, 9) 		
	BF_SITE = Trim(request("bType"))
	IB_IDX  = Trim(request("IB_IDX"))

    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	

    Call dfgameSql.RetrieveInfo_Betting(dfDBConn.Conn,  1, 1, "IB_IDX", IB_IDX, sStartDate, sEndDate, "all", 0,0)
    site = "all" 'REQUEST("JOBSITE")
	SET DbRec=Server.CreateObject("ADODB.Recordset") 
	DbRec.CursorType=1

	SQLR = " INFO_BETTING a,info_user b WHERE 1=1 and a.IB_ID = b.IU_ID AND A.IB_SITE = B.IU_SITE AND B.IU_LEVEL = 9 "

	SQLLIST = "SELECT COUNT(*) AS TN FROM "& SQLR &""

		'######### ���� ����Ʈ�� �ҷ���                 ################	
   
	Call dfgameSql.RetrieveInfo_Betting_ADMINLEVEL(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site, 0,0)

%>
<html>
<head>
<title>���� ����Ʈ</title>
<!-- #include virtual="/Inc_Month.asp"-->
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
</head>

<body topmargin="0" marginheight="0">
<iframe name="exeFrame" width=0 height=0 frameborder=0></iframe>
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td>
        <b class="text07"><font color="red">���ýð� ������ ���ڰ� ���ù�ȣ�Դϴ�</font>
	      </b>
    </td>
</tr>
</table>    
<div style="height:10px;"></div>
<table border="0" cellpadding="0" cellspacing="0" align="center">
</table>

<%	IF  dfgameSql.RsCount = 0 THEN	%>

���� ��ϵ� ������ �����ϴ�.

<%
	ELSE
%>

<%
    Dim txttotalIBD_RESULT(9)
        txttotalIBD_RESULT(0) = "��÷"
        txttotalIBD_RESULT(1) = "��÷"
        txttotalIBD_RESULT(2) = "1��ó��"
        txttotalIBD_RESULT(3) = "1��ó��"
        txttotalIBD_RESULT(4) = "���" ' ������ ���
        txttotalIBD_RESULT(9) = "������"
        

                
	FOR ii = 0 TO dfgameSql.RsCount -1
	
	    IB_ID		= dfgameSql.Rs(ii,"IB_ID")
        IB_IDX		= dfgameSql.Rs(ii,"IB_Idx")
        IB_TYPE		= dfgameSql.Rs(ii,"IB_Type")
        IG_IDX		= dfgameSql.Rs(ii,"IG_Idx")
        IB_NUM		= dfgameSql.Rs(ii,"IB_Num")
        IB_BENEFIT	= dfgameSql.Rs(ii,"IB_Benefit")
        IB_AMOUNT	= dfgameSql.Rs(ii,"IB_Amount")
        IB_STATUS	= dfgameSql.Rs(ii,"IB_Status")
        IB_REGDATE	= dfgameSql.Rs(ii,"IB_RegDate")
        
        IB_CANCEL   = dfgameSql.Rs(ii,"IB_CANCEL")
        IU_NICKNAME     = dfgameSql.Rs(ii,"IU_NICKNAME")
        	
        IB_IDX1             = 0 
        BenefitAmount     = 1
        TotalBenefit        = 1
        TotalBenefitA        = 1
        BenefitAmountA        = 1
        totalIBD_RESULT     = 5 '0  : ����, 1  : ����, 2 : ���, 3 : ����Ư�� , 4: ������ ���,  5 : ������ , 9 : ������
        	
        Set dfgameSql1 = new gameSql
        Call dfgameSql1.RetrieveINFO_BETTING_DETAILByPreview(dfDBConn.Conn,IB_IDX)                        
%>
        
            <table width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#4D4D4D">
                <tr bgcolor="#eeeeee">
                    <td width="12%"  align="center" > <b><%= IB_ID %>(<%= IU_NICKNAME %>)</b></td>
                    <td width="7%"  align="center" >���</td>
                    <td width="20%"  align="center" >��(Ȩ��)</td>
                    <td width="5%"  align="center" >��</td>
                    <td width="20%"  align="center" >��(������)</td>
                    <td width="5%"  align="center" >����</td>
                    <td width="15%"  align="center" >����</td>
                    <td width="8%"  align="center" >���</td>                    
                </tr>
<%        
        IF dfgameSql1.RsCount <> 0 Then              
            For  j = 0 to dfgameSql1.RsCount - 1
                IG_IDX		= dfgameSql1.Rs(j,"IG_IDX")
                IBD_IDX		= dfgameSql1.Rs(j,"IBD_IDX")
	            RL_League		= dfgameSql1.Rs(j,"RL_LEAGUE")
	            IG_Team1		= dfgameSql1.Rs(j,"IG_TEAM1")
	            IG_Team2		= dfgameSql1.Rs(j,"IG_TEAM2")
	            IG_Status		= dfgameSql1.Rs(j,"IG_STATUS")
	            IG_Result		= dfgameSql1.Rs(j,"IG_RESULT")
	            IG_StartTime	= dfgameSql1.Rs(j,"IG_STARTTIME")
	            IG_Team1Benefit = dfgameSql1.Rs(j,"IG_TEAM1BENEFIT")
	            IG_DrawBenefit	= dfgameSql1.Rs(j,"IG_DRAWBENEFIT")
	            IG_Team2Benefit	= dfgameSql1.Rs(j,"IG_TEAM2BENEFIT")
	            IG_Score1		= dfgameSql1.Rs(j,"IG_SCORE1")
	            IG_Score2		= dfgameSql1.Rs(j,"IG_SCORE2")
	            IG_Type			= dfgameSql1.Rs(j,"IG_TYPE")
	            IG_Handicap		= dfgameSql1.Rs(j,"IG_HANDICAP")
	            IG_Draw		    = dfgameSql1.Rs(j,"IG_DRAW")
	            IBD_NUM         = dfgameSql1.Rs(j,"IBD_Num")
	            IBD_RESULT      = dfgameSql1.Rs(j,"IBD_RESULT")
	            IBD_RESULT_BENEFIT = dfgameSql1.Rs(j,"IBD_RESULT_BENEFIT")
	            IBD_BENEFIT = dfgameSql1.Rs(j,"IBD_BENEFIT")
            
                IG_Result = Trim(IG_Result)
                
                df = DATEDIFF("s",now(),Cdate(IG_StartTime))

                
                IF boolBET_CANCEL2 AND CDBL(df) < 0 Then            
                    boolBET_CANCEL2 = False
                End IF     
                           
                            
                IF (IG_Status = "E") OR (IG_Status = "S") Then
                    IG_Result = 3
                End IF
                        

	            IF IG_Type <> "0" THEN 
		            IG_DrawBenefit = IG_Handicap
	            END IF
                

                
                IF IG_Type = "1" Then
                    txtIG_Type  = "�ڵ�"   
                    IG_DRAWBENEFIT =  IG_HANDICAP
                ElseIF IG_Type = "2" Then
                    txtIG_Type  = "��/��"  
                    IG_DRAWBENEFIT =  IG_HANDICAP  
                Else
                    txtIG_Type  = "�¹���"    
                End IF
                
                IF IBD_NUM = "1" Then
                    choice  = "��"    
                ElseIF IBD_NUM = "0" Then
                    choice  = "��"    
                ElseIF IBD_NUM = "2" Then
                    choice  = "��"    
                End IF
                

                IF IBD_RESULT = "0" Then    
                txtIBD_RESULT = "����"
                IF cStr(IBD_NUM) = "0" Then
                    cssSelected1 = ""
                    cssSelected0 = "class='Selected'"
                    cssSelected2 = ""                
                ElseIF cStr(IBD_NUM) = "1" Then
                    cssSelected1 = ""
                    cssSelected0 = ""
                    cssSelected2 = "class='Selected'"                                
                ElseIF cStr(IBD_NUM) = "2" Then
                    cssSelected1 = "class='Selected'"
                    cssSelected0 = ""
                    cssSelected2 = ""                                
                End IF                  
            ElseIF IBD_RESULT = "1" Then
                txtIBD_RESULT = "����"
                
                IF cStr(IBD_NUM) = "0" Then
                    cssSelected1 = ""
                    cssSelected0 = "class='Selected'"
                    cssSelected2 = ""                
                ElseIF cStr(IBD_NUM) = "1" Then
                    cssSelected1 = "class='Selected'"
                    cssSelected0 = ""
                    cssSelected2 = ""                                
                ElseIF cStr(IBD_NUM) = "2" Then
                    cssSelected1 = ""
                    cssSelected0 = ""
                    cssSelected2 = "class='Selected'"                                
                End IF                
            ElseIF IBD_RESULT = "2" Then '���
                txtIBD_RESULT = "1��ó��"
                IG_Result = 4
            ElseIF IBD_RESULT = "3" Then '��Ư
                txtIBD_RESULT = "1��ó��"
                IG_Result = 4
            Else
                txtIBD_RESULT = "����"
            End IF
            
            IF IBD_RESULT_BENEFIT = 1 Then
                txtIBD_RESULT = "1��ó��"
                IG_Result = 4                    
            End IF
                
                IF IBD_RESULT_BENEFIT = 1 Then
                    txtIBD_RESULT = "1��ó��"
                    IG_Result = 4                    
                End IF
                
                SCORE = IG_SCORE1 & " : " & IG_SCORE2
                
                '#### ���� ������ üũ�Ѵ�.
                IF IBD_RESULT = 9  Then
                   totalIBD_RESULT = 9 
                   IBD_RESULT_BENEFIT = IBD_BENEFIT
                End IF            
                
                TotalBenefit = Cdbl(TotalBenefit) * Cdbl(IBD_RESULT_BENEFIT)
                TotalBenefitA = Cdbl(TotalBenefit) * Cdbl(IBD_RESULT_BENEFIT)
                
                'response.Write IBD_RESULT & "--" & IBD_RESULT_BENEFIT & "---" & TotalBenefit &"<br>"
            
                                            
%>  
                
                <tr bgcolor="ffffff" >
                <form name="form<%= i %>" action="Betting_Proc_new.asp" target="exeFrame">                
                <input type="hidden" name="IB_ID" value="<%= IB_ID %>" />
                <input type="hidden" name="IBD_IDX" value="<%= IBD_IDX %>" />
                <input type="hidden" name="IG_IDX" value="<%= IG_IDX %>" />
                <input type="hidden" name="IBD_NUM_ORI" value="<%= IBD_NUM %>" />
                <input type="hidden" name="IB_Amount" value="<%= IB_Amount %>" />                
                    <td align="center" ><%=dfStringUtil.GetFullDate(IG_StartTime)%></td>
                    <td align="center" ><%=txtIG_Type%></td>
                    <td align="center" <%=cssSelected1%>>
                        <table cellpadding=0 cellspacing=0 border=0 width=100%>
                            <tr>
                                <td width="80%" align="left" width="71" style="padding-left:4" align="center" ><% IF IG_TYPE = "2" Then response.Write OVER_IMAGE %><%=IG_Team1%></td>
                                <td align="right" width="71" style="padding-right:4" align="center" ><%= FormatNumber(IG_TEAM1BENEFIT,2) %></td>
                            </tr>
                        </table>    
                    </td>                    
                    <td style="padding-top:4;" align="center" <%=cssSelected0%>>
                        <%= dfStringUtil.getDrawValue(IG_TYPE, dfgameSql1.Rs(j,"IG_DRAWBENEFIT") ,dfgameSql1.Rs(j,"IG_HANDICAP")) %>
                    </td>
                    <td align="center" <%=cssSelected2%>>
                        <table cellpadding=0 cellspacing=0 border=0 width=100%>
                            <tr>
                                <td align="left" width="71" style="padding-left:4" align="center" ><%= FormatNumber(IG_TEAM2BENEFIT,2) %></td>
                                <td width="80%" align="right"width="71" style="padding-right:4" align="center" ><%=IG_Team2%><% IF IG_TYPE = "2" Then response.write UNDER_IMAGE %></td>
                            </tr>
                        </table>                       
                    </td>                   
                    <td style="padding-top:4;" align="center" ><%=SCORE%></td>
                    <td style="padding-top:4;" align="center">
                    <select name="IBD_NUM">
                        <option value="1" <% IF cStr(IBD_NUM) = "1" Then %>selected<% End IF %>>��</option>
                        <option value="0" <% IF cStr(IBD_NUM) = "0" Then %>selected<% End IF %>>��</option>
                        <option value="2" <% IF cStr(IBD_NUM) = "2" Then %>selected<% End IF %>>��</option>
                    </select>                    
                    <select name="IBD_RESULT">
                        <option value="1" <% IF cStr(IBD_RESULT) = "1" Then %>selected<% End IF %>>����</option>
                        <option value="0" <% IF cStr(IBD_RESULT) = "0" Then %>selected<% End IF %>>����</option>
                    </select>                                        
                    <input type="text" name="IBD_RESULT_BENEFIT" value="<%= IBD_RESULT_BENEFIT %>" size="4" />
                    </td>
                    <td style="padding-top:4;" align="center" >                    
                        <input type="submit" value="<%=txtIBD_RESULT%>" />
                    </td>                    
                </form>                    
                </tr>
<%                            
		    Next
        End IF
        
        
        BenefitAmount = Cdbl(IB_Amount)  * CDbl(numdel2(TotalBenefit*100))/100 
        BenefitAmountA = Cdbl(IB_Amount)  * CDbl(numdel2(TotalBenefit*100))/100 
        BenefitAmount = numdel2(BenefitAmount)
        BenefitAmountA = numdel2(BenefitAmountA)
        IF cInt(TotalBenefit) = 1 Then
            totalIBD_RESULT = 2
            resultBgColor1 = "Cancel"
        ElseIF cInt(TotalBenefit) = 0 Then                
            totalIBD_RESULT = 0
            resultBgColor1 = "Looser"
        Else                    
            IF cInt(totalIBD_RESULT) = 9 Then               
                totalIBD_RESULT = 9 
                resultBgColor1 = "noSelected"
            Else
                totalIBD_RESULT = 1 
                resultBgColor1 = "Winner"
            End IF                    
        End IF
                
                
        IF IB_CANCEL <> 0 Then
            totalIBD_RESULT = 4
            resultBgColor1 = "failGame"
        End IF 
        
        
        
%>
    <form name="form111<%= i %>" action="Betting_Proc_new.asp" target="exeFrame">
    <input type="hidden" name="IB_IDX" value="<%= IB_IDX %>" />
                <tr bgcolor="#eeeeee">
                    <td colspan="6">
                        <table width="100%">
                        <tr>
                            <td>
                                <b style="font-size:15px"><font color="red">���ù�ȣ :
                                <%= IB_IDX %></font></br></b><input type="text" name="IB_REGDATE" value="<%=dfStringUtil.GetFullDate(IB_REGDATE)%>" />
                            </td>
                            <td>
                                ���ñݾ� : <B style='color:red'><%=FORMATNUMBER(IB_Amount,0)%></B> ��
                            </td>
                            <td>
                                ���� : <B style='color:red'><%= FORMATNUMBER(TotalBenefit,2) %></B>
                            </td>                            
                            <td>
                                ���� ���߱� :<B style='color:red'> <%= FORMATNUMBER(BenefitAmountA,0) %></B> ��
                            </td>                                                        
                            <td>
                                ���߱ݾ� : <B style='color:red'><%= FORMATNUMBER(BenefitAmount,0) %></B> ��
                            </td>                                                                                    
                        </tr>
                        </table>
                    </td>
                    <td  class="<%= resultBgColor1 %>" style="padding-top:4;" align="center" >
                    <%=txttotalIBD_RESULT(totalIBD_RESULT)%>&nbsp;
                    </td>
                    <td align="center">
                        <input type="submit" value="�ð�����" />                        
                    </td>
                </tr>
</form>                
                </table>
                
                <div style="height:5px;"></div>
<%         

        BenefitAmount     = 1
        TotalBenefit        = 1
        TotalBenefitA        = 1
        BenefitAmountA        = 1
        totalIBD_RESULT     = 5
           
	Next 

		
END IF
%>


<br clear="all">
<table width="100%">
<tr>
    <td align="center">
<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
<!-- paging End -->
</td>
</tr>
</table>


</body>
</html>
