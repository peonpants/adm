<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->


<%
	Page			= REQUEST("Page")
	IU_ID			= REQUEST("IU_ID")
	IU_IDX			= CDbl(TRIM(REQUEST("IU_IDX")))

		UPDSQL = "UPDATE INFO_USER SET IU_level = IU_level + 1 WHERE IU_IDX = "& IU_IDX &" "
		DbCon.execute(UPDSQL)

''''''''''''''''''''''''''''''''''등업축하 쪽지'''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''등업축하 쪽지'''''''''''''''''''''''''''''''''''



		BC_TITLE	= "★☆★등업을 축하드립니다★☆★"
		BC_MANAGER	= "관리자"
		BC_WRITER	= IU_ID
		BC_CONTENTS	= "&nbsp;&nbsp;<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;안녕하세요 이벤트 관리자 입니다<br />"
		BC_CONTENTS	= BC_CONTENTS & "<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;회원님이 등업기준에 적합하여 자동등업 되셨습니다<br />"
		BC_CONTENTS	= BC_CONTENTS & "<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;등업혜택은 공지사항의 새로운 등업혜택을 참조해주시기 바라며 등업에"
		BC_CONTENTS	= BC_CONTENTS & "<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;따른 주의사항을 알려드리겠습니다.<br />"
		BC_CONTENTS	= BC_CONTENTS & "<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;1. 레벨업에 따른 새로운 도메인 부여<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;- 등업이 되시면 회원님의 핸드폰으로 새로운 도메인이 부여됩니다.<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;추후 로그인부터는 반드시 발급받으신 도메인으로 즐겨찾기 및 도메인 이용 부탁<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;드립니다.<br />"
		BC_CONTENTS	= BC_CONTENTS & "<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;2. 레벨업에 따른 새로운 계좌부여<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;- 고래는 사이트 보안목적상 각 레벨에 따른 계좌가 자동으로 발급됩니다.<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;회원님의 전용계좌는 충전하기 메뉴에서 충전계좌문의 아이콘을 클릭하시면 자<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;동으로 회원님의 충전계좌가 발급되오니 새로운 충전계좌를 이용해주시기 바랍<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;니다<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;기존 구계좌로 입금시 충전처리가 지연될수있으니 주의하시기 바랍니다<br />"
		BC_CONTENTS	= BC_CONTENTS & "<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;3. 그외 낙첨포인트 지급등의 등급별 혜택은 공지사항의 새로운 등급별 혜택을 참<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;고하시기 바랍니다^^<br />"
		BC_CONTENTS	= BC_CONTENTS & "<br />"
		JOBSITE		= JOBSITE


	
		SQL2 = "INSERT INTO Board_Customer ( BC_WRITER, BC_ID, BC_TITLE, BC_CONTENTS, BC_SITE, BC_MANAGER, BC_REPLY,BC_TYPE) VALUES ( '관리자', "
		SQL2 = SQL2 & "'"&BC_WRITER&"','"&BC_TITLE&"','"&BC_CONTENTS&"','"&JOBSITE&"','"&BC_MANAGER&"', 1,2)"

		DbCon.execute(SQL2)

	
	DbCon.Close
	Set DbCon=Nothing

		        
''''''''''''''''''''''''''''''''''등업축하 쪽지'''''''''''''''''''''''''''''''''''

'	RESPONSE.REDIRECT "View.asp?page="&PAGE&"&IU_IDX="&IU_IDX
	Response.Write "<script language=javascript>"
	Response.Write "history.back();"
	Response.Write "</script>"
	Response.End

%>