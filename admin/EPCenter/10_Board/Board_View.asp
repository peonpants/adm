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
	Page		= REQUEST("Page")
	BF_Idx		= REQUEST("BF_Idx")
	Find		= Trim(REQUEST("Find"))
	Search		= Trim(REQUEST("Search"))
	sStartDate	= Trim(REQUEST("sStartDate"))
	sEndDate	= Trim(REQUEST("sEndDate"))

	bType = request("bType")	
	SQLstr="UPDATE Board_Free SET BF_HITS=BF_HITS+3 WHERE BF_IDX = "& BF_IDX &" "
	DbCon.Execute(SQLstr)

	SQLMSG = "SELECT * FROM Board_Free WHERE BF_Idx = '"& BF_Idx &"' "
	SET RS = DbCon.Execute(SQLMSG)

	BF_Title	= Trim(RS("BF_Title"))
	BF_Writer	= RS("BF_Writer")
	BC_ID	= RS("BF_PW")
	IB_IDX  = RS("IB_IDX")
	 
	BF_Contents	= replace(Trim(RS("BF_Contents")),"#0b151b", "")
	
	BF_RegDate	= RS("BF_RegDate")
	BF_Hits		= RS("BF_Hits")
	BF_SITE		= RS("BF_SITE")
	BF_Level		= RS("BF_Level")

	RS.Close
	Set RS = Nothing
	
	
%>

<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script language="javascript" src="Alditor/alditor.js" type="text/javascript"></script>
<script>
	function goDelete(idx) {
		location.href="Board_Delete.asp?SelUser="+idx+"&page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&bType=<%=bType%>";
	}

	function goReply() {
		var frm = document.frm1;
		
		if ((frm.BFR_Contents.value == "") || (frm.BFR_Contents.value.length < 1))
		{
		  alert("댓글을 한글자이상 입력해주세요..");
		  frm.BFR_Contents.focus();
		  return false;
		}
		
		frm.submit();
	}
  function goMo (idx){
    document.frm.submit();
  }


  function goReplyDel(ridx,fidx) {
	//alert("댓글을 5자이상 입력해주세요..");
	top.HiddenFrm.location.href="Board_Free_Reply_Proc.asp?ProcFlag=D&BFR_Idx="+ridx+"&BF_Idx="+fidx;
  }
</script></head>

<body topmargin="0" marginheight="0">
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 게시판 관리</b></td>
</tr>
</table>    
<div style="height:10px;"></div>

<table width="800" border="1" bordercolorlight="#bebebe" cellspacing="0" cellpadding="1" bordercolordark="#FFFFFF">
<form name="frm" action="Board_Write_Proc.asp" method="post" >
<input type="Hidden" name="Process" value="E">
<input type="hidden" name="BF_Idx" value="<%=BF_Idx%>">
<input type="hidden" name="bType" value="<%=bType%>">
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>글쓴이</b></td>
	<td colspan="3"><input type="text" name="BF_Writer"  maxlength="50" style="width:300px;border:1px solid #999999;" value="<%=BF_Writer%>"></td></tr>
	<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>공지적용</b></td>
	<td colspan="3">
	<select name="level">
	<option value="0" <%If BF_Level = "0" then%>selected<%End If %>>일반</option>
	<option value="1" <%If BF_Level = "1" then%>selected<%End If %>>공지사항</option>
	<option value="2" <%If BF_Level = "2" then%>selected<%End If %>>이 벤 트</option>
	<option value="3" <%If BF_Level = "3" then%>selected<%End If %>>흐르는공지</option>
	</select>
	</td></tr>

