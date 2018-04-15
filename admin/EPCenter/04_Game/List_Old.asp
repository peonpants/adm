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
    page = REQUEST("page")
	SRL_League = REQUEST("SRL_League")
	SRS_Sports = REQUEST("SRS_Sports")
	SFlag = REQUEST("SFlag")	
	Search = Trim(REQUEST("Search"))
	Find = Trim(REQUEST("Find"))
	GSITE = REQUEST("GSITE")
	IG_Type = REQUEST("IG_Type")
	
    IF SFlag = "" Then
        SFlag = "E"
    End IF
	
	IF IG_Type = "" Then
	    IG_Type =  9 
	End IF
	FSql = "select * from info_game where ig_status = 'E' and ig_result > 0"
	SET FRs = Server.CreateObject("ADODB.Recordset")
	FRs.Open FSql, DbCon, 1
	
	If Not FRs.eof Then
		for  FR = 1 To FRs.RecordCount
		ESql = "update info_game set ig_status = 'F' where ig_idx ="&FRs("IG_IDX")
		DbCon.Execute (ESql)
		FRs.movenext
		next
	End If 

	FRs.Close
	Set FRs = Nothing 
	
    pageSize        = 50   
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 

	
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    	
	'######### ���� ����Ʈ�� �ҷ���                 ################	
   
	Call dfgameSql.RetrieveInfo_Game(dfDBConn.Conn,  page, pageSize, SRS_Sports, SRL_League, SFlag, Search, Find, GSITE, IG_Type)

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
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<!--<script src="/Sc/Base.js"></script>-->
<SCRIPT LANGUAGE="JavaScript">
function new_win(link) {
	if(link!="#") {
	location.href = ""+link+"";	}}

function go_delete(form) {
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
	form.action = "Delete.asp?page=<%=PAGE%>&SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>";
	form.submit();	}

function go_start(form) {
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
	form.action = "GameStart.asp?page=<%=PAGE%>&SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>";
	form.submit();	}

function jsBag(anc) {
	var selnums='', i, form=document.frm1, unchked=0, chked=0;
	for(i=0;i<form.length;i++) {
		if(form[i].type!='checkbox') continue;
		if(!form[i].checked) { unchked++; continue; }
		selnums+=form[i].value+'|', chked++;
	}
	if(!selnums) {
		for(i=0;i<form.length;i++) {
			if(form[i].type!='checkbox') continue;
			form[i].checked=true;
		}
		return false;
	}
	if(unchked==0) { // ��ü������ 2�� ����� ������ �ȴ�.
		
		
				for(i=0;i<form.length;i++) {
					if(form[i].type!='checkbox') continue;
					form[i].checked=false;
				}
				
	}
		
	return true;
}

