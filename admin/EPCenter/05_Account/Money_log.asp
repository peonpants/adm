<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/05_Account/_Sql/accountSql.Class.asp"-->
<!-- #include virtual="/EPCenter/01_CP/_Sql/cpSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%

    pageSize      = 500             
    page            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999) 
	sStartDate     = Trim(dfRequest.Value("sStartDate"))
	sEndDate       = Trim(dfRequest.Value("sEndDate"))

    IF sEndDate <> "" Then
        sEndDate = sEndDate & " 23:59"
    End IF
    
	'response.write sStartDate & "<br>"
	'response.write sEndDate
	'response.end
    'IF sStartDate = "" Then
       'sStartDate = 2011-12-09 
       'sStartDate = sStartDate & " 00:00"
   ' End IF
    
    'RESPONSE.Write sStartDate
    'RESPONSE.END
    
	IF Trim(dfRequest.Value("JOBSITE")) = "" Then
		site        = request.Cookies("JOBSITE")
	Else
		site        = Trim(dfRequest.Value("JOBSITE"))
	End IF

	
	
    '######### ��� ����                    ################	
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()	
    
	'######### �׷캰 ���� ����Ʈ�� �ҷ���	################
	Call dfCpSql.RetrieveINFO_ADMIN(dfDBConn.Conn, request.Cookies("GROUP"), request.Cookies("AdminLevel"))

    	
	'######### ���� ����Ʈ�� �ҷ���                 ################
   
	Call dfAccountSql.RetrieveLog_AdjustByDay1(dfDBConn.Conn, page, pageSize, sStartDate, sEndDate, site)

	IF dfAccountSql.RsCount <> 0 Then
	    nTotalCnt = dfAccountSql.RsOne("TC")
	Else
	    nTotalCnt = 0
	End IF

		
    '--------------------------------
	'   Page Navigation
	'--------------------------------
	Dim objPager
	Set objPager = New Pager
	
	objPager.RecordCount = nTotalCnt
	objPager.PageIndexVariableName = "page"
	objPager.NumericButtonFormatString = "{0}"
	objPager.PageButtonCount = 5
	objPager.PageSize = pageSize
	objPager.NumericButtonCssClass = "paging"
	objPager.SelectedNumericButtonCssClass = "paging_crnt"
	objPager.NavigateButtonCssClass = "paging_txt1"
	objPager.CurrentPageIndex = page
	objPager.NumericButtonDelimiter = "<span class=""paging_txt2"">|</span>"
	objPager.NavigationButtonDelimiter = "<span class=""paging_txt2"">|</span>"
	objPager.NavigationShortCut = false
		
%>

