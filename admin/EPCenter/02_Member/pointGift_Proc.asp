<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/EPCenter/05_Account/_Sql/accountSql.Class.asp"-->
<%
	Page			= REQUEST("Page")
	reqIU_ID		= REQUEST("IU_ID")
	
	LP_POINT = REPLACE(TRIM(REQUEST("Amount")), ",", "")
	LP_CONTENTS1 = REQUEST("LP_CONTENTS1")
	Contents = "관리자증감"


    dfDBConn.SetConn = Application("DBConnString")
    dfDBConn.Connect()	
    
 
    '####### 문자를 보낸다.
    arrIU_ID = Split(reqIU_ID,",")
 
    For ii = 0 To Ubound(arrIU_ID)
        
        IU_ID = Trim(arrIU_ID(ii))
        
        SQL_SP = "UP_insertLOG_POINT"
        Call dfaccountSql.insertLOG_POINT(dfDBConn.Conn, IU_ID, 1, LP_POINT, Contents, LP_CONTENTS1)
        dfaccountSql.debug
    Next
%>
<script type="text/javascript">
location.href ="/EPCenter/05_Account/point_list.asp"
</script>