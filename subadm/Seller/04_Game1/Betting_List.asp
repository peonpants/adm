<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/Seller/04_Game1/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
	SETSIZE = 20
	PGSIZE = 30

    PAGE = REQUEST("PAGE")
	Search = REQUEST("Search")
	Find = Trim(REQUEST("Find"))
    sStartDate = REQUEST("sStartDate")
    sEndDate = REQUEST("sEndDate")
    
    reqIB_AMOUNT = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("IB_AMOUNT")), 0, 0, 3000000)
    real_user = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("real_user")), 1, 0, 1)
    
    site = SESSION("rJOBSITE")
	IA_SITE = Session("rJOBSITE")
	SQLLIST2 = "select top 1 * from info_admin where ia_site = '"&Session("rJOBSITE")&"'"
	SET RS2 = DBCON.EXECUTE(SQLLIST2)

	IA_LEVEL = RS2("IA_LEVEL")
	IA_GROUP = RS2("IA_GROUP")
	IA_GROUP1 = RS2("IA_GROUP1")
	IA_GROUP2 = RS2("IA_GROUP2")
	IA_GROUP3 = RS2("IA_GROUP3")
	IA_GROUP4 = RS2("IA_GROUP4")
	IA_Type = RS2("IA_Type")
	RS2.CLOSE
	SET RS2 = Nothing

	SET DbRec=Server.CreateObject("ADODB.Recordset") 
	DbRec.CursorType=1

	SQLR = " INFO_BETTING a,info_user b WHERE 1=1 and a.IB_ID = b.IU_ID AND A.IB_SITE = B.IU_SITE"

	SQLLIST = "SELECT COUNT(*) AS TN FROM "& SQLR &""
	SET RSLIST = DbCon.Execute(SQLLIST)
	TOMEM = RSLIST(0)
	RSLIST.CLOSE
	SET RSLIST = Nothing

    pageSize        = 25             
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 

    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	

	'######### ���� ����Ʈ�� �ҷ���                 ################	
	If IA_LEVEL = "2" Then
		Call dfgameSql.RetrieveInfo_Betting_SUBNEW(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site, reqIB_AMOUNT, real_user, IA_GROUP, IA_GROUP1, IA_LEVEL)
	ELSEIf IA_LEVEL = "3" Then
		Call dfgameSql.RetrieveInfo_Betting_SUBNEWs1(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site, reqIB_AMOUNT, real_user, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_LEVEL)
	ELSEIf IA_LEVEL = "4" Then
		Call dfgameSql.RetrieveInfo_Betting_SUBNEWs2(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site, reqIB_AMOUNT, real_user, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_LEVEL)
	ELSEIf IA_LEVEL = "5" Then
		Call dfgameSql.RetrieveInfo_Betting_SUBNEWs3(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate, site, reqIB_AMOUNT, real_user, IA_GROUP, IA_GROUP1, IA_GROUP2, IA_GROUP3, IA_GROUP4, IA_LEVEL)
	End If

	

    'dfGameSql.debug
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
	objPager.PageButtonCount = 5
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
<title>���� ����Ʈ</title>
  <script type="text/javascript" src="../includes/calendar1.js"></script>
  <script type="text/javascript" src="../includes/calendar2.js"></script>
<link rel="stylesheet" type="text/css" href="/seller/Css/Style.css">
<link rel="stylesheet" href="../Includes/bootstrap3.3.2.min.css" type="text/css" />          
<link rel="stylesheet" href="../Includes/bootstrap-theme3.3.2.min.css" type="text/css" />    
<script src="/js/jquery-1.10.2.min.js" type="text/javascript"></script>						
<script src="../Includes/bootstrap3.3.2.min.js" type="text/javascript"></script>			
<link rel="stylesheet" href="../css/HberAdmin_Style.css" type="text/css" />			