function BetList(URL) {
	window.open(URL, 'BetList', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,copyhistory=no,width=500,height=500'); }
function gong(gidx){
			var ss = "<%=SRS_Sports%>";
			var sl = "<%=SRL_League%>";
			var fg = "<%=SFlag%>";
			var pg = "<%=Page%>";
			var openUrl = "Game_Edit_go.asp?IG_Idx="+gidx+"&SRS_Sports="+ss+"&SRL_League="+sl+"&SFlag="+fg+"&page="+pg;
			window.open(openUrl, 'gong','left=400,top=400,width=600,height=300,0,0,0,0');			
		}	
</SCRIPT>

<!--���콺 ��Ŭ�� ����-->


</head>

<body topmargin="0" marginheight="0" onload="location.href='#111'">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07">  ���Ӱ��� �� ���Ӹ���Ʈ</b></td>
</tr>
</table>    
<div style="height:10px;"></div>
<form name="frm1" method="post">
<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF">
  <tr>
    <td width="80" bgcolor="e7e7e7" align="center">
	  <b>Ÿ��</b>
	</td>
	<td width="110" align="center">
	  <select name="IG_TYPE" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" onChange="new_win(this.options[this.selectedIndex].value)">
	    <option value="List.asp?SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>&GSITE=<%=GSITE%>&IG_TYPE=9" <% IF IG_TYPE = "" THEN Response.write "SELECTED" %>>:: ��üŸ�� ::</option>
	    <option value="List.asp?SRS_Sports=<%=SRL_League%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>&GSITE=<%=GSITE%>&IG_TYPE=0" <% IF cStr(IG_TYPE) = "0" THEN Response.write "SELECTED" %>>������</option>
	    <option value="List.asp?SRS_Sports=<%=SRL_League%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>&GSITE=<%=GSITE%>&IG_TYPE=1" <% IF cStr(IG_TYPE) = "1" THEN Response.write "SELECTED" %>>�ڵ�</option>
	    <option value="List.asp?SRS_Sports=<%=SRL_League%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>&GSITE=<%=GSITE%>&IG_TYPE=2" <% IF cStr(IG_TYPE) = "2" THEN Response.write "SELECTED" %>>����</option>

      </select>
	</td>  
    <td width="80" bgcolor="e7e7e7" align="center">
	  <b>����</b>
	</td>
	<td width="110" align="center">
	  <select name="SRS_Sports" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" onChange="new_win(this.options[this.selectedIndex].value)">
	    <option value="List.asp?SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SRS_Sports = "" THEN Response.write "SELECTED" %>>:: ��ü���� ::</option>
	      <%
		    SQLR = "SELECT RS_SPORTS FROM Ref_Sports WHERE RS_STATUS = 1 Order By RS_IDX"
		    SET RS = Server.CreateObject("ADODB.Recordset")
		      RS.Open SQLR, DbCon, 1

		      RSCount = RS.RecordCount

		    FOR a =1 TO RSCount
		
		      RLS = RS(0) 
	      %>
	    <option value="List.asp?SRS_Sports=<%=RLS%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SRS_Sports = RLS THEN Response.write "SELECTED" %>><%=RLS%></option>
	      <%	
		    RS.movenext
		    NEXT
		
		    RS.Close
		    Set RS=Nothing	
		  %>
      </select>
	</td>



	<td width="80" bgcolor="e7e7e7" align="center">
	  <b>����</b>
	</td>
	<td width="210" align="center">
	  <select name="SRL_League" style="width:200px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" onChange="new_win(this.options[this.selectedIndex].value)">
	    <option value="List.asp?SRS_Sports=<%=SRS_Sports%>&SFlag=<%=SFlag%>&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SRL_League = "" THEN Response.write "SELECTED"%>>:::::::::::::: ��ü���� ::::::::::::::</option>
	    <%	
		  IF SRS_Sports = "" THEN
		    SQLMSG = " RL_STATUS = 1 "
		  ELSE
		    SQLMSG = " RL_SPORTS = '"& SRS_Sports & "' "
		  END IF

		  SQLR = "SELECT RL_LEAGUE FROM Ref_League WHERE "& SQLMSG &" Order By RL_LEAGUE"
		    SET RS = Server.CreateObject("ADODB.Recordset")
		  RS.Open SQLR, DbCon, 1

		  RSCount = RS.RecordCount

		  FOR a =1 TO RSCount
		
		  RLS = RS(0) 
		%>
	    <option value="List.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=RLS%>&SFlag=<%=SFlag%>&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SRL_League = RLS THEN Response.write "SELECTED" %>><%=RLS%></option>
	      <%	
		    RS.movenext
		    NEXT
		
		    RS.Close
		    Set RS=Nothing	
	      %>
      </select>
	</td>
    <td width="80" bgcolor="e7e7e7" align="center">
	  <b>����</b>
	</td>
	<td width="110" align="center">
	  <select name="SFlag" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" onChange="new_win(this.options[this.selectedIndex].value)">
	    <option value="List.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=All&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SFlag = "" THEN Response.write "SELECTED" %>>:: ��ü��Ȳ ::</option>
	    <option value="List.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=R&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SFlag = "R" THEN Response.write "SELECTED" %>>&nbsp;���ӵ��&nbsp;</option>
	    <option value="List.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=S&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SFlag = "S" THEN Response.write "SELECTED" %>>&nbsp;�� �� ��&nbsp;</option>
	    <option value="List.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=E&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SFlag = "E" THEN Response.write "SELECTED" %>>&nbsp;���ø���&nbsp;</option>
	    <option value="List.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=F&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SFlag = "F" THEN Response.write "SELECTED" %>>&nbsp;��������&nbsp;</option>
	    <option value="List.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=C&GSITE=<%=GSITE%>&IG_TYPE=<%= IG_TYPE %>" <% IF SFlag = "C" THEN Response.write "SELECTED" %>>&nbsp;�������&nbsp;</option></select></td>
	  <script>
	    function searchfrm()
		  {
		    var frm = document.frm1;
		      location.href = "List.asp?Search="+frm.Search.value+"&Find="+frm.Find.value;
	       }
	    function Move()
		  {
		    if (event.keyCode == 13)
			  {
			    searchfrm();
			    return false;
		      } 
			else 
			  {
			    return false;
		      }
	      }
	  </script>
	<td width="80" bgcolor="e7e7e7" align="center">
	  <b>�˻�</b>
	</td>
	<td>
	  <select name="Search" style="width:110px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
	    <option value="RL_LEAGUE" <%if Search = "RL_LEAGUE" then Response.Write "selected"%>>����</option>
		<option value="TEAM" <%if Search = "TEAM" then Response.Write "selected"%>>����</option>
      </select>
	</td>
	<td>
	  <input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input" >
	</td>
	<td>
	  <input type="button" value="�� ��" onclick="searchfrm()">
	</td>
    <td align="center" bgcolor="e7e7e7" width="100">
	  <%IF request.Cookies("AdminLevel") = 1 THEN %><input type="button" value="��������" onclick="location.href='List_Excel.asp?RS_Sports=<%=Sel_Sports%>&RL_League=<%=Sel_League%>&Flag=<%=Flag%>';" style="border: 1 solid; background-color: #C5BEBD;" id=button1 name=button2><% END IF %>
	</td>
  </tr>
</table>
  
  <br>

<table>
  <tr>
    <td> * 
	  <a href="List.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&IG_TYPE=<%= IG_TYPE %>&SFlag=R"><img src="/img/btn/btn_r_on.gif" style="border:0;width:15px;height:16px;" align="absmiddle" style="cursor:hand;"></a>:���ӵ�� / 
	  <a href="List.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&IG_TYPE=<%= IG_TYPE %>&SFlag=S"><img src="/img/btn/btn_s_on.gif" style="border:0;width:15px;height:16px;" align="absmiddle" style="cursor:hand;"></a>:���ð��� / 
	  <a href="List.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&IG_TYPE=<%= IG_TYPE %>&SFlag=E"><img src="/img/btn/btn_e_on.gif" style="border:0;width:15px;height:16px;" align="absmiddle" style="cursor:hand;"></a>:���ø��� / 
	  <a href="List.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&IG_TYPE=<%= IG_TYPE %>&SFlag=F"><img src="/img/btn/btn_f_on.gif" style="border:0;width:15px;height:16px;" align="absmiddle" style="cursor:hand;"></a>:���긶�� / 
	  <a href="List.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&IG_TYPE=<%= IG_TYPE %>&SFlag=C"><strong>C</strong></a>:�������
	</td>
  </tr>
</table>


<%IF request.Cookies("AdminLevel") = 1 THEN %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
	  <a name="111"></a>
	    <input type="reset" value="����"  onclick="javascript:go_start(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;">&nbsp;
	    <input type="button" value="���" onclick="window.location='Regist.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>&page=<%=PAGE%>';" style="border: 1 solid; background-color: #C5BEBD;">&nbsp;
	    <input type="reset" value="����"  onclick="javascript:go_delete(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;">

    </td>
  </tr>
</table>
<% End IF %>  
<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
  <tr bgcolor="e7e7e7"> 
	<td align="center" height="30" width="40">
	  <a href="#" onClick="jsBag(this);">��ü</a>
	</td>
	<!-- <td align="center" width="40"><b>��ȣ</b></td> -->
	<td align="center">
	  <b>���׸�</b>
	</td>
	<td align="center" width="100">
	  <b>���ð�</b>
	</td>
	<td align="center">
	  <b>Ȩ��</b>
	</td>
	<td align="center">
	  <b>��(�ڵ�ĸ/�������)</b>
	</td>
	<td align="center">
	  <b>������</b>
	</td>
	<td align="center">
	  <b>Score</b>
	</td>
	<td align="center">
	  <b>���</b>
	</td>
	<td align="center">
	  <b>����</b>
	</td>
	<td align="center">
	  <b>����</b>
	</td>
	<td align="center">
	  <b>���</b>
	</td>
  </tr>
  <%IF dfgameSql.RsCount = 0 THEN%>
  <tr>
    <td align="center" colspan="12" height="35">
	  ���� ��ϵ� ������ �����ϴ�.
	</td>
  </tr>
    <%
	  ELSE

	  FOR i = 0 TO dfgameSql.RsCount -1
		

		IG_IDX			= dfgameSql.Rs(i,"IG_IDX")
		RL_LEAGUE		= dfgameSql.Rs(i,"RL_LEAGUE")
		RL_IMAGE		= dfgameSql.Rs(i,"RL_IMAGE")
		RL_IMAGE		= "<img src='/UpFile/League/" & RL_IMAGE & "' width='20' height='14' style='border:1px solid;' align='absmiddle'>"
		IG_STARTTIME	= dfStringUtil.GetFullDate(dfgameSql.Rs(i,"IG_STARTTIME"))		

		
		IG_TEAM1		= dfgameSql.Rs(i,"IG_TEAM1")
		IG_TEAM2		= dfgameSql.Rs(i,"IG_TEAM2")
		IG_HANDICAP		= CDbl(dfgameSql.Rs(i,"IG_HANDICAP"))
		IG_TEAM1BENEFIT = dfgameSql.Rs(i,"IG_TEAM1BENEFIT")
		IG_DRAWBENEFIT	= dfgameSql.Rs(i,"IG_DRAWBENEFIT")
		IG_TEAM2BENEFIT = dfgameSql.Rs(i,"IG_TEAM2BENEFIT")
		IG_TEAM1BETTING = dfgameSql.Rs(i,"IG_TEAM1BETTING")
		IG_DRAWBETTING	= dfgameSql.Rs(i,"IG_DRAWBETTING")
		IG_TEAM2BETTING	= dfgameSql.Rs(i,"IG_TEAM2BETTING")
		IG_SCORE1		= dfgameSql.Rs(i,"IG_SCORE1")
		IG_SCORE2		= dfgameSql.Rs(i,"IG_SCORE2")
		IG_RESULT		= Trim(dfgameSql.Rs(i,"IG_RESULT"))
		IG_STATUS		= dfgameSql.Rs(i,"IG_STATUS")
		IG_TYPE			= dfgameSql.Rs(i,"IG_TYPE")
		IG_VSPOINT		= dfgameSql.Rs(i,"IG_VSPOINT")
		IG_MEMO			= dfgameSql.Rs(i,"IG_MEMO")
		IG_SITE			= dfgameSql.Rs(i,"IG_SITE")
		IG_SP			= dfgameSql.Rs(i,"IG_SP")
		IG_TEAM1BET_CNT			= dfgameSql.Rs(i,"IG_TEAM1BET_CNT")
		IG_TEAM2BET_CNT			= dfgameSql.Rs(i,"IG_TEAM2BET_CNT")
		IG_DRAWBET_CNT			= dfgameSql.Rs(i,"IG_DRAWBET_CNT")
		
					
		
        IG_CNT = IG_TEAM1BET_CNT & "," & IG_DRAWBET_CNT & ", " & IG_TEAM2BET_CNT
		IF IG_RESULT = "0" THEN
			GameResult = " "
		ELSEIF IG_RESULT = "1" THEN
			GameResult = "Ȩ����"
		ELSEIF IG_RESULT = "2" THEN
			GameResult = "��������"
		END IF	
	%>

  <tr bgcolor="#FFFFFF" height="25">
    <td align="center">
        <%
            IF SFlag = "E" THEN 
                IF IG_TEAM1BETTING + IG_TEAM2BETTING + IG_DRAWBETTING = 0 Then
        %>
            <input type="checkbox" name="SelUser" value="<%=IG_IDX%>">
        <% 
                End IF
            Else
        %>
            <input type="checkbox" name="SelUser" value="<%=IG_IDX%>">
        <% End IF %>
	  
	</td>
	<!-- <td align="center"><%=NN%></td> -->
	  <%
	    if IG_SP = "Y" Then
		  response.write "<td bgcolor=#8cafda>"	
	    Else 
		  response.write "<td>"
	    End If 
	  %>
	  &nbsp;<%=RL_LEAGUE%>
	</td>
	<td align="center">
	  <table border="0" cellspacing="1" cellpadding="0">
	    <tr>
		  <td align="center" class="txt8">
		    <%=REPLACE(Left(IG_StartTime,10),"-","/")%>
	      </td>
		</tr>
		<tr>
		  <td align="center" class="txt11" style="font-size:12px;">
		    <% 
			  IF CDbl(Mid(IG_StartTime,12,2)) > 11 THEN 
			%>
			    PM
		    <% ELSE %>
			    AM
			<% END IF %>&nbsp;<%=Mid(IG_StartTime,12,5)%>
	      </td>
		</tr>
      </table>
	</td>
	<td style="padding-left:5px;">
	  <b><%=IG_TEAM1%></b><br>[ ���� : <%=formatnumber(IG_TEAM1BENEFIT,2)%> / ���� : <a href="javascript:BetList('GameBet.asp?IG_IDX=<%=IG_IDX%>&IB_NUM=1');"><font color=red><%=formatnumber(IG_TEAM1BETTING,0)%></font></a> ]</td>
	<%	IF IG_HANDICAP = 0 THEN %>
	<td align="center"><b>���º�</b>(<%=formatnumber(IG_DRAWBENEFIT,2)%>)<br>����:<a href="javascript:BetList('GameBet.asp?IG_IDX=<%=IG_IDX%>&IB_NUM=0');"><font color=red><%=formatnumber(IG_DRAWBETTING,0)%></font></a></td>
	<% 
		ELSE
			IF IG_HANDICAP > 0 Then
				IG_HANDICAPTEMP = "+" & IG_HANDICAP 
			ELSE
				IG_HANDICAPTEMP = IG_HANDICAP
			END IF
			
			IF IG_TYPE = "2" THEN 
				VIEWCAP = "�������"
			ELSE
				VIEWCAP = "�ڵ�ĸ"
			END IF	%>
	<td bgcolor="#ffff00" align="center"><b><%=VIEWCAP%></b>(<%=formatnumber(IG_HANDICAPTEMP,2)%>)</td>
	<%	END IF %>
	<td style="padding-left:5px;"><b><%=IG_TEAM2%></b><br>[ ���� : <%=formatnumber(IG_TEAM2BENEFIT,2)%> / ���� : <a href="javascript:BetList('GameBet.asp?IG_IDX=<%=IG_IDX%>&IB_NUM=2');"><font color=red><%=formatnumber(IG_TEAM2BETTING,0)%></font></a> ]</td>
	<td align="center"><%=IG_SCORE1%> : <%=IG_SCORE2%></td>
	<td align="center">
	  <%IF IG_STATUS = "F" then
			Response.write IG_STATUS
		ELSE
			Response.write "__"
		END IF	%>
    </td>
	
	<script>
		function chgProcFlag(idx,gp,pg,rs,rl) {

		    if (gp == "R") confirmMsg = "���� ������� �����Ͻðڽ��ϱ�?";
			if (gp == "S") confirmMsg = "���� �������� �����Ͻðڽ��ϱ�?";
			if (gp == "E") confirmMsg = "���� �������� �����Ͻðڽ��ϱ�?";
							
			if (!confirm(confirmMsg)) {
				return;
			}
			else {
			  location.href="Game_Proc_Change.asp?IG_Idx="+idx+"&GameProc="+gp+"&page="+pg+"&SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>";
			}		
				
		}
		
		function openInsertResult(idx,pg,rs,rl) {
			var openUrl = "Insert_Result.asp?IG_Idx="+idx+"&page="+pg+"&SRS_Sports="+rs+"&SRL_League="+rl+"&SFlag=<%=SFlag%>";
			window.open(openUrl, '','left=400,top=400,width=400,height=300,0,0,0,0');
		}
		
		// ����ó��(F)����...������ ������� ����...
		function goGameEdit(gidx) {
			var ss = "<%=SRS_Sports%>";
			var sl = "<%=SRL_League%>";
			var fg = "<%=SFlag%>";
			var pg = "<%=Page%>";
			
			var openUrl = "Game_Edit.asp?IG_Idx="+gidx+"&SRS_Sports="+ss+"&SRL_League="+sl+"&SFlag="+fg+"&page="+pg;
			window.open(openUrl, 'gameEdit','left=400,top=400,width=600,height=300,0,0,0,0');
		}
		
		// ���Ӱ���� �߸��Է��������...���� ó���� �̹Ƿ�...�ܼ��� ����� ���氡��...
		function goGameEdit1(gidx) {
			var ss = "<%=SRS_Sports%>";
			var sl = "<%=SRL_League%>";
			var fg = "<%=SFlag%>";
			var pg = "<%=Page%>";
			
			var openUrl = "Game_Result_Edit.asp?IG_Idx="+gidx+"&SRS_Sports="+ss+"&SRL_League="+sl+"&SFlag="+fg+"&page="+pg;
			window.open(openUrl, 'gameEdit','left=600, top=50,width=600,height=300,0,0,0,0');
		}
		
		function goGameCancel(gidx) {
			if (!confirm("���� ����Ͻðڽ��ϱ�?\n\n��ҽ� �ش� ���ÿ� ���� ȯ��ó���� �̷�� ���ϴ�.")) return;		
			top.HiddenFrm.location.href="Game_Cancel_Proc.asp?IG_Idx="+gidx;
		}
	</script>
	
	<td align="center">
	  <% IF IG_STATUS = "R" THEN %>
		<img src="/img/btn/btn_r_on.gif" style="border:0;width:15px;height:16px;" align="absmiddle">
		<img src="/img/btn/btn_s_off.gif" style="border:0;width:15px;height:16px;" align="absmiddle" <%IF request.Cookies("AdminLevel") = 1 THEN %> style="cursor:hand;" onclick="chgProcFlag(<%=IG_IDX%>,'S',<%=PAGE%>,'<%=SRS_Sports%>','<%=SRL_League%>');" <% END IF %>>
		<img src="/img/btn/btn_e_off.gif" style="border:0;width:15px;height:16px;" align="absmiddle">
		<img src="/img/btn/btn_f_off.gif" style="border:0;width:15px;height:16px;" align="absmiddle">
	  <% END IF %>
	  <% IF IG_STATUS = "S" THEN %>
		<img src="/img/btn/btn_r_off.gif" style="border:0;width:15px;height:16px;" align="absmiddle" <%IF request.Cookies("AdminLevel") = 1 THEN %> style="cursor:hand;" onclick="chgProcFlag(<%=IG_IDX%>,'R',<%=PAGE%>,'<%=SRS_Sports%>','<%=SRL_League%>');" <% END IF %>>
		<img src="/img/btn/btn_s_on.gif" style="border:0;width:15px;height:16px;" align="absmiddle">
		<img src="/img/btn/btn_e_off.gif" style="border:0;width:15px;height:16px;" align="absmiddle" <%IF request.Cookies("AdminLevel") = 1 THEN %> style="cursor:hand;" onclick="chgProcFlag(<%=IG_IDX%>,'E',<%=PAGE%>,'<%=SRS_Sports%>','<%=SRL_League%>');" <% END IF %>>
		<img src="/img/btn/btn_f_off.gif" style="border:0;width:15px;height:16px;" align="absmiddle">
	  <% END IF %>
	  <% IF IG_STATUS = "E" THEN %>
		<img src="/img/btn/btn_r_off.gif" style="border:0;width:15px;height:16px;" align="absmiddle" <%IF request.Cookies("AdminLevel") = 1 THEN %> style="cursor:hand;" onclick="chgProcFlag(<%=IG_IDX%>,'R',<%=PAGE%>,'<%=SRS_Sports%>','<%=SRL_League%>');" <% END IF %>>
		<img src="/img/btn/btn_s_off.gif" style="border:0;width:15px;height:16px;" align="absmiddle" <%IF request.Cookies("AdminLevel") = 1 THEN %> style="cursor:hand;" onclick="chgProcFlag(<%=IG_IDX%>,'S',<%=PAGE%>,'<%=SRS_Sports%>','<%=SRL_League%>');" <% END IF %>>
		<img src="/img/btn/btn_e_on.gif" style="border:0;width:15px;height:16px;" align="absmiddle">
		<img src="/img/btn/btn_f_off.gif" style="border:0;width:15px;height:16px;" align="absmiddle" <%IF request.Cookies("AdminLevel") = 1 THEN %> style="cursor:hand;" onclick="openInsertResult(<%=IG_IDX%>,<%=PAGE%>,'<%=SRS_Sports%>','<%=SRL_League%>');" <% END IF %>>
	  <% END IF %>
	  <% IF IG_STATUS = "F" THEN %>
		<img src="/img/btn/btn_r_off.gif" style="border:0;width:15px;height:16px;" align="absmiddle">
		<img src="/img/btn/btn_s_off.gif" style="border:0;width:15px;height:16px;" align="absmiddle">
		<img src="/img/btn/btn_e_off.gif" style="border:0;width:15px;height:16px;" align="absmiddle">
		<img src="/img/btn/btn_f_on.gif" style="border:0;width:15px;height:16px;" align="absmiddle">
	  <% END IF %>
	  <% IF IG_STATUS = "C" THEN %>
		�������
	  <% END IF %>
	</td>
	
	<td align="center" width="40">
	  <%IF request.Cookies("AdminLevel") = 1 THEN %>
	      <% IF IG_STATUS = "R" OR IG_STATUS = "S" THEN %>
		    <input type="button" value="����" style="border:1px solid;height:16px;" onclick="goGameEdit(<%=IG_IDX%>);">
	      <% ELSEIF IG_STATUS = "F" THEN %>
		    <input type="button" value="����" style="border:1px solid;height:16px;" onclick="goGameEdit1(<%=IG_IDX%>);">
	      <% ElseIf IG_STATUS = "E" Then %>
		    <input type="button" value="����" style="border:1px solid;height:16px;" onclick="gong(<%=IG_IDX%>);">
	      <% ELSE %>
		    �Ұ�
	      <% END IF %>
	  <% ELSE %>
		�Ұ�
	  <% END IF %>
	</td>

	<td align="center" width="40">
	    <%IF request.Cookies("AdminLevel") = 1 THEN %>
	      <% IF IG_STATUS = "E" THEN %>
		    <input type="button" value="���" style="border:1px solid;height:16px;" onclick="goGameCancel(<%=IG_IDX%>);">
	      <% ELSE %>
		    &nbsp;
	      <% END IF %>
	    <% ELSE %>
	      �Ұ�
        <% END IF %>
	</td>
  </tr>
  <%      	
	Next 
   %>
		
   <% END IF %>
 </table>
 <script type="text/javascript">
 function goGameBetCnt(IG_IDX)
 {
    cnt = document.getElementById("cnt_"+IG_IDX).value
    url = "gameBetCnt_Proc.asp?IG_IDX=" + IG_IDX + "&betCnt=" +cnt ;

    exeFrame.location.href = url;
    
 }
 </script>
 <iframe name="exeFrame" width="0" height="0"></iframe>
 <br clear="all">

<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
<!-- paging End -->
</form>
<%IF request.Cookies("AdminLevel") = 1 THEN %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
	  <a name="111"></a>
	    <input type="reset" value="����"  onclick="javascript:go_start(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;">&nbsp;
	    <input type="button" value="���" onclick="window.location='Regist.asp?SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>&page=<%=PAGE%>';" style="border: 1 solid; background-color: #C5BEBD;">&nbsp;
	    <input type="reset" value="����"  onclick="javascript:go_delete(document.frm1);" style="border: 1 solid; background-color: #C5BEBD;">

    </td>
  </tr>
  <tr>
    <td>
	  <form name="frm_xls" method="post" target="_blank" action="Game_Xls_Reague.asp?IG_SITE=All" enctype="multipart/form-data">
		<input type="file" name="xls" >
		<input type="button" value="���� �˼�" onclick="submit();" style="border: 1 solid; width:100px;background-color: #C5BEBD;">
	  </form>
    </td>
  </tr>  
  <tr>
    <td>
	  <form name="frm_xls" method="post" action="Game_Xls.asp?IG_SITE=All" enctype="multipart/form-data">
		<input type="file" name="xls" >
		<input type="button" value="��� ���" onclick="submit();" style="border: 1 solid; width:100px;background-color: #C5BEBD;">
	  </form>
    </td>
  </tr>
  <tr>
    <td>
	  <form name="frm_xls" method="post" action="GameSp_Xls.asp?IG_SITE=All" enctype="multipart/form-data">
		<input type="file" name="xls" >
		<input type="button" value="����� ��� ���" onclick="submit();" style="border: 1 solid; width:100px;background-color: #C5BEBD;">
	  </form>
    </td>
  </tr>
</table>
<% END IF %>
<div style="width:100%;height:50px;background:#000;color:#ffffff;text-align:center;cursor:pointer" onclick="location.href='#frm1'">������</div>
</body>
</html>
