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
	SQL = "delete from board_customer_template where bct_title='1'"
	DbCon.execute SQL

	SQL = "update board_customer set bc_contents='' where bc_contents is null "
	DbCon.execute SQL

    '######### request 값                    ################	
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999)
	pageSize = 20
    sStartDate  = REQUEST("sStartDate")
    sEndDate = REQUEST("sEndDate")
    Search = REQUEST("Search")
	Find = REQUEST("Find")    
	BC_Type            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("BC_Type")), 0, 0, 9)
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
	'######### 충전 내역을 볼러옴                 ################	
   
	Call dfcustomerSql.RetrieveBoard_Customer(dfDBConn.Conn,  page, pageSize, Search, Find, sStartDate, sEndDate , BC_Type)
    'dfcustomerSql.debug
	IF dfcustomerSql.RsCount <> 0 Then
	    nTotalCnt = dfcustomerSql.RsOne("TC")
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

<script language="JavaScript">
	// 모든 체크박스 on/off
	function AllChk() {
		var chkAll = document.frm1.chkAll;
		var cbox = document.frm1.SelUser;
		if (cbox.length) {
			for(var i=0; i<cbox.length; i++) {
				cbox[i].checked = chkAll.checked;
			}
		}
		else {
			cbox.checked = chkAll.checked;
		}
	}
	
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
		alert("숨길 정보를 선택해 주세요."); 
		return;
	} 
	
	//alert(v_data);
	
	if (!confirm("정말로 숨기시겠습니까?")) return;		
	form.action = "Delete.asp?page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&BC_Type=<%= BC_Type %>";
	form.submit();	}

function go_delete2(form)
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
	form.action = "Delete.asp?delType=1&page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&BC_Type=<%= BC_Type %>";
	form.submit();	}
	
	function del_bank_delete()
	{
	    location.href = "Delete.asp?delType=2&page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&BC_Type=1";
	}
</script></head>

<body topmargin="0" marginheight="0">

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 고객센터 관리</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table border="0" cellpadding="0" cellspacing="0" align="center">
<form name="MainForm" method="get" action="List.asp">
<tr>
    <td>타입 :</td><td>
    <select name="BC_Type" onchange="location.href='List.asp?BC_Type='+this.value">
        <option value="0" <% IF cStr(BC_Type) = "0" Then %>selected<% End IF %>>일반</option>
        <option value="1" <% IF cStr(BC_Type) = "1" Then %>selected<% End IF %>>계좌문의</option>
    </select>
    </td>
    <td>시작일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	<input type="text" name="sStartDate" value="<%=REQUEST("sStartDate")%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td><td>~</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td>종료일자 :</td><td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="sEndDate" value="<%=REQUEST("sEndDate")%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:80" class="input"></td>
	<td><img src="blank.gif" border="0" width="50" height="1"></td>
	<td><select name="Search" style="width:100px;font-size:9pt;bgcolor:#F5E0E0;padding-left:10px" class="input">
		<option value="BC_ID" <%if Search = "BC_ID" then Response.Write "selected"%>>아이디</option>
		<option value="BC_Writer" <%if Search = "BC_Writer" then Response.Write "selected"%>>작성자</option>
		<option value="BC_Title" <%if Search = "BC_Title" then Response.Write "selected"%>>글제목</option>
		<option value="BC_CONTENTS" <%if Search = "BC_CONTENTS" then Response.Write "selected"%>>글내용</option>
		<option value="BC_SITE" <%if Search = "BC_SITE" then Response.Write "selected"%>>사이트명</option></select></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="text" name="Find" size="20" maxlength="30" value="<%=Find%>" class="input"></td>
	<td><img src="blank.gif" border="0" width="5" height="1"></td>
	<td><input type="submit" value="검 색"></td></tr></form></table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td><img src="blank.gif" border="0" width="1" height="10"></td></tr></table>

<table border="0"  cellspacing="1" cellpadding="5" bgcolor="#AAAAAA" width="100%">
<form name="frm1" method="post">
<tr><td align="center" height="30" bgcolor="e7e7e7" width="60"><b><input type="Checkbox" name="chkAll" onclick="AllChk();"></b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>제목</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>작성자</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>쪽지</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>사이트</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>조회수</b></td>
	<td align="center" height="30" bgcolor="e7e7e7" width="100"><b>작성일</b></td>
	<td align="center" height="30" bgcolor="e7e7e7" width="60"><b>답변</b></td>
	<td align="center" height="30" bgcolor="e7e7e7"><b>상태</b></td>	
	</tr>

