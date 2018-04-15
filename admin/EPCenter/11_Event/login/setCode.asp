<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/11_Event/_Sql/eventSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%
    
    '######### Request Check                    ################	    
    
    reqRound            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("round")), 1, 1, 9999999) 
	
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
 
    	
	'######### 리그 리스트를 불러옴                 ################	

	Call dfeventSql.RetrieveEvent_Login(dfDBConn.Conn,  reqRound)


	IF dfeventSql.RsCount <> 0 Then
	    For i = 0 to dfeventSql.RsCount - 1
            Set dfeventSql1 = new eventSql            
            
            Call dfeventSql1.UpdateEvent_LoginByCode(dfDBConn.Conn, makePassword(6,6), dfeventSql.Rs(i,"EL_IDX"))
            
            Set dfeventSql1 = Nothing 
        Next
	End IF
	
        '-------------------------------------------------------------
        'nLenMin ~ nLenMax 범위 내에서 임의 숫자를 산출한다.
        '랜덤 숫자를 산출하는 makeRand 사용자 정의 함수를 사용한다.
        '-------------------------------------------------------------

        public function makePassword(nLenMin, nLenMax)

            Dim idx, nEnd, nStat, resultStr

            nEnd = makeRand(nLenMin, nLenMax)
            resultStr = ""

            for idx=1 to nEnd
                nStat = makeRand(1,2)
                select case nStat
                    case 0 : resultStr = resultStr & Chr(makeRand(Asc("a"),Asc("z")))
                    case 1 : resultStr = resultStr & Chr(makeRand(Asc("A"),Asc("Z")))                            
                    case 2 : resultStr = resultStr & Chr(makeRand(Asc("0"),Asc("9")))
                end select
            next

            makePassword = resultStr

        end function
        '-------------------------------------------------------------
        'nMin ~ nMax 범위 내에서 임의 숫자를 산출한다.
        '-------------------------------------------------------------
        public function makeRand(nMin, nMax)

            Randomize

            makeRand = Int((nMax - nMin + 1) * Rnd + nMin)

        end function 	
%>
<script type="text/javascript">
alert("인증코드가 업데이트 되었습니다.");
parent.location.reload();
</script>