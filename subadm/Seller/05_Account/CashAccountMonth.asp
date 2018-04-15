<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/seller/05_Account/_Sql/accountSql.Class.asp"-->
<!-- #include virtual="/seller/01_CP/_Sql/cpSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->

<%
    
	

    '######### Request Check                    ################	    

	reqLDD_DATE     = Trim(dfRequest.Value("LDD_DATE"))
    
    IF reqLDD_DATE = "" Then
        reqLDD_DATE = right("000" & year(date)  , 4) & "-" & right("0" & month(date) , 2)
    End IF

	sStartDate     = Trim(dfRequest.Value("sStartDate"))
	sEndDate       = Trim(dfRequest.Value("sEndDate"))
	
	site        = SESSION("rJOBSITE")
   
    '######### 디비 연결                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
    
    
    	
	'######### 정산 리스트를 불러옴                 ################
   
	Call dfAccountSql.RetrieveLOG_DAILY_DATA_STAT_SUB2(dfDBConn.Conn, sStartDate, sEndDate, site)
'dfAccountSql.debug
	IF dfAccountSql.RsCount <> 0 Then
	    nTotalCnt = dfAccountSql.RsOne("TC")
	Else
	    nTotalCnt = 0
	End IF

    ALL_LDD_CASHIN = 0        
    ALL_LDD_CASHOUT = 0
    ALL_LDD_USERMONEY = 0
    ALL_LDD_BATIN = 0
    ALL_LDD_BATOUT = 0
    ALL_LDD_ADD_POINT = 0
    ALL_LDD_SUB_POINT = 0
    ALL_LDD_BOARD_CUSTOM_COUNT = 0
    ALL_LDD_BOARD_FREE_COUNT = 0
    ALL_LDD_USER_COUNT = 0
	ALL_LDD_CASHCANCEL = 0
    ALL_LDD_BATCANCEL = 0

    ALL_LDD_BATINSPORTS = 0
    ALL_LDD_BATOUTSPORTS = 0
    ALL_LDD_BATINALLLIVE = 0
    ALL_LDD_BATOUTALLLIVE = 0
    ALL_LDD_BATINLIVE = 0
    ALL_LDD_BATOUTLIVE = 0
    ALL_LDD_BATINDAL = 0
    ALL_LDD_BATOUTDAL = 0
    ALL_LDD_BATINDARI = 0
    ALL_LDD_BATOUTDARI = 0
    ALL_LDD_BATINPOWER = 0
    ALL_LDD_BATOUTPOWER = 0
    ALL_LDD_BATINPOWER = 0
    ALL_LDD_BATOUTPOWER = 0
	ALL_LDD_BATINALADIN = 0
	ALL_LDD_BATOUTALADIN = 0	
	ALL_LDD_BATINHIGH = 0
	ALL_LDD_BATOUTHIGH = 0				
	ALL_LDD_BATINVIRTUALS = 0
	ALL_LDD_BATOUTVIRTUALS = 0		
	ALL_LDD_BATINBANGU = 0
	ALL_LDD_BATOUTBANGU = 0			
	ALL_LDD_BATINDICE = 0
	ALL_LDD_BATOUTDICE = 0			
	ALL_LDD_BATINPOWERS = 0
	ALL_LDD_BATOUTPOWERS = 0		

%>    
<html>
<head>
<title>날짜별 현황</title>
<!-- #include virtual="/Inc_Month.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<link rel="stylesheet" type="text/css" href="/_Common/inc/Css/Style2.css">
<script src="/Sc/Base.js"></script>
</head>
<body>

<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td><b class="text07"> 날짜별 현황 NEW</b></td>
    
</tr>
</table>    
<table  border="0" cellspacing="2" cellpadding="5" width="100%">
<form name="frm" method="get" action="">
<tr>    
	<td width="500"></td>
    <td width="70" align="right" style="padding-top:4;" class=text4 rowspan="3"><b>기간 : </b>&nbsp;&nbsp;</td>
	<td width="200">
		<font color="#000000" style="font-size:12px;" > 
			<div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:135;display:none;position: absolute; z-index: 99"></div>
			<input type="text" name="sStartDate" value="<%=REQUEST("sStartDate")%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:70" class="input">
			<img src="blank.gif" border="0" width="1" height="1">~<img src="blank.gif" border="0" width="1" height="1">
			<input type="text" name="sEndDate" value="<%=REQUEST("sEndDate")%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:70" class="input">
		</font>				
	</td>
	<td width="65"><input type="submit" value="검색"></td>
