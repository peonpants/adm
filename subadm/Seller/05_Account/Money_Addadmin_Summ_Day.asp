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



	If Request.queryString("type") ="" Then
		sSDate = now()
		
		'�˻��⵵���ϱ�
		fMsSDate = dateadd("m",-1, sSDate)

	    YYYY = year(sSDate)
	    bYYYY = year(fMsSDate)
		fYYYY = year(dateadd("m",1, sSDate))
		'�˻� �����ϱ�
		MM = month(sSDate)
		bMM = month(dateadd("m",-1, sSDate))
		fMM = month(dateadd("m",1, sSDate))

	Else
			sdateY = CInt(Request.queryString("sSdateY"))
			sdateM = CInt(Request.queryString("sSdateM"))
			YYYY = sdateY
			nDate = sdateY &"-"& sdateM &"-10"
			bYYYY = year(dateadd("m",-1, nDate))
			fYYYY = year(dateadd("m",1, nDate))
			MM = sdateM
			bMM = month(dateadd("m",-1, nDate))
			fMM = month(dateadd("m",1, nDate))

	End if
	
	
	if Request.queryString("Sdate") =""   then
			sStartDate = Request.Form("sStartDate")		
		if isNull(sStartDate)  then
		    sStartDate = datevalue(now)  & " 00:00:00"
		else 
			sStartDate = sStartDate & " 00:00:00"

		end if
	else
		sStartDate = Request.queryString("Sdate")
	end if
	if Request.queryString("Edate") ="" then
		sEndDate = Request.Form("sEndDate")		
		if isNull(sEndDate)  then
		    sEndDate = datevalue(now) & " 23:59:59" 
		else 
			sEndDate = sEndDate & " 23:59:59" 
		end if
	else
		sEndDate = Request("Edate")
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


    Group1 = IA_GROUP1
    Group2 = IA_GROUP2
    Group3 = IA_GROUP3
    Group4 = IA_GROUP4

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





	'H ���׷���� ���� �׷�� ����Ʈ AND ���ۼ�
	SelGroupSQL = " "		'ia
	SelGroupSqlA = " "	'ia JOIN��
	SelGroupSqlU = " "	'iu
	SelGroupSqlB = " "	'info_betting , ib_group
	if IA_GROUP1 = 0 then
	else
		SelGroupSQL = SelGroupSQL & " AND IA_GROUP1 ="&IA_GROUP1
		SelGroupSqlA = SelGroupSqlA & " AND A.IA_GROUP1 ="&IA_GROUP1
		SelGroupSqlU = SelGroupSqlU & " AND IU_GROUP1 ="&IA_GROUP1
		SelGroupSqlB = SelGroupSqlB & " AND IB_GROUP1 ="&IA_GROUP1
	end if
	if IA_GROUP2 = 0 then
	else
		SelGroupSQL = SelGroupSQL & " AND IA_GROUP2 ="&IA_GROUP2
		SelGroupSqlA = SelGroupSqlA & " AND A.IA_GROUP2 ="&IA_GROUP2
		SelGroupSqlB = SelGroupSqlB & " AND IB_GROUP2 ="&IA_GROUP1

	end if
	if IA_GROUP3 = 0 then
	else
		SelGroupSQL = SelGroupSQL & " AND IA_GROUP3 ="&IA_GROUP3
		SelGroupSqlA = SelGroupSqlA & " AND A.IA_GROUP3 ="&IA_GROUP3
		SelGroupSqlB = SelGroupSqlB & " AND IB_GROUP3 ="&IA_GROUP1
	end if
	if IA_GROUP4 = 0 then
	else
		SelGroupSQL = SelGroupSQL & " AND IA_GROUP4 ="&IA_GROUP4
		SelGroupSqlA = SelGroupSqlA & " AND A.IA_GROUP4 ="&IA_GROUP4
		SelGroupSqlB = SelGroupSqlB & " AND IB_GROUP4 ="&IA_GROUP1
	end If
	







 
 



