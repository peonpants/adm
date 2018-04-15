<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/Seller/05_Account/_Sql/accountSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->

<link rel="stylesheet" href="../Includes/bootstrap3.3.2.min.css" type="text/css" />          <!-- ��Ʈ��Ʈ��  ----------------->
<link rel="stylesheet" href="../Includes/bootstrap-theme3.3.2.min.css" type="text/css" />    <!-- ��Ʈ��Ʈ�� �߰��׸� ----------------->
<script src="/js/jquery-1.10.2.min.js" type="text/javascript"></script>						<!-- ��Ʈ��Ʈ��  ----------------->
<script src="../Includes/bootstrap3.3.2.min.js" type="text/javascript"></script>			<!-- ��Ʈ��Ʈ��  ----------------->


<style>
.td_right{
	text-align:right;
}
/*H ���̺� ȣ���� ����*/
.trhover tr:not(:first-child):not(:last-child):hover{
    background-color:#ddf1ff !important;
}

.trhover tr table tr td:hover {
    background-color: #182755 !important;
    color:#ffffff;
    font-weight:bold;
}
.thBoldImp{
	font-weight:bold !important;
}
.trWidth50{
	width:50px;
}
.trWidth100{
	width:100px;
}
.trWidth150{
	width:150px;
}
.aliRight{
	text-align:right;
}
/*H ���̺� ȣ���� ���� ��*/
</style>

<%
	SumDownUserCount = 0		'H �������� ȸ���� �հ��
    page = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("page")), 1, 1, 9999999)
	pageSize = 20
	

	'H �������������� queryString ���� �Ѿ�ð���.. �������������� POST�� �ٽ� �о����� ���� -����
    sStartDate = datevalue(now)  & " 00:00:00"
    sEndDate = datevalue(now) & " 23:59:59" 
	if Request.queryString("Sdate") =""   then
			sStartDate = Request.Form("sStartDate")		
		if isNull(sStartDate)  then
		    sStartDate = datevalue(now)  & " 00:00:00"
		else 
			sStartDate = REPLACE(sStartDate,";","")
			sStartDate = REPLACE(sStartDate,"'","")

			sStartDate = sStartDate & " 00:00:00"

		end if
	else
		sStartDate = Request.queryString("Sdate")
		sStartDate = REPLACE(sStartDate,";","")
		sStartDate = REPLACE(sStartDate,"'","")

	end if
	if Request.queryString("Edate") ="" then
		sEndDate = Request.Form("sEndDate")		
		if isNull(sEndDate)  then
		    sEndDate = datevalue(now) & " 23:59:59" 
		else 
			sEndDate = REPLACE(sEndDate,";","")
			sEndDate = REPLACE(sEndDate,"'","")
			sEndDate = sEndDate & " 23:59:59" 
		end if
	else
		sEndDate = Request("Edate")
		sEndDate = REPLACE(sEndDate,";","")
		sEndDate = REPLACE(sEndDate,"'","")

	end if
	'H �������������� queryString ���� �Ѿ�ð���.. �������������� POST�� �ٽ� �о����� ���� -��

	    pageSize = 500                  
    
	'H �������������� QueryString ���� ���� �׷�� ( Cint = int Ÿ�Կܿ� queryString �ȹް�.. ������ ����)
    Group1 = Cint(Request("g1"))
    Group2 = Cint(Request("g2"))
    Group3 = Cint(Request("g3"))
    Group4 = Cint(Request("g4"))


	'H �α����� ������ ������ ���س���
    SQLLIST2 = "select top 1 * from info_admin where ia_site = '"&Session("rJOBSITE")&"'"
	SET RS2 = DBCON.EXECUTE(SQLLIST2)
	IA_LEVEL = RS2("IA_LEVEL")
	IA_GROUP = RS2("IA_GROUP")
	IA_GROUP1 = RS2("IA_GROUP1")
	IA_GROUP2 = RS2("IA_GROUP2")
	IA_GROUP3 = RS2("IA_GROUP3")
	IA_GROUP4 = RS2("IA_GROUP4")
	RS2.CLOSE
	SET RS2 = Nothing
    
    dfDBConn.SetConn = Application("DBConnString")
	dfDBConn.Connect()  