<%	IF dfcustomerSql.RsCount = 0 THEN	%>

<tr bgcolor="#FFFFFF" height="25"><td align="center" colspan="9" height="35">현재 등록된 글이 없습니다.</td></tr>

<%
	ELSE

	FOR i = 0 TO dfcustomerSql.RsCount -1 

		BC_Idx		= dfcustomerSql.Rs(i,"BC_Idx")
		BC_Writer	= dfcustomerSql.Rs(i,"BC_Writer")
		BC_Title	= dfcustomerSql.Rs(i,"BC_Title")
		BC_RegDate	= dfcustomerSql.Rs(i,"BC_RegDate")
		BC_Reply	= CDbl(dfcustomerSql.Rs(i,"BC_Reply"))
		BC_Status	= CDbl(dfcustomerSql.Rs(i,"BC_Status"))
		BC_SITE		= dfcustomerSql.Rs(i,"BC_SITE")
		BC_ID		= dfcustomerSql.Rs(i,"BC_ID")
		BC_DELYN	= dfcustomerSql.Rs(i,"BC_DELYN")
        BC_READ = dfcustomerSql.Rs(i,"BC_READ")
		BC_READYN  = dfcustomerSql.Rs(i,"BC_READYN")
		IF BC_Reply = 1 THEN
			Reply = "완료"
		ELSE
			Reply = "<font color='red'>미해결</font>"
		END IF

		IF BC_Status = 0 THEN
			ViewType = "숨김"
		ELSE
			ViewType = "<font color= red>노출</font>"
		END IF	

		If BC_DELYN <> " " then
		    IF cint(BC_DELYN) = 1 THEN
			    ViewType = "사용자삭제"
		    END IF		
		End If 
		
		If BC_READYN = 0 THEN
		%>

<tr <% IF BC_Status <> "1" THEN Response.Write "bgcolor='#d6f7fd'" Else Response.Write "bgcolor='#ffffff'" End IF %>>
    <td align="center"><input type="checkbox" name="SelUser" value="<%=BC_Idx%>"></td>
	<td>&nbsp;<a href="View.asp?BC_Idx=<%=BC_Idx%>&page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&BC_Type=<%= BC_Type %>"><%=BC_Title%></a></td>
	<%
	If BC_Writer = "관리자" Then 
	%>
	<td>&nbsp;<a href="/EPCenter/07_Customer/List.asp?Search=BC_Writer&Find=<%=BC_Writer%>&BC_Type=<%= BC_Type %>"><%=BC_ID%>에게 관리자 쪽지(답변)</td>
	<%
	Else 
	%>
	<td>&nbsp;<a href="/EPCenter/07_Customer/List.asp?Search=BC_Writer&Find=<%=BC_Writer%>&BC_Type=<%= BC_Type%>"><%=BC_ID%>&nbsp;&nbsp;(<%=BC_Writer%>)</td>
	<%
	End If 
	%>
	<td align="center">
		<a href="/EPCenter/02_Member/Write_Message.asp?cd=<%=BC_ID%>&cdi=<%=IU_IDX%>&JOBSITE=<%=IU_SITE%>" target="_blank"><b>쪽지</b></a>
	</td>
	<td align="center">
	&nbsp;<a href="/EPCenter/07_Customer/List.asp?Search=BC_SITE&Find=<%=BC_SITE%>"><%=BC_SITE%></td>	
	<td align="center"><%=BC_READ%></td>
	<td align="center"><%=BC_RegDate%></td>
	<td align="center"><%=Reply%></td>
	<td align="center"><%=ViewType%>
	</td>
	</tr>
<%	END IF	%>
	<% 
		Next 
	END IF 
	%>

</table>

<table>
<tr>
<td>
    <input type="button" value=" 삭제 " onclick="go_delete(form);" class="input">
  <!--  <input type="button" value=" 삭제 " onclick="go_delete2(form);" class="input">-->
    <% IF BC_Type = 1 Then %>
    <input type="button" value=" 계좌정보 전체지우기 " onclick="del_bank_delete();" class="input">
    <% End IF %>
</td>
</tr>
</table>


<br clear="all">

<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
<br /><br /><br /><br />
</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>