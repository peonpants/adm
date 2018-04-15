<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/02_Member/_Sql/memberSql.Class.asp"-->
<%
    
    '######### Request Check                    ################	    

    
    pageSize      = 50             
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999)
	Search     = Trim(dfRequest.Value("Search"))
	Find         =  Trim(dfRequest.Value("Find"))
	sortColumn = Trim(dfRequest.Value("sortColumn"))
	sortDirection = Trim(dfRequest.Value("sortDirection"))
	IF sortDirection = "" Then
	    sortDirection ="DESC"  
	End IF 
	reqIU_SITE        = Trim(dfRequest.Value("IU_SITE"))
    IF reqIU_SITE = "" Then
        reqIU_SITE = "ALL"
    End IF

	
    '######### 디비 연결                    ################
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	
    
    	
	'######### 회원 리스트를 불러옴                 ################	
          
	Call dfmemberSql.Retrievewriter_list(dfDBConn.Conn,  page, pageSize, sortColumn, sortDirection, Search, Find)
   ' response.end
    'dfmemberSql.debug
	'RESPONSE.END
	IF dfMemberSql.RsCount <> 0 Then
	    nTotalCnt = dfMemberSql.RsOne("TC")
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
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">

<SCRIPT LANGUAGE="JavaScript">
function FrmChk(frm)
{
    if(frm.BN_LEVEL.value == "")
    {
        alert("글쓰기 레벨을 입력해 주세요.");
        frm.BN_LEVEL.focus();
        return false;
    }

    if (frm.BN_SPORTS.value == "")
    {
        alert("글쓰기 종목을 입력해 주세요.");
        frm.BN_SPORTS.focus();
        return false;
    }

}
</SCRIPT>
</head>

<body topmargin="0" marginheight="0">

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 게시판 글쓰기용 관리자아이디  
	      <% IF REQUEST("sStartDate") <> "" Or REQUEST("sEndDate") <> "" Or REQUEST("Search") <> "" Or REQUEST("Find") <> "" THEN %>
	        [검색 인원 : <%=formatnumber(TN,0)%> 명]
	      <% END IF %></b></td>
</tr>
</table>    
<div style="height:10px;"></div>


<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td>
	  <img src="blank.gif" border="0" width="1" height="10">
	</td>
  </tr>
</table>

<table border="0"  cellspacing="1" cellpadding="2" bgcolor="#AAAAAA" width="100%">
<col width="30" />
<col width="15" />
<col width="50" />
<col width="50" />
<col width="15" />
<col width="30" />
<col width="30" />
<col width="20" />
  
  <tr bgcolor="e7e7e7">	
	<td align="center">
	  <b>아이디</b>
	</td>
	<td align="center">
	  <b>레벨</b>
	</td>	
	<td align="center">
	  <b>닉네임</b>
	</td>
	<td align="center">
	  <b>글쓰기 닉네임</b>
	</td>
	<td align="center"  ><b>글쓰기 레벨</b></td>
	<td align="center"  ><b>글쓰기 종목</b></td>
	<td align="center"  ><b>사이트</b></td>
	<td align="center"  ><b>수정</b></td>	
  </tr>

<%
IF dfMemberSql.RsCount = 0 Then
%>

  <tr>
    <td align="center" colspan="13" height="35">현재 등록된 회원이 없습니다.</td>
  </tr>

<%
ELSE

	FOR i = 0 TO dfMemberSql.RsCount -1

        IU_IDX			= dfMemberSql.Rs(I,"IU_IDX")
		IU_ID			= dfMemberSql.Rs(I,"IU_ID")
		IU_NICKNAME		= dfMemberSql.Rs(I,"IU_NICKNAME")
		BN_NICKNAME		= dfMemberSql.Rs(I,"BN_NICKNAME")
		IU_Level		= dfMemberSql.Rs(I,"IU_LEVEL")
		BN_LEVEL		= dfMemberSql.Rs(I,"BN_LEVEL")
		IU_SITE			= dfMemberSql.Rs(I,"IU_SITE")
		BN_SPORTS			= dfMemberSql.Rs(I,"BN_SPORTS")
		

		if i mod 2 = 0 Then
		    trColor = "#FFFFFF"
		Else
		    trColor = "#F0F0F0"
		End IF
%>
<form name="frmchk<%= i %>" method="post"  onsubmit="return FrmChk(this);" action = "writer_insert.asp">
<input type="hidden" name = "IU_ID" value="<%=IU_ID%>">
<input type="hidden" name = "IU_NICKNAME" value="<%=IU_NICKNAME%>">
<tr bgcolor="<%= trColor %>">
    <td >
      <a href="View.asp?IU_IDX=<%=IU_IDX%>&IU_SITE=<%=IU_SITE%>&PAGE=<%=PAGE%>"><%=IU_ID%></a>
	</td>
	
	<td align="center">
	  <%=IU_Level%>
	</td>
	
	<td align="left">
	  <%=IU_NICKNAME%>
	</td>
	<td align="center">
	  <%=BN_NICKNAME%>
	</td>
	<td align='right'>
	<INPUT TYPE = "TEXT" NAME = "BN_LEVEL" VALUE = "<%=BN_LEVEL%>" WIDTH = "20">
	</td>
	<td align='right'>
	<INPUT TYPE = "TEXT" NAME = "BN_SPORTS" VALUE = "<%=BN_SPORTS%>" WIDTH = "20">
	</td>	
	<td align="right">
        <%= IU_SITE%>
	</td>
	<td align="center"> 
	<% IF request.Cookies("AdminLevel") = 1 THEN %> 
	    <input type="submit" class="input" value="수정" style="border: 1 solid; background-color:#C5BEBD;">
	<% ELSE %>
	    -
	<% END IF %> 
	</td>	
	</tr>
	    
</form>
<%
    Next 
END IF
%>

</table><br clear="all">

<!-- paging Start -->

<%= objPager.Render %>

<br /><br />
<!-- paging End -->


</body>
</html>