'	SQLLIST = "	SELECT ISNULL(SUM(C.LC_CASH),0)  
'				FROM Log_CashInOut AS C INNER JOIN INFO_ADMIN AS A ON C.LC_SITE = A.ia_id  
'				WHERE  C.LC_ID NOT IN (SELECT IU_ID FROM INFO_USER WHERE IU_LEVEL =9) "&SelGroupSqlA&"   AND C.LC_CONTENTS='ȯ������' AND C.LC_REGDATE Between '"& sStartDate &"' AND '"& sEndDate &"'"


 		'H �Ϻ� ����� SQL======================================================================================================================================
		SQL2 = "SELECT DATEPART(day,C.LC_REGDATE) AS BeDate,"
		SQL2 = SQL2 & " ISNULL(SUM( CASE WHEN C.LC_CONTENTS = '�Ӵ�����' THEN C.LC_CASH END),0) AS BeCash1,"
		SQL2 = SQL2 & " ISNULL(SUM( CASE WHEN C.LC_CONTENTS = 'ȯ������' THEN C.LC_CASH END),0) AS BeCash2,"
		SQL2 = SQL2 & " ISNULL(SUM( CASE WHEN C.LC_CONTENTS = '��������' THEN C.LC_CASH END),0) AS BeCash3,"
		SQL2 = SQL2 & " ISNULL(SUM( CASE WHEN C.LC_CONTENTS = '���ù��' THEN C.LC_CASH END),0) AS BeCash4"
		SQL2 = SQL2 & " FROM Log_CashInOut AS C INNER JOIN INFO_ADMIN AS A ON C.LC_SITE= A.ia_id "
		SQL2 = SQL2 & " WHERE C.LC_ID NOT IN (SELECT IU_ID FROM INFO_USER WHERE IU_LEVEL =9) "&SelGroupSqlA&" AND DATEPART(yyyy,C.LC_REGDATE) ="&YYYY& " AND  DATEPART(mm,C.LC_REGDATE) ="&MM
		SQL2 = SQL2 & " GROUP BY DATEPART(day,C.LC_REGDATE)"
		SQL  = SQL2 & " ORDER BY BeDate DESC"

	'A.LC_ID NOT IN (SELECT IU_ID FROM INFO_USER WHERE IU_LEVEL =9) AND




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
					<div class="panel-heading"><span class="txtsh011b" style="color:#adc;"> �� </span><span style="font-size:18px; font-weight:bold;text-shadow:0px 2px 2px #fff;">���ں� ���  -������</span></div>
					<div class="panel-body"> 
						<span style="color:#9999f0">
						</span><br/>

 
	 
						<a  class="btn btn-info btn-xs" href="Money_Addadmin_Summ_Day.asp?type=1&sSdateY=<%=bYYYY%>&sSdateM=<%=bMM%>"><span style="color:white;"> <%=bYYYY%>�� <%=bMM%>��</span></a> 

						<button class="btn btn-info active btn-sm " disabled="disabled" type="submit" title="���� ǥ�õǰ� �ִ� ���Դϴ�.."><%=YYYY%>�� <%=MM%>��</button>

						<a class="btn btn-info btn-xs" href="Money_Addadmin_Summ_Day.asp?type=1&sSdateY=<%=fYYYY%>&sSdateM=<%=fMM%>"><span style="color:white;"> <%=fYYYY%>�� <%=fMM%>��</span></a> 

						<div style="height:10px;"></div>
					</div>
				<div style="padding:0px;margin:0px;border:1px solid #cccccc;">
					<table border="0"  cellspacing="1" cellpadding="2" bgcolor="#AAAAAA" width="100%" class=" trhover HberTh HberTableLG" >
			 <tr bgcolor="e7e7e7" class="title-backgra" height="40">
				  <th align="center">��¥
				  </th>


				  <th align="center">�Ӵ�����
				  </th>
				  <th align="left">ȯ������
				  </th>
				  <th align="left">����
				  </th>
				  <th align="left">
				  </th>
				  <th align="right">��������
				  </th>
				  <th class="center">���ù��
				  </th>
 				  <th align="center">��������
				  </th>
				  <th align="center">
				  </th>
				</tr>
			<%		
            IF resCount <> 0 Then
                For i = 0 to resCount-1
					IU_ID = Results(0,i)
					if i mod 2 = 0 Then
					%>			<tr height="25"><%
					else%>			<tr height="25" style="background-color:#fafafa">

					<%End if
        %>

			  <td align="left" ><%=YYYY%>�� <%=MM%>�� <%=Results(0,i)%>��
			  </td>
			  <td class="aliRight" >
							<%= formatnumber(Results(1,i),0)%>
			  </td> 
			  <td class="aliRight" >

							<%= formatnumber(-Results(2,i),0)%>
			  </td> 
			  <td class="aliRight" >	
							<%= formatnumber(Results(1,i)+Results(2,i),0)%>
			  </td> 
	  		  <td id="grap1_<%=i%>" width="100">
			  </td> 

			  <td class="aliRight" >
							<%= formatnumber(-Results(3,i),0)%>
			  </td> 
			  <td class="aliRight" >
							<%= formatnumber(Results(4,i),0)%>
			  </td> 
			  <td class="aliRight" >	
							<%= formatnumber(-Results(3,i)-Results(4,i),0)%>
			  </td> 
	  		  <td id="grap2_<%=i%>" width="100">
			  </td> 
	  		</tr>
		<%
            Next 

			End IF
	    %>
	    <tr height="25" bgcolor="#EEEEEE">
		  <td align="center">
			<%=i%>
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

