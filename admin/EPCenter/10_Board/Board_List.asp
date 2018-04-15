<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/08_Board/_Sql/boardSql.Class.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
    <%
        Randomize 
        num = Int((8*Rnd))
        'iMod = (num mod 10)+ 1
    %>
<%

	bType = request("bType")	
	
	SQLstr="UPDATE Board_Free SET BF_HITS=BF_HITS+"&NUM&" WHERE BF_REGDATE > dateadd(hour,-4,getdate())"
	DbCon.Execute(SQLstr)
	
	
%>
<%  

    '######### Request Check                    ################	    

    
    pageSize        = 27            
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
	sStartDate      = Trim(dfRequest.Value("sStartDate"))
	sEndDate        = Trim(dfRequest.Value("sEndDate"))
	Search          = Trim(dfRequest.Value("Search"))
	Find            = Trim(dfRequest.Value("Find"))	
	reqBF_LEVEL        = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("BF_LEVEL")), 0, 0, 9) 		
	BF_SITE = Trim(request("bType"))
	IB_IDX  = Trim(request("IB_IDX"))


    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 회원 리스트를 불러옴                 ################	
   
	Call dfboardSql.RetrieveBoard_Free(dfDBConn.Conn, page, pageSize,  Search, Find, sStartDate, sEndDate, reqBF_LEVEL)
    Call dfgameSql.RetrieveInfo_Betting(dfDBConn.Conn,  1, 1, "IB_IDX", IB_IDX, sStartDate, sEndDate, "all", 0,0)

'dfboardSql.debug
	IF dfboardSql.RsCount <> 0 Then
	    nTotalCnt = dfboardSql.RsOne("TC")
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
<title></title>
<!-- #include virtual="/Inc_Month.asp"-->
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/Sc/Base.js"></script>
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
		alert("삭제할 정보를 선택해 주세요."); 
		return;
	} 
	
	//alert(v_data);
	
	if (!confirm("정말 삭제하시겠습니까?")) return;		
	form.action = "Board_Delete.asp?page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&bType=<%=bType%>";
	form.submit();
}
</SCRIPT></head>

<body topmargin="0" marginheight="0">

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 게시판 관리</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="post" action="Board_List.asp">
<tr><td>시작일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" value="<%=REQUEST("sStartDate")%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>종료일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" value="<%=REQUEST("sEndDate")%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="">---검색어---</option>
		<option value="BF_Writer" <%if Search = "BF_Writer" then Response.Write "selected"%>>작성자</option>
		<option value="BF_Title" <%if Search = "BF_Title" then Response.Write "selected"%>>글제목</option>
		<option value="BF_CONTENTS" <%if Search = "BF_CONTENTS" then Response.Write "selected"%>>글내용</option>
		<option value="BF_SITE" <%if Search = "BF_SITE" then Response.Write "selected"%>>사이트명</option></select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="검 색"> 사이트명 전체 : All</td></tr></form></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="100%">
<form name="frm1" method="post">
<tr><td align="center" height="30" bgcolor="e7e7e7"><b>선택</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>No.</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>제 목</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>작성자</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>작성일</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>조 회</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>상 태</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>사이트</b></td></tr>

<%	IF dfboardSql.RsCount = 0 THEN	%>

<tr><td align="center" colspan="8" height="35">현재 등록된 게시물이 없습니다.</td></tr>

<%
	ELSE

	FOR i = 0 TO dfboardSql.RsCount -1


		BF_IDX		= dfboardSql.Rs(i,"BF_IDX")
		BF_TITLE	= dfboardSql.Rs(i,"BF_TITLE")
		BF_WRITER	= dfboardSql.Rs(i,"BF_WRITER")
		BF_REGDATE	= dfboardSql.Rs(i,"BF_REGDATE")
		BF_HITS		= dfboardSql.Rs(i,"BF_HITS")
		BF_STATUS	= CDbl(dfboardSql.Rs(i,"BF_STATUS"))
		BF_LEVEL	= CDbl(dfboardSql.Rs(i,"BF_LEVEL"))
		BF_REPLYCNT	= CDbl(dfboardSql.Rs(i,"BF_REPLYCNT"))
		BF_SITE		= dfboardSql.Rs(i,"BF_SITE")
		BF_TYPE		= dfboardSql.Rs(i,"BF_TYPE")
		IB_IDX		= dfboardSql.Rs(i,"IB_IDX")
		BF_PW		= dfboardSql.Rs(i,"BF_PW")
       
		If BF_TYPE = "1" Then
			BF_TYPE = "[ 일 반 ]&nbsp;"
		ElseIf BF_TYPE = "2" Then 
			BF_TYPE = "[ 분 석 ]&nbsp;"	
		End If
		IF BF_LEVEL = "1" THEN
			'BF_Part = "Notice"
			BF_TYPE = ""
		ELSEIF BF_LEVEL = "2" THEN
			'BF_Part = "Event"
			BF_TYPE = ""
		END IF	

		IF BF_ReplyCnt <> 0 THEN 
			BF_ReplyCnt = "(" & BF_ReplyCnt & ")"
		ELSE
			BF_ReplyCnt = ""
		END IF

		IF BF_Level = 1 THEN 
			BF_Level = "[공지]"
		ELSEIF BF_Level = 2 THEN 
			BF_Level = "[이벤트]"
		ELSE
			BF_Level = ""
		END IF
		
		IF BF_Status = 0 THEN
			ViewType = "숨김"
		ELSE
			ViewType = "<font color= red>노출</font>"
		END IF		%>

