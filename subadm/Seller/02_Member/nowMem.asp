<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<%
    nn = 0 
    nn1 = 0
	IA_SITE = Session("rJOBSITE")
	SQLLIST2 = "select top 1 * from info_admin where ia_site = '"&Session("rJOBSITE")&"'"
	SET RS2 = DBCON.EXECUTE(SQLLIST2)

	IA_LEVEL = RS2("IA_LEVEL")
	IA_GROUP = RS2("IA_GROUP")
	IA_GROUP1 = RS2("IA_GROUP1")
	IA_GROUP2 = RS2("IA_GROUP2")
	IA_GROUP3 = RS2("IA_GROUP3")
	IA_GROUP4 = RS2("IA_GROUP4")
	IA_Type = RS2("IA_Type")

	SQLLIST2 = "select  IU_IDX, iu_id, iu_nickName, iu_cash,iu_point, (select top 1 c_dir from realtime_log where iu_id = a.iu_id order by REGDATE desc) as c_dir , IU_LOGIN_CNT, IU_CHARGE, IU_EXCHANGE , IU_SITE from  info_user a where a.iu_id IN (select iu_id from realtime_log) and iu_level <>  9 and iu_site = '"&Session("rJOBSITE")&"' order by iu_site "
	SET RS2 = DBCON.EXECUTE(SQLLIST2)

%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/Seller/Css/Style.css">

</head>
<body topmargin="0" marginheight="0">

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td>
        <b class="text07"> 회원 관리 &nbsp;&nbsp; ▶  현재접속자
	      </b>
    </td>
</tr>
</table>    
<div style="height:10px;"></div>
<table width="900" border="0" acellpadding="3" cellspacing="1" bgcolor="#AAAAAA">
	<tr height='25' bgcolor="#EEEEEE">
	    <td align="center" ><b>번호</b></td>
	    <td align="center" ><b>아이디</b></td>
	    <td align="center" ><b>닉네임</b></td>
	    <td align="center" ><b>위치</b></td>
	    <td align="center" ><b>캐쉬</b></td>
	    <td align="center" ><b>포인트</b></td>
	    <td align="center" ><b>로그인</b></td>
	    <td align="center" ><b>입금</b></td>
	    <td align="center" ><b>출금</b></td>
	    <td align="center" ><b>사이트</b></td>
	    <td align="center" ><b>쪽지</b></td>
	    <td align="center" ><b>배팅</b></td>
	    <td align="center" ><b>게시글</b></td>
	</tr>
<%
    
    		
	IF NOT RS2.EOF Then
        DO WHILE NOT RS2.EOF
            IF Rs2("IU_SITE") = "CLUBTOTO" Then
		        nn = nn + 1		        
            Else
                nn1 = nn1 + 1
            End IF
%>
    <tr bgcolor="#ffffff">
        <td>
<%
            IF Rs2("IU_SITE") = "CLUBTOTO" Then
		        response.Write nn
            Else
                response.Write nn1
            End IF    
%>                
        </td>
        <td><a href="View.asp?IU_IDX=<%= RS2("iu_idx") %>"><%= RS2("IU_ID") %></a></td>
        <td><%= RS2("IU_nickname") %></td>
        <td><%= RS2("c_dir") %></td>
        <td><%= formatNumber(RS2("IU_CASH"),0) %></td>
        <td><%= formatNumber(RS2("IU_POINT"),0) %></td>
        <td><%= formatNumber(RS2("IU_LOGIN_CNT"),0) %></td>
        <td><%= formatNumber(RS2("IU_CHARGE"),0) %></td>     
        <td><%= formatNumber(RS2("IU_EXCHANGE"),0) %></td>                
        <td><%= RS2("IU_SITE") %></td>
        <td><input type="button" value="쪽지" onclick="location.href='Write_Message.asp?cd=<%=RS2("IU_ID")%>&cdi=<%=RS2("IU_IDX")%>'" style="border: 1 solid; background-color:#C5BEBD;"> </td>
        <td><input type="button" value="배팅" onclick="location.href='/Seller/04_Game/Betting_List.asp?Search=IB_ID&Find=<%= RS2("IU_ID") %>'" style="border: 1 solid; background-color:#C5BEBD;"></td>
        <td><input type="button" value="게시글" onclick="location.href='/Seller/08_Board/Board_List.asp?Search=BF_Writer&Find=<%= RS2("IU_nickname") %>'" style="border: 1 solid; background-color:#C5BEBD;"></td>        
    </tr>
<%



		RS2.MOVENEXT
		LOOP
	END IF 

%>
</table>

</body>
</html>