'H ��ȸ�� �׷췹���� SQL ����Ʈ���� 
'H ��ȸ�� �׷�� �α����� ������ �׷췹���� ���ؼ� ���� �׷���ȸ �Ұ��ϰ� ����� 
addAndS = " "
if Group4 = 0 then
	addAndS = addAndS & ""
else
	addAndS = addAndS & " AND A.ia_group4=" & Group4 & " "
end if
if IA_LEVEL < 4 then
	if Group3 = 0 then
		addAndS = addAndS & ""
	else
		addAndS = addAndS & " AND A.ia_group3=" & Group3 & " "
	end if
else
		addAndS = addAndS & " AND A.ia_group3=" & IA_GROUP3 & " "
end if
if IA_LEVEL < 3 then
	if Group2 = 0 then
		addAndS = addAndS & ""
	else
		addAndS = addAndS & " AND A.ia_group2=" & Group2 & " "
	end if
else
		addAndS = addAndS & " AND A.ia_group2=" & IA_GROUP2 & " "
end if


	    SQL = "SELECT IU_IDX, iu_id, IU_LEVEL, IU_NickName, IU_CASH, IU_POINT, IU_CHARGE , IU_EXCHANGE,  IU_LOGIN_CNT,  (select count(*) from info_betting where ib_id = I.iu_id) AS IU_BETCNT, IU_RegDate, IU_SITE, IU_Status   FROM INFO_USER AS I INNER JOIN INFO_ADMIN AS A ON I.iu_site = A.ia_id WHERE   I.IU_REGDATE > '"& sStartDate &"' AND I.IU_REGDATE < '"& sEndDate &"'  AND A.ia_group1="&Group1&" "& addAndS &"   ORDER BY A.ia_level desc"
 
 

	SET RS1 = DbCon.Execute(SQL)
	If Not(RS1.Eof Or RS1.Bof) then 
		Results = RS1.GetRows()
		resCount = Ubound(Results,2)+1
	End If


%>    
<!-- #include virtual="/_Common/Inc/top.inc.asp"-->
<link rel="stylesheet" href="../Includes/bootstrap3.3.2.min.css" type="text/css" />          <!-- ��Ʈ��Ʈ��  ----------------->
<link rel="stylesheet" href="../Includes/bootstrap-theme3.3.2.min.css" type="text/css" />    <!-- ��Ʈ��Ʈ�� �߰��׸� ----------------->
<script src="/js/jquery-1.10.2.min.js" type="text/javascript"></script>						<!-- ��Ʈ��Ʈ��  ----------------->
<script src="../Includes/bootstrap3.3.2.min.js" type="text/javascript"></script>			<!-- ��Ʈ��Ʈ��  ----------------->
<link rel="stylesheet" href="../css/HberAdmin_Style.css" type="text/css" />			<!-- ��ڸ޴� ��Ÿ�� �׸�  ----------------->




<body topmargin="0" marginheight="0" style="padding:0px 0px 0px 1px;" class="AdminBodyW99">
<div class="MenuLeft_MainDiv2 width100pIMP">
	<div class="MenuLeft_MainInnerDiv width95pIMP">
 


<div style="height:10px;"></div>




<div style="padding:5px;">
<div class="panel panel-default">
	<div class="panel-heading"><span class="txtsh011b" style="color:#adc;"> �� </span><span style="font-size:18px; font-weight:bold;text-shadow:0px 2px 2px #fff;">�Ⱓ�� ���� ȸ�� ����Ʈ </span></div>
	<div class="panel-body"> 