<tr <% IF BF_Status <> "1" THEN Response.Write "bgcolor='#d6f7fd'"%>>
	<td align="center"><input type="checkbox" name="SelUser" value="<%=BF_Idx%>"></td>
<%
SET DbRec2=Server.CreateObject("ADODB.Recordset") 

WSQL = "SELECT a.iu_id,a.iu_nickname FROM INFO_USER  a, BOARD_FREE b WHERE a.iu_nickname = '"&BF_Writer&"'"
DbRec2.Open WSQL, DbCon

If Not DbRec2.eof Then
bf_id = dbRec2("IU_ID")
Else 
bf_id = ""
End If 


%>
	<td align="center"><%=BF_IDX%></td>
	<td align="center"><%=BF_SITE%></td>
	<a href="Board_View.asp?BF_Idx=<%=BF_Idx%>&page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&bType=<%=bType%>">
	<td style="cursor:hand;"><font color="#000000">&nbsp;<%=BF_Level%><%=BF_TYPE%><%=BF_Title%>&nbsp;<%=BF_ReplyCnt%></font></td></a>
<% If bf_pw<>BF_ID Then %>
	<td align="center"><a href="/EPCenter/08_Board/Board_List.asp?Search=BF_Writer&Find=<%=BF_Writer%>"><b><font color="red"><%=bf_id%>&nbsp;&nbsp;(<%=BF_Writer%>)</b></font></a></td>
<% Else %>
	<td align="center"><a href="/EPCenter/08_Board/Board_List.asp?Search=BF_Writer&Find=<%=BF_Writer%>"><%=bf_id%>&nbsp;&nbsp;(<%=BF_Writer%>)</a></td>
<% End if%>
	<td align="center"><%=bf_regdate%></td>
    <td align="center">
	    <input type="text" name="BF_Hits<%= BF_IDX %>"  id="BF_Hits<%= BF_IDX %>" value="<%= BF_Hits %>" size="4" maxlength="4" class="input" onblur="changeLevel(<%= BF_IDX %>);" />
	</td>
	<td align="left"><%= IB_IDX %>&nbsp;</td>
	<td align="center"><%=ViewType%></td>
</tr>

<%  
    Next 
END IF
%>

</table><br clear="all">

<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td width="60%">
	<input type="reset" value="등록"  onclick="javascript:location.href='/EPCenter/08_Board/Board_Write.asp?BF_LEVEL=<%= reqBF_LEVEL %>';" style="border: 1 solid;width:50px; background-color: #C5BEBD;">
	<input type="reset" value="삭제"  onclick="javascript:go_delete(document.frm1);" style="border: 1 solid;width:50px; background-color: #C5BEBD;"></form>	
	</td>
	<td width="40%">
	<form name="frm_dis" method="post" action="Board_disable.asp">	
	    <input type="hidden" name="mode" value="add" />	
	    <input type="text" name="BFR_WRITER" value="" />	
		<input type="button" value="게시판 사용 제재" onclick="submit();" style="border: 1 solid; width:100px;background-color: #C5BEBD;">
	</form>
	<form name="frm_dis1" method="post" action="Board_disable.asp">	
	    <input type="hidden" name="mode" value="del" />	
	    <input type="text" name="BFR_WRITER" value="" />	
		<input type="button" value="게시판 사용 해제" onclick="submit();" style="border: 1 solid; width:100px;background-color: #C5BEBD;">
	</form>	
	</td>
	</tr></table>

</body>
</html>

<%

	DbCon.Close
	Set DbCon=Nothing
%>