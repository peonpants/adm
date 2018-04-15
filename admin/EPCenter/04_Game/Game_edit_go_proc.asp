<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->

<%
	Page		= REQUEST("Page")
	SFlag		= REQUEST("SFlag")
	SRS_Sports	= REQUEST("SRS_Sports")
	SRL_League	= REQUEST("SRL_League")

	IG_IDX		= REQUEST("IG_IDX")
	s_year		= REQUEST("s_year")
	s_month		= REQUEST("s_month")
	s_day		= REQUEST("s_day")
	s_hour		= REQUEST("s_hour")
	IG_Team1	= Trim(REQUEST("IG_Team1"))
	IG_Team2	= Trim(REQUEST("IG_Team2"))
	IG_Content  = Replace(Trim(REQUEST("IG_Team2")),"'","''")
	
	If Len(Trim(s_month)) = 1 Then
	s_month = "0"&s_month
	End If 
	s_min		= REQUEST("s_min")
	
	IG_StartTime = s_year & "-" & s_month & "-" & s_day & " " & s_hour & ":" & s_min & ":00"
	
	IG_Team1Benefit = formatnumber(Trim(REQUEST("IG_Team1Benefit")),2)
	IG_DrawBenefit = formatnumber(Trim(REQUEST("IG_DrawBenefit")),2)
	IG_Team2Benefit = formatnumber(Trim(REQUEST("IG_Team2Benefit")),2)
	IG_Handicap = formatnumber(Trim(REQUEST("IG_Handicap")),2)

	IG_Memo = Trim(REQUEST("IG_Memo"))

	'response.write  FormatDateTime(now, 2)& " "  &FormatDateTime(now, 4)&":00"&"  "&ig_starttime&"  "&DateDiff("n",FormatDateTime(now, 2)& " "  &FormatDateTime(now, 4)&":00",ig_starttime)
	'response.End

	'// DB 입력
	UPDSQL = "UPDATE INFO_GAME SET IG_Team1Benefit=" & Cdbl(IG_Team1Benefit)
	UPDSQL = UPDSQL & ", IG_StartTime='" & IG_StartTime
	UPDSQL = UPDSQL & "', IG_DrawBenefit=" & Cdbl(IG_DrawBenefit)
	UPDSQL = UPDSQL & ", IG_Team2Benefit=" & Cdbl(IG_Team2Benefit)
	UPDSQL = UPDSQL & ", IG_Handicap=" & Cdbl(IG_Handicap)
	UPDSQL = UPDSQL & ", IG_Memo='" & IG_Memo & "' "
	UPDSQL = UPDSQL & ", IG_Team1='" & IG_Team1 & "' "
	UPDSQL = UPDSQL & ", IG_Team2='" & IG_Team2 & "' "
	UPDSQL = UPDSQL & ", IG_Content='" & IG_Content & "' "	
	If DateDiff("n",FormatDateTime(now, 2)& " "  &FormatDateTime(now, 4)&":00",ig_starttime) > 0 Then
		'UPDSQL = UPDSQL & ", IG_STATUS='S' "
	End If 
	UPDSQL = UPDSQL & " WHERE IG_IDX=" & IG_IDX
	DbCon.Execute (UPDSQL)

	DbCon.Close
	Set DbCon=Nothing
%>
<script type="text/javascript">
    alert("노박사요청으로 인하여 새로고침을 하지 않습니다.");
	//opener.location.reload();
	self.close();
</script>