<html>
<head>
<title>��¥�� ��Ȳ</title>
<!-- #include virtual="/Inc_Month.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/_Common/inc/Css/Style2.css">
<script src="/Sc/Base.js"></script>
</head>
<body >
<font color="red"><b>***�ݵ�� �˻��ϰ��� �ϴ� ��¥�� �����ؼ� ������ Ȯ���ϼ���(�ǾƷ� ��������¥�� �ε����� 500�� �Ѿ�� ��Ȯ�� �ݾ׻����� �Ұ��մϴ�)**</b></font></br>
<font color="red"><b>***���ñݾ׻����� ���ñݾ�-������ұݾ��� Ȯ���ϼž� �մϴ�. ���ñݾ��� ������ұݾ��� �������� �ʽ��ϴ�**</b></font></br>
<font color="red"><b>***�����Ӵϴ� ������ �Ұ��մϴ�. **</b></font></br>
<font color="red"><b>***�ѹ��˻��� 1�а����� �ð��� �ҿ�ǹǷ� �˻��� ��ٷ��ֽñ� �ٶ��ϴ�**</b></font></br>
<form name="frm" method="get" action="">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="list0" style=table-layout:fixed> 
    <tr><td align="left" width="40%"><strong>&nbsp;&nbsp;��¥�� ��Ȳ</strong></td></tr>
	<tr>
      <td > 
		<table width="100%" border="0" cellpadding="10" cellspacing="1">
		    <td>
		        <table width="500" border="0" align="right" cellpadding="0" cellspacing="0" >
		          <tr height="25">
					<%
						IF dfCpSql.RsCount <> 0 Then
					%>
				    <td width="170" align="right" style="padding-top:10;" class=text4 rowspan="3"><b>���� ����Ʈ : </b>

					<select name="jobsite">
					<%
							For i = 0 to dfCpSql.RsCount - 1

								if site = dfCpSql.Rs(i,"IA_SITE") Then
									selected = "selected"
								Else
									selected = ""
								End IF
					%>
						<option value="<%= dfCpSql.Rs(i,"IA_SITE") %>" <%= selected %>><%= dfCpSql.Rs(i,"IA_SITE") %></option>
					<%
							Next
					%>
					</select>
					</td>
					<%
							
						End IF
					%>
		            <td width="70" align="right" style="padding-top:4;" class=text4 rowspan="3"><b>�Ⱓ : </b>&nbsp;&nbsp;</td>
	                <td width="200">
		                <font color="#000000" style="font-size:12px;" > 
		                    <div id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:135;display:none;position: absolute; z-index: 99"></div>
		                    <input type="text" name="sStartDate" value="<%=REQUEST("sStartDate")%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:70" class="input">
		                    <img src="blank.gif" border="0" width="1" height="1">~<img src="blank.gif" border="0" width="1" height="1">
		                    <input type="text" name="sEndDate" value="<%=REQUEST("sEndDate")%>" OnClick="MiniCal(this);" readonly style="text-align:center; font:menu; width:70" class="input">
		                </font>			
		            </td>
		            <td width="65"><input type="submit" value="�˻�"></td>
		          </tr>
		        </table>	
				</form>
		    </td>
		</table>
	  </td>
    </tr>

    <tr> 
      <td>
      
        <!-- ���̺� ��� ���� -->
        <table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="#6C6C6C">
            <tr>
                <td width="40"  height="31" style="background-image:url('/images/bg2.jpg'); background-repeat:repeat-x; padding-top:6;" align="center" class=text2>��ȣ</td>
                <td width="100" style="background-image:url('/images/bg2.jpg'); background-repeat:repeat-x; padding-top:6;" align="center" class=text2>��¥</td>
                <td width="100" style="background-image:url('/images/bg2.jpg'); background-repeat:repeat-x; padding-top:6;" align="center" class=text2>����Ʈ</td>
                <td width="100" style="background-image:url('/images/bg2.jpg'); background-repeat:repeat-x; padding-top:6;" align="center" class=text2>�Ա�</td>
                <td width="100" style="background-image:url('/images/bg2.jpg'); background-repeat:repeat-x; padding-top:6;" align="center" class=text2>���</td>
                <td style="background-image:url('/images/bg2.jpg'); background-repeat:repeat-x; padding-top:6;" align="center" class=text2>����</td>
                <td width="100" style="background-image:url('/images/bg2.jpg'); background-repeat:repeat-x; padding-top:6;" align="center" class=text2>�Ϻ�����ݾ�</td>
                <td width="100" style="background-image:url('/images/bg2.jpg'); background-repeat:repeat-x; padding-top:6;" align="center" class=text2>���ñݾ�</td>
				<td width="100" style="background-image:url('/images/bg2.jpg'); background-repeat:repeat-x; padding-top:6;" align="center" class=text2>���ù��</td>
                <td width="100" style="background-image:url('/images/bg2.jpg'); background-repeat:repeat-x; padding-top:6;" align="center" class=text2>�������</td>
            </tr>                        
<%
    IF dfAccountSql.RsCount = 0 Then
%>

    <tr><td align="center" colspan="7" height="35">������ �����ϴ�.</td></tr>

