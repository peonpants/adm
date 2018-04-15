<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual='/_Global/amount.asp' -->
<!-- #include virtual="/_Global/functions.asp" -->
<!-- #include virtual="/_Global/ASocket.inc" -->

<%
	IL_GUID		= REQUEST("IL_GUID")
	ILG_NUM		= REQUEST("ILG_NUM")

	ILG_Score1	= REQUEST("ILG_Score1")
	ILG_Score2	= REQUEST("ILG_Score2")


	SQLMSG = "SELECT ILG_HANDICAP, ILG_TYPE FROM INFO_LOTTO_GAME WHERE IL_GUID = '" & IL_GUID & "' AND ILG_NUM = " & ILG_NUM
	SET RS = DbCon.Execute(SQLMSG)
	
	ILG_HANDICAP		= Trim(RS("ILG_HANDICAP"))
	ILG_TYPE			= RS("ILG_TYPE")
	
	IF ILG_TYPE = "0" Or ILG_TYPE = "2" THEN
		Score1 = ILG_Score1
	ELSE
		Score1 = Cdbl(ILG_Score1) + Cdbl(ILG_HANDICAP)
	END IF
	
	Score2 = ILG_Score2
	
	ILG_STATUS = "F"

	'2 언더오버
	'1 핸디캡
	'0 프로토
	IF ILG_TYPE = "2" THEN 
		IF Cdbl(ILG_HANDICAP) < Cdbl(Cdbl(Score1) + Cdbl(Score2)) THEN 
			WinTeam = "2"
		ElseIf Cdbl(ILG_HANDICAP) = Cdbl(Cdbl(Score1) + Cdbl(Score2)) THEN 
			WinTeam = "NULL"
			ILG_STATUS = "X"
		Else 
			WinTeam = "1"
		END IF
	ELSE
		IF Cdbl(Score1) > Cdbl(Score2) THEN
			WinTeam = "1"
		ELSEIF Cdbl(Score1) < Cdbl(Score2) THEN
			WinTeam = "2"
		ElseIf Cdbl(Score1) = Cdbl(Score2) And ILG_TYPE = "1"  THEN
			WinTeam = "NULL"
			ILG_STATUS = "X"
		Else 
			WinTeam = "0"
		END IF
	END IF 


	'게임리스트 승리팀을 반영
	UPDSQL = "Update INFO_LOTTO_GAME SET ILG_Score1=" & ILG_Score1 & ", ILG_Score2=" & ILG_Score2 & ", ILG_Result = " & WinTeam & ", ILG_Status = '" & ILG_STATUS & "'"
	UPDSQL = UPDSQL & " where IL_GUID = '" & IL_GUID & "' AND ILG_NUM = " & ILG_NUM

	DbCon.Execute (UPDSQL)

	DbCon.Close
	Set DbCon=Nothing
%>
<script type="text/javascript">
	opener.top.ViewFrm.location.reload();
	self.close();
</script>