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
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    reqType            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("type")), 0, 0, 2)     
    IG_TYPE            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("IG_TYPE")), 0, 0, 2)     
    reqLang            = Trim(dfRequest.Value("lang"))
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
    pageSize        = 500
    reqLang = "kr"
	'######### ���� ����Ʈ�� �ҷ���                 ################	
    IF reqLang = "kr" Then
	    Call dfgameSql.RetrieveINFO_7M_IGTYPE(dfDBConn.Conn,page, pageSize, reqType, IG_TYPE)
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
</head>

<body>
<table border="0"  cellspacing="1" cellpadding="3" bgcolor="#AAAAAA" width="100%" id="Table1">
<tr bgcolor="eeeeee"  height="25">     
    <td align="right">
        <b>
        <a href="Game_7mListHtml.asp?IG_TYPE=0">�¹���</a> | 
        <a href="Game_7mListHtml.asp?IG_TYPE=1">�ڵ�ĸ</a> | 
        <a href="Game_7mListHtml.asp?IG_TYPE=2">�������</a>
        </b>        
    </td>
</tr>
</table>
<br />
<table border="0"  cellspacing="1" cellpadding="3" bgcolor="#AAAAAA" width="100%" id="tblGameList">
<tr bgcolor="eeeeee"  height="25">     
    <td>����</td>
    <td>�����Ͻ�</td>
    <td>����</td>    
    <td>Ȩ��</td>
    <td>Ȩ���</td>    
    <td>����</td>    
    <td>�������</td>    
    <td>����</td>
    <td>IDX</td>   
</tr>    
<%	
    IF  dfgameSql.RsCount = 0 THEN	
%>
<tr bgcolor="ffffff"> <td align="center" colspan="13" height="35">���� ��ϵ� ������ �����ϴ�.</td></tr>
<%
	ELSE
	    FOR ii = 0 TO dfgameSql.RsCount -1
            
           
            IG_STARTTIME = dfGameSql.Rs(ii,"I7_STARTTIME") 
            
            checkTime = ""
            IF isNull(dfGameSql.Rs(ii,"IG_STARTTIME")) Or dfGameSql.Rs(ii,"IG_STARTTIME") <> "" Then
                IF dfGameSql.Rs(ii,"I7_STARTTIME") <> dfGameSql.Rs(ii,"IG_STARTTIME") Then
                   checkTime = "<b><font color='red'>[�ð�����]</font></b>"
                End IF
            End IF
            
            '��� ����
            IF dfGameSql.Rs(ii,"IG_TEAM1BENEFIT") <> "" Then
                trClass = "#FCEAEA"
            Else
                trClass = "#FFFFFF"
            End IF

            
            
            
%>
<tr bgcolor="<%= trClass %>" height="25" > 
    <td>
        <%
            IF dfGameSql.Rs(ii,"IG_TYPE") = "0" Then
                response.write "�º���"
            ElseIF dfGameSql.Rs(ii,"IG_TYPE") = "1" Then
                response.write "�ڵ�ĸ"                               
            ElseIF dfGameSql.Rs(ii,"IG_TYPE") = "2" Then
                response.write "�������"                    
            End IF
        %>
    </td>
    <td><%= dfStringUtil.GetFullDate(IG_STARTTIME) %> <%= checkTime %></td>    
    <td style="color:<%= fontColor %>"><%= dfGameSql.Rs(ii,"I7_LEAGUE") %></td>    
    <td><%= dfGameSql.Rs(ii,"I7_TEAM1") %></td>    
    <td><%= dfGameSql.Rs(ii,"IG_TEAM1BENEFIT") %></td>
    <td><%= dfGameSql.Rs(ii,"IG_DRAWBENEFIT") %></td>
    <td><%= dfGameSql.Rs(ii,"IG_TEAM2BENEFIT") %></td>
    <td> <%= dfGameSql.Rs(ii,"I7_TEAM2") %></td>                
    <td><%= dfGameSql.Rs(ii,"I7_IDX") %></td>    
</tr> 
<%	    
	    Next
    End IF	    
%>	 
</body>
</html>