</tr>
</form>
</table>    
<div style="height:10px;"></div>

<table width="100%" border="0" cellpadding="0" cellspacing="1"  bgcolor="#AAAAAA">
<tr height="25" bgcolor="#EEEEEE"> 
    <td align="center" >날짜</td>
    <td align="center" >싸이트</td>
    <td width="1" bgcolor="AAAAAA"></td> 
    <td align="center" >충전</td>
    <td align="center" >환전</td>
    <td align="center" >차액</td>
    <td width="1" bgcolor="AAAAAA"></td>      
    <td align="center" >배팅금액</td>
	<td align="center" >배팅배당</td> 
    <td align="center" >스포츠배팅</td>
	<td align="center" >스포츠배당</td>
    <td align="center" >실시간(전체)배팅</td>
	<td align="center" >실시간(전체)배당</td>
    <td align="center" >사다리배팅</td>
	<td align="center" >사다리배당</td>
	<td align="center" >달팽이배팅</td>
	<td align="center" >달팽이배당</td>
	<td align="center" >다리다리배팅</td>
	<td align="center" >다리다리배당</td>
	<td align="center" >파워볼배팅</td>
	<td align="center" >파워볼배당</td>
	<td align="center" >알라딘배팅</td>
	<td align="center" >알라딘배당</td>
	<td align="center" >로하이배팅</td>
	<td align="center" >로하이배당</td>
	<td align="center" >가상축구배팅</td>
	<td align="center" >가상축구배당</td>
	<td align="center" >방구차사다리배팅</td>
	<td align="center" >방구차사다리배당</td>
	<td align="center" >주사위배팅</td>
	<td align="center" >주사위배당</td>
	<td align="center" >파워볼사다리배팅</td>
	<td align="center" >파워볼사다리배당</td>
	<td width="1" bgcolor="AAAAAA"></td>  
    <td align="center" >환전취소금액</td>
    <td align="center" >배팅취소금액</td>
  </tr>
<%
	For i = 0 to dfAccountSql.RsCount -1
	    if i mod 2 = 1 Then
	        trBgColor = "#EEEEEE"
	    Else
	        trBgColor = "#ffffff"
	    End IF
	    
	    LDD_CASH = CDBL(dfAccountSql.Rs(i,"LDD_CASHIN")) - CDBL(dfAccountSql.Rs(i,"LDD_CASHOUT"))
	    IF LDD_CASH > 0 Then
	        LDD_CASH = "<font color='blue'>"&FormatNumber(LDD_CASH,0)&"원</font>"
	    ElseIF LDD_CASH < 0 Then
	        LDD_CASH = "<font color='red'>"&FormatNumber(LDD_CASH,0)&"원</font>"
        Else
            LDD_CASH = FormatNumber(LDD_CASH,0) &"원"
	    End If


%>  
<tr height="25" bgcolor="<%= trBgColor %>"> 
    <td align="center"><%= dfAccountSql.Rs(i,"LDD_DATE") %></td>    
    <td align="center"><%= dfAccountSql.Rs(i,"LDD_SITE") %></td>    
    <td width="1" bgcolor="AAAAAA"></td>  
    <td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_CASHIN"),0) %>원</td>    
    <td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_CASHOUT"),0) %>원</td>    
    <td align="right" bgcolor="#FFDBE6"><%= LDD_CASH %></td>    
    <td width="1" bgcolor="AAAAAA"></td>       
    <td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATOUT"),0) %>원</td>    
    <td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATIN"),0) %>원</td>  
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATOUTSPORTS"),0) %>원</td>  
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATINSPORTS"),0) %>원</td>  
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATOUTALLLIVE"),0) %>원</td> 
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATINALLLIVE"),0) %>원</td>  
 	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATOUTLIVE"),0) %>원</td>
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATINLIVE"),0) %>원</td>  
 	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATOUTDAL"),0) %>원</td>   
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATINDAL"),0) %>원</td>  
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATOUTDARI"),0) %>원</td>  
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATINDARI"),0) %>원</td>  
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATOUTPOWER"),0) %>원</td> 
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATINPOWER"),0) %>원</td>  
 	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATOUTALADIN"),0) %>원</td> 
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATINALADIN"),0) %>원</td>  
 	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATOUTHIGH"),0) %>원</td>  
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATINHIGH"),0) %>원</td>  
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATOUTVIRTUALS"),0) %>원</td>  
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATINVIRTUALS"),0) %>원</td>  
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATOUTBANGU"),0) %>원</td>  
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATINBANGU"),0) %>원</td>  
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATOUTDICE"),0) %>원</td>  
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATINDICE"),0) %>원</td>  
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATOUTPOWERS"),0) %>원</td>  
	<td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATINPOWERS"),0) %>원</td>  
	<td width="1" bgcolor="AAAAAA"></td>       
    <td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_CASHCANCEL"),0) %>원</td>    
    <td align="right"><%= FormatNumber(dfAccountSql.Rs(i,"LDD_BATCANCEL"),0) %>원</td>  