<script type="text/javascript" src="../includes/calendar1.js"></script>
<script type="text/javascript" src="../includes/calendar2.js"></script>
<form name="MainForm" action="Money_Addadmin_NEW_MembeList.asp?g1=<%=Group1%>&g2=<%=Group2%>&g3=<%=Group3%>&g4=<%=Group4%>" method="post" align="center">
�������� :
<div   id=minical OnClick="this.style.display='none';" oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style="background : buttonface; margin: 5; margin-top: 2;border-top: 1 solid buttonhighlight;border-left: 1 solid buttonhighlight;border-right: 1 solid buttonshadow;border-bottom: 1 solid buttonshadow;width:155;display:none;position: absolute; z-index: 99"></div>
	
	<input type="text" name="sStartDate" id="txtDate" value="<%=Left(sStartDate,10)%>" onclick="fnPopUpCalendar(txtDate,txtDate,'yyyy-mm-dd')" class='text_box1'>
	�������� :
	<input type="text" name="sEndDate" id="txtDate2" value="<%=Left(sEndDate,10)%>" onclick="fnPopUpCalendar2(txtDate2,txtDate2,'yyyy-mm-dd')" class='text_box1'>
	<input type="hidden" name="Group1" value="<%=Group1%>"><input type="hidden" name="Group2" value="<%=Group2%>"><input type="hidden" name="Group3" value="<%=Group3%>">
	<button class="btn btn-info btn-xs" type="submit" title="���� ��¥�� ����ȸ���� �˻��մϴ�.">�� ��</button> 


<div style="height:10px;"></div>
	</div>




<div style="padding:0px;margin:0px;border:1px solid #cccccc;">
<table border="0"  cellspacing="1" cellpadding="2" bgcolor="#AAAAAA" width="100%" class=" trhover HberTh HberTableLG" >
  <tr bgcolor="e7e7e7" class="title-backgra" height="40">



		  <th align="center">���̵�
          </th>
		  <th align="center">lv
          </th>
          <th align="left">�г���
          </th>
          <th align="right">���øӴ�
          </th>
          <th class="aliRight">����Ʈ
          </th>
          <th class="aliRight">�Ա�
          </th>
          <th class="aliRight">���
          </th>
          <th align="right">����
          </th>
          <th align="center">�α���
          </th>
          <th align="center">���ü�
          </th>
          <th align="center">�����
          </th>
          <th align="center">����Ʈ
          </th>
          <th align="center">����
          </th>
          <th align="center">����
          </th>
 
		</tr>
		<%		
            IF resCount <> 0 Then
                For i = 0 to resCount-1
					IU_ID = Results(0,i)
					if i mod 2 = 0 Then
					%>			<tr height="25">
