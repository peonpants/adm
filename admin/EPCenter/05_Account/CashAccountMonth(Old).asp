<!-- #include virtual="/Includes/Conn.asp" --->

<%
	AdminChk()
	
	page = Trim(Request.QueryString("page"))
	If page = "" then page = 1
%>

<html>
<head>
	<title>▒ 관리자 ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒</title>
	<link rel="stylesheet" type="text/css" href="../css/style.css">
	<script src="/Sc/Base.js"></script>
</head>

<body topmargin="0" marginheight="0">
<table border="1"  bordercolorlight="#706E6E" cellspacing="0" cellpadding="1" bordercolordark="#bebebe" width="100%">
	<tr>
		<td bgcolor="706E6E" style="padding-left:12" height="23">
			<b><font color="FFFF00">결제관리</font><font color="ffffff">&nbsp;&nbsp;▶ 전체 결제정보 &nbsp;&nbsp;▶ 월별  </font></b>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
  		<td align="center">
			<%
				Call dbOpen(db)

				s_year = addFilter(Request.QueryString("s_year"))
				If s_year ="" then s_year = year(now)
				s_month = addFilter(Request.QueryString("s_month"))
				If s_month = "" then s_month = month(now)
				s_day = addFilter(Request.QueryString("s_day"))
				If s_day ="" then s_day = day(now)
				total_days = 12
			%>
			<!------매출통계보기-------------->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr><td align="center" valign="top"></td></tr>
				<tr>
					<td align="center" valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr><td bgcolor="D6D3D6"><img src="./img/sale4.gif" width="1" height="1"></td></tr>
						</table>
						<table width="100%" height="38" border="0" cellspacing="0" cellpadding="0">
							<tr>
							<form name="frm" method="get">
								<td>
								<select name="s_year">
								<%for yy=2007 to 2012%>
									<option value="<%=yy%>" <%if yy=cint(s_year) then%> selected <%end if%>><%=yy%>년</option>
								<%next%>
								</select>
								<input type="image" src="../images/sale5.gif" width="58" height="19" border="0" align="absmiddle">
								</td>
								<td align="right"><a href="CashAccountDay.asp">일별</a> | <a href="CashAccountMonth.asp"><b>월별</b></a></td>
							</form>
							</tr>
						</table>
						<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="DEE3E7">
							<tr bgcolor="EFF7F7"> 
								<td width="10%" height="30" align="center">날짜</td>
								<td width="15%" align="center">신용카드</td>
								<td width="15%" align="center">핸드폰</td>
								<td width="15%" align="center">무통장</td>
								<td width="15%" align="center">ARS</td>
								<td width="15%" align="center">보너스</td>
								<td width="10%" align="center"><b>총액</b></td>
							</tr>
							<%
								Dim j, start_day, s_mm, s_dd, objGrs
								Dim CreditMoney, MobileMoney, AccountMoney, BonusMoney, RowSumMoney
								Dim tot_CreditMoney, tot_MobileMoney, tot_AccountMoney, tot_BonusMoney, tot_RowSumMoney
								
								j=0
								tot_CreditMoney = 0
								tot_MobileMoney = 0
								tot_AccountMoney = 0	
								tot_BonusMoney = 0
								tot_RowSumMoney = 0
								
								for start_day = 1 to total_days
								
									If Len(start_day) = 1 then 
										s_mm = "0"&start_day
									else
										s_mm = start_day
									End if
		
									set objGrs = db.execute("sp_CashAccountInfo_Stat '"&s_year&"','"&start_day&"','0'")
									
									CreditMoney = objGrs("AcMoney1")
									MobileMoney = objGrs("AcMoney2")
									AccountMoney = objGrs("AcMoney3")
									BonusMoney = objGrs("AcMoney4")
									ArsMoney = objGrs("AcMoney5")
									RowSumMoney = objGrs("AcMoney6")
									
									tot_CreditMoney = tot_CreditMoney + CreditMoney
									tot_MobileMoney = tot_MobileMoney + MobileMoney
									tot_AccountMoney = tot_AccountMoney + AccountMoney
									tot_ArsMoney = tot_ArsMoney + ArsMoney
									tot_BonusMoney = tot_BonusMoney + BonusMoney
									tot_RowSumMoney = tot_RowSumMoney + RowSumMoney
							%>
							<tr bgcolor="#FFFFFF"> 
								<td height="25" align="center"><%=s_year%>-<%=s_mm%></td>
								<td align="right" style="padding-right:9px;"><%=formatnumber(CreditMoney,0)%> 원</td>
								<td align="right" style="padding-right:9px;"><%=formatnumber(MobileMoney,0)%> 원</td>
								<td align="right" style="padding-right:9px;"><%=formatnumber(AccountMoney,0)%> 원</td>
								<td align="right" style="padding-right:9px;"><%=formatnumber(ArsMoney,0)%> 원</td>
								<td align="right" style="padding-right:9px;"><%=formatnumber(BonusMoney,0)%> 원</td>	
								<td align="right" style="padding-right:9px;"><%=formatnumber(RowSumMoney,0)%> 원</td>	
							</tr>
					<%
							objGrs.close
							set objGrs = nothing
				   			j = j + 1
				   		Next
					%>
					<tr bgcolor="EFF7F7"> 
						<td height="30" align="center">총계</td>
						<td align="right" bgcolor="#FFFFFF" style="padding-right:9px;"><b><%=formatnumber(tot_CreditMoney,0)%></b> 원</td>
						<td align="right" bgcolor="#FFFFFF" style="padding-right:9px;"><b><%=formatnumber(tot_MobileMoney,0)%></b> 원</td>
					 	<td align="right" bgcolor="#FFFFFF" style="padding-right:9px;"><b><%=formatnumber(tot_AccountMoney,0)%></b> 원</td>
						<td align="right" bgcolor="#FFFFFF" style="padding-right:9px;"><b><%=formatnumber(tot_ArsMoney,0)%></b> 원</td>
						<td align="right" bgcolor="#FFFFFF" style="padding-right:9px;"><b><%=formatnumber(tot_BonusMoney,0)%></b> 원</td>
						<td align="right" bgcolor="#FFFFFF" style="padding-right:9px;"><font color="red"><b><%=formatnumber(tot_RowSumMoney,0)%></b></font> 원</td>
					</tr>
				</table>   
			</td>
		</tr>
	<tr><td align="center" valign="top"></td></tr>
</table>
<!------매출통계보기-------------->
</body>
</html>

<%
	Call dbClose(db)
%>