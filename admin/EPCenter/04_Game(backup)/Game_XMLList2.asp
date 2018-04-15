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
'#################################################################
' �ε����� ���� ������� �����ϴ��� üũ�Ѵ�.
' �ε����� ���带 �ش� ����Ʈ�� ���׷� ����Ʈ ���纽
'#################################################################
pageSize        = 100             
page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
reqSite         = dfRequest("site")

'######### ��� ����                    ################	
dfDBConn.SetConn = Application("DBConnString")
dfDBConn.Connect()	


'######### ���� ����Ʈ�� �ҷ���                 ################	

Call dfgameSql.RetrieveINFO_INDEX_GAME2(dfDBConn.Conn,  page, pageSize)

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
<title>7m ���� ����Ʈ</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<!--<script src="/Sc/Base.js"></script>-->
</head>
<style>
.input3     {font-size: 12px; color: #000000;  font-family: verdana,����, Tahoma; height:22px; border: 1px solid #6C6C6C; padding:2px; background-color:F5FDBD;}
.input4     {font-size: 12px; color: #000000;  font-family: verdana,����, Tahoma; height:22px; border: 1px solid #6C6C6C; padding:2px; background-color:F4DAFE;}
.input5     {font-size: 12px; color: #000000;  font-family: verdana,����, Tahoma; height:22px; border: 1px solid #6C6C6C; padding:2px; background-color:C7CBFF;}
</style>
<script type="text/javascript">
//��ü���� / ��ü ���� 
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
//���õ� �׸� ������ ���� ó��
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
	if(mode == "reg") modeTxt = "���"; 
			
	if (v_cnt == 0) 
	{ 
		alert(modeTxt + "�� ������ ������ �ּ���."); 
		return;
	} 
	
	//alert(v_data);
	procForm.mode.value = mode; 
	procForm.v_data.value = v_data; 

	if (!confirm("���� "+ modeTxt +"�Ͻðڽ��ϱ�?")) return;		
	procForm.action = "GameStatus_XML_Proc.asp?page=<%=Page%>&SRS_Sports=<%=SRS_Sports%>&SRL_League=<%=SRL_League%>&SFlag=<%=SFlag%>";
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
    [��ü ��� ���� : <%= nTotalCnt %> ]  
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
	    <input type="reset" class="input" style="width:300px;height:30px;" value="     ��� �ϱ� "  onclick="javascript:go_proc('reg');" >
    </td>
  </tr>
</table>
<table border="0"  cellspacing="1" cellpadding="1" bgcolor="#AAAAAA" width="100%" id="Table2">
<tr bgcolor="eeeeee"  height="25"  align="center" > 
    <td align="center" >
        <input type="checkbox" id="Table2_SelectAllCheckbox" onclick="SelectCheckBox();" />
	</td>
    <td>Ÿ��</td>  
    <td>����</td>
    <td>����</td>
    <td>�����Ͻ�</td>     
    <td>������</td>
    <td>��</td>
    <td>��</td>    
    <td>��</td>��    
    <td>Ȩ��</td>       
    <td>������</td>
    <!--<td>Ȩ����</td>
    <td>��������</td>-->
    <td>���</td>
</tr>    
<%
    IF  dfgameSql.RsCount <> 0 THEN	
        FOR ii = 0 TO dfgameSql.RsCount -1
            
            IG_Type = dfGameSql.Rs(ii,"IG_TYPE")
            IG_IDX = dfGameSql.Rs(ii,"IG_IDX")
           
	        IF IG_TYPE = "2" THEN 
		        VIEWCAP = "��/��"
		        VIEWTDCOLOR = "EFAEE1"
	        ELSEIF IG_TYPE = "1" THEN 
		        VIEWCAP = "�ڵ�ĸ"
		        VIEWTDCOLOR = "ffff00"
            ELSEIF IG_TYPE = "3" THEN 
		        VIEWCAP = "�������߱�"
		        VIEWTDCOLOR = "ff0000"		    
            Else			    
                VIEWCAP = "�¹���"
                VIEWTDCOLOR = "ffffff"
	        END IF	
	        
	        IF dfGameSql.Rs(ii,"IG_SP") = "Y" Then
	            SP_COLOR = "8cafda"
	        Else
	            SP_COLOR = "ffffff"
	        End IF
                
%>
<form name="frm<%= ii %>" method="post" action="GameStatus_XML_Proc.asp" target="exeFrame" >
<input type="hidden" name="mode" value="idx" />  
<input type="hidden" name="IG_IDX" value="<%=IG_IDX%>" />  
<tr bgcolor="ffffff"  height="25"  >
     <td align="center">
        <input type="checkbox" name="SelUser" value="<%=IG_IDX%>"/>       
    </td>
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
    <!--<td><%= dfGameSql.Rs(ii,"IG_SCORE1") %></td>    
    <td><%= dfGameSql.Rs(ii,"IG_SCORE2") %></td>    
    -->
    <td>
    <% IF dfGameSql.Rs(ii,"IG_STATUS")  = "S" Then %>
    <input type="submit" value="���" class="input" />
    <% End IF %>
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