<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>사이트선택</b></td>
	<td><input type="radio" name="BF_SITE" value="All" > 전체노출
		<% 	Set PML = Server.CreateObject("ADODB.Recordset")
			PML.Open "SELECT SITE01 FROM SET_SITE Order By SEQ", dbCon, 1

			PMLC = PML.RecordCount
		   
			IF PMLC > 0 THEN

			FOR PM = 1 TO PMLC
		   
			IF PML.EOF THEN
				EXIT FOR
			END IF

			SITE01=PML(0) %>
		<input type="radio" name="BF_SITE" value="<%=SITE01%>" <%If site01 = bf_site Then %>checked<% End if%>> <%=SITE01%>
		<%	PML.Movenext
			Next
			END IF %></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>제&nbsp;&nbsp;목</b></td>
	<td colspan="3" style="padding:10,10,10,10;"><input type="text" name="BF_Title"  maxlength="100" style="width:300px;border:1px solid #999999;" value="<%=BF_Title%>"></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>등록시간</b></td>
    <td colspan="3"><input type="text" name="BF_REGDATE"  maxlength="50" style="width:300px;border:1px solid #999999;" value="<%=BF_REGDATE%>"> 예) 2010/01/01 12:21 (2010년 1월 1일 12시 21분) <br>미등록시 현재일로 등록</td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="100" nowrap><b>내&nbsp;&nbsp;용</b></td>
	<td colspan="3" style="overflow:scroll; width:700px; white-space:-moz-pre-wrap;word-break:break-all; padding:10,10,10,10;"><textarea name="BF_CONTENTS" style="width:700; height:500" ><%=BF_Contents%></textarea></td></tr>
<tr><td bgcolor="e7e7e7" align="center" width="120" nowrap><b>등록일</b></td>
	<td colspan="3">&nbsp;<%=BF_RegDate%></td></tr>

<tr><td>&nbsp;</td>
	<td colspan="3" align="right">
	<table border="0" cellspacing="0" cellpadding="0">
	<tr><td align="center">
<input type="reset" value="등록"  onclick="javascript:location.href='/EPCenter/08_Board/Board_Write.asp?bType=<%=bType%>&BF_LEVEL=<%= BF_LEVEL %>';" style="border: 1 solid;width:50px; background-color: #C5BEBD;">	
		<input type="button" value=" 수 정 " onclick="goMo(<%=BF_Idx%>)" style="border: 1 solid; background-color: #C5BEBD; cursor:hand">&nbsp;
		<input type="button" value=" 삭 제 " onclick="goDelete(<%=BF_Idx%>);" style="border: 1 solid; background-color: #C5BEBD; cursor:hand">&nbsp;
		<input type="reset" value=" 목 록 " onclick="window.location='Board_List.asp?page=<%=PAGE%>&sStartDate=<%=REQUEST("sStartDate")%>&sEndDate=<%=REQUEST("sEndDate")%>&Search=<%=Search%>&Find=<%=Find%>&bType=<%=bType%>';" style="border: 1 solid; background-color: #C5BEBD;"></td></tr></form></table></td></tr>

<!-- 댓글입력폼... -->
<%
BFR_RegDate =""
IF cStr(bType) = "1" OR cStr(bType) = "2" OR cStr(bType) = "" Then
    Set PMLs = Server.CreateObject("ADODB.Recordset")
    PMLs.Open "select top 1 BN_NICKNAME, BN_LEVEL,BN_SPORTS from BOARD_NICKNAME  ORDER BY NEWID()", dbCon, 1
    IF NOT PMLs.EOF Then
        BFR_Writer=PMLs(0)
        BN_LEVEL=PMLs(1)
        BN_SPORTS=PMLs(2)
    End IF
End IF			

%>
<tr>
<form name="frm1" method="post" action="Board_Free_Reply_Proc.asp" target="HiddenFrm">
    <td colspan="4">
        <table border='0'>
            
            <input type="hidden" name="BF_Idx" value="<%=BF_Idx%>">
            <input type="hidden" name="ProcFlag" value="I">
            <input type="hidden" name="IU_LEVEL" value="<%=BN_LEVEL %>">