<%
					else%>			<tr height="25" style="background-color:#fafafa">

					<%End if
        %>

			  <td align="left" ><a href="http://league.cl-on.com/seller/02_Member/View.asp?IU_IDX=<%= IU_ID%>&IU_SITE=jh0105&PAGE=1" title="<%= Results(1,i) %>�� ��������"><%= Results(1,i) %></a>
			  </td>
			  <td align="left" ><%= Results(2,i) %>
			  </td>
			  <td align="left" ><%= Results(3,i) %>
			  </td> 
			  <td class="aliRight" ><%= Results(4,i) %>
			  </td> 
			  <td class="aliRight" ><%= Results(5,i) %>
			  </td> 
			  <td align="right"><%IU_CHARGE = Results(6,i)%>
							<%= formatnumber(IU_CHARGE,0)%>
			  </td> 
			  <td align="right" ><% IU_EXCHANGE = Results(7,i) %>
							<%= formatnumber(IU_EXCHANGE,0)%>
			  </td> 
			  <td align="right" bgcolor="#FfEfEf"><% if IU_CHARGE < IU_EXCHANGE then%> <span style="color:red"><%end if%>
			  <%= formatnumber(IU_CHARGE-IU_EXCHANGE,0)%>
			  </td> 
			  <td align="center" ><%= Results(8,i) %>
			  </td> 
			  <td align="center" ><%= Results(9,i) %>
			  </td> 
			  <% IU_RegDate = Results(10,i) %>

			  <td align="center" >	  <%=right(dfStringUtil.GetFullDate(IU_RegDate),14)%>
			  </td> 
			  <td align="right" ><% iu_site =  Results(11,i) %>
				
						<%= iu_site %> > 
						<%
						'H ���ȵ�� �����ؾ� �Ѵ�.. ���� ������ �������� ������ �ؾ���!!!!!!!!!!!!!!!!!!!!!!!!!!!
							SQLLISTCount4 = "select  ia_site, ia_group1,ia_group2, ia_group3, ia_group4  FROM INFO_admin WHERE ia_id ='"& iu_site &"'"
							Set resCount4 = DbCon.Execute(SQLLISTCount4)
							ia_site3 = resCount4(0)
							ia_g1_1 = resCount4(1)
							ia_g1_2 = resCount4(2)
							ia_g1_3 = resCount4(3)
							ia_g1_4 = resCount4(4)
							resCount4.CLOSE
							SET resCount4 = Nothing

							
							SQLLISTCount5 = "select  ia_site  FROM INFO_admin WHERE ia_group1 = "&ia_g1_1 &" AND ia_group2 = "&ia_g1_2 &" AND ia_group3 = "&ia_g1_3 &" AND ia_group4 =0 "
							Set resCount5 = DbCon.Execute(SQLLISTCount5)
							ia_site5 = resCount5(0)
							resCount5.CLOSE
							SET resCount5 = Nothing
							%>
								<%= ia_site5 %> 
							<%


							if IA_LEVEL < 4 then
								SQLLISTCount5 = "select  ia_site  FROM INFO_admin WHERE ia_group1 = "&ia_g1_1 &" AND ia_group2 = "&ia_g1_2 &"  AND ia_group3 =0 AND ia_group4 =0 "
								Set resCount5 = DbCon.Execute(SQLLISTCount5)
								ia_site6 = resCount5(0)
								resCount5.CLOSE
								SET resCount5 = Nothing
							%>
								> <%= ia_site6 %> 
							<%
								if IA_LEVEL < 3 then
									SQLLISTCount5 = "select  ia_site  FROM INFO_admin WHERE ia_group1 = "&ia_g1_1 &" AND ia_group2 = 0 AND ia_group3 =0 AND ia_group4 =0 "
									Set resCount5 = DbCon.Execute(SQLLISTCount5)
									ia_site7 = resCount5(0)
									resCount5.CLOSE
									SET resCount5 = Nothing
								%>
									> <%= ia_site7 %> 
								<%
								end if
							end if
%>



			  </td> 
			  <%
					IU_Status = Results(12,i)
			  		IF IU_Status  = 1 THEN
						IU_Status = "<font color=blue>����</font>"
					ELSEIF IU_Status = 0 THEN
						IU_Status = "<font color=gray>����</font>"
					ELSEIF IU_Status = 9 THEN
						IU_Status = "<font color=red>Ż��</font>"
					END IF	

			  %>
			  <td align="center" ><%= IU_Status %>
			  </td> 
			  <td align="center" > <input type=button class="btn btn-default btn-xs" value="����" title="<%= Results(1,i) %>���� ���� ��������" onclick="location.href='/Seller/04_Game1/Betting_List.asp?Search=IB_ID&Find=<%= Results(1,i) %>'"></a></a>

			  </td> 
			</tr>
		<%
            Next 

			End IF
	    %>
	    <tr height="25" bgcolor="#EEEEEE">
		  <td align="center">
			<%=i%>���� ȸ��
          </td>
          <td align="center">
          </td>
          <td align="center">
          </td>
          <td align="center">
          </td>
          <td align="center">
          </td>
          <td align="center">
          </td>
          <td align="center">
          </td>
          <td align="center">
          </td>
          <td align="center">
          </td>
          <td align="center">
          </td>
          <td align="center">
          </td>
          <td align="center">
          </td>
          <td align="center">
          </td>
		            <td align="center">
          </td>

		</tr>
	</table>         
</div>
</div>
	</form>
</body>
</html>

