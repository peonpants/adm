<!-- #include virtual="/_Global/lta_object.asp" -->
<!-- #include virtual="/_Global/lta_function.asp" -->
<!-- #include virtual="/_Global/lta_const.asp" -->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
	viewidx = request("viewidx")
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>배팅상세내역</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/Css/style.css" />
<script>
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
	if(unchked==0) { // 전체선택을 2번 누루면 해제가 된다.
		
		
				for(i=0;i<form.length;i++) {
					if(form[i].type!='checkbox') continue;
					form[i].checked=false;
				}
				
	}
		
	return true;
}
function resizeFrame(name){
       var oBody = document.body;
       var oFrame = parent.document.all(name);
       var min_height = 120; //iframe의 최소높이(너무 작아지는 걸 막기위함, 픽셀단위, 편집가능)
       var min_width = 465; //iframe의 최소너비
       var i_height = oBody.scrollHeight + (oBody.offsetHeight-oBody.clientHeight);
       var i_width = oBody.scrollWidth + (oBody.offsetWidth-oBody.clientWidth);

       if(i_height < min_height) i_height = min_height;
       if(i_width < min_width) i_width = min_width;
       oFrame.style.height = i_height;
       oFrame.style.width = i_width;

       parent.scrollTo(1,1); //부모문서의 스크롤 위치를 1, 1로 옮긴다.(오감도님이 지적해주셨어요~^^)
}

function go_rel() {
		if (!confirm("정말 복구하시겠습니까?")) return;	
		document.frm1.submit();
}

function go_rel2() {
		if (!confirm("해당 배팅을 머니 이동 없이 종료 시키시겠습니까?")) return;	
		document.frm1.onoff.value = "off";
		document.frm1.submit();
}
function limit_i(num) {
		var frm = document.frm;
		
		document.getElementById("limit_f").src = "gamelimit.asp?viewidx="+num+"&limit="+frm.limit.value;
		document.getElementById("limit_f").location.relaod();
//		var tdval = "tr01_"+num;
//		var valold = "";
//		valold = GetCookie2('td01');
//		SaveCookie("td01", tdval, 300);
//		if (valold != "" && valold != null){
//		document.getElementById(valold).className = "";
//		}
//		document.getElementById(tdval).className = "tdbg";
}
function go_pop(val,site){
	window.open('user_info.asp?val='+val+'&site='+site,'회원정보','width=350,height=250,location=yes');
}
</script>
</head>
<body onload="location.href='#567'">
<table  border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td>&nbsp;&nbsp;</td>
    </tr>
    <tr> 
      <td><form name="frm" method="post"><strong>&nbsp;&nbsp;<%=viewidx%>경기 배팅내역</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제한금액 입력 : <input type="text" name="limit"><input type="button" value="입력" onclick="limit_i('<%=viewidx%>');"></form></td>
    </tr>
		<tr><td><img src="blank.gif" border="0" width="5" height="5"></td></tr>
    <tr> 
      <td><table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#bebebe"  style="border-collapse:collapse" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#bebebe"  style="border-collapse:collapse" class="list0">
          <tr align="center" bordercolor="#FFFFFF" bgcolor="#CCCCCC" height="25"> 
            <td width="40" bgcolor="5d7b92" ><font color="#000000" style="font-size:12px;"><strong><a href="#" onClick="jsBag(this);">전체</a></strong></font></td>
            <td width="40"><font color="#000000" style="font-size:12px;"><strong>순번</strong></font></td>
            <td width="60"><font color="#000000" style="font-size:12px;"><strong>배팅번호</strong></font></td>
            <td width="80"><font color="#000000" style="font-size:12px;"><strong>아이디</strong></font></td>
            <td width="80"><font color="#000000" style="font-size:12px;"><strong>닉네임</strong></font></td>
            <td width="34"><font color="#000000" style="font-size:12px;"><strong>승</strong></font></td>
            <td width="34"><font color="#000000" style="font-size:12px;"><strong>무</strong></font></td>
            <td width="34"><font color="#000000" style="font-size:12px;"><strong>패</strong></font></td>
            <td width="80"><font color="#000000" style="font-size:12px;"><strong>분할금</strong></font></td>
            <td width="80"><font color="#000000" style="font-size:12px;"><strong>배팅금</strong></font></td>
            <td width="50"><font color="#000000" style="font-size:12px;"><strong>배당율</strong></font></td>
            <td width="80"><font color="#000000" style="font-size:12px;"><strong>예상적중금</strong></font></td>
            <td width="60"><font color="#000000" style="font-size:12px;"><strong>조합건수</strong></font></td>
            <td width="60"><font color="#000000" style="font-size:12px;"><strong>적중건수</strong></font></td>
            <td width="60"><font color="#000000" style="font-size:12px;"><strong>건별결과</strong></font></td>
            <td width="60"><font color="#000000" style="font-size:12px;"><strong>전체결과</strong></font></td>
            <td width="120"><font color="#000000" style="font-size:12px;"><strong>배팅시각</strong></font></td>
            <td width="60"><font color="#000000" style="font-size:12px;"><strong>사이트명</strong></font></td>
            <td width="30"><font color="#000000" style="font-size:12px;"><strong>진행여부</strong></font></td>
          </tr>
