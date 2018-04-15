<!-- #include virtual="/_Global/DbCono.asp" -->
<table width = "400" border="1" align="left" cellpadding="0" cellspacing="0" bordercolorlight="#bebebe"  style="border-collapse:collapse">
<%

	SQLLIST = "SELECT LL_IP, COUNT (LL_IP) AS CNT FROM LOG_LOGIN GROUP BY LL_IP ORDER BY LL_IP DESC"
	SET RSLIST = DBCON.EXECUTE(SQLLIST)

	IF NOT RSLIST.EOF Then
		nn = 1
		nt = 1
		DO WHILE NOT RSLIST.EOF 
			LL_IP =  RSLIST("LL_IP")
			CNT = RSLIST("CNT")
			SQLLIST2 = "SELECT LL_ID, LL_NICKNAME,ll_site FROM LOG_LOGIN WHERE LL_IP = '"&LL_IP&"' group by ll_id,ll_nickname,ll_site"
			SET RS2 = DBCON.EXECUTE(SQLLIST2)
			DO WHILE NOT RS2.EOF
				If nt Mod 2 = 0 then
				RESPONSE.WRITE "<tr height='25'><td  align='center'><font color='#000000' style='font-size:12px;'>"&NN&"</TD>"&"<td  align='center'><font color='#000000' style='font-size:12px;'>"&ll_IP&"</TD>"&"<td  align='center'><font color='#000000' style='font-size:12px;'>"&RS2("LL_ID")&"</TD>"&"<td  align='center'><font color='#000000' style='font-size:12px;'>"&RS2("LL_NICKNAME")&"</TD><td  align='center'><font color='#000000' style='font-size:12px;'>"&RS2("LL_site")&"</TD></tr>"
				Else
				RESPONSE.WRITE "<tr bgcolor='#f0c8d7' height='25' ><td  align='center'><font color='#000000' style='font-size:12px;'>"&NN&"</TD>"&"<td  align='center'><font color='#000000' style='font-size:12px;'>"&ll_IP&"</TD>"&"<td  align='center'><font color='#000000' style='font-size:12px;'>"&RS2("LL_ID")&"</TD>"&"<td  align='center'><font color='#000000' style='font-size:12px;'>"&RS2("LL_NICKNAME")&"</TD><td  align='center'><font color='#000000' style='font-size:12px;'>"&RS2("LL_site")&"</TD></tr>"
				End If 
			nn = nn + 1
			RS2.MOVENEXT
			LOOP
			RS2.CLOSE
			SET RS2 = Nothing
			nt = nt + 1
		RSLIST.MOVENEXT	
		LOOP
	END IF 
	
	RSLIST.CLOSE
	SET RSLIST = NOTHING
%>
</table>