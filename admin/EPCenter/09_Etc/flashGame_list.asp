<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/EPCenter/09_Etc/_Sql/etcSql.Class.asp"-->

<%
    
    '######### Request Check                    ################	    

    
    pageSize      = 20             
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
    
 

    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
	    	
	'######### 정산 리스트를 불러옴                 ################
   
	Call dfEtcSql.RetrieveINFO_FlashGAme(dfDBConn.Conn, page, pageSize)

	IF dfEtcSql.RsCount <> 0 Then
	    nTotalCnt = dfEtcSql.RsOne("TC")
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
<title>날짜별 현황</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/_Common/inc/Css/Style2.css">

</head>

<body >
<style>


img {border:0;}
a,img,input {selector-dummy:expression(this.hideFocus=true);}
body,table,input,textarea,select {
	font:9pt dotum;

	letter-spacing: 0;
	}
TEXTAREA,center,pre,blockquote {font-family:;font-size:12px;line-height:160%;}
img{border:0}
#leftcol {
	width: 800px;
}

#leftcol ul {
	margin:0 20px 0 20px;
	padding:10px 10px 10px 10px;
}

#leftcol ul li {
    width : 120px;
	list-style: none;
	display: inline;
	float: left;
	margin: 15px;
}

</style>
<div id="leftcol">
<ul>

<%
 
IF dfEtcSql.RsCount <> 0 Then
    For i = 0 to  dfEtcSql.RsCount - 1
    
			ROWNUMBER		= dfEtcSql.Rs(i,"ROWNUMBER")
			IF_IDX			= dfEtcSql.Rs(i,"IF_IDX")
			IF_TITLE		= dfEtcSql.Rs(i,"IF_TITLE")
			IF_SWF          = dfEtcSql.Rs(i,"IF_SWF")
            IF_IMAGE          = dfEtcSql.Rs(i,"IF_IMAGE")
			TC		        = dfEtcSql.Rs(i,"TC")

 
%> 
                                <li>
                                <span class="img">
                                <a href="flashGame_view.asp?IF_IDX=<%= IF_IDX %>" target="_blank"><img alt="<%=IF_TITLE%>" src="<%=IF_IMAGE %>" /></a>
                                <br />
                                <%=IF_TITLE%>
                                </span>
                                    
                                </li>
<%
    Next
End IF
%>                                                               
</ul>
</div>
<script>
function checkForm(form)
{
    if(form.IF_TITLE.value == "")
    {
        alert("제목을 입력하세요");
        return false;
    }
    if(form.IF_IMAGE.value == "")
    {
        alert("이미지를 입력하세요");
        return false;
    }
    if(form.IF_SWF.value == "")
    {
        alert("게임경로를 입력하세요");
        return false;
    }        
}
</script>
<form name="inputForm" action="flashGame_proc.asp" method="post" onsubmit="return checkForm(this);">
<table width=100% border=0 cellpadding="3" cellspacing="1" border="0" bgcolor="#AAAAAA">
<tr bgcolor="#FFFFFF">
    <td>
    플래시 게임 제목
    </td>
    <td>
    <input type="text" name="IF_TITLE" />
    </td>
</tr>
<tr bgcolor="#FFFFFF">
    <td>
    이미지
    </td>
    <td>
    <input type="text" name="IF_IMAGE" />
    </td>
</tr>
<tr bgcolor="#FFFFFF">
    <td>
    게임경로
    </td>
    <td>
    <input type="text" name="IF_SWF" />
    </td>
</tr>
<tr bgcolor="#FFFFFF">
    <td colspan="2" align="right">
        <input type="submit" value="입력하기" />
    </td>
</tr>
</table>    
</form>
<br clear="all">
<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<table width=100% border=0>
<tr>
    <td align="center">
        <%= objPager.Render %>
    </td>
</tr>
</table>
<%	END IF	%>
<!-- paging End -->


</body>
      
</html>