</tr>
<%
        ALL_LDD_CASHIN = ALL_LDD_CASHIN + dfAccountSql.Rs(i,"LDD_CASHIN")
        ALL_LDD_CASHOUT = ALL_LDD_CASHOUT + dfAccountSql.Rs(i,"LDD_CASHOUT")
        ALL_LDD_USERMONEY = ALL_LDD_USERMONEY + dfAccountSql.Rs(i,"LDD_USERMONEY")
        ALL_LDD_BATIN = ALL_LDD_BATIN + dfAccountSql.Rs(i,"LDD_BATIN")
        ALL_LDD_BATOUT = ALL_LDD_BATOUT + dfAccountSql.Rs(i,"LDD_BATOUT")
        ALL_LDD_ADD_POINT = ALL_LDD_ADD_POINT + dfAccountSql.Rs(i,"LDD_ADD_POINT")
        ALL_LDD_SUB_POINT = ALL_LDD_SUB_POINT+ dfAccountSql.Rs(i,"LDD_SUB_POINT")
        ALL_LDD_BOARD_CUSTOM_COUNT = ALL_LDD_BOARD_CUSTOM_COUNT+ dfAccountSql.Rs(i,"LDD_BOARD_CUSTOM_COUNT")
        ALL_LDD_BOARD_FREE_COUNT = ALL_LDD_BOARD_FREE_COUNT+ dfAccountSql.Rs(i,"LDD_BOARD_FREE_COUNT")
        ALL_LDD_USER_COUNT = ALL_LDD_USER_COUNT+ dfAccountSql.Rs(i,"LDD_USER_COUNT")
		ALL_LDD_CASHCANCEL = ALL_LDD_CASHCANCEL + dfAccountSql.Rs(i,"LDD_CASHCANCEL")
		ALL_LDD_BATCANCEL = ALL_LDD_BATCANCEL + dfAccountSql.Rs(i,"LDD_BATCANCEL")

		ALL_LDD_BATINSPORTS = ALL_LDD_BATINSPORTS + dfAccountSql.Rs(i,"LDD_BATINSPORTS")
		ALL_LDD_BATOUTSPORTS =ALL_LDD_BATOUTSPORTS + dfAccountSql.Rs(i,"LDD_BATOUTSPORTS")
		ALL_LDD_BATINALLLIVE =ALL_LDD_BATINALLLIVE + dfAccountSql.Rs(i,"LDD_BATINALLLIVE")
		ALL_LDD_BATOUTALLLIVE =ALL_LDD_BATOUTALLLIVE + dfAccountSql.Rs(i,"LDD_BATOUTALLLIVE")
		ALL_LDD_BATINLIVE =ALL_LDD_BATINLIVE + dfAccountSql.Rs(i,"LDD_BATINLIVE")
		ALL_LDD_BATOUTLIVE =ALL_LDD_BATOUTLIVE + dfAccountSql.Rs(i,"LDD_BATOUTLIVE")
		ALL_LDD_BATINDAL =ALL_LDD_BATINDAL + dfAccountSql.Rs(i,"LDD_BATINDAL")
		ALL_LDD_BATOUTDAL =ALL_LDD_BATOUTDAL + dfAccountSql.Rs(i,"LDD_BATOUTDAL")
		ALL_LDD_BATINDARI =ALL_LDD_BATINDARI + dfAccountSql.Rs(i,"LDD_BATINDARI")
		ALL_LDD_BATOUTDARI =ALL_LDD_BATOUTDARI + dfAccountSql.Rs(i,"LDD_BATOUTDARI")
		ALL_LDD_BATINPOWER =ALL_LDD_BATINPOWER + dfAccountSql.Rs(i,"LDD_BATINPOWER")
		ALL_LDD_BATOUTPOWER =ALL_LDD_BATOUTPOWER + dfAccountSql.Rs(i,"LDD_BATOUTPOWER")
		ALL_LDD_BATINPOWER =ALL_LDD_BATINPOWER + dfAccountSql.Rs(i,"LDD_BATINPOWER")
		ALL_LDD_BATOUTPOWER =ALL_LDD_BATOUTPOWER + dfAccountSql.Rs(i,"LDD_BATOUTPOWER")
		ALL_LDD_BATINALADIN =ALL_LDD_BATINALADIN + dfAccountSql.Rs(i,"LDD_BATINALADIN")
		ALL_LDD_BATOUTALADIN =ALL_LDD_BATOUTALADIN + dfAccountSql.Rs(i,"LDD_BATOUTALADIN")	
		ALL_LDD_BATINHIGH =ALL_LDD_BATINHIGH + dfAccountSql.Rs(i,"LDD_BATINHIGH")
		ALL_LDD_BATOUTHIGH =ALL_LDD_BATOUTHIGH + dfAccountSql.Rs(i,"LDD_BATOUTHIGH")			
		ALL_LDD_BATINVIRTUALS =ALL_LDD_BATINVIRTUALS + dfAccountSql.Rs(i,"LDD_BATINVIRTUALS")
		ALL_LDD_BATOUTVIRTUALS =ALL_LDD_BATOUTVIRTUALS + dfAccountSql.Rs(i,"LDD_BATOUTVIRTUALS")		
		ALL_LDD_BATINBANGU =ALL_LDD_BATINBANGU + dfAccountSql.Rs(i,"LDD_BATINBANGU")
		ALL_LDD_BATOUTBANGU =ALL_LDD_BATOUTBANGU + dfAccountSql.Rs(i,"LDD_BATOUTBANGU")			
		ALL_LDD_BATINDICE =ALL_LDD_BATINDICE + dfAccountSql.Rs(i,"LDD_BATINDICE")
		ALL_LDD_BATOUTDICE =ALL_LDD_BATOUTDICE + dfAccountSql.Rs(i,"LDD_BATOUTDICE")			
		ALL_LDD_BATINPOWERS =ALL_LDD_BATINPOWERS + dfAccountSql.Rs(i,"LDD_BATINPOWERS")
		ALL_LDD_BATOUTPOWERS =ALL_LDD_BATOUTPOWERS + dfAccountSql.Rs(i,"LDD_BATOUTPOWERS")	
        
    Next