<form name="frm1" method="post" action="New_Back.asp">
<input type="hidden" name="onoff" value="on">
<input type="hidden" name="viewidx" value="<%=viewidx%>">
<%
	If viewidx <> "" then
		sql_view = "SELECT IB_IDX, IB_ID, IG_IDX, IB_NUM, IB_BENEFIT, IB_AMOUNT, ib_status, to_char(IB_REGDATE,'yyyy-mm-dd hh24:mi:ss') as ib_regdate, IB_SITE FROM INFO_BETTING where ig_idx like '%"&viewidx&"%' order by ib_regdate asc "
		SET viewRs=Server.CreateObject("ADODB.Recordset") 
		viewRs.Open sql_view, DbCon


		nn = 0
		IF NOT viewRs.EOF Then
	
			Do While Not viewRs.EOF
				r0_v = ""
				r1_v = ""
				r2_v = ""		
				ig_idx2 = viewRs("ig_idx")
				ib_num2 = viewRs("ib_num")
				ib_benefit2 = viewRs("ib_benefit")
				ig_idx_s = Split(ig_idx2,",")
				ib_num_s = Split(ib_num2,",")
				ib_benefit_s = Split(ib_benefit2,",")
				ib_num_arr = 1
				rescnt = 0
				thisres = ""
				canselcnt = 0
				endcnt = 0
				ib_status = viewRs("ib_status")
				'''
				For o=0 To ubound(ig_idx_s)
					
											'response.write ig_idx_s(o)&"||"&viewidx
					SQLMSG = "SELECT IG_Status, IG_Result FROM INFO_GAME WHERE IG_IDX = "& Trim(ig_idx_s(o)) &" "
					SET RS1 = DbCon.Execute(SQLMSG)

					If Not rs1.eof Then
						IG_Status_o = Trim(rs1("IG_Status"))
						IG_Result_o = Trim(rs1("IG_Result"))
						IF IG_Status_o <> "C" THEN
							If IG_Result_o <> "" Then
									'response.write IG_Result_o&"||"&Trim(ib_num_s(o))
								If Trim(IG_Result_o) = Trim(ib_num_s(o)) Then
									rescnt = rescnt + 1
									If Cstr(Trim(ig_idx_s(o))) = Cstr(Trim(viewidx)) Then
										thisres = "적중"
									End If 
								Else 
									If Cstr(Trim(ig_idx_s(o))) = Cstr(Trim(viewidx)) Then
										thisres = "실패"
									End If 
								End If 
								endcnt = endcnt + 1
							End If 
							ib_num_arr = CDbl(ib_num_arr) * CDbl(ib_benefit_s(o))
						Else 
							response.write IG_Result_o
							If Trim(IG_Status_o) = "C" Then
								canselcnt = canselcnt + 1
								If Cstr(Trim(ig_idx_s(o))) = Cstr(Trim(viewidx)) Then
									thisres = "적특"
								End If  
							End If 
						End If 
					Else
						thisres = "대기"
					End If 

					BenefitRate = ib_benefit_s(o)

						
					If Cstr(Trim(ig_idx_s(o))) = Cstr(Trim(viewidx)) Then
						'response.write "AA"
						ig_r = ig_idx_s(o)
						ib_r = ib_num_s(o)
						ib_benefit_r = ib_benefit_s(o)
						If Trim(ib_r) = "0" Then
							r0_v = ib_benefit_r
						ElseIf Trim(ib_r) = "1" Then
							r1_v = ib_benefit_r
						ElseIf Trim(ib_r) = "2" Then
							r2_v = ib_benefit_r
						End If 
					End If 
	rs1.close
	Set rs1 = Nothing
				Next 
				'''
				nn = nn + 1
				bnhal = UBound(ig_idx_s)+1
				If bnhal = 0 Then bnhal = 1 
				
