<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/03_League/_Sql/LeagueSql.Class.asp"-->
<!-- #include virtual="/_Global/DBHelper.asp" -->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
    '### 디비 관련 클래스(Command) 호출
    Set Dber = new clsDBHelper 
    
	Page			= REQUEST("Page")
	RL_Idx			= REQUEST("RL_Idx")
	Find            = Trim(REQUEST("Find"))
	RL_Sports       = REQUEST("RL_Sports")	
    	
    SQLMSG = "SELECT RL_IDX, RL_SPORTS, RL_LEAGUE, RL_IMAGE, RL_STATUS, RL_KR_League FROM Ref_League WHERE RL_IDX = ?"
    reDim param(0)
    param(0) = Dber.MakeParam("@RL_Idx",adInteger,adParamInput,,RL_Idx)                   'adInteger adVarWChar
        
    Set Rs = Dber.ExecSQLReturnRS(SQLMSG,param,nothing) 
    
    IF  Rs.Eof Then
        response.Write "존재하지 않는 데이터입니다."
        response.End
    End IF
    
	RL_IDX			= RS(0)
	RL_SPORTS		= RS(1)
	RL_LEAGUE		= RS(2)
	RL_IMAGE		= RS(3)
	IF RL_IMAGE <> "" THEN
	    RL_IMAGE = "<img src='"& dfStringUtil.GetLeagueImage(RL_IMAGE)	&"' style='border:1px solid;' >"
	ELSE
	RL_Image = "<font color=red>등록된 리그 아이콘이 없습니다.</font>"
	END IF
	RL_STATUS		= RS(4)
	RL_KR_League		= RS(5)

	RS.Close
	Set RS = Nothing
%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script>
	function FrmChk() {
		var frm = document.frm1;
		
		if (frm.RL_League.value == "")
		{
			alert("수정할 리그명을 입력해주세요.");
			frm.RL_League.focus();
			return false;
		}
        
        frm.action = "Edit_Proc.asp";
        frm.target    = "uploadIFm";
        frm.method = "post";		
		frm.submit();
	}
 function ImageUpload()
  	{
  	
        document.getElementById("uploadImage").src = document.getElementById("uploadImgName").value ;   	        
        document.getElementById("uploadImage").style.display = "";
        
  	}    
  			
</script></head>

<body topmargin="0" marginheight="0">
<form name="frm1" method="post" action="Edit_Proc.asp" >
<input type="hidden" name="RL_Idx" value="<%=RL_Idx%>">
<input type="hidden" name="Process" value="U">

<table border="1"  bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="700">
<tr><td bgcolor="706E6E" style="padding-left:12" height="23">
	<b><font color="FFFF00">게임리그 관리</font><font color="ffffff">&nbsp;&nbsp;▶ 게임리그 수정</font></b></td></tr></table>

<table border="1"  bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF" width="700">
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>종목 선택</b></td>
	<td colspan="3">
	<select name="RL_Sports">
	<%	
		    	    
    SQLR = "SELECT RS_SPORTS FROM Ref_Sports WHERE RS_STATUS = 1 Order By RS_IDX"
        
    Set Rs = Dber.ExecSQLReturnRS(SQLR,nothing,nothing) 
    	    
		RSCount = RS.RecordCount

		FOR a =1 TO RSCount
		
			RLS = RS(0) 
	%>
	<option value="<%=RLS%>" <% IF RL_SPORTS = RLS THEN %>SELECTED<% END IF %>><%=RLS%></option>
	<%
		RS.movenext
		NEXT
		
		RS.Close
		Set RS=Nothing	
	%>
	</select>
	</td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>게임 리그명</b></td>
	<td colspan="3"><input type="text" style="width:200px;border:1px solid;" maxlength="100" name="RL_League" value="<%=RL_League%>"></td></tr>
<tr>
    <td bgcolor="e7e7e7" align="center" width="120" nowrap><b>게임 리그명(한글)</b></td>
	<td colspan="3"><input type="text" name="RL_KR_League" style="width:400px;border:1px solid #999999;" maxlength="100" value="<%=RL_KR_League%>"></td>
</tr>	
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>리그 아이콘</b></td>
	<td colspan="3"><%=RL_Image%></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap>
	<% IF RL_IMAGE = "" THEN %>
	<b>아이콘 등록</b>
	<% ELSE %>
	<b>아이콘 수정</b>
	<% END IF %></td>
   	<td colspan="3">
	<input type="text" name="uploadImgName"  id="uploadImgName" value=""  onchange="ImageUpload();"  style="width:400px;border:1px solid #999999;" maxlength="70">
	<input type="button" onclick="window.open('http://imgur.com/')" value="이미지업로드" />
	<br />
    <img src="" id="uploadImage" width="20" height="20" style="display:none;" />
    
   	</td></tr></table><br>

<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr><td align="center"> 
	<input type="button" value=" 수 정 " onclick="javascript:FrmChk();" style="border: 1 solid; background-color: #C5BEBD;">
	<input type="reset" value=" 취 소 " onclick="javascript:document.frm1.reset();" style="border: 1 solid; background-color: #C5BEBD;">
	<input type="button" value=" 목 록 "  onclick="window.location='List.asp?Find=<%= Find %>&RL_Sports=<%= RL_Sports %>&page=<%=PAGE%>>';" style="border: 1 solid; background-color: #C5BEBD;"></td></tr></table></form>
<iframe id="uploadIFm" name="uploadIFm" width="0" height="0" frameborder="0"></iframe>
<br />
<img src="guide.jpg" />
</body>
</html>
<%
	Dber.Dispose
	Set Dber = Nothing 		
%>