%>  
<tr height="25" style="background:#000;color:#fff"> 
    <td style="background:#000;color:#fff" align="center">Total</td>    
    <td></td>   
    <td width="1"></td>   
    <td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_CASHIN,0) %>원</td>    
    <td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_CASHOUT,0) %>원</td>    
    <td style="background:#000;color:#fff;font-weight:bold;"  align="right" ><% response.write FormatNumber((ALL_LDD_CASHIN) -(ALL_LDD_CASHOUT),0) %>원</td>    
    <td width="1"></td>         
    <td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATOUT,0) %>원</td>    
    <td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATIN,0) %>원</td>  
    <td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATOUTSPORTS,0) %>원</td>    
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATINSPORTS,0) %>원</td>  
    <td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATOUTALLLIVE,0) %>원</td>  
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATINALLLIVE,0) %>원</td> 
    <td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATOUTLIVE,0) %>원</td>  
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATINLIVE,0) %>원</td> 
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATOUTDAL,0) %>원</td>  
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATINDAL,0) %>원</td> 
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATOUTDARI,0) %>원</td>  
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATINDARI,0) %>원</td> 
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATOUTPOWER,0) %>원</td>  
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATINPOWER,0) %>원</td> 
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATOUTALADIN,0) %>원</td>  
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATINALADIN,0) %>원</td> 
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATOUTHIGH,0) %>원</td>  
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATINHIGH,0) %>원</td> 
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATOUTVIRTUALS,0) %>원</td>  
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATINVIRTUALS,0) %>원</td> 
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATOUTBANGU,0) %>원</td>  
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATINBANGU,0) %>원</td> 
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATOUTDICE,0) %>원</td>  
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATINDICE,0) %>원</td> 
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATOUTPOWERS,0) %>원</td>  
	<td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATINPOWERS,0) %>원</td> 

	<td width="1"></td>         
    <td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_CASHCANCEL,0) %>원</td>    
    <td style="background:#000;color:#fff"  align="right" ><%= FormatNumber(ALL_LDD_BATCANCEL,0) %>원</td>  
</tr>
</body>
</html>
      