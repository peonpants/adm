<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<%
Response.CacheControl	= "no-cache"
Response.Expires		= -1
Response.Buffer			= true
Response.ContentType	="text/html"
Response.CharSet		= "euc-kr"
Response.AddHeader "pragma","no-cache"

CONST CURRENT_USER = False
CONST GAME_ALRAM = True
COnST SMS_USE = True
CONST KR_LEAGUE = True
CONST USER_LEVEL_BET_USE = True

CONST SITE_NAME= "all"
%>