<%
	ELSE
    NN  = 0
    TEMPDAY = dfAccountSql.Rs(0, "D1")
    STARTDAY = dfAccountSql.Rs(0, "D1")
    TEMPCASHIN = 0
    TEMPCASHOUT = 0
    TEMPUSERMONEY = 0
    TEMPBATIN = 0
    TEMPBATOUT1 = 0
    TEMPBATOUT2 = 0
    TEMPBATOUT = 0
	TEMPADMINMONEY = 0
    
    ALLCASHIN = 0
    ALLCASHOUT = 0
    ALLUSERMONEY = 0
    ALLBATIN = 0
    ALLBATOUT = 0
    ALLBATOUT1 = 0
    ALLBATOUT2 = 0
	ALLADMINMONEY = 0
    
	    FOR i = 0 TO dfAccountSql.RsCount -1
    		
		    D1		    = dfAccountSql.Rs(i, "D1")
		    L1      	= dfAccountSql.Rs(i, "L1")
		    CASHIN	    = CDbl(dfAccountSql.Rs(i, "CASHIN"))
		    CASHOUT 	= CDbl(dfAccountSql.Rs(i, "CASHOUT"))
		    USERMONEY	= CDbl(dfAccountSql.Rs(i, "USERMONEY"))
		    BATIN		= CDbl(dfAccountSql.Rs(i, "BATIN"))
			BATOUT1		= CDbl(dfAccountSql.Rs(i, "BATOUT1"))
			BATOUT2		= CDbl(dfAccountSql.Rs(i, "BATOUT2"))
			BATOUT		= ABS(BATOUT1) - ABS(BATOUT2)
		    ADMINMONEY		= CDbl(dfAccountSql.Rs(i, "ADMINMONEY"))

            
    	
	        IF D1 <> TEMPDAY THEN
%>
                <tr>
                    <td bgcolor="#CC8800" height="30" style="padding-top:4;" align="center" class=text2 colspan=3><%=TEMPDAY%></td>
                    <td bgcolor="#668800" width="100" style="padding-top:4;" align="center" class=text2><%=FORMATNUMBER(TEMPCASHIN,0)%>��</td>
                    <td bgcolor="#668800" style="padding-top:4;" align="center" class=text2><%=FORMATNUMBER(TEMPCASHOUT,0)%>��</td>
                    <td bgcolor="#668800" width="100" style="padding-top:4;" align="center" <% IF (TEMPCASHIN + TEMPCASHOUT) < 0 THEN %> class=text5 <% ELSE %> class=text2 <% END IF %> ><%=FORMATNUMBER(TEMPCASHIN + TEMPCASHOUT,0)%>��</td>
                   <!-- <td bgcolor="#668800" width="100" style="padding-top:4;" align="center" class=text2><%=FORMATNUMBER(TEMPUSERMONEY,0)%>��</td>
                    <td bgcolor="#668800" width="100" style="padding-top:4;" align="center" <% IF (-TEMPBATIN - TEMPBATOUT) < 0 THEN %> class=text5 <% ELSE %> class=text2 <% END IF %> >
                    <%=FORMATNUMBER(-TEMPBATIN - TEMPBATOUT,0)%>��</td>-->
					<td bgcolor="#668800" width="100" style="padding-top:4;" align="center" <% IF (TEMPBATIN) < 0 THEN %> class=text5 <% ELSE %> class=text2 <% END IF %> >
                    <%=abs(FORMATNUMBER(TEMPBATOUT1,0))-abs(FORMATNUMBER(TEMPBATOUT2,0))-abs(FORMATNUMBER(TEMPBATIN,0)) %>��</td>
                    <td bgcolor="#668800" width="100" style="padding-top:4;" align="center" <% IF (TEMPBATOUT1) < 0 THEN %> class=text5 <% ELSE %> class=text2 <% END IF %> >
                    <%=abs(FORMATNUMBER(TEMPBATOUT1,0)) %>��</td>
                    <td bgcolor="#668800" width="100" style="padding-top:4;" align="center" <% IF (TEMPBATOUT2) < 0 THEN %> class=text5 <% ELSE %> class=text2 <% END IF %> >
                    <%=abs(FORMATNUMBER(TEMPBATIN,0)) %>��</td>
					<td bgcolor="#668800" width="100" style="padding-top:4;" align="center" <% IF (TEMPBATOUT2) < 0 THEN %> class=text5 <% ELSE %> class=text2 <% END IF %> >
                    <%=abs(FORMATNUMBER(TEMPBATOUT2,0)) %>��</td>
                </tr>
                <tr><td bgcolor="#FFFFFF" height="20" style="padding-top:4;" align="right" class=text4 colspan=10></td></tr>
                <tr><td bgcolor="#000000" height="2" style="padding-top:4;" align="right" class=text4 colspan=10></td></tr>
