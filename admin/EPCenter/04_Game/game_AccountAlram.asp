<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<%


		SQLMSG = "SELECT COUNT(IB_IDX) FROM INFO_BETTING WITH(NOLOCK) where IB_CNT = IB_RESULT_CNT AND IB_STATUS = 0 AND IB_ID NOT IN (SELECT IU_ID FROM INFO_USER WITH(NOLOCK) WHERE IU_STATUS = 9)"
		SET RS = DbCon.Execute(SQLMSG)

		Alram		= RS(0)
        
		RS.Close
		Set RS = Nothing

		IF Alram > 0 Then
%>
<embed src="/midi/Customer.mid" hidden=true>
<%		
		End IF
%>