<script src="/js/ajax.js" language="JavaScript" type="text/javascript"></script>
    <style>
    .baord_table_bg {background-color:#AAAAAA}
    .td_red_bold {background-color:#EEEEEE}
    .trIngGame {background-color:#FFFFFF}

    .noChoice {vertical-align:middle;background:red;color:#FFFFFF; border: 1px solid #838383;}
    .noChoice table {color:#FFFFFF; }
    .Choice {vertical-align:middle;background:yellow;color:#000000;border: 1px solid #838383;}
    .Choice table {color:#000000; }

    .ingChoice {vertical-align:middle;background:#aaaaaa;color:#000000;border: 1px solid #838383;}
    .ingChoice table {color:#000000; }
    
    .cancelChoice {vertical-align:middle;background:#ffffff;color:#000000;border: 1px solid #838383;}
    .cancelChoice table {color:#E9BB5B; }
        
    </style>
<SCRIPT LANGUAGE="JavaScript">
function go_delete(form)
{
	var v_cnt = 0;
	var v_data = "";
	
	for( var i=0; i<form.elements.length; i++) 
	{
		var ele = form.elements[i];
		if( (ele.name=="SelUser") && (ele.checked) )
		{ 
			//if (v_cnt == 0)
			if (v_data.length==0)
				v_data = ele.value;
			else
				v_data = v_data + "," + ele.value; 
			v_cnt = v_cnt + 1; 
		} 
	}
		
	if (v_cnt == 0) 
	{ 
		alert("������ ������ ������ �ּ���."); 
		return;
	} 
	
	//alert(v_data);
	
	if (!confirm("���� �����Ͻðڽ��ϱ�?")) return;		
	form.action = "Delete.asp?page=<%=page%>";
	form.submit();
}
	
	function SearchSports(ss) {
		document.frm1.action = "List.asp?RS_Sports="+ss;	
		document.frm1.submit();
	}
	
	function SearchLeague(ss,sl) {
		// document.frm1.action = "List.asp?RS_Sports="+ss+"&RL_League="+sl;
		// document.frm1.submit();
		location.href = "List.asp?RS_Sports="+ss+"&RL_League="+sl;
	}

	function goMyBetDetail(idx,pg,tt) {
		goUrl = "Betting_Detail.asp?IB_Idx="+idx+"&page="+pg+"&total="+tt;
		location.href=goUrl;
	}
	function goBatdel(gidx) {
		if (!confirm("���� ����Ͻðڽ��ϱ�?\n\n��ҽ� �ش� ���ÿ� ���� ȯ��ó���� �̷�� ���ϴ�.")) return;		
		exeFrame.location.href="Bet_Cancel_Proc.asp?IB_Idx="+gidx;
	}
	
	function goDetail(IB_Idx, gameCnt)
	{
	    var url = "Betting_Detail.asp?IB_Idx="+IB_Idx;
	    dis = document.getElementById("tr"+IB_Idx).style.display == "none" ? "" : "none" ;
	    document.getElementById("tr"+IB_Idx).style.display = dis ;
	    if(dis == "")
	    {
	        
	        document.getElementById("iframe"+IB_Idx).style.width = "100%" ;
	        document.getElementById("iframe"+IB_Idx).style.height = (gameCnt*20) + 130 ;
	        document.getElementById("iframe"+IB_Idx).src = url ;
	    }
	}

    function ajaxRequestBet(ib_idx, e)
	{

        var E=window.event;
        var x =  E.clientX + document.body.scrollLeft ;
	    var y =  E.clientY + document.body.scrollTop;
    	
		document.getElementById("aaa").style.left = x ;
		document.getElementById("aaa").style.top = y ;	
		        
		var url = "ajaxBetting_Detail.asp";
		var pars = 'ib_idx=' + ib_idx
		
		var myAjax = new Ajax.Request(
			url, 
			{
				method: 'get', 
				parameters: pars, 
				onComplete: showResponse
			});

	
				
	}

	function showResponse(originalRequest)
	{
	
		document.getElementById("aaa").innerHTML = originalRequest.responseText;
        
	}


</SCRIPT>


</head>
<body topmargin="0" marginheight="0" style="padding:0px 0px 0px 1px;" class="AdminBodyW99">

<div class="MenuLeft_MainDiv2 width100pIMP">
	<div class="MenuLeft_MainInnerDiv width95pIMP">
	<iframe name="exeFrame" id="exeFrame" width="0" height="0"></iframe>

	<div class="title-default">
		<span class="txtsh011b" style="color:#adc;"> �� </span>
		          ���� ���� &nbsp;&nbsp; ��  ���� ����Ʈ  
	      </b>

	</div>


<div style="height:10px;"></div>



     
<div style="height:10px;"></div>
<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="get" action="Betting_List.asp">
<tr><td>�������� :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>
	<input type="text" name="sStartDate" id="txtDate" value="<%=Left(sStartDate,12)%>" onclick="fnPopUpCalendar(txtDate,txtDate,'yyyy/mm/dd')" class='text_box1' style="width:70px;"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>�������� :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" id="txtDate2" value="<%=Left(sEndDate,12)%>" onclick="fnPopUpCalendar2(txtDate2,txtDate2,'yyyy/mm/dd')" class='text_box1' style="width:70px;"></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="iu_nickname" <%if Search = "iu_nickname" then Response.Write "selected"%>>�г���</option>
		<option value="IB_ID" <%if Search = "IB_ID" then Response.Write "selected"%>>���̵�</option>
		<option value="IG_TEAM" <%if Search = "IG_TEAM" then Response.Write "selected"%>>����</option>
		<option value="IB_TYPE" <%if Search = "IB_TYPE" then Response.Write "selected"%>>���ӱ���</option>
		<option value="IB_CNT" <%if Search = "IB_CNT" then Response.Write "selected"%>>������</option>
		<option value="IB_SITE" <%if Search = "IB_SITE" then Response.Write "selected"%>>����Ʈ��</option>
		</select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="3" height="1"></td>
	<td></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>

	
	

	<div class="input-group input-group-sm">
		<span class="input-group-addon" id="basic-addon1">�ݾ�</span>
		<input type="text" name="IB_AMOUNT" size="20" maxlength="30" value="<%=reqIB_AMOUNT%>" class="input text_box1 form-control " style="width:100px;">
		  <span class="input-group-btn">
				  <input type="submit" value="�� ��" class="btn btn-info">
			  </span>
		  </div>



	
	</td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	</tr></form></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>


<div style="padding:0px;margin:0px;border:1px solid #cccccc;">
<table border="0"  cellspacing="1" cellpadding="2" bgcolor="#AAAAAA" width="100%" class="trhover HberTh HberTableLG" >

<form name="frm1" method="post">
  <tr bgcolor="e7e7e7" class="title-backgra">
	<!-- <th align="center" height="30" width="40"><b>����</b></th> -->
	<th align="center" width="50"><b>��ȣ</b></th>
	<th align="center" width="40"><b>����</b></th>
	<th align="center" width="30"><b>ID</b></th>
	<th align="center" width="60"><b>����Ʈ</b></th>
	<th align="center" width="40"><b>���Ӽ�</b></th>
	<th align="center"><b>�������೻��</b></th>			
	<th align="center" width="60"><b>�����</b></th>
	<th align="center" width="90"><b>���þ�</b></th>
	<th align="center" width="90"><b>������߱�</b></th>
	<th align="center" width="120"><b>���ýð�</b></th>		
	<th align="center" width="60"><b>���</b></th>
	<th align="center" width="60"><b>��</b></th>
	<th align="center" width="60"><b>���</b></th>
	</tr>

<%	IF  dfgameSql.RsCount = 0 THEN	%>

<tr bgcolor="ffffff"> <td align="center" colspan="13" height="35">���� ��ϵ� ������ �����ϴ�.</td></tr>

<%
	ELSE


IB_IDX1             = 0 
    BenefitAmount     = 1
    TotalBenefit        = 1  ' ��������%
    TotalBenefit1        = 1 ' ��������%
    totalIBD_RESULT     = 5 '0  : ����, 1  : ����, 2 : ���, 3 : ����Ư�� , 5 : ������ , 9 : ������
    
    Dim txttotalIBD_RESULT(9)
        txttotalIBD_RESULT(0) = "<font color='red'>����</font>"
        txttotalIBD_RESULT(1) = "<font color='yellow'>����</font>"
        txttotalIBD_RESULT(2) = "<font color='f0f0f0'>���</font>"
        txttotalIBD_RESULT(3) = "1��ó��"        
        txttotalIBD_RESULT(9) = "<font color='blue'>������</font>"
        
        
	FOR ii = 0 TO dfgameSql.RsCount -1
	
		IB_Idx		= dfgameSql.Rs(ii,"IB_Idx")
		IB_ID		= dfgameSql.Rs(ii,"IB_ID")
		IB_Type		= dfgameSql.Rs(ii,"IB_Type")
		IB_Num		= dfgameSql.Rs(ii,"IB_Num")
		IG_Idx		= dfgameSql.Rs(ii,"IG_Idx")
		IB_Benefit	= dfgameSql.Rs(ii,"IB_Benefit")
		IB_Amount	= dfgameSql.Rs(ii,"IB_Amount")
		IB_Status	= dfgameSql.Rs(ii,"IB_Status")
		IB_RegDate	= dfgameSql.Rs(ii,"IB_RegDate")
		IB_SITE		= dfgameSql.Rs(ii,"IB_SITE")
		IU_NICKNAME = dfgameSql.Rs(ii,"IU_NICKNAME")	
		IB_ADMIN_CANCEL = dfgameSql.Rs(ii,"IB_ADMIN_CANCEL")	
		IB_CANCEL_DATE = dfgameSql.Rs(ii,"IB_CANCEL_DATE")	
		IB_BWIN = dfgameSql.Rs(ii,"IB_BWIN")	
		IB_CNT = dfgameSql.Rs(ii,"IB_CNT")	
		
 	
		
        Set dfgameSql1 = new gameSql
        Call dfgameSql1.RetrieveINFO_BETTING_DETAILByPreview(dfDBConn.Conn,IB_IDX)    
                
        IF IB_CNT = 1 Then
            strIB_TYPE = "�ܽ�"
        Else
            strIB_TYPE = "����"
        End IF 
        
        IF IB_BWIN = "1" Then
            strIB_TYPE = strIB_TYPE &  "<Br>BWIN"
        End IF        
%>
<% If IB_CREGER <> "admin" Then %>
<tr bgcolor="ffffff"> 
	<td align="center">
	    <%= IB_Idx %>
	</td>
	<td align="center"><a href="/seller/04_Game1/Betting_List.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=IB_TYPE&Find=<%=IB_Type%>">
	<%= strIB_TYPE %></a></td>
	<td>&nbsp;<a href="/seller/04_Game1/Betting_List.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=IB_ID&Find=<%=IB_ID%>"><%=IB_ID%>(<%=iu_nickname%>)</a></td>
	<%
	siteColor = ""
	    IF IB_SITE = "None" Then
	        siteColor = "bgcolor=yellow"
	        IF cStr(IB_ADMIN_CANCEL) = "1" Then
	            siteColor = "bgcolor=skyblue"
	        End IF
	    End IF 
	%>
    <td align='center' <%= siteColor %>><a href="/seller/04_Game1/Betting_List.asp?sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=IB_SITE&Find=<%=IB_SITE%>"><%=IB_SITE%></a></td>
    <td align="center"><%=dfgameSql1.RsCount%></td>
    <td style="padding:0px;">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
    <%
    
    
            
        For  j = 0 to dfgameSql1.RsCount - 1
            IG_IDX		= dfgameSql1.Rs(j,"IG_IDX")
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
            IG_TEAM = dfgameSql1.Rs(j,"IG_TEAM")
            IBD_AdminDEL = dfgameSql1.Rs(j,"IBD_AdminDEL")
            


        if cStr(IG_RESULT) = "" Then
            IG_RESULT  = 9 
        End if
        'response.Write IB_IDX
        IF IG_Type = "1" Then
            txtIG_Type  = "�ڵ�ĸ"   
            IG_DRAWBENEFIT =  IG_HANDICAP
        ElseIF IG_Type = "2" Then
            txtIG_Type  = "����/���"  
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
        
    	                    
        IF IG_TYPE = 1 Then
            IF IBD_NUM = "1" Then
                choice  = "�ڽ�"    
            ElseIF IBD_NUM = "2" Then
                choice  = "����"    
            End IF            				        
        ElseIF IG_TYPE = 2 Then
            IF IBD_NUM = "1" Then
                choice  = "����"    
            ElseIF IBD_NUM = "2" Then
                choice  = "���"    
            End IF                                
        End IF
               

                        
        resultBgColor = "#FFFFFF"
        cssSelected2 = "class='cancelChoice'"
        IF IBD_RESULT = "0" Then    
            txtIBD_RESULT = "����"
            cssSelected2 = "class='noChoice'"
        ElseIF IBD_RESULT = "1" Then
             txtIBD_RESULT = "<font color='#000000'><b>����</b></font>"
             cssSelected2 = "class='Choice'"
        ElseIF IBD_RESULT = "2" Then
            txtIBD_RESULT = "<font color='000000'><b>���</b></font>"
            cssSelected2 = "class='cancelChoice'"
        ElseIF IBD_RESULT = "3" Then
            txtIBD_RESULT = "<font color='000000'><b>Ư��</b></font>"
            cssSelected2 = "class='cancelChoice'"
        Else
            txtIBD_RESULT = "����"
            cssSelected2 = "class='ingChoice'"
        End IF
        
        IF IB_SITE = "None" Then
            txtIBD_RESULT = "<font color='000000'><b>���</b></font>"
            cssSelected2 = "class='cancelChoice'"        
        End IF
        
        IF cStr(IB_BWIN) = "1" Then
            cssSelected2 = "class='cancelChoice'" 
            choice  = IG_TEAM                    
        End IF      
          
        IF IBD_AdminDEL = "Y" Then
            choice  = "<font color='B50D0D'>���</font>"
            cssSelected2 = "class='cancelChoice'" 
        End IF
        
        
        SCORE = IG_SCORE1 & " : " & IG_SCORE2
        
        '#### ���� ������ üũ�Ѵ�.
        IF IBD_RESULT = 9  Then
           totalIBD_RESULT = 9 
           IBD_RESULT_BENEFIT = IBD_BENEFIT
        End IF            
        
         TotalBenefit = Cdbl(TotalBenefit) * Cdbl(IBD_RESULT_BENEFIT)                
         TotalBenefit1= Cdbl(TotalBenefit1) * Cdbl(IBD_BENEFIT)                
            
            cellWidth = (100 / Cint(dfgameSql1.RsCount)) & "%"
            GameCnt = dfgameSql1.RsCount	                
    %>
        <td height="20" width="<%=cellWidth%>" <%= cssSelected2 %>  align="center"><%=IG_Team1%><br><%=choice%></td>
    <%
        Next
        
        BenefitAmount = Cdbl(IB_Amount)  * CDbl(numdel2(TotalBenefit*100))/100    
        BenefitAmount1 = Cdbl(IB_Amount)  * CDbl(numdel2(TotalBenefit1*100))/100    
        BenefitAmount1 = numdel2(BenefitAmount1) 
        BenefitAmount = numdel2(BenefitAmount) 
         
        resultBgColor1 = ""
        IF cDbl(TotalBenefit) = 1 Then
            totalIBD_RESULT = 2
        ElseIF cDbl(TotalBenefit) = 0 Then                
            totalIBD_RESULT = 0
            resultBgColor1 = "ingChoice"
        Else                    
            IF cDbl(totalIBD_RESULT) = 9 Then               
                totalIBD_RESULT = 9 
                resultBgColor1 = "cancelChoice"
            Else
                totalIBD_RESULT = 1 
                resultBgColor1 = "Winner"
            End IF                    
        End IF
                
                
        IF IB_CANCEL <> 0 Then
            totalIBD_RESULT = 4
        End IF   
        
        IF IB_SITE = "None" Then
            txtIBD_RESULT = "<font color='000000'><b>���</b></font>"
            cssSelected2 = "class='cancelChoice'"        
            totalIBD_RESULT = 2
        End IF
                               
    %>
    </tr>
    </table>
    </td>
	<td align="right">
    <% IF cDbl(TotalBenefit) = 0  Then %>	
	<%=numdel(TotalBenefit1)%>&nbsp;
	<% Else %>
	<%=numdel(TotalBenefit)%>&nbsp;
	<% End IF %>
    </td>
	<td align="right"><%=formatnumber(IB_Amount,0)%>��&nbsp;</td>
	<td align="right">	
	<% IF cDbl(TotalBenefit) = 0  Then %>	
	<%=formatnumber(BenefitAmount1,0)%>��&nbsp;
	<% Else %>
	<%=formatnumber(BenefitAmount,0)%>��&nbsp;
	<% End IF %>
	</td>
	<td align="center"><%=dfStringUtil.GetFullDate(IB_RegDate)%></td>			
	<td align="center" class="title-backgra2"><b><%=txttotalIBD_RESULT(totalIBD_RESULT)%></b></td>			
	<td align="center">
	<% IF cSTr(IB_BWIN) = "1" Then %>
	<a href="Betting_List.asp?Search=IB_IDX&Find=<%=IB_Idx%>">�󼼺���</a>
	<% Else %>
	<a href="Betting_Detail.asp?IB_Idx=<%=IB_Idx%>&Page=<%=Page%>&sStartDate=<%=Left(sStartDate,12)%>&sEndDate=<%=Left(sEndDate,12)%>&Search=<%=Search%>&Find=<%=Find%>">�󼼺���</a>
	<% End IF %>
	<br />
	<% IF cSTr(IB_BWIN) = "1" Then %>
	<a href="javascript:goDetailBwin(<%=IB_Idx%>, <%= GameCnt %>);">�ٷκ���</a>
	<% Else %>
	<a href="javascript:goDetail(<%=IB_Idx%>, <%= GameCnt %>);">�ٷκ���</a>
	<% End IF %>	
	</td>
<%
	siteColor = ""
	    IF IB_SITE = "None" Then
	        siteColor = "bgcolor=yellow"
	        IF cStr(IB_ADMIN_CANCEL) = "1" Then
	            siteColor = "bgcolor=skyblue"
	        End IF
	    End IF 
	%>	
	<td align="center" <%= siteColor %>>
	    
	</td>    
</tr>
<tr id="tr<%= IB_Idx %>" style="display:none;" >
    <td colspan="13" bgcolor="efefef">
        <iframe id="iframe<%= IB_Idx %>" frameborder="0"  scrolling="no" ></iframe>
    </td>
</tr>
<%
End if
        BenefitAmount     = 1
        BenefitAmount1     = 1
        TotalBenefit1     = 1
        TotalBenefit        = 1
        TotalBenefitA        = 1
        BenefitAmountA        = 1
        totalIBD_RESULT     = 5
        
    Next 
END IF
%>

</table><br clear="all">
<div style="width:100%;text-align:center;padding:0px;">

<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
<!-- paging End -->
</div>
</form>
<iframe name="exeFrame" id="exeFrame" width=0 height=0 frameborder=0></iframe>
</body>
</html>