<!--------------------------------자동댓글------------------------------>
<!--------------------------------자동댓글------------------------------->
                <tr>	
		            <td height="25" width="70"><input type="text" name="BFR_Writer" style="width:100px;"value="<%= BFR_Writer %>" >
		            <Br /><%=BN_SPORTS  %> Lv. <%=BN_LEVEL %>
		            </td>
		            <td ><textarea name="BFR_Contents" rows="2" style="width:520px; overflow:auto;"></textarea></td>
		            <td width="150"> <input type="text" name="BFR_REGDATE"  maxlength="50"  value="<%= BFR_RegDate %>"></td>
		            <td width="50"><input type="button" onclick="goReply();" value="입 력" style="border: 1 solid; background-color: #C5BEBD; cursor:hand"></td>
                    
                </tr>
        </table>
	</td>
	
</form>	
</tr>
</table></td></tr>


<!--덧글 리스트-->

<%
	SQLMSG = "SELECT * FROM Board_Free_Reply WHERE BF_Idx = '"& BF_Idx &"' Order By BFR_Idx Desc"
	SET RS1 = DbCon.Execute(SQLMSG)

	IF NOT RS1.EOF THEN

		DO UNTIL RS1.EOF
			BFR_Idx			= RS1("BFR_Idx")
			BFR_WRITER		= RS1("BFR_WRITER")
			BFR_CONTENTS	= Trim(RS1("BFR_CONTENTS"))
            BFR_CONTENTS   = RePlace(BFR_CONTENTS,"<script","")
			BFR_REGDATE		= RS1("BFR_REGDATE")	%>
<table ><tr><td>
<tr><td colspan="4"><table><form name="re_<%=BFR_Idx%>" method="post" action="Reply_Mo.asp">
	<input type="hidden" name="BFR_Idx" value="<%=BFR_Idx%>">
	<input type="hidden" name="BF_Idx" value="<%=BF_Idx%>">
	<tr><td height="25" width="100"><input type="text" name="BFR_Writer" style="width:100px;"value="<%=BFR_Writer%>" ></td>
		<td style="overflow:scroll; width:545px; white-space:-moz-pre-wrap;word-break:break-all;">		
		    <textarea name="BFR_Contents<%=BFR_Idx%>" rows="3" style="width:520px; overflow:auto;"><%=BFR_Contents%></textarea>		
		</td>
		<td width="150"><input type="text" name="BFR_REGDATE"  maxlength="50"  value="<%=dfStringUtil.GetFullDate(BFR_REGDATE)%>"></td>
		<td width="50"><a href="javascript:goReplyDel('<%=BFR_Idx%>','<%=BF_Idx%>');" class="bold white">X</a></td>
		<td width="50"><input type="submit" value="수정"></td></tr></form></table></td></tr>

<%
		RS1.MoveNext
		LOOP

	END IF

	RS1.Close
	Set RS1 = Nothing	%>
	

</form>	

<script>

	function FrmChk1()
	{
		if (!confirm("변경하시겠습니까?")) {
			return;
		}
		else {
			var frm = document.frm2;
			
			if ((frm.Amount.value == "") || (frm.Amount.value == 0)) {
				alert("추가/삭제하시려는 금액을 적어주세요.");
				frm.Amount.focus();
				return false;
			}
		
			document.frm2.submit();
		}
	}
	
	function FrmChk2()
	{
		if (!confirm("변경하시겠습니까?")) {
			return;
		}
		else {
			var frm = document.frm3;
			
			if ((frm.Amount.value == "") || (frm.Amount.value == 0)) {
				alert("추가/삭제하시려는 금액을 적어주세요.");
				frm.Amount.focus();
				return false;
			}
		
			document.frm3.submit();
		}
	}	
		
	function f_addPoin()
	{	    
	    document.getElementById("addCost").value =  parseInt((document.getElementById("cost").value/100) * document.getElementById("per").value,10)
	}
</script>

<iframe width=0 height=0 frameborder=0 name="frmConent"></iframe>

</body>
</html>

<%
	DbCon.Close
	Set DbCon=Nothing
%>