<%     
                TEMPCASHIN = 0
                TEMPCASHOUT = 0
                TEMPUSERMONEY = 0
				TEMPBATOUT1 = 0
				TEMPBATOUT2 = 0
                TEMPBATIN = 0
                TEMPBATOUT = 0
                TEMPDAY = D1
                TEMPADMINMONEY = 0

            END IF
            
            
            NN = NN + 1
            TEMPCASHIN = TEMPCASHIN + CASHIN
            TEMPCASHOUT = TEMPCASHOUT + CASHOUT
            TEMPUSERMONEY = TEMPUSERMONEY + USERMONEY
            TEMPBATIN = TEMPBATIN + BATIN
            TEMPBATOUT1 = TEMPBATOUT1 + BATOUT1
            TEMPBATOUT2 = TEMPBATOUT2 + BATOUT2
			TEMPBATOUT = TEMPBATOUT + BATOUT
			TEMPADMINMONEY = TEMPADMINMONEY + ADMINMONEY
            
            ALLCASHIN = ALLCASHIN + CASHIN
            ALLCASHOUT = ALLCASHOUT + CASHOUT
            IF TEMPUSERMONEY > ALLUSERMONEY THEN
                ALLUSERMONEY = TEMPUSERMONEY
            END IF
            ALLBATIN = ALLBATIN + BATIN
            ALLBATOUT1 = ALLBATOUT1 + BATOUT1
            ALLBATOUT2 = ALLBATOUT2 + BATOUT2