%>
		  <tr align="center" height="25"> 
						<td align="center"><input type="checkbox" name="SelUser" value="<%=viewRs("IB_IDX")%>"></td>
            <td><font color="#000000" style="font-size:12px;"><%=nn%></font><a name="567"></a></td>
            <td><font color="#000000" style="font-size:12px;"><%=viewRs("IB_IDX")%></font></td>
            <td bgcolor="5d7b92"><font color="#000000" style="font-size:12px;"><a href="#" style="cursor:hand;" onclick="go_pop('<%=viewRs("IB_ID")%>','<%=viewRs("IB_SITE")%>');"><%=viewRs("IB_ID")%></a></font></td>
<%
	sql = "select iu_nickname from info_user where iu_id = '"&viewRs("IB_ID")&"'"
	Set rsid2 = DbCon.Execute(sql)
	If Not rsid2.eof Then
		nickval = rsid2("iu_nickname")
	End If 
	rsid2.close
	Set rsid2 = nothing
%>
            <td><font color="#000000" style="font-size:12px;"><%=nickval%></font></td>
            <td><font color="#000000" style="font-size:12px;"><%=r1_v%></font></td>
            <td><font color="#000000" style="font-size:12px;"><%=r0_v%></font></td>
            <td><font color="#000000" style="font-size:12px;"><%=r2_v%></font></td>
            <td><font color="#000000" style="font-size:12px;"><%=Int(Cdbl(viewRs("IB_AMOUNT"))/Cdbl(bnhal))%></font></td>
            <td><font color="#000000" style="font-size:12px;"><%=viewRs("IB_AMOUNT")%></font></td>
            <td><font color="#000000" style="font-size:12px;"><%=formatnumber(int(ib_num_arr*100)/100,2)%></font></td>
            <td><font color="#000000" style="font-size:12px;"><%=CDbl(viewRs("IB_AMOUNT"))*CDbl(formatnumber(int(ib_num_arr*100)/100,2))%></font></td>
            <td><font color="#000000" style="font-size:12px;"><%=Cint(bnhal)%></font></td>
            <td><font color="#000000" style="font-size:12px;"><%=rescnt%></font></td>
            <td><font color="#000000" style="font-size:12px;"><%=thisres%></font></td>
            <td><font color="#000000" style="font-size:12px;">
<%
	If rescnt = (bnhal - canselcnt) Then 
		response.write "적중"
	Elseif (bnhal - canselcnt) = endcnt Then
		response.write "실패"
	Else 
		response.write "대기"
	End If 
	
%>			
			</font></td>
            <td><font color="#000000" style="font-size:12px;"><%=viewRs("ib_regdate")%></font></td>
            <td><font color="#000000" style="font-size:12px;"><%=viewRs("IB_SITE")%></font></td>
            <td><font color="#000000" style="font-size:12px;">
						<%
							If Trim(viewRs("ib_status")) = "0" Then
								process = "진행"
							Else
								process = "끝"
							End if
						%>
						<%=process%></font></td>
          </tr>
<%
			viewRs.MoveNext
			loop 
		else	
			betcount = 0
		END If

	
	viewRs.close
	Set viewRs = Nothing
	End If 

%>
</form>
        </table></td>
    </tr>
	<tr><td align="right" style="padding-right:20px;"><input type="button" value="진행끝으로 변경" onclick="go_rel2();">&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="진행내역경기진행전으로 복구" onclick="go_rel();">&nbsp;</td></tr>
	<tr><iframe name="limit_f" id="limit_f" src="gamelimit.asp" marginwidth="0" marginheight="0" frameborder="0" scrolling=no width="0" height="0" ></iframe></tr>
</table>
</body>
</html>
<script>
var oldFn = "";
if(window.onload != null){
       oldFn = new String(window.onload); //window.onload의 함수를 문자열로 받는다
       oldFn = oldFn.substring(22,oldFn.length-2);
}
window.onload = new Function("resizeFrame('bet_detail');" + oldFn); //새함수와 기존의 함수를 추가해서 onload이벤트에 할당
</script>
<%


	DbCon.Close
	Set DbCon=Nothing
%>