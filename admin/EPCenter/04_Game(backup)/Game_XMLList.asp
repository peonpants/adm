<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->

<%
'#################################################################
' 인덱스의 게임 결과값이 존재하는지 체크한다.
' 인덱스의 리드를 해당 싸이트의 리그로 컨버트 맞춰봄
'#################################################################
pageSize        = 1000            
page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
reqSite         = dfRequest("site")

'######### 디비 연결                    ################	
dfDBConn.SetConn = Application("DBConnString")
dfDBConn.Connect()	


'######### 배팅 리스트를 불러옴                 ################	

Call dfgameSql.RetrieveINFO_INDEX_GAME(dfDBConn.Conn,  page, pageSize)

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
<title>7m 게임 리스트</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/Sc/Base.js"></script>
</head>
<style>
.input3     {font-size: 12px; color: #000000;  font-family: verdana,돋움, Tahoma; height:22px; border: 1px solid #6C6C6C; padding:2px; background-color:F5FDBD;}
.input4     {font-size: 12px; color: #000000;  font-family: verdana,돋움, Tahoma; height:22px; border: 1px solid #6C6C6C; padding:2px; background-color:F4DAFE;}
.input5     {font-size: 12px; color: #000000;  font-family: verdana,돋움, Tahoma; height:22px; border: 1px solid #6C6C6C; padding:2px; background-color:C7CBFF;}
</style>
<script type="text/javascript">
//전체선택 / 전체 해제 
function SelectCheckBox()
{
    var checkboxContainer = document.getElementById("Table2");
    var inputs = checkboxContainer.getElementsByTagName('input');    
    var chek = document.getElementById("Table2_SelectAllCheckbox").checked
          
        for (var i = 0; i < inputs.length; i++)
        {
            inputs.item(i).checked = chek;
        }           
}
//선택된 항목 종류에 따라 처리
function go_proc(mode) 
{
	var v_cnt = 0;
	var v_data = "";
	
	var checkboxContainer = document.getElementById("Table2");
	var inputs = checkboxContainer.getElementsByTagName('input');
	
	for( var i=0; i<inputs.length; i++) 
	{
		var ele = inputs.item(i);
		if( (ele.name=="SelUser") && (ele.checked) )
		{ 
			if (v_data.length==0)
				v_data = ele.value;
			else
				v_data = v_data + "," + ele.value; 
			v_cnt = v_cnt + 1; 
		} 
	}
	if(mode == "start") modeTxt = "시작"; 
	if(mode == "end") modeTxt = "마감"; 
	if(mode == "del") modeTxt = "삭제"; 
			
	if (v_cnt == 0) 
	{ 
		alert(modeTxt + "할 정보를 선택해 주세요."); 
		return;
	} 
	
	//alert(v_data);
	procForm.mode.value = mode; 
	procForm.v_data.value = v_data; 

	if (!confirm("정말 "+ modeTxt +"하시겠습니까?")) return;		
	procForm.action = "GameStatus_Proc2.asp";
	procForm.submit();	
}


</script>
<body topmargin="0" marginheight="0">
<iframe name="exeFrame" width=0 height=0 frameborder=0></iframe>
<form name="procForm" method="post" target="exeFrame">
<input type="hidden" name="mode" />
<input type="hidden" name="v_data" />
</form>
<br />
<!-- paging Start -->
<table width="100%">
<tr>
    <td align="center" >
    [전체 경기 개수 : <%= nTotalCnt %> ]  
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
    </td>   
</tr>
</table>
<!-- paging End -->
<br />

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td >    
	   <input type="reset" class="input" value="정산마감"  onclick="javascript:go_proc('end');" >&nbsp;
    </td>
  </tr>
</table>
<table border="0"  cellspacing="1" cellpadding="1" bgcolor="#AAAAAA" width="100%" id="Table2">
<tr bgcolor="eeeeee"  height="25"  align="center" > 

    <td align="center" >
        <input type="checkbox" id="Table2_SelectAllCheckbox" onclick="SelectCheckBox();" />
	</td>
    <td>IG_IDX</td>
    <td>타입</td>  
    <td>종목</td>
    <td>리그</td>
    <td>게임일시</td>     
    <td>기준점</td>
    <td>승</td>
    <td>무</td>    
    <td>패</td>ㄴ    
    <td>홈팀</td>       
    <td>원정팀</td>
    <td>홈점수</td>
    <td>원정점수</td>
    <td>등록</td>
</tr>    
<%
    IF  dfgameSql.RsCount <> 0 THEN	
        FOR ii = 0 TO dfgameSql.RsCount -1
            
            IG_Type = dfGameSql.Rs(ii,"IG_TYPE")
            IG_IDX = dfGameSql.Rs(ii,"IG_IDX")
           
	        IF IG_TYPE = "2" THEN 
		        VIEWCAP = "오/언"
		        VIEWTDCOLOR = "EFAEE1"
	        ELSEIF IG_TYPE = "1" THEN 
		        VIEWCAP = "핸디캡"
		        VIEWTDCOLOR = "ffff00"
            ELSEIF IG_TYPE = "3" THEN 
		        VIEWCAP = "점수맞추기"
		        VIEWTDCOLOR = "ff0000"		    
            Else			    
                VIEWCAP = "승무패"
                VIEWTDCOLOR = "ffffff"
	        END IF	
	        
	        IF dfGameSql.Rs(ii,"IG_SP") = "Y" Then
	            SP_COLOR = "8cafda"
	        Else
	            SP_COLOR = "ffffff"
	        End IF
                
%>
<form name="gameEditForm<%= IG_IDX %>" id="gameEditForm<%= IG_IDX %>" method="post" target="exeFrame">

<input type="hidden" name="mode" value="idx" />  
<input type="hidden" name="IG_IDX" value="<%=IG_IDX%>" />  
<tr bgcolor="ffffff"  height="25"  >
     <td align="center">

        <input type="checkbox" name="SelUser" value="<%=IG_IDX%>"/>       
    </td>
	<td><%=IG_IDX %></td>
	<td bgcolor="<%=VIEWTDCOLOR %>"><%= VIEWCAP %></td>  
    <td > <%= dfGameSql.Rs(ii,"RL_SPORTS") %></td>  
    
    <td><img src="<%= reqSite %>/UpFile/League/<%= dfGameSql.Rs(ii,"RL_IMAGE") %>" width="20" /> <%= dfGameSql.Rs(ii,"RL_LEAGUE") %></td>  
    <td bgcolor="<%= SP_COLOR %>"><%= dfGameSql.Rs(ii,"IG_STARTTIME") %></td>
    <td><%= dfGameSql.Rs(ii,"IG_HANDICAP") %></td>
    <td><%= dfGameSql.Rs(ii,"IG_TEAM1BENEFIT") %></td>
    <td><%= dfGameSql.Rs(ii,"IG_DRAWBENEFIT") %></td>
    <td><%= dfGameSql.Rs(ii,"IG_TEAM2BENEFIT") %></td>        
    <td><%= dfGameSql.Rs(ii,"IG_TEAM1") %></td>     
    <td><%= dfGameSql.Rs(ii,"IG_TEAM2") %></td>    
    <td><%= dfGameSql.Rs(ii,"IG_SCORE1") %></td>    
    <td><%= dfGameSql.Rs(ii,"IG_SCORE2") %></td>    

    <td>
	<%
	if dfGameSql.Rs(ii,"IG_STATUS") = "F" THEN
	SQLLIST1 = "update info_game set IG_SCORE1='"&dfGameSql.Rs(ii,"IG_SCORE1")&"', IG_SCORE2='"&dfGameSql.Rs(ii,"IG_SCORE2")&"',ig_anal='1' where ii_idx='"&ig_idx&"' and IG_STATUS='E'"

	ELSEIF dfGameSql.Rs(ii,"IG_STATUS") = "C" THEN
	SQLLIST1 = "update info_game set IG_SCORE1='"&dfGameSql.Rs(ii,"IG_SCORE1")&"', IG_SCORE2='"&dfGameSql.Rs(ii,"IG_SCORE2")&"',ig_anal='2' where ii_idx='"&ig_idx&"' and IG_STATUS='E'"

	END IF
	DbCon.execute(sqllist1)
	%>

    </td>
</tr>    
</form>
<%

        Next
    End IF
%>
</table>
<br />
<!-- paging Start -->
<table width="100%">
<tr>
    <td align="center" >
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