%>


            <tr>
                <td bgcolor="#FFFFFF" width="40"  height="20" style="padding-top:4;" align="center" class=text4><%=NN%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:4;" align="center" class=text4><%=D1%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:4;" align="center" class=text4><%=replace(L1,"acewin","aplus")%></td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:4;" align="center" class=text4><%=FORMATNUMBER(CASHIN,0)%>��</td>
                <td bgcolor="#FFFFFF" style="padding-top:4;" align="center" class=text4><%=FORMATNUMBER(CASHOUT,0)%>��</td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:4;" align="center" <% IF (CASHIN + CASHOUT) < 0 THEN %> class=text5 <% ELSE %> class=text4 <% END IF %> ><%=FORMATNUMBER(CASHIN + CASHOUT,0)%>��</td>
                <!--<td bgcolor="#FFFFFF" width="100" style="padding-top:4;" align="center" class=text4><%=FORMATNUMBER(USERMONEY,0)%>��</td>
                <td bgcolor="#FFFFFF" width="100" style="padding-top:4;" align="center" <% IF (-BATIN - BATOUT) < 0 THEN %> class=text5 <% ELSE %> class=text4 <% END IF %> ><%=FORMATNUMBER(-BATIN - BATOUT,0)%>��</td>-->
				<td bgcolor="#FFFFFF" width="100" style="padding-top:4;" align="center" <% IF (BATIN) < 0 THEN %> class=text5 <% ELSE %> class=text4 <% END IF %> ><%=FORMATNUMBER(Abs(BATOUT1)-Abs(BATOUT2)-Abs(BATIN),0)%>��</td>
				<td bgcolor="#FFFFFF" width="100" style="padding-top:4;" align="center" <% IF (BATOUT1) < 0 THEN %> class=text5 <% ELSE %> class=text4 <% END IF %> ><%=FORMATNUMBER(Abs(BATOUT1),0)%>��</td>
				<td bgcolor="#FFFFFF" width="100" style="padding-top:4;" align="center" <% IF (BATOUT1) < 0 THEN %> class=text5 <% ELSE %> class=text4 <% END IF %> ><%=FORMATNUMBER(Abs(BATIN),0)%>��</td>
				<td bgcolor="#FFFFFF" width="100" style="padding-top:4;" align="center" <% IF (BATOUT2) < 0 THEN %> class=text5 <% ELSE %> class=text4 <% END IF %> ><%=FORMATNUMBER(Abs(BATOUT2),0)%>��</td>
            </tr>
            
            <% IF NN = dfAccountSql.RsCount THEN %>
            <tr>
                <td bgcolor="#CC8800" height="30" style="padding-top:4;" align="center" class=text2 colspan=3><%=TEMPDAY%></td>
                <td bgcolor="#668800" width="100" style="padding-top:4;" align="center" class=text2><%=FORMATNUMBER(TEMPCASHIN,0)%>��</td>
                <td bgcolor="#668800" style="padding-top:4;" align="center" class=text2><%=FORMATNUMBER(TEMPCASHOUT,0)%>��</td>
                <td bgcolor="#668800" width="100" style="padding-top:4;" align="center" <% IF (TEMPCASHIN + TEMPCASHOUT) < 0 THEN %> class=text5 <% ELSE %> class=text2 <% END IF %> ><%=FORMATNUMBER(TEMPCASHIN + TEMPCASHOUT,0)%>��</td>

                <td bgcolor="#668800" width="100" style="padding-top:4;" align="center" <% IF (TEMPBATIN) < 0 THEN %> class=text5 <% ELSE %> class=text2 <% END IF %> >
				<%=abs(FORMATNUMBER(TEMPBATOUT1,0))-abs(FORMATNUMBER(TEMPBATOUT2,0))-abs(FORMATNUMBER(TEMPBATIN,0)) %>��</td>
				<td bgcolor="#668800" width="100" style="padding-top:4;" align="center" <% IF (TEMPBATOUT1) < 0 THEN %> class=text5 <% ELSE %> class=text2 <% END IF %> >
				<%=abs(FORMATNUMBER(TEMPBATOUT1,0)) %>��</td>
				<td bgcolor="#668800" width="100" style="padding-top:4;" align="center" <% IF (TEMPBATOUT2) < 0 THEN %> class=text5 <% ELSE %> class=text2 <% END IF %> >
				<%=abs(FORMATNUMBER(TEMPBATIN,0)) %>��</td>
				<td bgcolor="#668800" width="100" style="padding-top:4;" align="center" <% IF (TEMPBATOUT2) < 0 THEN %> class=text5 <% ELSE %> class=text2 <% END IF %> >
				<%=abs(FORMATNUMBER(TEMPBATOUT2,0)) %>��</td>
            </tr>
            <tr><td bgcolor="#000000" height="2" style="padding-top:4;" align="right" class=text4 colspan=10></td></tr>
            <tr><td bgcolor="#FFFFFF" height="40" style="padding-top:4;" align="center" class=text4 colspan=10>T O T A L</td></tr>
           
            <tr>
                <td bgcolor="#660000" height="30" style="padding-top:4;" align="center" class=text2 colspan=3><%=TEMPDAY%>&nbsp;~&nbsp;<%=STARTDAY%></td>
                <td bgcolor="#660000" width="100" style="padding-top:4;" align="center" class=text2><%=FORMATNUMBER(ALLCASHIN,0)%>��</td>
                <td bgcolor="#660000" style="padding-top:4;" align="center" class=text2><%=FORMATNUMBER(ALLCASHOUT,0)%>��</td>
                <td bgcolor="#660000" width="100" style="padding-top:4;" align="center" class=text2><%=FORMATNUMBER(ALLCASHIN + ALLCASHOUT,0)%>��</td>
                <td bgcolor="#660000" width="100" style="padding-top:4;" align="center" class=text2><%=FORMATNUMBER(abs(ALLBATOUT1)-ALLBATOUT2-ALLBATIN,0)%>��</td>
				<td bgcolor="#660000" width="100" style="padding-top:4;" align="center" class=text2><%=abs(FORMATNUMBER(ALLBATOUT1,0))%>��</td>
                <td bgcolor="#660000" width="100" style="padding-top:4;" align="center" class=text2><%=FORMATNUMBER(ALLBATIN,0)%>��</td>
                <td bgcolor="#660000" width="100" style="padding-top:4;" align="center" class=text2><%=FORMATNUMBER(ALLBATOUT2,0)%>��</td>
            </tr>
            
            
            <% END IF %>
           
            
<%
        Next 
    END IF
%>    

        
        </table>
        <!-- ���̺� ��� �� -->
        
      </td>
    </tr>
</table>
<br clear="all">
<!-- paging Start -->
<%	IF nTotalCnt > 0 THEN	%>
<%= objPager.Render %>
<%	END IF	%>
<!-- paging End -->


</body>
      