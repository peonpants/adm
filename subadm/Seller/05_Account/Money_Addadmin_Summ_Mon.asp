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
<%
'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
'H
'H		������� ����Ÿ ����
'H	   int ���� double ������ ��ȯ (����.. �������ݾ��� 20���̻��ϰ�� long -> double ���� �ʿ���
'H		LINE 280 : Cdbl()  ������� ����ȯ
'H
'H
'H
'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

%>
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
 
	
	If Request.queryString("type") ="" Then
		sSDate = now()
		
		'�˻��⵵���ϱ�
		fMsSDate = dateadd("yyyy",-1, sSDate)
	    YYYY = year(sSDate)
	    bYYYY = year(fMsSDate)
		fYYYY = year(dateadd("yyyy",1, sSDate))
		'�˻� �����ϱ�

	Else
		
			sdateY = CInt(Request.queryString("sSdateY"))
			YYYY = sdateY
			nDate = sdateY &"-12-10"
			bYYYY = year(dateadd("yyyy",-1, nDate))
			fYYYY = year(dateadd("yyyy", 1, nDate))

	End if


 




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
 


 



	    	SQL2 = "SELECT DATEPART(day,C.LC_REGDATE) AS BeDate,"
		SQL2 = SQL2 & " ISNULL(SUM( CASE WHEN C.LC_CONTENTS = '�Ӵ�����' THEN C.LC_CASH END),0) AS BeCash1,"
		SQL2 = SQL2 & " ISNULL(SUM( CASE WHEN C.LC_CONTENTS = 'ȯ������' THEN C.LC_CASH END),0) AS BeCash2,"
		SQL2 = SQL2 & " ISNULL(SUM( CASE WHEN C.LC_CONTENTS = '��������' THEN C.LC_CASH END),0) AS BeCash3,"
		SQL2 = SQL2 & " ISNULL(SUM( CASE WHEN C.LC_CONTENTS = '���ù��' THEN C.LC_CASH END),0) AS BeCash4"
		SQL2 = SQL2 & " FROM Log_CashInOut AS C INNER JOIN INFO_ADMIN AS A ON C.LC_SITE= A.ia_id "
		SQL2 = SQL2 & " WHERE C.LC_ID NOT IN (SELECT IU_ID FROM INFO_USER WHERE IU_LEVEL =9) "&SelGroupSqlA&" AND DATEPART(yyyy,C.LC_REGDATE) ="&YYYY& " AND  DATEPART(mm,C.LC_REGDATE) ="&MM
		SQL2 = SQL2 & " GROUP BY DATEPART(day,C.LC_REGDATE)"
		SQL  = SQL2 & " ORDER BY BeDate DESC"



 		'H �Ϻ� ����� SQL======================================================================================================================================
		SQL2 = "SELECT DATEPART(month,C.LC_REGDATE) AS BeDate,"
		SQL2 = SQL2 & " ISNULL( SUM( CASE WHEN C.LC_CONTENTS = '�Ӵ�����' THEN convert(bigint, C.LC_CASH) else 0  END),0) AS BeCash1,"
		SQL2 = SQL2 & " ISNULL( SUM( CASE WHEN C.LC_CONTENTS = 'ȯ������' THEN convert(bigint, C.LC_CASH) else 0  END),0) AS BeCash2,"
		SQL2 = SQL2 & " ISNULL( SUM( CASE WHEN C.LC_CONTENTS = '��������' THEN convert(bigint, C.LC_CASH) else 0  END),0) AS BeCash3,"
		SQL2 = SQL2 & " ISNULL( SUM( CASE WHEN C.LC_CONTENTS = '���ù��' THEN convert(bigint, C.LC_CASH) else 0  END),0) AS BeCash4"
		SQL2 = SQL2 & " FROM Log_CashInOut AS C INNER JOIN INFO_ADMIN AS A ON C.LC_SITE= A.ia_id "
		SQL2 = SQL2 & " WHERE C.LC_ID NOT IN (SELECT IU_ID FROM INFO_USER WHERE IU_LEVEL =9) "
		SQL2 = SQL2 & "   AND C.LC_SITE !='aaa' "
		SQL2 = SQL2 & "   AND C.LC_SITE !='lss3' "
		SQL2 = SQL2 & "   AND C.LC_SITE !='scce' "
		SQL2 = SQL2 & "   AND ( C.LC_REGDATE < '2017-12-24 00:00:00' or C.LC_REGDATE > '2017-12-28 15:18:27')  "
		SQL2 = SQL2 & SelGroupSqlA&" AND DATEPART(yyyy,C.LC_REGDATE) ='"&YYYY &"'"
		SQL2 = SQL2 & " GROUP BY DATEPART(month,C.LC_REGDATE)"
		SQL2  = SQL2 & " ORDER BY BeDate DESC"
	
		'H �ӽ� �׽�Ʈ�� ===============================================
 
	SET RS1 = DbCon.Execute(SQL2)
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
					<div class="panel-heading"><span class="txtsh011b" style="color:#adc;"> �� </span><span style="font-size:18px; font-weight:bold;text-shadow:0px 2px 2px #fff;">���� ��� -������</span></div>
					<div class="panel-body"> 
						<span style="color:#9999f0">
						*�����͸� �����ϴµ� �ð��� �ټ� �ҿ�˴ϴ�
						<br>
						</span><br/>

						<script type="text/javascript" src="../includes/calendar1.js"></script>
						<script type="text/javascript" src="../includes/calendar2.js"></script>

						<a  class="btn btn-info btn-xs" href="Money_Addadmin_Summ_Mon.asp?type=1&sSdateY=<%=bYYYY%>"><span style="color:white;"> <%=bYYYY%>��  </span></a> 

						<button class="btn btn-info active btn-sm " disabled="disabled" type="submit" title="���� ǥ�õǰ� �ִ� ���Դϴ�.."><%=YYYY%>�� </button>

						<a class="btn btn-info btn-xs" href="Money_Addadmin_Summ_Mon.asp?type=1&sSdateY=<%=fYYYY%> "><span style="color:white;"> <%=fYYYY%>��  </span></a> 



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
'					IU_ID = Results(0,i)
					if i mod 2 = 0 Then
					%>			<tr height="25"><%
					else%>			<tr height="25" style="background-color:#fafafa">

					<%End if
        %>

			  <td align="left" ><%=YYYY%>��  <%=Results(0,i)%>��
			  </td>
			  <td class="aliRight" >
							<%= formatnumber(Results(1,i),0)%>
			  </td> 
			  <td class="aliRight" >
							<%= formatnumber(Results(2,i),0)%>
			  </td> 
			  <td class="aliRight" >
				<%
					 monin = Cdbl(Results(1,i))
					 monout = Cdbl(Results(2,i))
					monsum = monin + monout
					monbetin = Cdbl(Results(3,i))
					monbetout = Cdbl(Results(4,i))
					monbetsum = monbetin + monbetout
	

				%>
							<%= formatnumber(monsum,0)%>
			  </td> 
	  		  <td id="grap1_<%=i%>" width="100">
			  </td> 

			  <td class="aliRight" >
							<%= formatnumber(monbetin,0)%>
			  </td> 
			  <td class="aliRight" >
							<%= formatnumber(monbetout,0)%>
			  </td> 
			  <td class="aliRight" >	
							<%= formatnumber(monbetsum,0)%>
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
