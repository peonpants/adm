<!-- #include virtual="/_Global/DbCono.asp" -->
<link href="Includes/common.css" rel="stylesheet" type="text/css">
<script src="/Sc/Base.js"></script>
<script language="javascript" src="Includes/common.js"></script>
<%
	SET DbRec=Server.CreateObject("ADODB.Recordset") 
	DbRec.CursorType=1

	SQLLIST = "SELECT ISNULL(COUNT(*),0) FROM Info_Charge Where IC_Status=0"
	SET RSLIST = DbCon.Execute(SQLLIST)
	TINPUT = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING

	SQLLIST = "SELECT ISNULL(COUNT(*),0) FROM Info_Exchange Where IE_Status=0"
	SET RSLIST = DbCon.Execute(SQLLIST)
	TOUTPUT = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING
	
	SQLLIST = "SELECT ISNULL(COUNT(*),0) FROM Board_Customer Where BC_Status=1 AND BC_Reply=0"
	SET RSLIST = DbCon.Execute(SQLLIST)
	TMSG = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = NOTHING

	SQLLIST = "SELECT ISNULL(COUNT(*),0) FROM Board_free Where Bf_Status=1 and bf_hits = 0 "
	SET RSLIST = DbCon.Execute(SQLLIST)
	TBOD = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing

	SQLLIST = "select count(*) from info_betting where ib_id = 'parlia' and ib_status = 0 and IB_RESULT_CNT = IB_CNT"
	SET RSLIST = DbCon.Execute(SQLLIST)
	WB = CDBL(RSLIST(0))
	RSLIST.CLOSE
	SET RSLIST = Nothing

	SQLLIST = "select CHAT_USE from set_chat "
	SET RSLIST = DbCon.Execute(SQLLIST)
	CAUTO = RSLIST("CHAT_USE")
	RSLIST.CLOSE
	SET RSLIST = Nothing
	

%>	


<% IF TINPUT > 0 THEN %><embed src="/midi/charge.mid" hidden=true></embed><% END IF %>
<% IF TOUTPUT > 0 THEN %><embed src="/midi/xylofun.wav" hidden=true><% END IF %>
<% IF TMSG > 0 THEN %><embed src="/midi/cu.wav" hidden=true><% END IF %>
<% IF TBOD > 0 THEN %><embed src="/midi/Login.mid" volume=300 hidden=true><% END IF %>
<% IF WB > 0 THEN %><embed src="/midi/toto.wav" volume=300 hidden=true><% END IF %>
<% IF TREY > 0 THEN %><embed src="/midi/Reply.mid" hidden=true> <% END IF %>
<% IF CAUTO > 0 THEN %><embed src="/EPCenter/test.asp" hidden=true> <% END IF %>